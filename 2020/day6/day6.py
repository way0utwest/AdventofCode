# part 1
part1 = 0
for answers in open("2020\day6\day6_data.txt").read().split("\n\n"):
    answers = set(answers.replace("\n",""))
    part1 += len(answers)
print("Part 1:",part1)

# part1
part2 = 0
for answers in open("2020\day6\day6_data.txt").read().split("\n\n"):
    matches = set.intersection(*[set(answer) for answer in answers.split()])
    part2 += len(matches)
print("Part 2: ", part2)
