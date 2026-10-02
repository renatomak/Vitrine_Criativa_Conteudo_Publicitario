param([IO.DirectoryInfo]$Directory, $Metadata)
# IDs permanecem strings para evitar perda de precisão.
$ids = @($Metadata.fontes | Where-Object plataforma -eq 'tiktok-shop' | ForEach-Object { [string]$_.produto_id } | Where-Object { $_ -match '^\d{19}$' })
if ($Directory.Name -match '^(\d{19})(?:-|$)') { $ids += $Matches[1] }
foreach ($file in Get-ChildItem -LiteralPath $Directory.FullName -File | Where-Object { $_.Extension -in @('.txt','.md') }) {
    $content = Get-Content -LiteralPath $file.FullName -Raw
    foreach ($match in [regex]::Matches($content, '(?i)(?:/pdp/(?:[^/\s?]+/)?|/view/product/|\bID(?:\s+do\s+produto)?(?:\s+TikTok(?:\s+Shop)?)?\s*:\s*)(\d{19})(?!\d)')) {
        $ids += $match.Groups[1].Value
    }
}
$ids | Sort-Object -Unique
