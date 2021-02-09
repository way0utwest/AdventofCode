# 2020 Advent of Code
# Part 1 - The Expense reports


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

file_handle = open('2020\day1\day1_data.txt', 'r')
expensereports = file_handle.readlines()
file_handle.close
#expensereports = (1721,979,366,299,675,1456)
print("Part 1")
print("=============")
stop = 0
for i in expensereports:
    for j in expensereports:
        sumoftwo = int(i) + int(j)
        #print(i, " + ", j, " = ", sumoftwo)
        if sumoftwo == 2020:
            print("The two numbers are: ", i, " and ", j)
            print("product:",int(i)*int(j))
            stop = 1
            break
    if stop == 1:
        break

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
stop = 0
print("Part 2")
print("=============")
for i in expensereports:
    if stop == 1:
        break
    for j in expensereports:
        if stop == 1:
            break
        for k in expensereports:
            sumofthree = int(i) + int(j) + int(k)
            if sumofthree == 2020:
                productofthree = int(i) * int(j) * int(k)
                print("The three numbers are: ", i, " and ", j, " and ", k)
                print(productofthree)
                stop = 1
                break
