#!/usr/bin/env python

"""
This program tests the solution for the riddle
"""

import random

options = [True, False]


def generate_state_state():
    return (
        random.choice(options),
        random.choice(options),
        random.choice(options),
        random.choice(options),
    )


def get_turn_angle():
    return random.choice([0, 1, 2, 3])


def apply_turn(state, turn):
    return state[turn % 4], state[(1 + turn) % 4], state[(2 + turn) % 4], state[(3 + turn) % 4]


def apply_mod(state, mod):
    if mod == "c":
        return not state[0], state[1], not state[2], state[3]
    if mod == "b":
        return not state[0], not state[1], state[2], state[3]
    if mod == "a":
        return not state[0], state[1], state[2], state[3]
    raise ValueError("shouldnt get here")


def check_win(state):
    return len(set(state)) == 1


def main():
    experiments = 1000000
    for _ in range(experiments):
        state = generate_state_state()
        if check_win(state):
            continue
        for mod in ["c", "b", "c", "a", "c", "b", "c"]:
            state = apply_mod(state, mod)
            if check_win(state):
                break
            state = apply_turn(state, get_turn_angle())
        else:
            raise ValueError("we didnt win?!?")


if __name__ == "__main__":
    main()
