/* CONFIGURAÇÃO: substitua os dois valores abaixo pelos dados do seu projeto Supabase. Nunca use a chave service_role aqui. */
window.SUPABASE_URL = 'https://gwpxdexxhtmsgmqeltby.supabase.co/rest/v1/';
window.SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd3cHhkZXh4aHRtc2dtcWVsdGJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTM4NTMyMzUsImV4cCI6MjEwOTQyOTIzNX0.tagL45FcbeDK_HcxUg6pRnYKZ6WSuAJt9Z1x_s2JIs0';
window.supabaseClient = (window.supabase && !window.SUPABASE_URL.includes('SEU-PROJETO'))
  ? window.supabase.createClient(window.SUPABASE_URL, window.SUPABASE_ANON_KEY)
  : null;
window.hasSupabaseConfig = () => Boolean(window.supabaseClient);
