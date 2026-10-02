$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$productFolders = @(& (Join-Path $PSScriptRoot 'listar-pastas-produtos.ps1'))
$catalogPath = Join-Path $projectRoot 'CATALOGO-PRODUTOS.md'

function Get-FirstProductTitle {
    param([IO.DirectoryInfo]$Directory)

    foreach ($name in @('descricao-produto.txt', 'descricao.txt', 'detalhes.txt')) {
        $path = Join-Path $Directory.FullName $name
        if (Test-Path -LiteralPath $path) {
            $firstLine = Get-Content -LiteralPath $path |
                Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
                Select-Object -First 1
            if ($firstLine) { return $firstLine.Trim() }
        }
    }
    return $Directory.Name -replace '-', ' '
}

$records = @(foreach ($folder in $productFolders) {
    $directory = $folder.Directory
    $metadataPath = Join-Path $directory.FullName 'produto.json'
    $metadata = $null
    if (Test-Path -LiteralPath $metadataPath) {
        try { $metadata = Get-Content -Raw -LiteralPath $metadataPath | ConvertFrom-Json } catch {}
    }
    $title = if ($metadata.nome) { [string]$metadata.nome } else { Get-FirstProductTitle $directory }
    [PSCustomObject]@{
        Personagem = $folder.Personagem
        Pasta = $directory.Name
        Titulo = $title
        CaminhoRelativo = $folder.CaminhoRelativo
        TemDescricao = Test-Path -LiteralPath (Join-Path $directory.FullName 'descricao-produto.txt')
        TikTokId = (@(& (Join-Path $PSScriptRoot 'obter-ids-produto.ps1') -Directory $directory -Metadata $metadata) -join ', ')
        Aliases = @($metadata.aliases)
        Categoria = [string]$metadata.categoria
    }
})

$lines = [Collections.Generic.List[string]]::new()
$lines.Add('# Catálogo de Produtos')
$lines.Add('')
$lines.Add("Total: **$($records.Count) produtos**. Este arquivo é gerado por ``scripts/atualizar-catalogo.ps1``.")
$lines.Add('')
$lines.Add('Use a busca deste arquivo para localizar um nome. Antes de cadastrar um anúncio, execute `scripts/localizar-produto.ps1` com o título ou link completo.')

foreach ($group in $records | Group-Object Personagem) {
    $lines.Add('')
    $lines.Add("## $($group.Name)")
    $lines.Add('')
    foreach ($record in $group.Group) {
        $details = @("pasta: ``$($record.Pasta)``")
        if ($record.TikTokId) { $details += "TikTok: ``$($record.TikTokId)``" }
        if (-not $record.TemDescricao) { $details += 'descrição pendente' }
        $lines.Add("- [$($record.Titulo)](<$($record.CaminhoRelativo)>) — $($details -join '; ')")
    }
}

$duplicateTitles = @($records | Group-Object Titulo | Where-Object { $_.Count -gt 1 })
$invalidFolders = @($records | Where-Object { $_.Pasta -cnotmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$' })
$missingDescriptions = @($records | Where-Object { -not $_.TemDescricao })

$lines.Add('')
$lines.Add('## Alertas de organização')
$lines.Add('')
$lines.Add("- Títulos repetidos: **$($duplicateTitles.Count) grupos**.")
foreach ($duplicate in $duplicateTitles) {
    $folders = $duplicate.Group | ForEach-Object { "``$($_.CaminhoRelativo)``" }
    $lines.Add("  - $($duplicate.Name): $($folders -join ', ')")
}
$lines.Add("- Pastas fora do padrão kebab-case: **$($invalidFolders.Count)**.")
foreach ($record in $invalidFolders) { $lines.Add("  - ``$($record.CaminhoRelativo)``") }
$lines.Add("- Produtos sem ``descricao-produto.txt``: **$($missingDescriptions.Count)**.")
foreach ($record in $missingDescriptions) { $lines.Add("  - ``$($record.CaminhoRelativo)``") }

$missingIds = @($records | Where-Object { -not $_.TikTokId })
$lines.Add("- Cadastros sem ID localizado: **$($missingIds.Count)**.")
foreach ($record in $missingIds) { $lines.Add("  - $($record.Titulo): ``$($record.CaminhoRelativo)``") }
$idRows = @(foreach ($record in $records) { foreach ($id in ($record.TikTokId -split ', ' | Where-Object { $_ })) { [PSCustomObject]@{ Id = $id; Caminho = $record.CaminhoRelativo } } })
foreach ($duplicate in $idRows | Group-Object Id | Where-Object Count -gt 1) { $lines.Add("- ID em múltiplas pastas: ``$($duplicate.Name)`` — $($duplicate.Group.Caminho -join ', ')") }
Set-Content -LiteralPath $catalogPath -Value $lines -Encoding utf8
$records | Export-Csv -LiteralPath (Join-Path $projectRoot 'CATALOGO-PRODUTOS.csv') -NoTypeInformation -Encoding utf8
$records | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $projectRoot 'CATALOGO-PRODUTOS.json') -Encoding utf8
& (Join-Path $PSScriptRoot 'gerar-catalogo-visual.ps1') -Records $records
Write-Output "Catálogo atualizado: $catalogPath"
Write-Output "Produtos: $($records.Count) | Grupos repetidos: $($duplicateTitles.Count) | Descrições pendentes: $($missingDescriptions.Count)"
