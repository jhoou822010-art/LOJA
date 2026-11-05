let deferredInstallPrompt=null;
window.addEventListener('beforeinstallprompt',event=>{event.preventDefault();deferredInstallPrompt=event;document.querySelectorAll('[data-install-app]').forEach(button=>button.classList.remove('hidden'))});
window.addEventListener('appinstalled',()=>{deferredInstallPrompt=null;document.querySelectorAll('[data-install-app]').forEach(button=>button.classList.add('hidden'))});
async function installApp(){if(!deferredInstallPrompt){alert('No celular, use o menu do navegador e escolha “Adicionar à tela inicial” ou “Instalar aplicativo”.');return}deferredInstallPrompt.prompt();await deferredInstallPrompt.userChoice;deferredInstallPrompt=null}
document.addEventListener('click',event=>{const button=event.target.closest('[data-install-app]');if(button)installApp()});
if('serviceWorker' in navigator)window.addEventListener('load',()=>navigator.serviceWorker.register('./sw.js').catch(error=>console.warn('PWA indisponível:',error)));
