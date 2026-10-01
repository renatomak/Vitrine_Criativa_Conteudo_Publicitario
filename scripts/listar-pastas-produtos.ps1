$projectRoot = Split-Path -Parent $PSScriptRoot
$layouts = @(
    @{ Personagem = 'maia'; Caminho = 'produtos/maia' },
    @{ Personagem = 'nanda'; Caminho = 'produtos/nanda' },
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
            [PSCustomObject]@{
                Personagem = $layout.Personagem
                Directory = $directory
                CaminhoRelativo = "$($layout.Caminho)/$($directory.Name)"
            }
        }
    }
}
