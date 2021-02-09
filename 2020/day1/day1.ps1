# 2020 Advent of Code
# Day 1 - PoSh solution

# PPPPPPPPPPPPPPPPP                                               tttt                 1111111   
# P::::::::::::::::P                                           ttt:::t                1::::::1   
# P::::::PPPPPP:::::P                                          t:::::t               1:::::::1   
# PP:::::P     P:::::P                                         t:::::t               111:::::1   
#  P::::P     P:::::Paaaaaaaaaaaaa  rrrrr   rrrrrrrrr   ttttttt:::::ttttttt            1::::1   
#  P::::P     P:::::Pa::::::::::::a r::::rrr:::::::::r  t:::::::::::::::::t            1::::1   
#  P::::PPPPPP:::::P aaaaaaaaa:::::ar:::::::::::::::::r t:::::::::::::::::t            1::::1   
#  P:::::::::::::PP           a::::arr::::::rrrrr::::::rtttttt:::::::tttttt            1::::l   
#  P::::PPPPPPPPP      aaaaaaa:::::a r:::::r     r:::::r      t:::::t                  1::::l   
#  P::::P            aa::::::::::::a r:::::r     rrrrrrr      t:::::t                  1::::l   
#  P::::P           a::::aaaa::::::a r:::::r                  t:::::t                  1::::l   
#  P::::P          a::::a    a:::::a r:::::r                  t:::::t    tttttt        1::::l   
# PP::::::PP        a::::a    a:::::a r:::::r                  t::::::tttt:::::t     111::::::111
# P::::::::P        a:::::aaaa::::::a r:::::r                  tt::::::::::::::t     1::::::::::1
# P::::::::P         a::::::::::aa:::ar:::::r                    tt:::::::::::tt     1::::::::::1
# PPPPPPPPPP          aaaaaaaaaa  aaaarrrrrrr                      ttttttttttt       111111111111   
$dataFile = '2020\Day1\day1_data.txt'

$datarows = Get-Content $dataFile
write-host("Part 1")
$part1 = 0
$i = 0
$j = 0
foreach ($line in $datarows) {
    foreach ($line2 in $datarows) {
        $i = ($line/1)
        $j = ($line2/1)
        $sum = $i + $j
        #write-host("$i + $j = $sum")
        if ($sum -eq 2020) {
            write-host("The numbers are $i and $j")
            $part1 = $i * $j
          Break 
        }
        if ($part1 -gt 0) {break}
    }
}

write-host("part 1: $($part1)")


# PPPPPPPPPPPPPPPPP                                               tttt                222222222222222    
# P::::::::::::::::P                                           ttt:::t               2:::::::::::::::22  
# P::::::PPPPPP:::::P                                          t:::::t               2::::::222222:::::2 
# PP:::::P     P:::::P                                         t:::::t               2222222     2:::::2 
#   P::::P     P:::::Paaaaaaaaaaaaa  rrrrr   rrrrrrrrr   ttttttt:::::ttttttt                     2:::::2 
#   P::::P     P:::::Pa::::::::::::a r::::rrr:::::::::r  t:::::::::::::::::t                     2:::::2 
#   P::::PPPPPP:::::P aaaaaaaaa:::::ar:::::::::::::::::r t:::::::::::::::::t                  2222::::2  
#   P:::::::::::::PP           a::::arr::::::rrrrr::::::rtttttt:::::::tttttt             22222::::::22   
#   P::::PPPPPPPPP      aaaaaaa:::::a r:::::r     r:::::r      t:::::t                 22::::::::222     
#   P::::P            aa::::::::::::a r:::::r     rrrrrrr      t:::::t                2:::::22222        
#   P::::P           a::::aaaa::::::a r:::::r                  t:::::t               2:::::2             
#   P::::P          a::::a    a:::::a r:::::r                  t:::::t    tttttt     2:::::2             
# PP::::::PP        a::::a    a:::::a r:::::r                  t::::::tttt:::::t     2:::::2       222222
# P::::::::P        a:::::aaaa::::::a r:::::r                  tt::::::::::::::t     2::::::2222222:::::2
# P::::::::P         a::::::::::aa:::ar:::::r                    tt:::::::::::tt     2::::::::::::::::::2
# PPPPPPPPPP          aaaaaaaaaa  aaaarrrrrrr                      ttttttttttt       22222222222222222222

$part2 = 0
$i = 0
$j = 0
foreach ($line in $datarows) {
    foreach ($line2 in $datarows) {
        foreach ($line3 in $datarows) {
            $i = ($line/1)
            $j = ($line2/1)
            $k = ($line3/1)
            $sum = $i + $j + $k
            #write-host("$i + $j = $sum")
            if ($sum -eq 2020) {
                write-host("The numbers are $i and $j and $k")
                $part2 = $i * $j * $k
                Break 
            }
        if ($part2 -gt 0) {break}
        }
    if ($part2 -gt 0) {break}
    }
}

write-host("part 2: $($part2)")
