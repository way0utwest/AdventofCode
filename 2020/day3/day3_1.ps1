$dataFile = '2020\Day3\day3_data.txt'

$part1 = 0

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


    write-host($line)
 
}
$part1 = $trees
write-host("Correct for part 1: $part1")