# Day 3 A 
import sys

input = int(sys.argv[1])

ring = 0
max_ring_val = 1

while max_ring_val < input:
    ring += 1
    max_ring_val += 8 * ring

sequence_index = (input - 1) % (2 * ring)
dist_along_edge = abs(sequence_index - ring)
taxi_dist = dist_along_edge + ring

print taxi_dist
print ring
print max_ring_val
print sequence_index
print dist_along_edge
