#!/usr/bin/env python3
"""Musu battles an enemy until it drops.

Usage:
    python3 musu_battle.py --ac 15 --hp 70
"""

import argparse
import random


def roll(sides):
    return random.randint(1, sides)


def main():
    parser = argparse.ArgumentParser(description="Musu attacks until the enemy is dead.")
    parser.add_argument("--ac", type=int, required=True, help="enemy armor class")
    parser.add_argument("--hp", type=int, required=True, help="enemy hit points")
    args = parser.parse_args()

    hp = args.hp
    while hp > 0:
        attack = roll(20) + 6
        if attack >= args.ac:
            b = roll(8)
            damage = b + 3
            hp = max(0, hp - damage)
            print(f"Hit! {damage} piercing damage + Sapped. ({hp} HP remaining)")
        else:
            print("Musu misses. sigh.")

    print("Victory! Musu has triumphed once again.")


if __name__ == "__main__":
    main()
