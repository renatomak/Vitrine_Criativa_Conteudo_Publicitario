# Vitrine Criativa — Conteúdo Publicitário

Acervo de materiais para criação de conteúdo publicitário, organizado por
influencer e produto.

Para localizar rapidamente um item, consulte o
[Catálogo de Produtos](CATALOGO-PRODUTOS.md).

## Onde encontrar cada material

```text
.
├── produtos/
│   └── maia/ ou nanda/
│       └── nome-do-produto/
│           ├── descricao-produto.txt
│           ├── produto-01.webp
│           ├── criativo-01.png
│           ├── referencia-01.png
│           ├── videos/       (somente quando houver vídeos)
│           └── arquivos/     (somente para pacotes ZIP e fontes)
├── referencias/
│   ├── maia/ e nanda/
│   └── unhas-artisticas-alongadas/
└── skills/
```

As imagens ficam diretamente na pasta do produto. Não é necessário criar uma
subpasta `imagens`.

## Como adicionar um produto

1. Antes de criar uma pasta, execute `scripts/localizar-produto.ps1` passando
   o link completo ou o título do anúncio. Se houver correspondência, revise a
   pasta indicada em vez de criar um novo cadastro.
2. Escolha a influencer em `produtos/`: Maia para artigos de religiões de matriz africana e o acervo espiritual relacionado; Nanda para os demais produtos.
3. Crie uma pasta com o nome do produto em letras minúsculas, sem acentos e
   com palavras separadas por hífen.
4. Coloque as fotos, os criativos, as referências e a descrição diretamente
   nessa pasta.
5. Quando o produto vier de uma loja, crie `produto.json` com o ID e o link
   canônico do anúncio, sem parâmetros de rastreamento.
6. Execute `scripts/atualizar-catalogo.ps1` para atualizar o índice navegável
   em `CATALOGO-PRODUTOS.md`.

Exemplo de verificação preventiva:

```powershell
.\scripts\localizar-produto.ps1 "https://shop.tiktok.com/br/pdp/123456789"
```

O localizador compara primeiro o ID do anúncio e depois o título, os apelidos
e o nome da pasta. Correspondências fortes devem ser tratadas como produto já
cadastrado até que as imagens demonstrem o contrário.

Exemplo de `produto.json`:

```json
{
  "nome": "Nome comercial do produto",
  "categoria": "categoria",
  "aliases": ["Outro nome usado no anúncio"],
  "fontes": [
    {
      "plataforma": "tiktok-shop",
      "produto_id": "123456789",
      "url": "https://shop.tiktok.com/br/pdp/123456789"
    }
  ]
}
```

Exemplo:

```text
produtos/
└── nanda/
    └── nome-do-produto/
        ├── descricao-produto.txt
        ├── produto-01.webp
        ├── produto-02.webp
        ├── criativo-01.png
        └── referencia-01.png
```

## Padrão de nomes

- Fotos do catálogo: `produto-01.webp`, `produto-02.jpg`.
- Peças prontas ou geradas: `criativo-01.png`.
- Imagens auxiliares: `referencia-01.png`.
- Descrição principal: `descricao-produto.txt`.
- Outros textos devem ter nomes curtos e claros, como `detalhes.txt` ou
  `manual-copywriting.txt`.
- Sequências descritivas existentes podem ser mantidas, por exemplo
  `01-visao-geral-pedra.jpeg`.

## Influencers e organização

- [Maia](produtos/maia/README.md): artigos de religiões de matriz africana e acervo espiritual relacionado.
- [Nanda](produtos/nanda/README.md): influencer de IA com perfil mais evangélico, responsável pelos demais produtos.

As pastas dos produtos ficam diretamente dentro de cada influencer. O campo
`categoria` dos metadados continua descrevendo o tipo de produto; o campo
`personagem` identifica `maia` ou `nanda`.

Alfazemas, incensos, contas de pedra e pulseira de sete nós foram reunidos na
Maia por afinidade editorial com o acervo espiritual. Essa organização não
atribui origem africana nem uso religioso exclusivo a esses itens.

As referências de cada influencer ficam em `referencias/maia/` e
`referencias/nanda/`. A coleção geral de unhas permanece compartilhada.
Materiais que servem para vários produtos, como fotos de modelos e referências
visuais gerais, devem ficar em `referencias/`.

Arquivos idênticos que precisam ser preservados para conferência ficam em uma
subpasta `_duplicadas`, com nomes padronizados. Eles não devem permanecer
misturados às imagens principais do produto.

## Direção atual dos criativos

- Duração padrão dos vídeos: **10 segundos**, salvo duração diferente solicitada pelo usuário.
- Linguagem UGC cotidiana, menos comercial; evitar tom de vendedor, botões de compra e chamadas insistentes para o carrinho.
- POV com movimento natural de câmera e mãos, demonstrando detalhes reais do produto.
- Referências de redação e estrutura: arquivos em `referencias/direcao-criativos/`. Servem como referência; instruções específicas do usuário prevalecem, inclusive duração e tom.
- As imagens-base para animação devem ficar sem tipografia; preservar produto, quantidade e características confirmadas.

## Descrições dos produtos

Alguns produtos ainda não possuem `descricao-produto.txt`. Isso não impede o
uso das imagens, mas adicionar esse arquivo facilita buscas e a criação futura
de anúncios.

## Referências de unhas

A coleção possui 52 imagens organizadas. Consulte o [índice de unhas](referencias/unhas-artisticas-alongadas/README.md).
