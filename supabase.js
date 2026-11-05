/* CONFIGURAÇÃO: substitua os dois valores abaixo pelos dados do seu projeto Supabase. Nunca use a chave service_role aqui. */
window.SUPABASE_URL = 'https://gwpxdexxhtmsgmqeltby.supabase.co';
window.SUPABASE_ANON_KEY = 'sb_publishable_3RnwQgdKt3eRgr3y0CFSGw_VkY99z-q';
window.supabaseClient = (window.supabase && !window.SUPABASE_URL.includes('SEU-PROJETO'))
  ? window.supabase.createClient(window.SUPABASE_URL, window.SUPABASE_ANON_KEY)
  : null;
window.hasSupabaseConfig = () => Boolean(window.supabaseClient);
