$sum = 0
$file = "input.txt"
$filename = Join-Path "D:\Documents\GitHub\AdventofCode\Day 3" $file
$sx = 0
$sy = 0
$rsx = 0
$rsy = 0
$santa = @{"0,0" = 1}
$who = 1

$directions = [char[]](Get-Content $file -Encoding byte)

foreach ($char in $directions) {
  if ($who -eq 1) {

     if ($char -eq '^') {$sy += 1}
     if ($char -eq '>') {$sx += 1}
     if ($char -eq 'V') {$sy -= 1}
     if ($char -eq '<') {$sx -= 1}
     $nexthouse = $sx.ToString() + "," + $sy.ToString()

     if ($santa.ContainsKey($nexthouse) -eq $true) {
       $santa.Set_Item($nexthouse, $santa[$nexthouse] + 1)
     }
     else {
       $santa.Add($nexthouse, 1)
     }
     $who = 0
  }
  else {
     if ($char -eq '^') {$rsy += 1}
     if ($char -eq '>') {$rsx += 1}
     if ($char -eq 'V') {$rsy -= 1}
     if ($char -eq '<') {$rsx -= 1}
     $nexthouse = $rsx.ToString() + "," + $rsy.ToString()

     if ($santa.ContainsKey($nexthouse) -eq $true) {
       $santa.Set_Item($nexthouse, $santa[$nexthouse] + 1)
     }
     else {
       $santa.Add($nexthouse, 1)
     }
     $who = 1

  }

}
$sum = $santa.count 

Write-host("Total houses from Santa:" + $santa.Count.ToString())
Write-host("Total houses from RoboSanta:" + $robosanta.Count.ToString())
Write-host("Total houses with at least one present:" + $sum.ToString())
