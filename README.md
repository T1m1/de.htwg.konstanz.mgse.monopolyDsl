# Example Monopoly DSL
```
Monopoly htwg


// Game
Fieldsize 28
Bank bank with currency in "Euro" with parking money 200
Dicevalue from 1 to 6

// Fields
Field Datenbank Type STREET Price 200 Position 2
Field Modellgetrieben Type STREET Price 200 Position 3
Field Mathe Type STREET Price 300 Position 4
...

// Community Cards
CommunityCard commnitycard1 description "Ziehe von deinen Spielern 200 Euro ein"
CommunityCard communitycard2 description "Zahle deinen Gegenspielern 200 Euro"
...

// Change Cards
ChangeCard changecard1 description "Ziehe von deinen Spielern 200 Euro ein"
ChangeCard changecard2 description "Zahle deinen Gegenspielern 200 Euro"
...

// Player
Player Timi startposition 0 with budget 2000 number of prison free cards 5 with Icon Boger
Player Steffen startposition 0 with budget 100 number of prison free cards 0 with Icon Eck;
...
```


## How

1. MonopolyDSL.xtext -> right click -> run as -> Generate Xtext Artifacts
2. GenerateMonopolyDSL.mwe2 -> run as -> MWE2 Workflow
3. de.htwg.konstanz.de.mgse.monopolyDsl -> run as -> Eclipse Application
4. Create empty project
5. Create empty file with extension: .monopoly
5. write dsl
