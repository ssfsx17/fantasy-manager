
import math

stat_priority_multipliers = {
    "s": 1.5,
    "a": 1.25,
    "b": 1,
    "c": 0.75,
    "d": 0.50,
    "f": 0.25,
    "z": 0
}

stat_names_and_types = {
    "health_base": "stat",
    "energy_base": "stat",
    "melee_accuracy": "stat",
    "melee_evasion": "stat",
    "melee_damage_base": "stat",
    "melee_penetration": "stat",
    "ranged_accuracy": "stat",
    "ranged_evasion": "stat",
    "ranged_damage_base": "stat",
    "ranged_penetration": "stat",
    "magic_accuracy": "stat",
    "magic_evasion": "stat",
    "magic_damage_base": "stat",
    "magic_penetration": "stat",
    "special_accuracy": "stat",
    "special_evasion": "stat",

    "barehanded": "skill",
    "melee_weapons_1h": "skill",
    "melee_weapons_2h": "skill",
    "reach_weapons_1h": "skill",
    "reach_weapons_2h": "skill",
    "ranged_weapons_1h": "skill",
    "ranged_weapons_2h": "skill"
}

class Stat():
    name = "default_stat"
    rating = 20
    modifier = 0
    priority = "f"

    def __init__(self, stat_name="health_base"):
        if (stat_name in stat_names_and_types):
            self.name = stat_name
        else:
            print(f'ERROR - invalid stat name {stat_name}')

    def set_priority(input_priority):
        if (input_priority in stat_priority_multipliers):
            priority = input_priority
        else:
            print(f'ERROR - invalid priority {input_priority}')
            priority = "f"

    def recalc(self, level=1):
        self.rating = 20 + (level * stat_priority_multipliers[self.priority])
        self.rating = math.trunc(self.rating)
        self.modifier = 0

    def pretty_log(self):
        print(f'stat {self.name}')
        print(f'  rating: {self.rating}')
        print(f'  modifier: {self.modifier}')
        print(f'  priority: {self.priority}')
