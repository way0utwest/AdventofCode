$sum = 0
$file = "input.txt"
$filename = Join-Path "D:\Documents\GitHub\AdventofCode\Day 2 - Wrapping" $file

foreach ($line in [System.IO.File]::ReadLines($filename)) {
    $dimensions = $line.split("x") | % {iex $_} | Sort-Object
    $length = $dimensions[0]
    $width = $dimensions[1]
    $height = $dimensions[2]
    $sum = $sum + ((2*$length*$width) + (2 * $length * $height) + (2 * $width * $height) + ($length * $width))
}

Write-Host("Total:" + $sum)