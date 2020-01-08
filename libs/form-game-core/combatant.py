
import game_stat

class Combatant:
    level = 1
    stats = game_stat.all_stats()
    max_health = 0
    cur_health = 0
    max_energy = 0
    cur_energy = 0

    def __init__(self, input_level=1):
        self.level = input_level

    def recalc(self):
        health_base = game_stat.Stat("health_base")
        energy_base = game_stat.Stat("energy_base")
        for stat in self.stats:
            stat.recalc(self.level)
            if stat.name == "health_base":
                health_base = stat
            if stat.name == "energy_base":
                energy_base = stat
        self.max_health = health_base.rating * self.level
        self.max_energy = energy_base.rating * self.level
        self.cur_health = self.max_health
        self.cur_energy = self.max_energy

    def pretty_log(self):
        for stat in self.stats:
            stat.pretty_log()
        print(f'max_health: {self.max_health}')
        print(f'cur_health: {self.cur_health}')
        print(f'max_energy: {self.max_energy}')
        print(f'cur_energy: {self.cur_energy}')

# test code
for x in range(20, 30):
    test_combatant = Combatant(x)
    test_combatant.recalc()
    test_combatant.pretty_log()
