#Day 5 - Strings

$nicestrings = 0
$file = "input.txt"
$filename = Join-Path "C:\users\steve\documents\github\AdventofCode\Day 5" $file

foreach ($line in [System.IO.File]::ReadLines($filename)) {
   write-host($line)
}



write-host($nicestrings)
