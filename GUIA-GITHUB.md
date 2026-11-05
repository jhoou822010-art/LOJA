# Guia para colocar a loja no GitHub Pages

Este guia mostra como enviar os arquivos da pasta `compras-rapidas-andrade` para um repositório do GitHub usando apenas o navegador. Não é necessário instalar programas, usar terminal ou conhecer programação.

## 1. Prepare os arquivos

Baixe o arquivo `compras-rapidas-andrade.zip` e extraia o conteúdo no celular ou computador. Depois de extrair, você verá a pasta `compras-rapidas-andrade`.

Dentro dela estarão os arquivos principais:

- `index.html`: página inicial da loja.
- `produto.html`: detalhes de cada produto.
- `admin.html`: painel administrativo.
- `style.css` e `admin.css`: estilos visuais.
- `script.js` e `admin.js`: funções da loja e do painel.
- `supabase.js`: endereço e chave pública do Supabase.
- `supabase.sql`: configuração do banco, usada somente no SQL Editor do Supabase.
- `demo.html`: prévia interativa com dados fictícios.
- `LEIA-ME.md`: instruções gerais.
- `GUIA-GITHUB.md`: este guia.

Você deve publicar os arquivos reais da loja. O `demo.html` é opcional e serve apenas para testar a interface sem Supabase.

## 2. Crie o repositório no GitHub

1. Acesse [github.com](https://github.com) e entre na sua conta.
2. Clique no botão **+** no canto superior direito.
3. Escolha **New repository**.
4. Em **Repository name**, digite, por exemplo:

   `compras-rapidas-andrade`

5. Escolha **Public**.
6. Não marque a opção de criar README, `.gitignore` ou licença agora, porque esses arquivos já estão na pasta da loja.
7. Clique em **Create repository**.

## 3. Envie os arquivos pelo navegador

Na página do repositório novo:

1. Clique em **Add file**.
2. Escolha **Upload files**.
3. Abra a pasta extraída `compras-rapidas-andrade` no seu computador ou celular.
4. Selecione os arquivos que estão dentro da pasta.
5. Arraste-os para a área de upload do GitHub ou use **choose your files**.
6. Envie os arquivos diretamente para a raiz do repositório.

É importante enviar o conteúdo da pasta, não criar uma pasta extra dentro do repositório. O arquivo `index.html` precisa aparecer diretamente na página principal do repositório.

A estrutura correta no GitHub deve ficar assim:

```text
compras-rapidas-andrade/
├── index.html
├── produto.html
├── admin.html
├── style.css
├── admin.css
├── script.js
├── admin.js
├── supabase.js
├── supabase.sql
├── demo.html
├── LEIA-ME.md
└── GUIA-GITHUB.md
```

7. Na parte inferior da página, mantenha **Commit directly to the main branch** selecionado.
8. Clique em **Commit changes**.

Se estiver usando um celular e não conseguir selecionar vários arquivos, envie os arquivos em mais de uma rodada. Sempre confira se todos estão na raiz do repositório.

## 4. Configure o Supabase antes de publicar a loja real

O arquivo `supabase.js` ainda possui valores de exemplo. Antes de usar a loja real:

1. Abra o projeto do Supabase.
2. Vá em **Project Settings > API**.
3. Copie o **Project URL**.
4. Copie a chave **anon public**.
5. No GitHub, abra o arquivo `supabase.js`.
6. Clique no ícone de lápis para editar.
7. Troque somente estes valores:

```javascript
window.SUPABASE_URL = 'https://SEU-PROJETO.supabase.co';
window.SUPABASE_ANON_KEY = 'COLE_AQUI_SUA_CHAVE_PUBLICA_ANON';
```

8. Clique em **Commit changes**.

Nunca coloque a chave `service_role` no GitHub. Use somente a chave pública `anon` no navegador.

## 5. Execute o SQL no Supabase

O arquivo `supabase.sql` não deve ser executado no GitHub Pages. Ele deve ser executado uma vez no Supabase:

1. Abra o projeto Supabase.
2. Vá em **SQL Editor**.
3. Clique em **New query**.
4. Abra o arquivo `supabase.sql` no seu dispositivo.
5. Copie todo o conteúdo.
6. Cole no SQL Editor.
7. Clique em **Run**.

Depois, crie o usuário administrador em **Authentication > Users > Add user**. Copie o User UID e execute no SQL Editor:

```sql
insert into public.app_admins(user_id)
values('COLE-O-UUID-DO-ADMIN-AQUI');
```

## 6. Ative o GitHub Pages

1. No repositório, abra a aba **Settings**.
2. No menu lateral, abra **Pages**.
3. Em **Build and deployment**, escolha **Deploy from a branch**.
4. Em **Branch**, selecione `main`.
5. Em pasta, selecione `/ (root)`.
6. Clique em **Save**.
7. Aguarde alguns minutos.
8. Volte a **Settings > Pages** para ver o endereço publicado.

O endereço normalmente terá este formato:

```text
https://SEU-USUARIO.github.io/compras-rapidas-andrade/
```

A loja fica no endereço principal. O painel fica em:

```text
https://SEU-USUARIO.github.io/compras-rapidas-andrade/admin.html
```

A prévia independente fica em:

```text
https://SEU-USUARIO.github.io/compras-rapidas-andrade/demo.html
```

## 7. Faça o primeiro teste

Abra a loja publicada e confira:

1. A página inicial abre sem erro.
2. O nome da loja aparece.
3. O painel `/admin.html` abre a tela de login.
4. O administrador consegue entrar.
5. É possível criar uma categoria.
6. É possível criar um produto.
7. É possível colocar um link de afiliado.
8. É possível enviar fotos.
9. O produto aparece na vitrine quando está ativo.
10. O botão Comprar mostra a mensagem e abre o parceiro.
11. O contador de cliques aparece no painel.
12. A aba Backup baixa o arquivo JSON.

## 8. Onde colocar os links de afiliado

Depois de entrar em `admin.html`:

1. Abra **Produtos**.
2. Clique em **Novo produto**.
3. Preencha o campo **Link de afiliado** com o endereço completo fornecido pela plataforma parceira.
4. Salve o produto.

O botão **Comprar** usará esse endereço. O cliente verá uma mensagem avisando que será direcionado para a loja parceira antes de abrir o link.

## 9. Como atualizar a loja depois

Quando quiser alterar os arquivos:

1. Abra o repositório no GitHub.
2. Abra o arquivo que deseja modificar.
3. Clique no lápis de edição.
4. Faça a alteração.
5. Clique em **Commit changes**.

Para alterar produtos, preços e links, não é necessário editar os arquivos. Use o painel `admin.html`.

Para trocar o visual, textos ou funções, altere os arquivos HTML, CSS ou JavaScript no GitHub.

## 10. Solução de problemas comuns

**A página aparece em branco:** confirme se `index.html` está na raiz do repositório e se o GitHub Pages está usando a branch `main` e a pasta `/ (root)`.

**A loja mostra “Configure o Supabase”:** o arquivo `supabase.js` ainda está com os valores de exemplo ou os dados foram digitados incorretamente.

**O login não funciona:** confirme se o usuário foi criado em **Authentication > Users** e se o User UID foi incluído na tabela `app_admins`.

**O usuário entra, mas não vê produtos no painel:** confirme se o SQL completo foi executado e se o usuário está na tabela `app_admins`.

**As imagens não sobem:** confirme se o SQL criou os buckets `product-images` e `site-assets` e se o usuário está autorizado como administrador.

**O link de afiliado não abre:** confirme se o endereço começa com `https://` e foi copiado completo.

**O site não atualizou:** aguarde alguns minutos, atualize a página e, se necessário, abra uma janela anônima para evitar o cache.

## Resumo rápido

A sequência correta é:

1. Criar o repositório público.
2. Enviar o conteúdo da pasta para a raiz.
3. Executar `supabase.sql` no Supabase.
4. Criar o usuário administrador.
5. Inserir a URL e a chave `anon` em `supabase.js`.
6. Ativar o GitHub Pages.
7. Acessar `/admin.html`.
8. Cadastrar categorias, produtos, fotos e links de afiliado.
