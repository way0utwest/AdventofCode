$sum = 0
$file = "input.txt"
$filename = Join-Path "D:\Documents\GitHub\AdventofCode\Day 3" $file
$x = 0
$y = 0
$houses = @{"0,0" = 1}

$directions = [char[]](Get-Content $file -Encoding byte)

foreach ($char in $directions) {
  if ($char -eq '^') {$y += 1}
  if ($char -eq '>') {$x += 1}
  if ($char -eq 'V') {$y -= 1}
  if ($char -eq '<') {$x -= 1}
  $nexthouse = $x.ToString() + "," + $y.ToString()

  if ($houses.ContainsKey($nexthouse) -eq $true) {
    $houses.Set_Item($nexthouse, $houses[$nexthouse] + 1)
  }
  else {
      $houses.Add($nexthouse, 1)
  }

}
$sum = $houses.count

Write-host("Total houses with at least one present:" + $sum.ToString())
