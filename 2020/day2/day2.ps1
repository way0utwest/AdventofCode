$dataFile = '2020\Day2\day2_data.txt'

$part1 = 0
$part2 = 0

foreach ($line in Get-Content $dataFile) {
    #write-host($line)
    $values = $line.Split(' ')
    $counters = $values.split('-')
    $min = $counters[0]
    $max = $counters[1]
    $checkvalue = $values[1].Substring(0, $values[1].Length - 1)
    $pwd = $values[2]
    $count = ($pwd.ToCharArray() | Where-Object {$_ -eq $checkvalue } | Measure-Object).count
    if (($count -ge $min) -and ($count -le $max)) { $part1 += 1}

    if (($checkvalue -eq $pwd[$min-1]) -ne ($checkvalue -eq $pwd[$max-1])) { $part2 += 1}

}

write-host("Correct for part 1: $part1   part2: $part2")