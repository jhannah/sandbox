#!/usr/bin/env python3
"""Simulate a D&D turn for Musu and his mighty war pick."""

import random


def roll(sides):
    return random.randint(1, sides)


def main():
    a = roll(20)  # 1d20 attack roll
    b = roll(8)   # 1d8 damage roll

    print("Musu swings his mighty war pick. "
          f"If a {a + 6} hits, he does {b + 3} piercing damage "
          "and his target is now Sapped.")


if __name__ == "__main__":
    main()
