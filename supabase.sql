-- COMPRAS RÁPIDAS ANDRADE | execute este arquivo no SQL Editor do Supabase
create extension if not exists pgcrypto;
create table if not exists public.app_admins (user_id uuid primary key references auth.users(id) on delete cascade, created_at timestamptz not null default now());
create table if not exists public.categories (id uuid primary key default gen_random_uuid(), name text not null unique, description text, image_url text, is_active boolean not null default true, created_at timestamptz not null default now());
create table if not exists public.products (id uuid primary key default gen_random_uuid(), category_id uuid references public.categories(id) on delete set null, name text not null, description text not null default '', price numeric(12,2) not null check(price >= 0), promo_price numeric(12,2) check(promo_price is null or promo_price >= 0), affiliate_url text not null, video_url text, is_featured boolean not null default false, is_active boolean not null default true, created_at timestamptz not null default now(), updated_at timestamptz not null default now());
create table if not exists public.product_images (id uuid primary key default gen_random_uuid(), product_id uuid not null references public.products(id) on delete cascade, image_url text not null, sort_order integer not null default 0, created_at timestamptz not null default now());
create table if not exists public.click_events (id uuid primary key default gen_random_uuid(), product_id uuid not null references public.products(id) on delete cascade, referrer text, created_at timestamptz not null default now());
create table if not exists public.site_settings (id integer primary key default 1 check(id=1), store_name text not null default 'Compras Rápidas Andrade', logo_url text, hero_image_url text, primary_color text not null default '#1769e0', store_color text not null default '#071a35', background_color text not null default '#fbfdff', backup_enabled boolean not null default false, backup_frequency text not null default 'off', backup_time time not null default '09:00', updated_at timestamptz not null default now());
alter table public.categories add column if not exists image_url text;
alter table public.site_settings add column if not exists primary_color text not null default '#1769e0';
alter table public.site_settings add column if not exists store_color text not null default '#071a35';
alter table public.site_settings add column if not exists background_color text not null default '#fbfdff';
alter table public.site_settings add column if not exists backup_enabled boolean not null default false;
alter table public.site_settings add column if not exists backup_frequency text not null default 'off';
alter table public.site_settings add column if not exists backup_time time not null default '09:00';
insert into public.site_settings(id) values(1) on conflict(id) do nothing;
create index if not exists products_active_idx on public.products(is_active, created_at desc); create index if not exists product_images_product_idx on public.product_images(product_id, sort_order); create index if not exists click_events_product_idx on public.click_events(product_id);
create or replace function public.is_admin() returns boolean language sql stable security definer set search_path=public as $$ select exists(select 1 from public.app_admins where user_id=auth.uid()); $$;
alter table public.app_admins enable row level security; alter table public.categories enable row level security; alter table public.products enable row level security; alter table public.product_images enable row level security; alter table public.click_events enable row level security; alter table public.site_settings enable row level security;
drop policy if exists "public read active categories" on public.categories; create policy "public read active categories" on public.categories for select using (is_active=true or public.is_admin());
drop policy if exists "admins manage categories" on public.categories; create policy "admins manage categories" on public.categories for all using(public.is_admin()) with check(public.is_admin());
drop policy if exists "public read active products" on public.products; create policy "public read active products" on public.products for select using(is_active=true or public.is_admin());
drop policy if exists "admins manage products" on public.products; create policy "admins manage products" on public.products for all using(public.is_admin()) with check(public.is_admin());
drop policy if exists "public read product images" on public.product_images; create policy "public read product images" on public.product_images for select using(exists(select 1 from public.products p where p.id=product_id and (p.is_active=true or public.is_admin())));
drop policy if exists "admins manage product images" on public.product_images; create policy "admins manage product images" on public.product_images for all using(public.is_admin()) with check(public.is_admin());
drop policy if exists "public create click events" on public.click_events; create policy "public create click events" on public.click_events for insert with check(true);
drop policy if exists "admins read click events" on public.click_events; create policy "admins read click events" on public.click_events for select using(public.is_admin());
drop policy if exists "public read settings" on public.site_settings; create policy "public read settings" on public.site_settings for select using(true);
drop policy if exists "admins manage settings" on public.site_settings; create policy "admins manage settings" on public.site_settings for all using(public.is_admin()) with check(public.is_admin());
insert into storage.buckets(id,name,public) values('product-images','product-images',true) on conflict(id) do update set public=true;
insert into storage.buckets(id,name,public) values('site-assets','site-assets',true) on conflict(id) do update set public=true;
drop policy if exists "public view store images" on storage.objects; create policy "public view store images" on storage.objects for select using(bucket_id in ('product-images','site-assets'));
drop policy if exists "admins upload store images" on storage.objects; create policy "admins upload store images" on storage.objects for insert with check(bucket_id in ('product-images','site-assets') and public.is_admin());
drop policy if exists "admins update store images" on storage.objects; create policy "admins update store images" on storage.objects for update using(bucket_id in ('product-images','site-assets') and public.is_admin());
drop policy if exists "admins delete store images" on storage.objects; create policy "admins delete store images" on storage.objects for delete using(bucket_id in ('product-images','site-assets') and public.is_admin());
-- Depois de criar o usuário no Authentication > Users, substitua o UUID abaixo e execute:
-- insert into public.app_admins(user_id) values('UUID-DO-USUARIO-ADMIN');
-- Para contar cliques por produto no painel, crie também esta coluna calculada via view:
create or replace view public.product_click_summary with (security_invoker=true) as select p.id, count(c.id)::integer as click_count from public.products p left join public.click_events c on c.product_id=p.id group by p.id;
-- O painel utiliza a função abaixo para contar sem expor os eventos a visitantes.
