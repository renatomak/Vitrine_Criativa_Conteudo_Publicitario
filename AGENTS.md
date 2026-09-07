# Regras para cadastro de produtos

Estas regras se aplicam a qualquer inclusão ou atualização dentro de `produtos/`.

1. Antes de criar uma pasta, execute `scripts/localizar-produto.ps1` com o link
   completo ou o título do anúncio.
2. Se o localizador retornar uma correspondência exata por ID ou título, não
   crie outra pasta. Atualize o cadastro existente quando os itens forem o
   mesmo produto.
3. Se houver apenas semelhança, compare as imagens, quantidade, modelo e
   características verificáveis antes de decidir.
4. Para anúncios de lojas, mantenha um `produto.json` com nome, categoria,
   aliases, plataforma, ID do produto e URL canônica sem rastreamento.
5. Use nomes de pasta em kebab-case: letras minúsculas, números e hífens, sem
   espaços ou acentos.
6. Depois de qualquer inclusão, remoção ou renomeação, execute
   `scripts/atualizar-catalogo.ps1` e confira os alertas no fim de
   `CATALOGO-PRODUTOS.md`.
7. Não consolide nem exclua cadastros duplicados existentes sem comparar todos
   os arquivos e obter autorização do usuário.
