import hashlib

secret_key = "iwrupvqb"
counter = 0
hash = str(secret_key)
while hash.startswith('000000') == False:
    counter += 1
    hash = hashlib.md5(str(secret_key + str(counter)).encode()).hexdigest()

print("Hash:" + str(hash))
print(secret_key + str(counter))
print(str(counter))
