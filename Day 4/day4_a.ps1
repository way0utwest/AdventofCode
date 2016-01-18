#calculate MD5 hashes
$seed = 'iwrupvqb'
$num = 300000
$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = new-object -TypeName System.Text.UTF8Encoding

while ($true) {

  $hashstring = $seed + $num.ToString()

  $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($hashstring)))
  write-host("Trying " + $num.ToString() + "   - Hash:" + $hash.ToString())

  if ($hash.ToString().Startswith("00-00-0")) {
     break
  }
  $num += 1

}

write-host($num)
