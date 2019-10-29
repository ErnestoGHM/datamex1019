import random

print('Welcome to Mini-Risk!\n'
'WAR! America and Europe have engaged in a fearsome battle for World domination!\n\n'
'Instructions:'
"'The objective of the game is to win all of your opponent's territories; you lose the game if the opposite happens.\n"
'You will start controlling 5 American regions, where you will display your initial troops (20 units).\n'
"As an attacker, you'll toss 3 dice, it you have 4 or more troops in your attacking region, 2 dice if you have three troops, 1 die if tou have two, and can´t attack if you just have one troop.\n"
"As a defender, you won´t choose with which region you will defend, and you'll toss 2 dice if you have two or more troops in your region, or 1 die if you have one.\n"
"When combat happens, the dice will be matched, taking the attacker's top throws against the defender's. When there´s a tie, the defender will win the battle.\n")

Die = [1,2,3,4,5,6]
Region = {'South_America':0,'Central_America':0,'Mexico':0,'USA':0,'Canada':0}
Enemyregion = {'UK':4,'Iberic_Peninsule':4,'Nordic_Countries':4,'Mid_Europe':4,'East_Europe':4}

print('Game Setup.\n'
"You'll play as America, and your enemy as Europe.\nHere are your regions : 'South_America','Central_America','Mexico','USA','Canada'\n"
"And your enemies': 'UK','Iberic_Peninsule','Nordic_Countries','Mid_Europe','East_Europe'\n"
'You have 20 available troops, please assign them to your regions. You need to assign at least one to each of them.')

def assign(Troops=20):
    counter = 0
    for x in Region:
        print("Assign troops to {}: (remaining troops: {})".format(x,Troops))
        Region[x]= int(input())
        counter += Region[x]
        Troops -= int(Region[x])
    if counter > 20:
        print("You assigned too many troops, let's try again.")
        assign()

for y in Region:
    if Region[y]==0:
        assign()
    elif Region[y] <= 0:
        print('error')
        assign()
print("Let's begin!{}".format(Region))

def attackchoice():
    print('Choose your attacker:')
    attacker = input()
    if attacker in Region.keys() and Region[attacker]>1:
        return attacker
    elif attacker not in Region.keys():
        print('Choose a valid option.')
        attackchoice()
    elif Region[attacker]<=1:
        print('Choose among the regions that have 2 or more Troops.')
        attackchoice()

attch=attackchoice()


def attack():
    att = []
    df = []
    if Region[attch] >= 4:
        att = [random.choice(Die), random.choice(Die), random.choice(Die)]
    elif Region[attch] == 3:
        att = [random.choice(Die), random.choice(Die)]
    elif Region[attch] == 2:
        att = [random.choice(Die)]
    print('Choose an Enemy region: {}'.format(Enemyregion))
    oppreg = input()
    if oppreg in Enemyregion.keys() and Enemyregion[oppreg] > 0:
        if Enemyregion[oppreg] >= 2:
            df = [random.choice(Die), random.choice(Die)]
        elif Enemyregion[oppreg] == 1:
            df = [random.choice(Die)]
    elif attch == 3:
        att = [random.choice(Die), random.choice(Die)]
        for y in range(Enemyregion[oppreg]):
            df.append(random.choice(Die))
    elif oppreg not in Enemyregion.keys():
        print('Choose a valid option.')
        attack()
    elif Enemyregion.keys() <= 0:
        print('Choose among the regions that have 2 or more Troops.')
        attack()

    att.sort(reverse=True)
    df.sort(reverse=True)

    print('{} attacking dice: {}'.format(attch, att))
    print('{} defending dice: {}'.format(oppreg, df))

    valatt = Region[attch]
    valdf = Enemyregion[oppreg]

    for w in range(min(len(att), len(df))):
        if att[w] > df[w]:
            valdf -= 1
            Enemyregion[oppreg] = valdf
        elif df[w] >= att[w]:
            valatt -= 1
            Region[attch] = valatt

    print(Region)
    print(Enemyregion)


def defense():
    att = []
    df = []
    print('Enemy preparing attack...')
    for k, v in Enemyregion.items():
        if v >= 4:
            attch = k
            att = [random.choice(Die), random.choice(Die), random.choice(Die)]
        elif v == 3:
            attch = k
            att = [random.choice(Die), random.choice(Die)]
        elif v == 2:
            attch = k
            att = [random.choice(Die)]

    for g, h in Region.items():
        if h == 1:
            oppreg = g
            df = [random.choice(Die)]
        elif h >= 2:
            oppreg = g
            df = [random.choice(Die), random.choice(Die)]

    att.sort(reverse=True)
    df.sort(reverse=True)

    print('{} attacking dice: {}'.format(attch, att))
    print('{} defending dice: {}'.format(oppreg, df))

    valatt = Enemyregion[k]
    valdf = Region[g]

    for w in range(min(len(att), len(df))):
        if att[w] > df[w]:
            valdf -= 1
            Region[g] = valdf
        elif df[w] >= att[w]:
            valatt -= 1
            Enemyregion[k] = valatt

    print(Region)
    print(Enemyregion)

while Region.values and Enemyregion != 0 and 1:
    attack()
    defense()
    attch = attackchoice()