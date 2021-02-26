$dataFile = '2020\Day3\day3_data.txt'

$part2 = 1

$trees = 0
$moveDown = 1
$moveRight = 3
$currRow = 0
$nextX = 1 + $moveRight
$nextY = 1 + $moveDown

foreach ($line in Get-Content $dataFile) {
    #write-host($line)
    $currRow += 1
    $rowlength = $line.length
    Write-Host("Current spot: $nextX, $nextY")
    if ($currRow -eq $nextY){
        if ($line.substring($nextX-1, 1) -eq '#'){
            $trees+=1
        }
        $nextX += $moveRight
        if ($nextX -gt $line.length) {
            $nextX -= $line.Length
        }
        $nextY += $moveDown
    }
}
$part2 *= $trees

$trees = 0
$moveDown = 1
$moveRight = 1
$currRow = 0
$nextX = 1 + $moveRight
$nextY = 1 + $moveDown

foreach ($line in Get-Content $dataFile) {
    #write-host($line)
    $currRow += 1
    $rowlength = $line.length
    Write-Host("Current spot: $nextX, $nextY")
    if ($currRow -eq $nextY){
        if ($line.substring($nextX-1, 1) -eq '#'){
            $trees+=1
        }
        $nextX += $moveRight
        if ($nextX -gt $line.length) {
            $nextX -= $line.Length
        }
        $nextY += $moveDown
    }
}
$part2 *= $trees

$trees = 0
$moveDown = 1
$moveRight = 5
$currRow = 0
$nextX = 1 + $moveRight
$nextY = 1 + $moveDown

foreach ($line in Get-Content $dataFile) {
    #write-host($line)
    $currRow += 1
    $rowlength = $line.length
    Write-Host("Current spot: $nextX, $nextY")
    if ($currRow -eq $nextY){
        if ($line.substring($nextX-1, 1) -eq '#'){
            $trees+=1
        }
        $nextX += $moveRight
        if ($nextX -gt $line.length) {
            $nextX -= $line.Length
        }
        $nextY += $moveDown
    }
}
$part2 *= $trees

$trees = 0
$moveDown = 1
$moveRight = 7
$currRow = 0
$nextX = 1 + $moveRight
$nextY = 1 + $moveDown

foreach ($line in Get-Content $dataFile) {
    #write-host($line)
    $currRow += 1
    $rowlength = $line.length
    Write-Host("Current spot: $nextX, $nextY")
    if ($currRow -eq $nextY){
        if ($line.substring($nextX-1, 1) -eq '#'){
            $trees+=1
        }
        $nextX += $moveRight
        if ($nextX -gt $line.length) {
            $nextX -= $line.Length
        }
        $nextY += $moveDown
    }
}
$part2 *= $trees

$trees = 0
$moveDown = 2
$moveRight = 1
$currRow = 0
$nextX = 1 + $moveRight
$nextY = 1 + $moveDown

foreach ($line in Get-Content $dataFile) {
    #write-host($line)
    $currRow += 1
    $rowlength = $line.length
    if ($currRow -eq $nextY){
        if ($line.substring($nextX-1, 1) -eq '#'){
            $trees+=1
        }
        $nextX += $moveRight
        if ($nextX -gt $line.length) {
            $nextX -= $line.Length
        }
        $nextY += $moveDown
    }
}
$part2 *= $trees

write-host("Correct for part 2: $part2")