// TEMPEST SCENE

// Scene
=== tempest ===
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Moussaillon:MOUSSAILLON
-> start

= start
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Moussaillon:MOUSSAILLON
// Set the location
#set:tempest
// Set the actor's positions
#position:Player:4:2
#position:Moussaillon:30:30
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3

// Start the scene
#audience:ovation
#move(Player)
- -> boss_battle
VIGIE: Cap'taine ! Cap'taine ! J'aperçois du mouvement dans l'eau, à tribord.
    * [Sans doute le Léviathan !] PLAYER: Nul doute qu'il s'agit du Léviathan ! Nous sommes à l'endroit exact indiqué par la carte.
        #audience:surprised
        VIGIE: Si vous l'dites, cap'taine !
    * [On appelle cela des vagues.] PLAYER: N'as-tu jamais vu des vagues auparavant, matelot ?
        #audience:laugh
        VIGIE: Quelques-unes, cap'taine, mais jamais de si hautes ! 
    * [Concentrons-nous sur la tempête.] PLAYER: Ce n'est pas le plus important. Une telle tempête requiert toute notre attention, matelot !
        #audience:applause
        VIGIE: Bien compris, cap'taine !
- // Actions du joueur
    * [Baisser les voiles.]
        ~ b_sail_is_down = true
    * [Amener un deuxième tonneau.]
        ~ b_explosive_barrel_2_is_brought_and_not_used = true
    * [Charger le harpon.]
        ~ b_harpoon_is_loaded = true
- PLAYER: Cette tempête...
    * [N'annonce rien de bon...] PLAYER: ... Est le signe annonciateur d'une terrible catastrophe, foi de capitaine !
    * [Ne nous laissera pas pour morts !] PLAYER: ... Ne vaincra pas un équipage tel que le nôtre, promesse de capitaine ! 
    * [Signale la présence du Léviathan.] PLAYER: ... N'est pas une tempête ordinaire : elle indique peut-être la présence de la mythique créature ! Soyez sur vos gardes, moussaillons !
-
    * {b_sail_is_down == false} [Baisser les voiles.]
        ~ b_sail_is_down = true
    * {b_explosive_barrel_2_is_brought_and_not_used == false} [Amener un deuxième tonneau.]
        ~ b_explosive_barrel_2_is_brought_and_not_used = true
    * {b_harpoon_is_loaded == false} [Charger le harpon.]
        ~ b_harpoon_is_loaded = true
    * [Charger le canon.]
        ~ b_canon_is_loaded = true
- VIGIE: Cap'taine ! Cap'taine ! Le mouvement se rapproche !
- PLAYER : Le mouvement... se rapproche ?
    * [Que veux-tu dire ?] PLAYER: Que veux-tu dire, matelot ?
        VIGIE: Le mouvement dont je parlais : il se rapproche à toute hâte, cap'taine !
    * [Qu'il vienne, nous l'attendons !] PLAYER: Un mouvement, tu dis ? Qu'il vienne nous chercher ! Nous l'attendons !
        VIGIE : Nous n'attendrons pas longtemps, cap'taine ! Il se rapproche à toute hâte !
    * [Le mouvement... des vagues ?] PLAYER: Moussaillon, as-tu jamais connu une tempête ? Le mouvement des vagues ne se rapproche pas, il est partout !
        VIGIE: Sauf votre respect, mon cap'taine... Ce ne sont pas des vagues qui se rapprochent à toute hâte !
#creature_apparition
#audience:shock
#audience:ovation
#audience:ovation
- -> boss_battle