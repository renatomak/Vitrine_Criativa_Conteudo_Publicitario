# Vitrine Criativa — Conteúdo Publicitário

Acervo de materiais para criação de conteúdo publicitário, organizado por
categoria e produto.

## Onde encontrar cada material

```text
.
├── produtos/
│   └── categoria/
│       └── nome-do-produto/
│           ├── descricao-produto.txt
│           ├── produto-01.webp
│           ├── criativo-01.png
│           ├── referencia-01.png
│           ├── videos/       (somente quando houver vídeos)
│           └── arquivos/     (somente para pacotes ZIP e fontes)
├── referencias/
│   ├── modelos/
│   └── unhas-artisticas-alongadas/
└── skills/
```

As imagens ficam diretamente na pasta do produto. Não é necessário criar uma
subpasta `imagens`.

## Como adicionar um produto

1. Escolha a categoria em `produtos/`.
2. Crie uma pasta com o nome do produto em letras minúsculas, sem acentos e
   com palavras separadas por hífen.
3. Coloque as fotos, os criativos, as referências e a descrição diretamente
   nessa pasta.
4. Crie `videos/` ou `arquivos/` apenas se esses materiais existirem.

Exemplo:

```text
produtos/
└── moda-feminina/
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

## Categorias atuais

- `beleza-e-perfumaria`
- `brinquedos-e-hobbies`
- `casa-e-cozinha`
- `espiritualidade-e-artesanato`
- `limpeza`
- `livros`
- `moda-feminina`
- `moda-masculina`

Materiais que servem para vários produtos, como fotos de modelos e referências
visuais gerais, devem ficar em `referencias/`.

Arquivos idênticos que precisam ser preservados para conferência ficam em uma
subpasta `_duplicadas`, com nomes padronizados. Eles não devem permanecer
misturados às imagens principais do produto.

## Observação sobre descrições

Alguns produtos ainda não possuem `descricao-produto.txt`. Isso não impede o
uso das imagens, mas adicionar esse arquivo facilita buscas e a criação futura
de anúncios.
