# Compras Rápidas Andrade

Loja afiliada estática para GitHub Pages, usando HTML, CSS, JavaScript puro e Supabase. Não há React, Node.js, build ou servidor próprio.

## 1. Criar o Supabase

1. Acesse [supabase.com](https://supabase.com), crie uma conta e selecione **New project**.
2. Escolha um nome, senha do banco e região. Aguarde o projeto ficar pronto.
3. Abra **SQL Editor > New query**, copie todo o conteúdo de `supabase.sql`, cole e clique em **Run**.

## 2. Criar o administrador

1. No Supabase, abra **Authentication > Users > Add user**.
2. Crie o e-mail e a senha que serão usados no painel. Marque a confirmação de e-mail, se aparecer.
3. Copie o **User UID** desse usuário.
4. Volte ao SQL Editor e execute, trocando o texto pelo UID real:

```sql
insert into public.app_admins(user_id) values('COLE-O-UUID-AQUI');
```

Não crie a conta do administrador na loja pública. A autorização do painel depende da tabela `app_admins`.

## 3. Configurar URL e chave pública

1. No Supabase, abra **Project Settings > API**.
2. Copie **Project URL** e a chave **anon / public**.
3. Abra `supabase.js` e substitua `https://SEU-PROJETO.supabase.co` e `COLE_AQUI_SUA_CHAVE_PUBLICA_ANON`.
4. Nunca cole a chave `service_role` em nenhum arquivo do site. Ela é secreta e não deve ir para o GitHub.

## 4. Publicar no GitHub Pages pelo navegador

1. No GitHub, clique em **New repository** e crie um repositório público, por exemplo `compras-rapidas-andrade`.
2. Clique em **Add file > Upload files**.
3. Envie estes arquivos para a raiz do repositório: `index.html`, `produto.html`, `admin.html`, `style.css`, `admin.css`, `script.js`, `admin.js` e `supabase.js`.
4. Envie também `supabase.sql` e este `LEIA-ME.md` se desejar manter a documentação no repositório. O SQL não é carregado pelo navegador.
5. Clique em **Commit changes**.
6. Abra **Settings > Pages**, escolha **Deploy from a branch**, selecione `main` e a pasta `/ (root)`, e clique em **Save**.
7. Aguarde o endereço aparecer. A loja fica em `https://SEU-USUARIO.github.io/NOME-DO-REPOSITORIO/` e o painel em `/admin.html`.

## 5. Cadastrar e editar produtos

1. Acesse `/admin.html` e entre com o usuário criado no Supabase.
2. Use **Categorias > Nova categoria** para criar as categorias.
3. Em **Produtos > Novo produto**, preencha nome, descrição, preço, preço promocional opcional e o link de afiliado completo.
4. Selecione várias fotos de uma vez. A primeira será a capa. O upload vai para o bucket público `product-images` criado pelo SQL.
5. Marque **Produto em destaque** para ele aparecer na seção de ofertas. Desmarque **Produto ativo** para ocultá-lo sem apagar.
6. Use **Editar** para alterar informações e **Excluir** para remover o produto.
7. Em **Marca e banners**, é possível salvar nome da loja e URLs públicas de logo/banner. O banner fica disponível para personalização futura; a vitrine usa a composição visual padrão para não quebrar quando nenhum banner for informado.
8. A coluna de cliques registra cada acesso ao link de afiliado. O contador aparece no painel.

## Observações importantes

- O navegador usa somente a chave pública `anon`. As políticas RLS impedem visitantes de alterar produtos e categorias.
- Visitantes conseguem ler produtos ativos, imagens públicas e categorias ativas.
- A contagem de cliques é um evento de acesso, não uma confirmação de venda na plataforma afiliada.
- Como o GitHub Pages é hospedagem estática, toda administração acontece diretamente no Supabase pelo navegador.

## 9. Fazer backup pelo painel

Depois de entrar em `admin.html`, abra a aba **Backup** e clique em **Baixar backup JSON**. O arquivo salva produtos, categorias, links de afiliado, preços, configurações e URLs das imagens. As imagens físicas continuam no Supabase Storage; por isso, guarde também o acesso ao seu projeto Supabase. Recomenda-se baixar um backup antes de alterações importantes no catálogo.

## 10. Prévia interativa

O arquivo `demo.html` é uma demonstração independente para testar a interface sem Supabase. Ele usa dados fictícios e `localStorage` do navegador. A demo não substitui a versão de produção: os dados adicionados nela não são enviados ao Supabase.

## Guia de publicação no GitHub

Para enviar os arquivos pelo navegador e ativar o GitHub Pages, consulte o arquivo `GUIA-GITHUB.md`.


## 11. Carrossel de ofertas em destaque

Para colocar um produto no carrossel principal, abra o painel, edite o produto e marque **Produto em destaque**. Todos os produtos ativos marcados dessa forma entram no carrossel, que troca automaticamente a cada cinco segundos e também possui setas e indicadores. Não há limite artificial de produtos destacados; quanto mais produtos forem marcados, mais itens ficarão disponíveis na sequência.


## 12. Imagens nas categorias

No painel administrativo, abra **Categorias**, crie ou edite uma categoria e selecione uma imagem opcional. Ela será enviada ao bucket `product-images` do Supabase Storage e aparecerá no card da categoria na vitrine.


## 13. Alterar cores da loja

Em **Marca e banners**, selecione diretamente os arquivos do logotipo e do banner no celular ou computador. Use também os seletores de cor para alterar a cor dos botões, a cor principal da vitrine e o fundo da página. Clique em **Salvar configurações**. As cores ficam salvas no Supabase e são aplicadas na loja pública.


## 14. Importar, exportar e agendar backup

Na aba **Backup**, use **Exportar backup** para baixar um JSON, **Importar backup** para restaurar um arquivo JSON anterior e **Agendar backup** para definir frequência e horário. Como o GitHub Pages é estático, o download automático só acontece enquanto o painel estiver aberto; o agendamento fica salvo no Supabase.
