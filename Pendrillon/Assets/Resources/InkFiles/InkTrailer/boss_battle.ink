// BOSS BATTLE SCENE

// Player variables
VAR b_player_is_dead = false
VAR b_player_won = false
VAR b_player_hp = 999
VAR b_player_AP = 3
VAR b_player_is_on_top_of_mast = false
// Player attacks damages
VAR harpoon_damages = 10
VAR canon_damages = 18
VAR explosive_barrel_damages = 20
VAR explosive_barrel_on_mouth_damages = 38
VAR angel_jump_damages = 25
// Player moovepool
VAR load_harpoon_mod = 40 // 90%
VAR aim_harpoon_mod = 30 // 80%
VAR shoot_harpoon_mod_default = 20 // 70%
VAR shoot_harpoon_mod = 20 // 70%
VAR load_canon_mod = 30 // 80%
VAR shoot_canon_mod_default = 0 // 50%
VAR shoot_canon_mod = 0 // 50%
VAR aim_canon_mod = 30 // 80%
VAR load_barrel_mod = 0
VAR throw_barrel_mod = 0
VAR climb_mast_mod = 20
VAR lower_sail_mod = 0
VAR angel_jump_mod = 0
VAR aim_bonus_mod = 20
// Souffleur variables
VAR souffleur_explained_AP = false
VAR souffleur_explained_mast = false
VAR souffleur_explained_sail_down = false
VAR souffleur_told_mid_life = false
VAR souffleur_told_about_to_die = false

// Environement
VAR b_harpoon_is_loaded = false
VAR b_harpoon_is_aimed = false
VAR b_canon_is_loaded = false
VAR b_canon_is_aimed = false
VAR b_nb_canon_bullet_left = 2
VAR b_sail_is_down = false
VAR b_mast_is_cracked = false
VAR b_mast_is_broken = false
VAR b_explosive_barrel_1_is_used = false
VAR b_explosive_barrel_1_is_loaded = false
VAR b_explosive_barrel_2_is_brought_and_not_used = false
VAR b_explosive_barrel_2_is_used = false
VAR b_explosive_barrel_2_is_loaded = false
VAR b_explosive_barrel_left = true

// Boss variables
// Base
VAR b_boss_is_dead = false
VAR b_boss_state = "default"
VAR b_boss_attack = 1
VAR b_tail_attack = false
VAR b_boss_max_hp = 35 // Doit être le même nombre que b_boss_hp
VAR b_boss_hp = 35 // Doit être le même nombre que b_boss_max_hp
VAR nb_state_before_special_attack = 2
// Boss attacks
// [1: default attack]
VAR b_boss_default_attack_power = 1
VAR b_boss_default_attack_precision = 90
// [2: open mouth attack]
VAR b_boss_open_mouth_attack_power = 2
VAR b_boss_open_mouth_attack_precision = 80
VAR b_boss_open_mouth_attack_probability = 30
// [3: on boat attack]
VAR b_boss_on_boat_attack_power = 3
VAR b_boss_on_boat_attack_precision = 100
VAR b_boss_on_boat_attack_probability = 30
// [4: special attack]
VAR b_boss_special_attack_power = 8

// Scene
=== boss_battle ===
- -> start

= start
// // Define the actors of the scene
// #actor:Player:PLAYER
// // Set the location
// #set:tempest
// // Set the actor's positions
// #position:Player:4:2
// // Audience reaction
// #wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3

// Set the location : A SUPPRIMER PLUS TARD CAR LE DECORS EST DEJA SET PAR LA SCENE D'AVANT !!!!
- #set:tempest

// Start the scene
#audience:ovation
- SOUFFLEUR: Psssst... Hé, l'ami ! #wait:120
SOUFFLEUR: Cette scène nous coûte une fortune en effets spéciaux à chaque spectacle...
SOUFFLEUR: Tu n'imagines pas le budget que ça représente, en terme de chorégraphie, matériel, main-d'oeuvre...
SOUFFLEUR: Sans parler des <shake>coûts d'entretiens</shake> !
SOUFFLEUR: Profitons-en pour en mettre plein les yeux au public, d'accord l'ami ?
- -> player_moovepool

// Souffleur explain action points
= souffleur_explain_action_points
- SOUFFLEUR: Psssst... Hé, l'ami !
SOUFFLEUR: Cette scène est un moment un peu spécial de la pièce : c'est un véritable <shake>combat à mort</shake>.
SOUFFLEUR: Enfin... pas vraiment. Si tu perds l'affontement, ce n'est pas un drame... Tu ne vas pas <i>vraiment</i> mourir.
SOUFFLEUR: Bref. Tu viens de faire une action nécessitant un <b>talent</b>, pas vrai l'ami ?
SOUFFLEUR: Sache que lors d'un combat, tu peux effectuer <b>plusieurs actions</b> de ce type lors d'un <b>même tour</b>.
SOUFFLEUR: Le nombre de <b>talents</b> que tu peux utiliser avant que ton tour ne se termine est inscrit au dessus.
SOUFFLEUR: On appelle ça des <shake>points d'action™</shake>. Enfin... c'est <i>moi</i> qui les appelle comme ça.
SOUFFLEUR: Une dernière chose : tu peux <b>passer ton tour</b> si tu le souhaites.
SOUFFLEUR: Tes <b>points d'action</b> seront <b>mis de coté</b> pour le tour suivant.
SOUFFLEUR: Bonne chance, l'ami !
~ souffleur_explained_AP = true
{
    - b_player_is_on_top_of_mast:
        -> on_top_of_mast
    - else:
        -> player_moovepool
}

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
- SOUFFLEUR: Psssst... Hé, l'ami !
SOUFFLEUR: Lors d'une tempête, un marin devrait toujours <b>baisser les voiles</b> de son navire.
SOUFFLEUR: C'est un petit conseil d'ami, fais-en ce que tu veux...
SOUFFLEUR: Tu ne pourras pas dire que je ne t'ai pas prévenu, l'ami !
~ souffleur_explained_sail_down = true
{
    - b_player_is_on_top_of_mast:
        -> on_top_of_mast
    - else:
        -> player_moovepool
}

// Souffleur give advice about climbing the mast to avoid special attack
= souffleur_advice_about_climbing_mast
- SOUFFLEUR: Psssst... Hé, l'ami !
SOUFFLEUR: L'attaque que vient de faire le Léviathan est dévastatrice, pas vrai ?
SOUFFLEUR: Un conseil d'ami : si tu parviens à monter au mât avant que le monstre ne fasse cette attaque...
SOUFFLEUR: Tu éviteras de te blesser inutilement !
~ souffleur_explained_mast = true
{
    - b_player_is_on_top_of_mast:
        -> on_top_of_mast
    - else:
        -> player_moovepool
}

// Player mooves
= player_moovepool
// Player turn
C'est à votre tour. Vous avez {b_player_AP} AP et {b_player_hp} HP.
// Checks if boss or player is dead
{
    - b_boss_is_dead:
        -> kill_boss
    - b_player_is_dead:
        -> kill_player
}
// Checks if player has no AP
{b_player_AP<=0: -> end_turn}
{b_boss_state == "under water" && souffleur_advice_about_sail_down == false: -> souffleur_advice_about_sail_down}
// Player movepool
    + (use_harpoon) [Utiliser le harpon]
        ++ {b_player_AP > 0 && b_player_is_on_top_of_mast == false && b_harpoon_is_loaded == false} [Remonter le harpon {t(DEXT, load_harpoon_mod)}]
            {
                - sc(DEXT, load_harpoon_mod):
                    ~ load_harpoon()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_player_is_on_top_of_mast == false && b_harpoon_is_loaded == true && b_harpoon_is_aimed == false} [Viser avec le harpon {t(DEXT, aim_harpoon_mod)}]
            {
                - sc(DEXT, aim_harpoon_mod): 
                    ~ aim_harpoon()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_player_is_on_top_of_mast == false && b_harpoon_is_loaded == true} [Tirer avec le harpon {t(DEXT, shoot_harpoon_mod)}]
            {
                - sc(DEXT, shoot_harpoon_mod): 
                    ~ shoot_harpoon()
                - else:
                    ~ use_action_point()
            }
        ++ [Retourner sur le pont]
            -> player_moovepool
        -- {souffleur_explain_action_points == false: -> souffleur_explain_action_points}
        -- {b_player_AP>0: -> use_harpoon | -> end_turn}
    + (use_canon) {b_nb_canon_bullet_left > 0} [Utiliser le canon]
        ++ {b_player_AP > 0 && b_canon_is_loaded == false && b_nb_canon_bullet_left > 0} [Charger le canon {t(STRE, load_canon_mod)}]
            {
                - sc(STRE, load_canon_mod): 
                    ~ load_canon()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_canon_is_loaded == true && b_canon_is_aimed == false} [Viser avec le canon {t(DEXT, aim_canon_mod)}]
            {
                - sc(STRE, aim_canon_mod): 
                    ~ aim_canon()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_canon_is_loaded == true} [Tirer avec le canon {t(STRE, shoot_canon_mod)}]
            {
                - sc(STRE, shoot_canon_mod): 
                    ~ shoot_canon()
                - else:
                    ~ use_action_point()
            }
        ++ [Retourner sur le pont]
            -> player_moovepool
        -- {souffleur_explain_action_points == false: -> souffleur_explain_action_points}
        -- {b_player_AP>0: -> use_canon | -> end_turn}
    + (use_barrels) {b_explosive_barrel_left == true} [Utiliser les tonneaux explosifs]
        ++ {b_player_AP > 0 && b_explosive_barrel_1_is_used == false && b_explosive_barrel_1_is_loaded == false && b_explosive_barrel_left == true} [Charger le tonneau d'explosifs {t(STRE, load_barrel_mod)}]
            {
                - sc(STRE, load_barrel_mod): 
                    ~ load_barrel_1()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_explosive_barrel_1_is_used == false && b_explosive_barrel_1_is_loaded == true && b_boss_state == "open mouth"} [Lancer le tonneau explosif {t(STRE, throw_barrel_mod)}]
            {
                - sc(STRE, throw_barrel_mod): 
                    ~ throw_barrel_1()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_explosive_barrel_1_is_used == true && b_explosive_barrel_2_is_brought_and_not_used == true && b_explosive_barrel_2_is_used == false && b_explosive_barrel_2_is_loaded == false} [Charger le tonneau d'explosifs {t(STRE, load_barrel_mod)}]
            {
                - sc(STRE, load_barrel_mod): 
                    ~ load_barrel_2()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_explosive_barrel_1_is_used == true && b_explosive_barrel_2_is_brought_and_not_used == true && b_explosive_barrel_2_is_used == false && b_explosive_barrel_2_is_loaded == true && b_boss_state == "open mouth"} [Lancer le tonneau explosif {t(STRE, throw_barrel_mod)}]
            {
                - sc(STRE, throw_barrel_mod): 
                    ~ throw_barrel_2()
                - else:
                    ~ use_action_point()
            }
        ++ [Retourner sur le pont]
            -> player_moovepool
        -- {souffleur_explain_action_points == false: -> souffleur_explain_action_points}
        -- {b_player_AP>0: -> use_barrels | -> end_turn}
    + (on_top_of_mast) {b_mast_is_broken == false} [Monter au mât {t(DEXT, climb_mast_mod)}]
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
        {souffleur_explain_action_points == false: -> souffleur_explain_action_points}
        ++ {b_player_AP > 0 && b_sail_is_down == false} [Baisser la voile {t(STRE, lower_sail_mod)}]
            {
                - sc(STRE, lower_sail_mod): 
                    ~ lower_sail()
                - else:
                    ~ use_action_point()
            }
        ++ {b_player_AP > 0 && b_boss_state != "under water" && b_boss_state == "on boat"} [Saut de l'ange {t(CHAR, angel_jump_mod)}]
            {
                - sc(CHAR, angel_jump_mod): 
                    ~ angel_jump()
                - else:
                    ~ use_action_point()
            }
            -> player_moovepool
        ++ {b_player_AP > 0} [Descendre du mât]
            Vous descendez du mât. #anim:climb_down_mast
            ~ climb_down_mast()
            -> player_moovepool
        ++ {b_player_AP > 0} [Passer son tour]
            -> end_turn
        -- {b_player_AP>0: -> on_top_of_mast | -> end_turn}
        -- {b_mast_is_broken: -> player_moovepool}
    + {b_player_AP > 0} [Passer son tour]
        -> end_turn
- {b_player_AP>0: -> player_moovepool | -> end_turn}


// End the current turn
= end_turn
Fin du tour.
// Boss attack
~ boss_attack()
// Roll new boss state
~ roll_boss_state()
// Grant action points to player
~ b_player_AP += 3
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
Fin du combat. Vous avez {b_player_won: gagné | perdu} le combat.
{
    - b_player_won:
        Il vous restait {b_player_hp} HP.
}
-> tribunal_2


/////////////////////////////////////////
// FUNCTIONS

// Boss attack
=== function boss_attack()
// Roll boss attack
~ roll_boss_attack()
// Body attack
{
    - b_boss_attack == 1:
        {
            - boss_attack_check(b_boss_default_attack_precision):
                ~ hurt_player(b_boss_default_attack_power)
            - else:
                ~ fail_boss_attack()
        }
    - b_boss_attack == 2:
        {
            - boss_attack_check(b_boss_open_mouth_attack_precision):
                ~ hurt_player(b_boss_open_mouth_attack_power)
            - else:
                ~ fail_boss_attack()
        }
    - b_boss_attack == 3:
        {
            - boss_attack_check(b_boss_on_boat_attack_precision):
                ~ hurt_player(b_boss_on_boat_attack_power)
            - else:
                ~ fail_boss_attack()
        }
    - b_boss_attack == 4:
        ~ nb_state_before_special_attack = 2
        {
            - b_player_is_on_top_of_mast == false:
                ~ hurt_player(b_boss_special_attack_power)
            - else:
                ~ fail_boss_special_attack()
        }
}

// Hurt player
=== function hurt_player(pDamages)
~ b_player_hp -= pDamages
{
    - b_player_hp<=0:
        ~ b_player_hp = 0
        ~ b_player_is_dead = true
}
Le boss a attaqué avec l'attaque {b_boss_attack}. Il vous reste {b_player_hp} HP.

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
            - else:
                ~ hurt_boss(explosive_barrel_damages)
        }
    - pAttack == "angel jump":
        {
            - b_boss_state == "on boat":
                ~ hurt_boss(angel_jump_damages)
            - else:
                Pas possible de faire un saut de l'ange si le boss n'est pas dans l'état on boat.
        }
}
{
    - souffleur_told_mid_life == false && b_boss_hp <= (b_boss_max_hp/2):
        SOUFFLEUR: Psssst... Hé, l'ami !
        SOUFFLEUR: Ce combat est un moment fort de la pièce...
        SOUFFLEUR: Mais la troupe ne veut pas non plus qu'il dure trop longtemps, tu comprends ?
        SOUFFLEUR: Le Léviathan en est environ à <b>la moitié</b> de son espérance de vie, si tu vois ce que je veux dire...
        SOUFFLEUR: Bon courage, l'ami !
        ~ souffleur_told_mid_life = true
    - souffleur_told_about_to_die == false && b_boss_hp <= (b_boss_max_hp/5):
        SOUFFLEUR: Psssst... Hé, l'ami !
        SOUFFLEUR: Je crois que le Léviathan est sur le point de <b>flancher</b> !
        SOUFFLEUR: Tu as un vrai talent pour la bagarre, l'ami !
        SOUFFLEUR: Que tu gagnes ou que tu perdes, cette scène aura été un franc succès : le public est conquis !
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
Le boss a perdu {pDamages} HP. Il lui reste {b_boss_hp} HP.

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
Le boss a raté son attaque.

// Fail boss special attack
=== function fail_boss_special_attack()
L'attaque spéciale a été esquivée car vous êtes sur le mât.

// Use one action point
== function use_action_point()
    ~ b_player_AP -= 1
    Il vous reste {b_player_AP} AP.

// Roll boss state
=== function roll_boss_state()
// Roll the state dice
~ temp D100State = roll_D100()
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
            - D100State>=67: 
                ~ change_boss_state("default")
            - D100State>=34:
                ~ change_boss_state("open mouth")
            - else:
                ~ change_boss_state("on boat")
        }
}
// Check if the state is under water
{
    - nb_state_before_special_attack <= 0:
        ~ change_boss_state("under water")
}
// Decrement 1 before under water state
~ nb_state_before_special_attack -= 1

// Change boss state
=== function change_boss_state(pState)
    ~ b_boss_state = pState
{
    - b_boss_state == "default":
        Le boss est en état {b_boss_state}.
    - b_boss_state == "open mouth":
        Le boss est en état {b_boss_state}.
    - b_boss_state == "on boat":
        Le boss est en état {b_boss_state}.
    - b_boss_state == "under water":
        Le boss est en état {b_boss_state}.
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
        // If sail is not down, it breaks
        {
            - b_sail_is_down == false:
            {
                - b_mast_is_cracked == false:
                    ~ crack_mast()
                - b_mast_is_cracked:
                    ~ break_mast()
            }
        }
}

// Load the harpoon
=== function load_harpoon()
Vous remontez le harpon. #anim:load_harpoon
    ~ b_harpoon_is_loaded = true
    ~ use_action_point()

// Aim with the grabble
=== function aim_harpoon()
Vous visez avec le harpon. #anim:aim_harpoon
    ~ b_harpoon_is_aimed = true
    ~ shoot_harpoon_mod += aim_bonus_mod
    ~ use_action_point()

// Shoot with the grabble
=== function shoot_harpoon()
Vous tirez avec le harpon. #anim:shoot_harpoon
    ~ b_harpoon_is_loaded = false
    ~ b_harpoon_is_aimed = false
    ~ attack_boss("harpoon")
    ~ use_action_point()
    ~ shoot_harpoon_mod = shoot_harpoon_mod_default

// Climb up the sail
=== function climb_up_mast()
{
    - b_player_is_on_top_of_mast == false:
        Vous montez au mât.
        ~ b_player_is_on_top_of_mast = true
        ~ use_action_point()
}

// Climb down the sail
=== function climb_down_mast()
Vous descendez du mât.
    ~ b_player_is_on_top_of_mast = false

// Lower the sail
=== function lower_sail()
Vous descendez la voile.
    ~ b_sail_is_down = true
    ~ use_action_point()

// Do an angel jump
=== function angel_jump()
Vous sautez depuis le mât et attaquez. #anim:Player:mast_attack
    ~ attack_boss("angel jump")
    ~ b_player_is_on_top_of_mast = false
    ~ use_action_point()

// Load the canon
=== function load_canon()
Vous remontez le canon. #anim:load_canon
    ~ b_canon_is_loaded = true
    ~ use_action_point()

// Aim with the canon
=== function aim_canon()
Vous visez avec le canon. #anim:aim_canon
    ~ b_canon_is_aimed = true
    ~ shoot_canon_mod += aim_bonus_mod
    ~ use_action_point()

// Shoot with the canon
=== function shoot_canon()
Vous tirez avec le canon. #anim:shoot_canon
    ~ b_canon_is_loaded = false
    ~ b_canon_is_aimed = false
    ~ b_nb_canon_bullet_left -= 1
    ~ attack_boss("canon")
    ~ use_action_point()
    ~ shoot_canon_mod = shoot_canon_mod_default

// Load the barrel 1
=== function load_barrel_1()
Vous chargez le tonneau explosif. #anim:load_barrel_1
    ~ b_explosive_barrel_1_is_loaded = true
    ~ use_action_point()

// Throw the barrel 1
=== function throw_barrel_1()
Vous lancez le tonneau explosif. #anim:throw_barrel_1
    ~ b_explosive_barrel_1_is_used = true
    ~ attack_boss("explosive barrel")
    ~ use_action_point()
{
    - b_explosive_barrel_2_is_brought_and_not_used == false:
        ~ b_explosive_barrel_left = false
}

// Load the barrel 2
=== function load_barrel_2()
Vous chargez le tonneau explosif. #anim:load_barrel_2
    ~ b_explosive_barrel_2_is_loaded = true
    ~ use_action_point()

// Throw the barrel 1
=== function throw_barrel_2()
Vous lancez le tonneau explosif. #anim:throw_barrel_2
    ~ b_explosive_barrel_2_is_used = true
    ~ b_explosive_barrel_2_is_brought_and_not_used = false
    ~ b_explosive_barrel_left = false
    ~ attack_boss("explosive barrel")
    ~ use_action_point()

// Crack the mast
=== function crack_mast()
~ b_mast_is_cracked = true
Le mât du navire est fissuré.
- SOUFFLEUR: Tu as vu l'attaque que viens de faire le Léviathan ?
SOUFFLEUR: Si tu n'avais pas baissé les voiles de ton navire comme tu as eu la bonne idée de le faire...
SOUFFLEUR: ... ton mât aurait été réduit en miettes à l'heure qu'il est !
SOUFFLEUR: Bien joué, l'ami !

// Break the mast
=== function break_mast()
~ b_mast_is_broken = true
Le mât du navire est brisé.
- SOUFFLEUR: Wow ! Impressionnant ! Rien de cassé, l'ami ?
SOUFFLEUR: La bataille va être bien plus hardue maintenant que le mât est brisé...
SOUFFLEUR: C'est pour ça qu'un marin doit toujours <b>baisser les voiles</b> en cas de tempête.
SOUFFLEUR: Bon courage l'ami !
