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
- PLAYER: Quant à moi, je devrais me charger de...
    * [Baisser la voile {t(STRE, lower_sail_mod)}] // 90%
        {sc(STRE, lower_sail_mod): -> lower_sail_S | -> about_tempest}
        ** (lower_sail_S) #anim:Player:lower_sail
            ~ b_sail_is_down = true
    * [Charger le tonneau d'explosifs. {t(STRE, load_barrel_mod)}] // 90%
        {sc(STRE, load_barrel_mod): -> load_barrel_S | -> about_tempest}
        ** (load_barrel_S) #anim:Player:load_barrel
            ~ b_explosive_barrel_is_loaded = true
    * [Charger le canon. {t(STRE, load_canon_mod)}] // 80%
        {sc(STRE, load_canon_mod): -> load_canon_S | -> about_tempest}
        ** (load_canon_S) #anim:Player:load_canon
            ~ b_canon_is_loaded = true
- (about_tempest) PLAYER: Cette tempête...
    * [N'annonce rien de bon...] PLAYER: ... Est le signe annonciateur d'une terrible catastrophe, foi de capitaine !
    * [Ne nous laissera pas pour morts !] PLAYER: ... Ne vaincra pas un équipage tel que le nôtre, promesse de capitaine ! 
    * [Signale la présence du Léviathan.] PLAYER: ... N'est pas une tempête ordinaire : elle indique peut-être la présence de la mythique créature ! Soyez sur vos gardes, moussaillons !
- PLAYER: Et maintenant, la priorité est de...
    * {b_sail_is_down == false} [Baisser la voile {t(STRE, lower_sail_mod)}] // 90%
        {sc(STRE, lower_sail_mod): -> lower_sail_S_2 | -> mouvement_approaching}
        ** (lower_sail_S_2) #anim:Player:lower_sail
            ~ b_sail_is_down = true
    * {b_explosive_barrel_is_loaded == false} [Charger le tonneau d'explosifs. {t(STRE, load_barrel_mod)}] // 90%
        {sc(STRE, load_barrel_mod): -> load_barrel_S_2 | -> mouvement_approaching}
        ** (load_barrel_S_2) #anim:Player:load_barrel
            ~ b_explosive_barrel_is_loaded = true
    * {b_canon_is_loaded == false} [Charger le canon. {t(STRE, load_canon_mod)}] // 80%
        {sc(STRE, load_canon_mod): -> load_canon_S_2 | -> mouvement_approaching}
        ** (load_canon_S_2) #anim:Player:load_canon
            ~ b_canon_is_loaded = true
    * [Remonter le harpon. {t(DEXT, load_harpoon_mod)}] // 90%
        {sc(DEXT, load_harpoon_mod): -> load_harpoon_S | -> mouvement_approaching}
        ** (load_harpoon_S) #anim:Player:load_harpoon
            ~ b_harpoon_is_loaded = true
- (mouvement_approaching) VIGIE: Cap'taine ! Cap'taine ! Le mouvement se rapproche !
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