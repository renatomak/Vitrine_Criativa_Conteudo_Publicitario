---
name: criar-ugc-videos-curtos
description: Criar um pacote de copywriting e conteudo UGC de alta conversao para tres videos curtos de ate 8 segundos no TikTok Shop e Reels. Usar quando o usuario invocar $criar-ugc-videos-curtos seguido do nome, pasta, descricao ou imagens de um produto e quiser nome de pasta, descricao curta, direcao visual, tres falas ou prompts de cenas.
---

# Criar UGC para videos curtos

## Objetivo

Transformar as informacoes verificaveis de um produto em um criativo coeso para gerar tres videos verticais de ate 8 segundos, com angulos de venda distintos e linguagem natural.

## Obter informacoes do produto

1. Interpretar o texto apos a invocacao como nome, descricao ou caminho do produto.
2. Se o produto existir no workspace, localizar sua pasta e ler `descricao-produto.txt` e outros arquivos textuais relacionados.
3. Inspecionar imagens do produto quando isso ajudar a confirmar caracteristicas visiveis.
4. Usar somente informacoes fornecidas ou verificaveis nos arquivos.
5. Nao inventar material, tamanho, quantidade, certificacao, preco, desconto, estoque, eficacia ou resultado.
6. Se faltarem dados, criar o que for possivel com seguranca e indicar ao final, em uma frase curta, quais fatos precisam ser confirmados.
7. Nao pesquisar na internet, salvo se o usuario pedir explicitamente.

## Aplicar as cinco regras de ouro

Aplicar as regras em todos os textos, sem explica-las na resposta:

1. Vender a transformacao: destacar beneficio emocional, autoestima, praticidade ou alivio.
2. Ativar a dor primeiro: comecar pelo incomodo ou situacao reconhecivel e apresentar o produto como solucao.
3. Usar especificidade extrema: falar com um perfil e uma situacao cotidiana concretos.
4. Focar no espectador: construir cerca de 70% da mensagem em torno de "voce" e da vida do cliente; evitar excesso de "eu".
5. Criar urgencia emocional: dar um motivo legitimo para agir agora e nao procrastinar. Nao inventar escassez, promocao ou prazo.

## Desenvolver os tres videos

Criar tres opcoes independentes, cada uma com um angulo diferente:

- Video 1: dor imediata e alivio.
- Video 2: transformacao desejada ou autoestima.
- Video 3: situacao especifica com urgencia emocional legitima.

Manter cada fala natural, rapida e pronunciavel em no maximo 8 segundos. Usar preferencialmente de 12 a 18 palavras em portugues e ler mentalmente em voz alta antes de entregar. Evitar introducoes, explicacoes e frases genericas.

## Regras rigidas

### Nome da pasta

- Usar somente letras minusculas, numeros e hifens.
- Remover acentos.
- Usar kebab-case, por exemplo `percarbonato-sodio-500g`.

### Descricao precisa

- Resumir apenas os pontos principais verificados.
- Limitar rigidamente a 80 caracteres, contando espacos.
- Conferir a contagem antes de responder.

### Falas

- Entregar exatamente tres falas.
- Apresentar cada fala como um paragrafo unico, continuo e independente.
- Nao numerar, nao usar travessoes, aspas, listas ou rotulos dentro da secao.
- Nao incluir instrucoes de camera, atuacao ou tipo de voz nas falas.

### Direcao visual

- Proibir maos e outras partes humanas em cena.
- Incluir literalmente a restricao "sem maos humanas em cena".
- Priorizar produto e objetos estaticos, enquadramento POV top-down ou macro, iluminacao cinematografica de estudio em golden hour ou luz quente e composicao chique e minimalista.
- Nao descrever uma pessoa usando ou segurando o produto.

### Seguranca da copy

- Nao prometer cura, resultado garantido ou beneficio nao demonstrado.
- Nao fabricar prova social, depoimentos, preco, desconto, prazo ou estoque.
- Preferir urgencia baseada no custo emocional de adiar a solucao.

## Formato padrao da resposta

Usar exatamente estas secoes, nesta ordem:

**Nome da Pasta Sugerido:** `nome-em-kebab-case`

**Descricao Precisa do Produto:** texto com no maximo 80 caracteres

**Look e Ambiente (Google Flow / Master Studio):** um prompt em portugues, coeso e pronto para uso, que sirva aos tres videos e obedeca as regras visuais.

**Falas para Videos de 8s (3 Opcoes):**

Primeira fala em um unico paragrafo.

Segunda fala em um unico paragrafo.

Terceira fala em um unico paragrafo.

Nao acrescentar confirmacao, introducao ou explicacao antes dessas secoes.

## Prompts de cenas em ingles

Incluir esta secao somente quando o usuario solicitar prompts de cenas, prompts em ingles, Google Flow detalhado ou geracao cena a cena.

Criar exatamente tres blocos:

```text
[CENA 1]
PROMPT VISUAL: ...
ACAO: ...
DIALOGO: ...
```

Repetir para `[CENA 2]` e `[CENA 3]`.

- Escrever `PROMPT VISUAL` em ingles e incluir `no human hands in frame`.
- Escrever `ACAO` em portugues, usando apenas movimento de camera, luz, produto ou objetos.
- Reutilizar no `DIALOGO` a fala correspondente, sem alteracoes.
- Projetar cada cena como um video vertical 9:16 de ate 8 segundos.

## Verificacao final

Antes de responder, confirmar silenciosamente:

- nome da pasta em kebab-case;
- descricao com 80 caracteres ou menos;
- tres opcoes realmente diferentes;
- cada fala cabe em ate 8 segundos;
- foco dominante em "voce";
- dor antes da solucao;
- urgencia sem falsa escassez;
- nenhuma mao humana na direcao visual;
- nenhuma alegacao inventada.
