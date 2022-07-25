# Shellfish Fatigue Calculator
exit = 'n'

while exit == 'n':
    shellfish_died = int(input('Shellfish have died: '))
    enemy_cards = int(input('Enemy cards left: '))
    result = (shellfish_died - enemy_cards) * (shellfish_died - enemy_cards + 1) / 2
    print(result)
    exit = input("Exit? (y/n): ")
