import sys

def check_wire(circuit, wire):
    if wire not in circuit:
        circuit[wire] = 0
    return wire

def assign_value(circuit, wire, level):
    circuit[wire] = level

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
    instruction_list = direction.split()
    wire = check_wire(circuit, instruction_list[len(instruction_list)-1])
    for x in instruction_list:
        check_wire(circuit, x)
    if len(instruction_list) == 3:
        assign_value(circuit, wire, instruction_list[0])
    else:
        if instruction_list[0] == "NOT":
            assign_not(circuit, wire, instruction_list[1])
    if instruction_list[1] == "AND":
        perform_and(circuit, wire, instruction_list[0], instruction_list[2])
    if instruction_list[1] == "OR":
        perform_or(circuit, wire, instruction_list[0], instruction_list[2])
    if instruction_list[1] == "LSHIFT":
        perform_lshift(circuit, wire, instruction_list[0], instruction_list[2])
    if instruction_list[1] == "RSHIFT":
        perform_rshift(circuit, wire, instruction_list[0], instruction_list[2])

circuit = {}
filename = "input.txt"
with open(filename) as inputfile:
    for line in inputfile:
        decode_circuit(circuit, line)
print("end")
print(circuit)
print(circuit["a"])