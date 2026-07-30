# Vitrine Criativa — Conteúdo Publicitário

Acervo de imagens, vídeos, descrições e referências para criação de conteúdo
publicitário.

## Estrutura

```text
.
├── produtos/
│   ├── beleza-e-perfumaria/
│   ├── casa-e-cozinha/
│   ├── espiritualidade-e-artesanato/
│   ├── limpeza/
│   ├── livros/
│   ├── moda-feminina/
│   └── moda-masculina/
└── referencias/
    ├── modelos/
    └── unhas-artisticas-alongadas/
```

Cada produto mantém `descricao-produto.txt` diretamente em sua raiz, quando
houver uma descrição disponível, e utiliza somente as subpastas necessárias:

- `imagens/`: fotos de produto, criativos e capturas de referência;
- `videos/`: vídeos prontos ou materiais para edição;
- `textos/`: páginas e materiais textuais complementares;
- `arquivos/`: pacotes compactados recebidos como fonte.

## Padrão de nomes

- Letras minúsculas, sem acentos e sem espaços.
- Palavras separadas por hífen.
- Fotos de catálogo: `produto-01.webp`, `produto-02.jpg`.
- Peças geradas ou editadas: `criativo-01.png`.
- Capturas e imagens auxiliares: `referencia-01.png`.
- Sequências com significado mantêm a numeração e a descrição, como
  `01-visao-geral-pedra.jpeg`.
- Descrições principais usam `descricao-produto.txt` na raiz da pasta do
  produto.

## Catálogo

O acervo está dividido em 7 categorias, com 26 produtos. As duas pastas
anteriores do kit de 5 shorts Arara Sport foram reunidas em um único produto,
sem descarte dos arquivos de origem.

As fotos de pessoas que estavam soltas na raiz ficam em
`referencias/modelos/`. As imagens de unhas artísticas ficam em
`referencias/unhas-artisticas-alongadas/`.
