// TEMPEST SCENE

// Variables
VAR sails_down = false
VAR harpoon_loaded = false
VAR first_explosive_barrel_loaded = false
VAR second_explosive_barrel_supplied = false
VAR second_explosive_barrel_loaded = false
VAR cannon_loaded = false

// Scene
=== tempest ===
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Moussaillon:MOUSSAILLON
-> start

= start
#audience:ovation
#move(Player)
VIGIE: Cap'taine ! Cap'taine ! J'aperçois du mouvement dans l'eau, à tribord.
    * [Sans doute le Léviathan !] PLAYER: Nul doute qu'il s'agit du Léviathan ! Nous sommes à l'endroit exact indiqué par la carte.
        #audience:surprised
        VIGIE: Si vous l'dites, cap'taine !
    * [On appelle cela des vagues.] PLAYER: N'as-yu jamais vu des vagues auparavant, matelot ?
        #audience:laugh
        VIGIE: Quelques unes, cap'taine, mais jamais de si hautes ! 
    * [Concentrons-nous sur la tempête.] PLAYER: Ce n'est pas le plus important. Une telle tempête requière toute notre attention, matelot !
        #audience:applause
        VIGIE: Bien compris, cap'taine !
-
    * [Baisser les voiles.]
        ~ sails_down = true
        #anim:
    * [Charger le harpon.]
        ~ harpoon_loaded = true
    * [Charger de poudre le tonneau.]
        ~ first_explosive_barrel_loaded = true
- PLAYER: Cette tempête...
    * [N'annonce rien de bon...] PLAYER: ... Est le signe annonciateur d'une terrible catastrophe, foi de capitaine !
    * [Ne nous laissera pas pour morts !] PLAYER: ... Ne vaincra pas un équipage tel que le notre, promesse de capitaine ! 
    * [Signale la présence du Léviathan.] PLAYER: ... N'est pas une tempête ordinaire : elle indique peut-être la présence de la mythique créature ! Soyez sur vos gardes, moussaillons !
-
    * {sails_down == false} [Baisser les voiles.]
    * {sails_down == true} [Charger le harpon.]
    * [Charger le canon.]
    * [Amener un deuxième tonneau.]
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
- -> tribunal_2