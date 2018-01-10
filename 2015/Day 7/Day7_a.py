import sys
import re

def check_wire(circuit, wire):
    if wire not in circuit:
        return 0
    else:
        return 1

def assign_value(circuit, wire, level):
    if level.isdigit():
        circuit[wire] = level
    if check_wire(circuit, level):
        circuit[wire] = circuit[level]
    if wire == "lw" or wire == "lv" or wire == "lc" or wire == "l" or wire == "lu":
        print("************ first wire found ***** " + wire + " ******************" )

def assign_not(circuit, wire, input):
    circuit[wire] = 65535 - int(circuit[input])

def perform_and(circuit, wire, left, right):
    circuit[wire] = int(circuit[left]) & int(circuit[right])

def perform_or(circuit, wire, left, right):
    circuit[wire] = int(circuit[left]) | int(circuit[right])

def perform_lshift(circuit, wire, left, right):
    circuit[wire] = int(circuit[left]) << int(right)

def perform_rshift(circuit, wire, left, right):
    circuit[wire] = int(circuit[left]) >> int(right)

def decode_circuit(circuit, direction):
    used = 0
    instruction_list = direction.split()
    wire = instruction_list[len(instruction_list)-1]
    if len(instruction_list) == 3:
        # assign a level to this wire
        assign_value(circuit, wire, instruction_list[0])
        used = 1
    else:
        if instruction_list[0] == "NOT":
            if check_wire(circuit, instruction_list[1]):
                assign_not(circuit, wire, instruction_list[1])
                used = 1
        if instruction_list[1] == "AND":
            if check_wire(circuit, instruction_list[0]) and check_wire(circuit,instruction_list[2]):
                perform_and(circuit, wire, instruction_list[0], instruction_list[2])
                used = 1
        if instruction_list[1] == "OR":
            if check_wire(circuit, instruction_list[0]) and check_wire(circuit, instruction_list[2]):
                perform_or(circuit, wire, instruction_list[0], instruction_list[2])
                used = 1
        if instruction_list[1] == "LSHIFT":
            if check_wire(circuit, instruction_list[0]):
                perform_lshift(circuit, wire, instruction_list[0], instruction_list[2])
                used = 1
        if instruction_list[1] == "RSHIFT":
            if check_wire(circuit, instruction_list[0]):
                perform_rshift(circuit, wire, instruction_list[0], instruction_list[2])
                used = 1
    return used

circuit = {}
filename = "input.txt"
solved = 0
loop = 1
used_instructions = {}
while not solved:
    with open(filename) as inputfile:
        for line in inputfile:
            if line not in used_instructions:
                used = decode_circuit(circuit, line)
                if used == 1:
                    used_instructions[line] = 1
        if check_wire(circuit, "a"):
            if circuit["a"] > "0":
                solved = 1
    if loop % 500 == 0:
        print(str(loop))
    loop += 1
print("end")
print(circuit)
if check_wire(circuit, "a"):
    print(circuit["a"])