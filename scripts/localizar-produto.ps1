param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Consulta
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$productFolders = @(& (Join-Path $PSScriptRoot 'listar-pastas-produtos.ps1'))

function Convert-ToSearchText {
    param([string]$Text)

    if ([string]::IsNullOrWhiteSpace($Text)) { return '' }

    $decomposed = $Text.Normalize([Text.NormalizationForm]::FormD)
    $builder = [Text.StringBuilder]::new()
    foreach ($character in $decomposed.ToCharArray()) {
        if ([Globalization.CharUnicodeInfo]::GetUnicodeCategory($character) -ne
            [Globalization.UnicodeCategory]::NonSpacingMark) {
            [void]$builder.Append($character)
        }
    }

    $plain = $builder.ToString().Normalize([Text.NormalizationForm]::FormC).ToLowerInvariant()
    return (($plain -replace '[^a-z0-9]+', ' ') -replace '\s+', ' ').Trim()
}

function Get-TitleSimilarity {
    param([string]$Left, [string]$Right)

    $leftText = Convert-ToSearchText $Left
    $rightText = Convert-ToSearchText $Right
    if (-not $leftText -or -not $rightText) { return 0.0 }
    if ($leftText -eq $rightText) { return 1.0 }
    if ($leftText.Contains($rightText) -or $rightText.Contains($leftText)) { return 0.95 }

    $ignored = @('a','as','com','da','das','de','do','dos','e','em','o','os','para','por','um','uma')
    $leftWords = @($leftText.Split(' ') | Where-Object { $_ -and $_ -notin $ignored } | Select-Object -Unique)
    $rightWords = @($rightText.Split(' ') | Where-Object { $_ -and $_ -notin $ignored } | Select-Object -Unique)
    if (-not $leftWords.Count -or -not $rightWords.Count) { return 0.0 }

    $intersection = @($leftWords | Where-Object { $_ -in $rightWords }).Count
    $union = @($leftWords + $rightWords | Select-Object -Unique).Count
    $coverage = $intersection / [Math]::Min($leftWords.Count, $rightWords.Count)
    $jaccard = $intersection / $union
    return (0.7 * $coverage) + (0.3 * $jaccard)
}

function Get-FirstProductTitle {
    param([IO.DirectoryInfo]$Directory)

    $preferredNames = @('descricao-produto.txt', 'descricao.txt', 'detalhes.txt')
    foreach ($name in $preferredNames) {
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

function Get-QueryDetails {
    param([string]$Value)

    $clean = [Net.WebUtility]::HtmlDecode($Value.Trim())
    if ($clean -match '\((https?://[^\)]+)\)') { $clean = $Matches[1] }
    elseif ($clean -match '(https?://\S+)') { $clean = $Matches[1] }
    $clean = $clean -replace '\\&', '&' -replace '\\_', '_'

    $productId = $null
    if ($clean -match '/(?:pdp|view/product)/(\d+)') { $productId = $Matches[1] }

    $title = $Value
    if ($clean -match '(?:\?|&)og_info=([^&]+)') {
        try {
            $ogInfo = [Net.WebUtility]::UrlDecode($Matches[1]) | ConvertFrom-Json
            if ($ogInfo.title) { $title = [Net.WebUtility]::UrlDecode([string]$ogInfo.title) }
        } catch {
            # O título informado ainda pode ser comparado mesmo se o parâmetro estiver incompleto.
        }
    }

    [PSCustomObject]@{ ProductId = $productId; Title = $title }
}

$query = Get-QueryDetails $Consulta
$records = @(foreach ($folder in $productFolders) {
    $directory = $folder.Directory
    $metadataPath = Join-Path $directory.FullName 'produto.json'
    $metadata = $null
    if (Test-Path -LiteralPath $metadataPath) {
        try { $metadata = Get-Content -Raw -LiteralPath $metadataPath | ConvertFrom-Json } catch {}
    }

    $title = if ($metadata.nome) { [string]$metadata.nome } else { Get-FirstProductTitle $directory }
    $aliases = @($metadata.aliases)
    $sourceIds = @($metadata.fontes | ForEach-Object { [string]$_.produto_id } | Where-Object { $_ })
    if ($directory.Name -match '^(\d{10,})(?:-|$)') { $sourceIds += $Matches[1] }
    $scores = @(
        Get-TitleSimilarity $query.Title $title
        Get-TitleSimilarity $query.Title ($directory.Name -replace '-', ' ')
        $aliases | ForEach-Object { Get-TitleSimilarity $query.Title ([string]$_) }
    )

    [PSCustomObject]@{
        Personagem = $folder.Personagem
        Pasta = $directory.Name
        Titulo = $title
        Caminho = $directory.FullName
        MesmoId = [bool]($query.ProductId -and $query.ProductId -in $sourceIds)
        Similaridade = [Math]::Round(($scores | Measure-Object -Maximum).Maximum, 2)
    }
})

$matches = @($records |
    Where-Object { $_.MesmoId -or $_.Similaridade -ge 0.60 } |
    Sort-Object @{Expression='MesmoId';Descending=$true}, @{Expression='Similaridade';Descending=$true})

if (-not $matches.Count) {
    Write-Output 'RESULTADO: nenhum produto semelhante foi localizado.'
    Write-Output 'DECISAO: o produto pode ser cadastrado como novo após conferir as imagens.'
    exit 1
}

$certain = @($matches | Where-Object { $_.MesmoId -or $_.Similaridade -ge 0.90 })
if ($certain.Count) {
    Write-Output 'RESULTADO: produto já cadastrado ou correspondência praticamente exata.'
    Write-Output 'DECISAO: não crie uma nova pasta antes de revisar o cadastro abaixo.'
} else {
    Write-Output 'RESULTADO: foram encontrados possíveis produtos semelhantes.'
    Write-Output 'DECISAO: compare as imagens antes de criar uma nova pasta.'
}

$matches | Select-Object Personagem, Pasta, Titulo, MesmoId, Similaridade, Caminho |
    Format-List | Out-String | Write-Output

if ($certain.Count) { exit 2 }
exit 3
