def add_route_distance(routes, cities, source):
    c = source.split()
    citykey = c[0] + ':' + c[2]
    cities.add(c[0])
    routes[citykey] = c[4]


def get_route_distance(routes, source, dest):
    if (source+":"+dest in routes):
        return routes[source+":"+dest]
    else:
        return routes[dest+":"+source]

filename = "input.txt"
citylist = set()
routes = {"0:0": "0"}
with open(filename) as inputfile:
    for line in inputfile:
        add_route_distance(routes, citylist, line)

print('Cities to visit')
print(citylist)
print("Routes")
print(routes)
print("Distance from Straylight to Norrath")
print(get_route_distance(routes, "Straylight", "Norrath"))

