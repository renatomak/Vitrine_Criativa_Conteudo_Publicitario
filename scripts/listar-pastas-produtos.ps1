$projectRoot = Split-Path -Parent $PSScriptRoot
$layouts = @(
    @{ Personagem = 'maia'; Caminho = 'produtos/maia' },
    @{ Personagem = 'nanda'; Caminho = 'produtos/nanda' },
    @{ Personagem = 'influencer-03'; Caminho = 'produtos/influencer-03' },
    @{ Personagem = 'influencer-03'; Caminho = 'influencer-03' },
    @{ Personagem = 'maia'; Caminho = 'MAIA' },
    @{ Personagem = 'maia'; Caminho = 'MAIA-MACUMBA' },
    @{ Personagem = 'nanda'; Caminho = 'NANDA-SALES' }
)
foreach ($layout in $layouts) {
    $root = Join-Path $projectRoot $layout.Caminho
    if (Test-Path -LiteralPath $root -PathType Container) {
        foreach ($directory in Get-ChildItem -LiteralPath $root -Directory | Sort-Object Name) {
            if (-not (Get-ChildItem -LiteralPath $directory.FullName -File -Recurse | Select-Object -First 1)) { continue }
            if ($directory.Name -in @('ModeloIA', 'Modelo-IA', 'Maia-Fotos')) { continue }
            if ($directory.Name -eq 'livros') {
                foreach ($book in Get-ChildItem -LiteralPath $directory.FullName -Directory) {
                    [PSCustomObject]@{ Personagem = $layout.Personagem; Directory = $book; CaminhoRelativo = "$($layout.Caminho)/livros/$($book.Name)" }
                }
                continue
            }
            [PSCustomObject]@{
                Personagem = $layout.Personagem
                Directory = $directory
                CaminhoRelativo = "$($layout.Caminho)/$($directory.Name)"
            }
        }
    }
}
