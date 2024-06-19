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
#position:Player:6:2
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3

// Start the scene
#audience:ovation
- VIGIE: Cap'taine ! Cap'taine ! J'aperçois du mouvement dans l'eau, à tribord. #playsound:VOX_Vigie_captaine
    * [Sans doute le Léviathan !] PLAYER: Nul doute qu'il s'agit du <shake a=0.5><b>Léviathan</b></shake> ! Nous sommes à l'endroit exact indiqué par la carte. #playsound:VOX_Player_nuldoutelevi
        #audience:surprised
        VIGIE: Si vous l'dites, cap'taine ! #playsound:VOX_Vigie_sivouldites
    * [On appelle cela des vagues.] PLAYER: N'as-tu jamais vu des vagues auparavant, matelot ? #playsound:VOX_Player_jamaisvudevague
        #audience:laugh
        VIGIE: Quelques-unes, cap'taine, mais jamais de si hautes ! #playsound:VOX_Vigie_quelquesunes
    * [Concentrons-nous sur la tempête.] PLAYER: Ce n'est pas le plus important. Une telle tempête requiert toute notre attention, matelot ! #playsound:VOX_Player_tempetetouteattention
        #audience:applause
        VIGIE: Bien compris, cap'taine ! #playsound:VOX_Vigie_biencompris
- PLAYER: Quant à moi, je devrais me charger de...
    * [Baisser la voile {t(STRE, lower_sail_mod)}] // 90%
        {sc(STRE, lower_sail_mod): -> lower_sail_S | -> about_tempest}
        ** (lower_sail_S) #lower_sail
            ~ b_sail_is_down = true
    * [Charger le tonneau d'explosifs. {t(STRE, load_barrel_mod)}] // 90%
        {sc(STRE, load_barrel_mod): -> load_barrel_S | -> about_tempest}
        ** (load_barrel_S) #anim:Player:load_barrel
            ~ b_explosive_barrel_is_loaded = true
    * [Charger le canon. {t(STRE, load_canon_mod)}] // 80%
        {sc(STRE, load_canon_mod): -> load_canon_S | -> about_tempest}
        ** (load_canon_S) #anim:Player:load_canon
            ~ b_canon_is_loaded = true
- (about_tempest) PLAYER: Cette tempête... #playsound:VOX_Player_cettetempete
    * [N'annonce rien de bon...] PLAYER: ... Est le signe annonciateur d'une terrible catastrophe, foi de capitaine ! #playsound:VOX_Player_signeterriblecata
    * [Ne nous laissera pas pour morts !] PLAYER: ... Ne vaincra pas un équipage tel que le nôtre, promesse de capitaine ! #playsound:VOX_Player_nevaincrapasequipage
    * [Signale la présence du Léviathan.] PLAYER: ... N'est pas une tempête ordinaire : elle indique peut-être la présence de la mythique créature ! Soyez sur vos gardes, moussaillons ! #playsound:VOX_Player_pastempereordinaire
- PLAYER: Et maintenant, la priorité est de...
    * {b_sail_is_down == false} [Baisser la voile {t(STRE, lower_sail_mod)}] // 90%
        {sc(STRE, lower_sail_mod): -> lower_sail_S_2 | -> mouvement_approaching}
        ** (lower_sail_S_2) #lower_sail
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
- (mouvement_approaching) VIGIE: Cap'taine ! Cap'taine ! Le mouvement se rapproche ! #playsound:VOX_Vigie_captaine2
- PLAYER : Le mouvement... se rapproche ? #playsound:VOX_Player_mouvementrapporche
    * [Que veux-tu dire ?] PLAYER: Que veux-tu dire, matelot ? #playsound:VOX_Player_queveuxtudire
        VIGIE: Le mouvement dont je parlais : il se rapproche à toute hâte, cap'taine ! #playsound:VOX_Vigie_mouvement
    * [Qu'il vienne, nous l'attendons !] PLAYER: Un mouvement, tu dis ? Qu'il vienne nous chercher ! Nous l'attendons ! #playsound:VOX_Player_unmouvementtudis
        VIGIE : Nous n'attendrons pas longtemps, cap'taine ! Il se rapproche à toute hâte ! #playsound:VOX_Vigie_nattendronspas
    * [Le mouvement... des vagues ?] PLAYER: Moussaillon, as-tu jamais connu une tempête ? Le mouvement des vagues ne se rapproche pas, il est partout ! #playsound:VOX_Player_moussaillonjamaistempete
        VIGIE: Sauf votre respect, mon cap'taine... Ce ne sont pas des vagues qui se rapprochent à toute hâte ! #playsound:VOX_Vigie_saufvotrespect
#creature_apparition
#audience:shock
#audience:ovation
#audience:ovation
- -> boss_battle