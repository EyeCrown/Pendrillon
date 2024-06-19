// BOSS BATTLE SCENE

// Player variables
VAR b_player_is_dead = false
VAR b_player_won = false
VAR b_player_hp = 20
VAR b_player_AP = 2
VAR b_player_AP_by_turn = 2
VAR b_player_is_on_top_of_mast = false
// Player attacks damages
VAR harpoon_damages = 15
VAR canon_damages = 22
VAR explosive_barrel_on_mouth_damages = 42
VAR angel_jump_damages = 27
// Player moovepool
VAR load_harpoon_mod = 40 // 90%
VAR aim_harpoon_mod = 35 // 85%
VAR shoot_harpoon_mod_default = 15 // 65% (90% si on vise)
VAR shoot_harpoon_mod = 15 // 65% (90% si on vise)
VAR load_canon_mod = 30 // 80%
VAR aim_canon_mod = 35 // 85%
VAR shoot_canon_mod_default = 0 // 50% (75% si on vise)
VAR shoot_canon_mod = 0 // 50%
VAR load_barrel_mod = 40 // 90%
VAR throw_barrel_mod = 25 // 75%
VAR climb_mast_mod = 35 // 75%
VAR lower_sail_mod = 40 // 90%
VAR angel_jump_mod = 25 // 60%
VAR aim_bonus_mod = 35
// Souffleur variables
VAR souffleur_explained_AP = false
VAR souffleur_explained_special_attack = false
VAR souffleur_explained_mast = false
VAR souffleur_explained_sail_down = false
VAR souffleur_told_mid_life = false
VAR souffleur_told_about_to_die = false
VAR souffleur_reaction_about_sail_down = false

// Environement
VAR b_harpoon_is_loaded = false
VAR b_harpoon_is_aimed = false
VAR b_canon_is_loaded = false
VAR b_canon_is_aimed = false
VAR b_nb_canon_bullet_left = 3
VAR b_sail_is_down = false
VAR b_mast_is_cracked = false
VAR b_mast_is_broken = false
VAR b_explosive_barrel_is_used = false
VAR b_explosive_barrel_is_loaded = false
VAR b_fall_out_of_mast_damages = 2

// Boss variables
// Base
VAR b_boss_is_dead = false
VAR b_boss_state = "default"
VAR boss_is_attacking = false
VAR b_boss_attack = 1
VAR b_tail_attack = false
VAR b_boss_max_hp = 120 // Doit être le même nombre que b_boss_hp
VAR b_boss_hp = 120 // Doit être le même nombre que b_boss_max_hp
VAR nb_state_before_special_attack = 2
// Boss attacks
// [1: default attack]
VAR b_boss_default_attack_power = 1
// [2: open mouth attack]
VAR b_boss_open_mouth_attack_power = 3
VAR b_boss_open_mouth_attack_probability = 80
// [3: on boat attack]
VAR b_boss_on_boat_attack_power = 3
VAR b_boss_on_boat_attack_probability = 80
// [4: special attack]
VAR b_boss_special_attack_power = 6

// Scene
=== boss_battle ===
- -> start

= start

// Start the scene 
- #audience:ovation #battle:begin #screenshake
- SOUFFLEUR: Psssst... Hé, l'ami ! #screenshake #wait:7 #playsound:VOX_Souffleur_pssthe7 #audience:ovation
SOUFFLEUR: Cette scène nous coûte <b>une fortune</b> en effets spéciaux à chaque spectacle... #playsound:VOX_Souffleur_fortuneeffetsspecias
SOUFFLEUR: Tu n'imagines pas le budget que ça représente, en termes de chorégraphie, matériel, main-d'œuvre... #playsound:VOX_Souffleur_budget
SOUFFLEUR: Sans parler des <b><shake a=0.5>coûts d'entretien</shake></b> ! #playsound:VOX_Souffleur_coutentretien
SOUFFLEUR: Profitons-en pour en mettre plein les yeux au public, d'accord l'ami ? #playsound:VOX_Souffleur_pleinlesyeux
- -> player_moovepool

// Souffleur explain action points
= souffleur_explain_action_points
- SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe4
SOUFFLEUR: Tu viens de faire une action nécessitant un <b>talent</b>, pas vrai l'ami ? #playsound:VOX_Souffleur_bref
SOUFFLEUR: Sache que lors d'un combat, tu peux effectuer <b>plusieurs actions</b> de ce type lors d'un <b>même tour</b>. #playsound:VOX_Souffleur_plusieursactions
SOUFFLEUR: Le nombre de <b>talents</b> que tu peux utiliser avant que ton tour ne se termine est <b>inscrit au-dessus</b>. #playsound:VOX_Souffleur_talentesecritdessus
SOUFFLEUR: On appelle ça des <shake a=0.5><b>points d'action™</b></shake>. Enfin... c'est <i>moi</i> qui les appelle comme ça. #playsound:VOX_Souffleur_pa
SOUFFLEUR: Une dernière chose : tu peux <b>passer ton tour</b> si tu le souhaites. #playsound:VOX_Souffleur_passersontour
SOUFFLEUR: Tes <b>points d'action</b> seront <b>mis de côté</b> pour le <b>tour suivant</b>. #playsound:VOX_Souffleur_pastored
SOUFFLEUR: Bonne chance, l'ami ! #playsound:VOX_Souffleur_glhf
~ souffleur_explained_AP = true
{
    - b_player_is_on_top_of_mast:
        -> on_top_of_mast
    - else:
        -> player_moovepool
}

// // Souffleur explain special attack
// = souffleur_explain_special_attack
// - SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe4
// SOUFFLEUR: Le <shake a=0.5><b>Léviathan</b></shake> s'apprête à faire une attaque <shake a=0.5>dévastatrice</shake> !
// SOUFFLEUR: Un conseil d'ami : prend de la <b>hauteur</b>.
// SOUFFLEUR: Bonne chance, l'ami !
// ~ souffleur_explained_special_attack = true
// {
//     - b_player_is_on_top_of_mast:
//         -> on_top_of_mast
//     - else:
//         -> player_moovepool
// }

// Souffleur give adice about sail down
= souffleur_advice_about_sail_down
{
    - b_sail_is_down:
    {
        - b_player_is_on_top_of_mast:
            -> on_top_of_mast
        - else:
            -> player_moovepool
    }
}
- SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe12
SOUFFLEUR: Lors d'une tempête, un marin devrait toujours <b>baisser les voiles</b> de son navire. #playsound:VOX_Souffleur_lorsdunetempete
SOUFFLEUR: C'est un petit conseil d'ami, fais-en ce que tu veux... #playsound:VOX_Souffleur_petitconseilcequrtu
SOUFFLEUR: Tu ne pourras pas dire que je ne t'ai pas prévenu, l'ami ! #playsound:VOX_Souffleur_pasdirepasprevenu
~ souffleur_explained_sail_down = true
{
    - b_player_is_on_top_of_mast:
        -> on_top_of_mast
    - else:
        -> player_moovepool
}

// Player mooves
= player_moovepool
// Player turn
C'est à votre tour.
~ boss_is_attacking = false
// Checks if boss or player is dead
{
    - b_boss_is_dead:
        -> kill_boss
    - b_player_is_dead:
        -> kill_player
}
// Checks if player has no AP
{b_player_AP<=0: -> end_turn}
// Player movepool
    + (use_harpoon) [Utiliser le harpon.]
        // Checks if boss or player is dead
        {
            - b_boss_is_dead:
                -> kill_boss
            - b_player_is_dead:
                -> kill_player
        } #move:Player:6:4:run
        ++ {b_player_AP > 0 && b_player_is_on_top_of_mast == false && b_harpoon_is_loaded == false} [Remonter le harpon. {t(DEXT, load_harpoon_mod)}] #look:Player:back #anim:Player:use // 90%
            {
                - sc(DEXT, load_harpoon_mod):
                    ~ load_harpoon()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_player_is_on_top_of_mast == false && b_harpoon_is_loaded == true && b_harpoon_is_aimed == false} [Viser avec le harpon. {t(DEXT, aim_harpoon_mod)}] #look:Player:back #anim:Player:use // 85%
            {
                - sc(DEXT, aim_harpoon_mod): 
                    ~ aim_harpoon()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_player_is_on_top_of_mast == false && b_harpoon_is_loaded == true} [Tirer avec le harpon. {t(DEXT, shoot_harpoon_mod)}] #look:Player:back #anim:Player:use // 65% (90% si on vise)
            {
                - sc(DEXT, shoot_harpoon_mod): 
                    ~ shoot_harpoon()
                - else:
                    ~ shoot_harpoon_fail()
            }
        ++ [Retourner sur le pont.]
            -> player_moovepool
        -- {souffleur_explain_action_points == false: -> souffleur_explain_action_points}
        -- {b_player_AP>0: -> use_harpoon | -> end_turn}
    + (use_canon) {b_nb_canon_bullet_left > 0} [Utiliser le canon.] 
        // Checks if boss or player is dead
        {
            - b_boss_is_dead:
                -> kill_boss
            - b_player_is_dead:
                -> kill_player
        } #move:Player:6:10:run
        ++ {b_player_AP > 0 && b_canon_is_loaded == false && b_nb_canon_bullet_left > 0} [Charger le canon. {t(STRE, load_canon_mod)}] #look:Player:back #anim:Player:use // 80%
            {
                - sc(STRE, load_canon_mod): 
                    ~ load_canon()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_canon_is_loaded == true && b_canon_is_aimed == false} [Viser avec le canon. {t(DEXT, aim_canon_mod)}] #look:Player:back #anim:Player:use // 85%
            {
                - sc(STRE, aim_canon_mod): 
                    ~ aim_canon()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_canon_is_loaded == true} [Tirer avec le canon. {t(STRE, shoot_canon_mod)}] #look:Player:back #anim:Player:use // 50% (75% si on vise)
            {
                - sc(STRE, shoot_canon_mod): 
                    ~ shoot_canon()
                - else:
                    ~ shoot_canon_fail()
            }
        ++ [Retourner sur le pont.]
            -> player_moovepool
        -- {souffleur_explain_action_points == false: -> souffleur_explain_action_points}
        -- {b_player_AP>0: -> use_canon | -> end_turn}
    + (use_barrels) {(b_player_AP > 0 && b_explosive_barrel_is_used == false && b_explosive_barrel_is_loaded == false) or (b_player_AP > 0 && b_boss_state != "under water" && b_explosive_barrel_is_used == false && b_explosive_barrel_is_loaded == true && b_boss_state == "open mouth")} [Utiliser le tonneau explosif.]
        // Checks if boss or player is dead
        {
            - b_boss_is_dead:
                -> kill_boss
            - b_player_is_dead:
                -> kill_player
        } #move:Player:8:2:run
        ++ {b_player_AP > 0 && b_explosive_barrel_is_used == false && b_explosive_barrel_is_loaded == false} [Charger le tonneau d'explosifs. {t(STRE, load_barrel_mod)}] #look:Player:left #anim:Player:use // 90%
            {
                - sc(STRE, load_barrel_mod): 
                    ~ load_barrel()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_explosive_barrel_is_used == false && b_explosive_barrel_is_loaded == true && b_boss_state == "open mouth"} [Lancer le tonneau explosif. {t(STRE, throw_barrel_mod)}] #look:Player:back #anim:Player:throw // 75%
            {
                - sc(STRE, throw_barrel_mod): 
                    ~ throw_barrel()
                - else:
                    ~ throw_barrel_fail()
            }
        ++ [Retourner sur le pont.]
            -> player_moovepool
        -- {souffleur_explain_action_points == false: -> souffleur_explain_action_points}
        -- {b_player_AP>0: -> use_barrels | -> end_turn}
    + (on_top_of_mast) {b_mast_is_broken == false} [Monter au mât. {t(DEXT, climb_mast_mod)}] #move:Player:8:12 #look:Player:back // 75%
        {b_player_AP<=0: -> end_turn}
        {
            - b_player_is_on_top_of_mast == false:
                {
                    - sc(DEXT, climb_mast_mod): 
                        ~ climb_up_mast()
                        -> on_top_of_mast
                    - else:
                        ~ use_action_point()
                        -> player_moovepool
                }
        }
        // Checks if boss or player is dead
        {
            - b_boss_is_dead:
                -> kill_boss
            - b_player_is_dead:
                -> kill_player
        }
        {souffleur_explain_action_points == false: -> souffleur_explain_action_points}
        ++ {b_player_AP > 0 && b_sail_is_down == false} [Baisser la voile. {t(STRE, lower_sail_mod)}] // 90%
            {
                - sc(STRE, lower_sail_mod): 
                    ~ lower_sail()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_boss_state == "on boat"} [Saut de l'ange. {t(CHAR, angel_jump_mod)}] // 60%
            {
                - sc(CHAR, angel_jump_mod): 
                    ~ angel_jump()
                - else:
                    ~ angel_jump_fail()
            }
            -> player_moovepool
        ++ {b_player_AP > 0} [Descendre du mât.]
            ~ climb_down_mast()
            -> player_moovepool
        ++ {b_player_AP > 0} [Passer son tour.]
            -> end_turn
        -- {b_player_AP>0: -> on_top_of_mast | -> end_turn}
        -- {b_mast_is_broken: -> player_moovepool}
    + {b_player_AP > 0} [Passer son tour.]
        -> end_turn
- {b_player_AP>0: -> player_moovepool | -> end_turn}


// End the current turn
= end_turn
-
// Fin du tour.
// Boss attack
~ boss_attack()
{
    - b_mast_is_broken && b_player_is_on_top_of_mast:
        ~ b_player_is_on_top_of_mast = false
        -> player_moovepool
}
// Roll new boss state
~ roll_boss_state()
// Grant action points to player
~ b_player_AP += b_player_AP_by_turn
{
    - b_player_is_on_top_of_mast == true:
        -> on_top_of_mast
    - else:
        -> player_moovepool
}

// Kill the boss
= kill_boss
~ b_player_won = true
    -> end_battle

// Kill the player
= kill_player
~ b_player_won = false
    -> end_battle

// End of the battle
= end_battle
- #wait:5 #battle:end
    -> barge.scene_3


/////////////////////////////////////////
// FUNCTIONS

// Boss attack
=== function boss_attack()
// Roll boss attack
~ boss_is_attacking = true
~ roll_boss_attack()
// Body attack
{
    - b_boss_attack == 1:
        ~ hurt_player(b_boss_default_attack_power)
    - b_boss_attack == 2:
        ~ hurt_player(b_boss_open_mouth_attack_power)
    - b_boss_attack == 3:
        ~ hurt_player(b_boss_on_boat_attack_power)
    - b_boss_attack == 4:
        ~ nb_state_before_special_attack = 2
        {
            - b_player_is_on_top_of_mast == false:
                ~ hurt_player(b_boss_special_attack_power)
            - else:
                ~ fail_boss_special_attack()
        }
        // If sail is not down, it breaks
        {
            - b_sail_is_down == false:
            {
                - b_mast_is_cracked == false:
                    ~ crack_mast()
                - b_mast_is_cracked && b_mast_is_broken == false:
                    ~ break_mast()
            }
            - b_sail_is_down == true && souffleur_reaction_about_sail_down == false:
                SOUFFLEUR: Tu as vu l'attaque que vient de faire le <shake a=0.5><b>Léviathan</b></shake> ?
                SOUFFLEUR: Si tu n'avais pas baissé les voiles de ton navire comme tu as eu la bonne idée de le faire...
                SOUFFLEUR: ... ton mât aurait été <b>réduit en miettes</b> à l'heure qu'il est !
                SOUFFLEUR: Bien joué, l'ami !
                ~ souffleur_reaction_about_sail_down = true
        }
}
// Le boss a attaqué avec l'attaque {b_boss_attack}. Il vous reste {b_player_hp} HP.

// Hurt player
=== function hurt_player(pDamages)
~ b_player_hp -= pDamages
{
    - b_player_hp<=0:
        ~ b_player_hp = 0
        ~ b_player_is_dead = true
}
// {
//     - b_boss_attack == 4 && souffleur_explained_mast == false:
//         SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe12
//         SOUFFLEUR: L'attaque que vient de faire le Léviathan est dévastatrice, pas vrai ? #playsound:VOX_Souffleur_lataquedevastatrice
//         SOUFFLEUR: Un conseil d'ami : si tu parviens à monter au mât avant que le monstre ne fasse cette attaque... #playsound:VOX_Souffleur_conseilmat
//         SOUFFLEUR: Tu éviteras de te blesser inutilement ! #playsound:VOX_Souffleur_blesserinutile
//         ~ souffleur_explained_mast = true
// }

// Hurt boss
=== function attack_boss(pAttack)
{
    - pAttack == "harpoon":
        ~ hurt_boss(harpoon_damages)
    - pAttack == "canon":
        ~ hurt_boss(canon_damages)
    - pAttack == "explosive barrel":
        {
            - b_boss_state == "open mouth":
                ~ hurt_boss(explosive_barrel_on_mouth_damages)
        }
    - pAttack == "angel jump":
        {
            - b_boss_state == "on boat":
                ~ hurt_boss(angel_jump_damages)
            // - else:
            //     Pas possible de faire un saut de l'ange si le boss n'est pas dans l'état on boat.
        }
}
{
    - souffleur_told_mid_life == false && b_boss_hp <= (b_boss_max_hp/2):
        SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe4
        SOUFFLEUR: Ce combat est un moment fort de la pièce... #playsound:VOX_Souffleur_combatfort
        SOUFFLEUR: Mais la troupe ne veut pas non plus qu'il dure trop longtemps, tu comprends ? #playsound:VOX_Souffleur_troupepastroplongtemps
        SOUFFLEUR: Le <shake a=0.5><b>Léviathan</b></shake> en est environ à <b>la moitié</b> de son espérance de vie, si tu vois ce que je veux dire... #playsound:VOX_Souffleur_lelevihalflife
        SOUFFLEUR: Bon courage, l'ami ! #playsound:VOX_Souffleur_boncouragelami1
        ~ souffleur_told_mid_life = true
    - souffleur_told_about_to_die == false && b_boss_hp <= (b_boss_max_hp/5):
        SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe2
        SOUFFLEUR: Je crois que le <shake a=0.5><b>Léviathan</b></shake> est sur le point de <b>flancher</b> ! #playsound:VOX_Souffleur_leviathansoondead
        SOUFFLEUR: Tu as un vrai talent pour la bagarre, l'ami ! #playsound:VOX_Souffleur_talentpourlabagarre
        SOUFFLEUR: Que tu gagnes ou que tu perdes, cette scène aura été un franc succès : le public est <b>conquis</b> ! #playsound:VOX_Souffleur_lepublicconquis
        ~ souffleur_told_about_to_die = true
}

// Hurt boss
=== function hurt_boss(pDamages)
~ b_boss_hp -= pDamages
{
    - b_boss_hp<=0:
        ~ b_boss_hp = 0
        ~ b_boss_is_dead = true
}
// Le boss a perdu {pDamages} HP. Il lui reste {b_boss_hp} HP.

=== function boss_attack_check(pPrecision)
    ~ temp result = true
    ~ temp D100 = roll_D100()
    {
        - D100 < pPrecision:
            ~ result = true
        - else:
            ~ result = false
    }
~ return result

// Fail boss attack
=== function fail_boss_attack()
-
// Le boss a raté son attaque.

// Fail boss special attack
=== function fail_boss_special_attack()
-
// L'attaque spéciale a été esquivée car vous êtes sur le mât.

// Use one action point
== function use_action_point()
    ~ b_player_AP -= 1
    // Il vous reste {b_player_AP} AP.

// Roll boss state
=== function roll_boss_state()
// Roll the state dice
~ temp D100State = roll_D100()
// Check if the state is under water
{
    - nb_state_before_special_attack <= 0:
        ~ change_boss_state("under water")
    - else:
        {
            - b_boss_state == "default":
                {
                    - D100State>=50:
                        ~ change_boss_state("open mouth")
                    - else:
                        ~ change_boss_state("on boat")
                }
            - b_boss_state == "open mouth":
                {
                    - D100State>=50:
                        ~ change_boss_state("on boat")
                    - else:
                        ~ change_boss_state("default")
                }
            - b_boss_state == "on boat":
                {
                    - D100State>=50:
                        ~ change_boss_state("default")
                    - else:
                        ~ change_boss_state("open mouth")
                }
            - b_boss_state == "under water":
                {
                    - D100State>=55:
                        ~ change_boss_state("on boat")
                    - D100State>=20:
                        ~ change_boss_state("open mouth")
                    - else:
                        ~ change_boss_state("default")
                }
        }
}
{
    - b_boss_state == "under water" && souffleur_explained_special_attack == false:
        SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe4
        SOUFFLEUR: Le <shake a=0.5><b>Léviathan</b></shake> s'apprête à faire une attaque <b><shake a=0.5>dévastatrice</shake></b> !
        SOUFFLEUR: Un conseil d'ami : prend de la <b>hauteur</b>.
        SOUFFLEUR: Bonne chance, l'ami !
        ~ souffleur_explained_special_attack = true
}

// Decrement 1 before under water state
~ nb_state_before_special_attack -= 1

// Change boss state
=== function change_boss_state(pState)
    ~ b_boss_state = pState
{
    - b_boss_state == "default":
        #playsound:Play_SFX_NPC_Leviathan_TurnStart
    - b_boss_state == "open mouth":
        #playsound:Play_SFX_NPC_Leviathan_TurnStart
    - b_boss_state == "on boat":
        #playsound:Play_SFX_NPC_Leviathan_TurnStart
    - b_boss_state == "under water":
        #playsound:Play_SFX_NPC_Leviathan_Underwater
}

// Roll the boss attack
=== function roll_boss_attack()
// Roll the state dice
~ temp D100Atk = roll_D100()
{
    - b_boss_state == "default":
        ~ b_boss_attack = 1
    - b_boss_state == "open mouth":
        {
            - D100Atk>=b_boss_open_mouth_attack_probability: 
                ~ b_boss_attack = 1
            - else:
                ~ b_boss_attack = 2
        }
    - b_boss_state == "on boat":
        {
            - D100Atk>=b_boss_on_boat_attack_probability: 
                ~ b_boss_attack = 1
            - else:
                ~ b_boss_attack = 3
        }
    - b_boss_state == "under water":
        ~ b_boss_attack = 4
}

// Load the harpoon
=== function load_harpoon()
- #anim:Player:load_harpoon
// Vous remontez le harpon. #anim:Player:load_harpoon
    ~ b_harpoon_is_loaded = true
    ~ use_action_point()

// Aim with the grabble
=== function aim_harpoon()
- #anim:Player:aim_harpoon
// Vous visez avec le harpon. #anim:Player:aim_harpoon
    ~ b_harpoon_is_aimed = true
    ~ shoot_harpoon_mod += aim_bonus_mod
    ~ use_action_point()

// Shoot with the grabble
=== function shoot_harpoon()
- #anim:Player:shoot_harpoon
// Vous tirez avec le harpon. #anim:Player:shoot_harpoon
    ~ b_harpoon_is_loaded = false
    ~ b_harpoon_is_aimed = false
    ~ attack_boss("harpoon")
    ~ use_action_point()
    ~ shoot_harpoon_mod = shoot_harpoon_mod_default

// Shoot with the grabble and fail
=== function shoot_harpoon_fail()
-
// Vous ratez votre tir.
    ~ b_harpoon_is_loaded = false
    ~ b_harpoon_is_aimed = false
    ~ use_action_point()
    ~ shoot_harpoon_mod = shoot_harpoon_mod_default

// Climb up the sail
=== function climb_up_mast()
{
    - b_player_is_on_top_of_mast == false:
        #height:Player:6 #playsound:VOX_Player_Emotion_climb
        // Vous montez au mât. #height:Player:6 #playsound:VOX_Player_Emotion_climb
        ~ b_player_is_on_top_of_mast = true 
        ~ use_action_point()
}

// Climb down the sail
=== function climb_down_mast()
-
// Vous descendez du mât. #look:Player:front #height:Player:-6
    ~ b_player_is_on_top_of_mast = false

// Lower the sail
=== function lower_sail()
- 
// Vous descendez la voile. //#anim:Player:lower_sail
    ~ b_sail_is_down = true
    ~ use_action_point()

// Do an angel jump
=== function angel_jump()
- #look:Player:front #height:Player:-6 //#anim:Player:mast_attack
// Vous sautez depuis le mât et attaquez. #look:Player:front #height:Player:-6 //#anim:Player:mast_attack
    ~ attack_boss("angel jump")
    ~ b_player_is_on_top_of_mast = false
    ~ use_action_point()

// Do an angel jump and fail
=== function angel_jump_fail()
- #look:Player:front #height:Player:-6
// Vous ratez votre saut de l'ange. #look:Player:front #height:Player:-6
    ~ b_player_is_on_top_of_mast = false
    ~ use_action_point()

// Fall out of mast when it break
=== function fall_out_of_mast_when_it_breaks()
    ~ hurt_player(b_fall_out_of_mast_damages)
    - #look:Player:front #height:Player:-6 //#anim:Player:fall_out_of_mast
    // Vous êtes tombé du mât car il a rompu. Vous avez perdu {b_fall_out_of_mast_damages} HP.
    // Il vous reste {b_player_hp} HP. #look:Player:front #height:Player:-6 //#anim:Player:fall_out_of_mast

// Load the canon
=== function load_canon()
- #anim:Player:load_canon
// Vous remontez le canon. #anim:Player:load_canon
    ~ b_canon_is_loaded = true
    ~ use_action_point()

// Aim with the canon
=== function aim_canon()
- #anim:Player:aim_canon
// Vous visez avec le canon. #anim:Player:aim_canon
    ~ b_canon_is_aimed = true
    ~ shoot_canon_mod += aim_bonus_mod
    ~ use_action_point()

// Shoot with the canon
=== function shoot_canon()
- #anim:Player:shoot_canon
// Vous tirez avec le canon. #anim:Player:shoot_canon
    ~ b_canon_is_loaded = false
    ~ b_canon_is_aimed = false
    ~ b_nb_canon_bullet_left -= 1
    ~ attack_boss("canon")
    ~ use_action_point()
    ~ shoot_canon_mod = shoot_canon_mod_default

// Shoot with the canon and fail
=== function shoot_canon_fail()
-
// Vous ratez votre tir.
    ~ b_canon_is_loaded = false
    ~ b_canon_is_aimed = false
    ~ b_nb_canon_bullet_left -= 1
    ~ use_action_point()
    ~ shoot_canon_mod = shoot_canon_mod_default

// Load the barrel
=== function load_barrel()
- #anim:Player:load_barrel
// Vous chargez le tonneau explosif. #anim:Player:load_barrel
    ~ b_explosive_barrel_is_loaded = true
    ~ use_action_point()

// Throw the barrel
=== function throw_barrel()
- #anim:Player:throw_barrel
// Vous lancez le tonneau explosif. #anim:Player:throw_barrel
    ~ b_explosive_barrel_is_used = true
    ~ attack_boss("explosive barrel")
    ~ use_action_point()

// Throw the barrel and fail
=== function throw_barrel_fail()
-
// Vous ratez votre lancé.
    ~ b_explosive_barrel_is_used = true
    ~ use_action_point()

// Crack the mast
=== function crack_mast()
-
~ b_mast_is_cracked = true
// Le mât du navire est fissuré suite à l'attaque du Léviathan.

// Break the mast
=== function break_mast()
-
~ b_mast_is_broken = true
{
    - b_player_is_on_top_of_mast:
        ~ fall_out_of_mast_when_it_breaks()
}
// Le mât du navire est brisé.
- SOUFFLEUR: Wow ! Impressionnant ! Rien de cassé, l'ami ?
SOUFFLEUR: La bataille va être bien plus ardue maintenant que le mât est brisé...
SOUFFLEUR: C'est pour ça qu'un marin doit toujours <b>baisser les voiles</b> en cas de tempête.
SOUFFLEUR: Bon courage l'ami !
