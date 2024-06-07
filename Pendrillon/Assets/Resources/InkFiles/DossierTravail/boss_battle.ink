// BOSS BATTLE SCENE

// Player variables
VAR b_player_is_dead = false
VAR b_player_won = false
VAR b_player_hp = 10
VAR b_player_AP = 3
//VAR b_player_nb_combo_attack = 0 // max per turn = 3
VAR b_player_is_on_top_of_mast = false
VAR b_week_attack_AP = 1
VAR b_strong_attack_AP = 3
VAR b_week_attack_power = 2
VAR b_strong_attack_power = 5
VAR b_week_attack_sc = 20 // dext
VAR b_strong_attack_sc = 0 // stre

// Environement
VAR b_grabble_is_loaded = true
VAR b_grabble_is_aimed = false
VAR b_canon_is_loaded = false
VAR b_canon_is_aimed = false
VAR b_sail_is_down = false
VAR b_explosive_barrel_1_is_used = false
VAR b_explosive_barrel_1_is_loaded = false
VAR b_explosive_barrel_2_is_brought = false
VAR b_explosive_barrel_2_is_used = false
VAR b_explosive_barrel_2_is_loaded = false

// Boss variables
// Base
VAR b_boss_is_dead = false
VAR b_boss_state = "default"
VAR b_boss_body_attack = 1
VAR b_boss_tail_attack = 1
VAR b_boss_is_grabbled = false
VAR b_boss_body_hp = 10
VAR b_boss_tail_hp = 5
// Boss attacks
// [1]
// body
VAR b_boss_body_attack_1_power = 2
VAR b_boss_body_attack_1_precision = 90
// tail
VAR b_boss_tail_attack_1_power = 1
VAR b_boss_tail_attack_1_precision = 90
// [2]
// body
VAR b_boss_body_attack_2_power = 3
VAR b_boss_body_attack_2_precision = 80
VAR b_boss_body_attack_2_probability = 30
// tail
VAR b_boss_tail_attack_2_power = 2
VAR b_boss_tail_attack_2_precision = 80
VAR b_boss_tail_attack_2_probability = 30
// [3]
// body
VAR b_boss_body_attack_3_power = 4
VAR b_boss_body_attack_3_precision = 100
VAR b_boss_body_attack_3_probability = 30
// tail
VAR b_boss_tail_attack_3_power = 3
VAR b_boss_tail_attack_3_precision = 80
VAR b_boss_tail_attack_3_probability = 30
// [4]
// body
VAR b_boss_body_attack_4_power = 4
VAR b_boss_body_attack_4_precision = 100
VAR b_boss_body_attack_4_probability = 30
// tail
VAR b_boss_tail_attack_4_power = 3
VAR b_boss_tail_attack_4_precision = 80
VAR b_boss_tail_attack_4_probability = 30
// [5 -> special attack]
// body
VAR b_boss_body_attack_5_power = 8
VAR b_boss_body_attack_5_precision = 100

// Scene
=== boss_battle ===
- -> start

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
- -> main_menu
// Default state
= main_menu
// Checks if boss or player is dead
{
    - b_boss_is_dead:
        -> kill_boss
    - b_player_is_dead:
        -> kill_player
}
// Checks monster's current state
{
    - b_boss_state == "default":
        Default state : dans l’eau, avec sa queue dans l’eau aussi.
        -> default_state
    - b_boss_state == "open mouth":
        Open mouth state : ouvre la gueule et hurle (screenshake).
        -> open_mouth_state
    - b_boss_state == "under water":
        Under water state : plonge sous l'eau (inatteignable mais n’attaque pas).
        -> under_water_state
    - b_boss_state == "on boat":
        On boat state : rapproche sa tête et pose sa queue sur le bateau.
        -> on_boat_state
}

= end_turn
Fin du tour.
// Suite combat
// Boss attack
/*~ boss_attack()*/
// Next turn
/*- -> next_turn*/

= default_state
    // Player movepool
    + [Utiliser le grappin.]
        ++ {b_player_AP >= 1 && b_player_is_on_top_of_mast == false && b_grabble_is_loaded == false} [Remonter le grappin. (1)]
            ~ load_grabble()
        ++ {b_player_AP >= 1 && b_player_is_on_top_of_mast == false && b_grabble_is_loaded == true} [Viser. (1)]
            ~ aim_grabble()
        ++ {b_player_AP >= 3 && b_player_is_on_top_of_mast == false && b_grabble_is_loaded == true} [Tirer. (3)]
            ~ shoot_grabble()
        ++ [Retourner sur le pont.]
            -> default_state
    + [Utiliser le canon.]
        -> canon_movepool
    + [Utiliser les tonneaux.]
        -> barrel_movepool
        + [Monter au mât. (1)]
            ~ climb_up_mast()
            ** {b_player_AP >= 3 && b_player_is_on_top_of_mast == true && b_sail_is_down == false} [Baisser la voile. (3)]
                ~ lower_sail()
            ++ {b_player_AP >= 2 && b_player_is_on_top_of_mast == true} [Saut de l'ange. (2)]
                ~ angel_jump()
            ++ {b_player_AP >= 1 && b_player_is_on_top_of_mast == true} [Descendre du mât. (1)]
                Vous descendez du mât. #anim:climb_down_mast
- {b_player_AP>0: -> default_state | -> end_turn}


= open_mouth_state
Open mouth

= under_water_state
Under water

= on_boat_state
On boat

= canon_movepool
Vous êtes devant le canon.

= grapple_movepool
Vous êtes devant le grappin.
    + {b_player_AP >= 1 && b_player_is_on_top_of_mast == false && b_grabble_is_loaded == false} [Remonter le grappin. (1)]
    + {b_player_AP >= 1 && b_player_is_on_top_of_mast == false && b_grabble_is_loaded == true} [Viser avec le grappin. (1)]
        Vous visez avec le grappin. #anim:aim_grabble
    + {b_player_AP >= 3 && b_player_is_on_top_of_mast == false && b_grabble_is_loaded == true} [Tirer avec le grappin. (3)]
    + [Retourner sur le pont.]
        -> main_menu

= barrel_movepool
Vous êtes devant les tonneaux explosifs.

= mast_movepool
Vous montez au mât.

= all_actions_moovepool
// Player movepool
    + {b_player_AP >= 1 && b_player_is_on_top_of_mast == false && b_grabble_is_loaded == false} [Remonter le grappin. (1)]
        Vous remontez le grappin. #anim:load_grabble
    + {b_player_AP >= 1 && b_player_is_on_top_of_mast == false && b_grabble_is_loaded == true} [Viser avec le grappin. (1)]
        Vous visez avec le grappin. #anim:aim_grabble
    + {b_player_AP >= 3 && b_player_is_on_top_of_mast == false && b_grabble_is_loaded == true} [Tirer avec le grappin. (3)]
        Vous tirez avec le grappin. #anim:shoot_grabble
    + {b_player_AP >= 3 && b_player_is_on_top_of_mast == false} [Monter au mât. (3)]
        Vous montez au mât. #anim:Player:climb_mast
            ~ b_player_is_on_top_of_mast = true
    * {b_player_AP >= 3 && b_player_is_on_top_of_mast == true && b_sail_is_down == false} [Remonter la voile. (3)]
        Vous remontez la voile. #anim:lower_sail
            ~ b_player_is_on_top_of_mast = true
    + {b_player_AP >= 2 && b_player_is_on_top_of_mast == true} [Saut de l'ange. (2)]
        -- ~ angel_jump()
    + {b_player_AP >= 1 && b_player_is_on_top_of_mast == true} [Descendre du mât. (1)]
        Vous descendez du mât. #anim:climb_down_mast
    + {b_player_AP >= 1 && b_player_is_on_top_of_mast == false && b_player_AP >= b_week_attack_AP} [Attaque faible. (1)]
        Vous effectuez une attaque faible. #anim:Player:attack
    + {b_player_AP >= 3 && b_player_is_on_top_of_mast == false && b_player_AP >= b_strong_attack_AP} [Attaque forte. (3)]
        Vous effectuez une attaque puissante. #anim:Player:strong_attack
    + [Se protéger.]
        Vous vous protégez et passez le tour.

// End turn
= next_turn
~ b_player_AP += 3
~ roll_boss_state()
// Change state
{
    - b_boss_state == "default":
        -> default_state
    - b_boss_state == "open mouth":
        -> open_mouth_state
}

// Open mouth state
= open_mouth_state_2
// Checks if boss or player is dead
{
    - b_boss_is_dead:
        -> kill_boss
    - b_player_is_dead:
        -> kill_player
}
Open mouth state : ouvre la gueule et hurle.
// Player attack
    * {b_grabble_is_loaded == false} [Remonter le grappin. (1)]
        Vous remontez le grappin. #anim:load_grabble
    * {b_grabble_is_loaded == true} [Viser avec le grappin. (1)]
        Vous visez avec le grappin. #anim:aim_grabble
    * {b_grabble_is_loaded == true} [Tirer avec le grappin. (3)]
        Vous tirez avec le grappin. #anim:shoot_grabble
    * {b_player_is_on_top_of_mast == false} [Monter au mât. (3)]
        Vous montez au mât. #anim:Player:climb_mast
            ~ b_player_is_on_top_of_mast = true
    * {b_player_is_on_top_of_mast == true} [Saut de l'ange. (2)]
        Vous sautez depuis le mât et attaquez. #anim:Player:mast_attack
    * {b_player_AP >= b_week_attack_AP} [Attaque faible. (1)]
        Vous effectuez une attaque faible. #anim:Player:attack
    * {b_player_AP >= b_strong_attack_AP} [Attaque forte. (3)]
        Vous effectuez une attaque puissante. #anim:Player:strong_attack
// Boss attack
~ boss_attack()
// Next turn
- -> next_turn

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


// FUNCTIONS

// Player attack
=== function player_attack(pAttack)
{
    - b_boss_state == "default":
        {
            - pAttack == "weak":
                ~ b_boss_body_hp -= b_week_attack_power
                ~ b_player_AP -= b_week_attack_AP
            - pAttack == "strong":
                ~ b_boss_body_hp -= b_strong_attack_power
                ~ b_player_AP -= b_strong_attack_AP
        }
}

// Boss attack
=== function boss_attack()
{
    - b_boss_state == "default":
        ~ roll_boss_attack()
    - b_boss_state == "open mouth":
        ~ roll_boss_attack()
}
// Body attack
{
    - b_boss_body_attack == 1:
        ~ b_player_hp -= b_boss_body_attack_1_power
    - b_boss_body_attack == 2:
        ~ b_player_hp -= b_boss_body_attack_2_power
    - b_boss_body_attack == 3:
        ~ b_player_hp -= b_boss_body_attack_3_power
    - b_boss_body_attack == 4:
        ~ b_player_hp -= b_boss_body_attack_4_power
    - b_boss_body_attack == 5:
        ~ b_player_hp -= b_boss_body_attack_5_power
}
Le body a attaqué. Vous avez {b_player_hp} HP.
// Tail attack
{
    - b_boss_tail_attack == 1:
        ~ b_player_hp -= b_boss_tail_attack_1_power
    - b_boss_tail_attack == 2:
        ~ b_player_hp -= b_boss_tail_attack_2_power
    - b_boss_tail_attack == 3:
        ~ b_player_hp -= b_boss_tail_attack_3_power
    - b_boss_tail_attack == 4:
        ~ b_player_hp -= b_boss_tail_attack_4_power
}
Le tail a attaqué. Vous avez {b_player_hp} HP.

// Roll boss state
=== function roll_boss_state()
~ b_boss_state = "default"

// Roll the boss attack
=== function roll_boss_attack()
{
    - b_boss_state == "default":
        
}

// Player weak attack
=== function weak_attack()
~ b_boss_body_hp -= b_week_attack_power
{
    - b_boss_body_hp <= 0:
        kill_boss()
}

// Load the grabble
=== function load_grabble()
Vous remontez le grappin. #anim:load_grabble
~ b_grabble_is_loaded = true

// Aim with the grabble
=== function aim_grabble()
Vous visez avec le grappin. #anim:aim_grabble
~ b_grabble_is_aimed = true

// Shoot with the grabble
=== function shoot_grabble()
Vous tirez avec le grappin.
~ b_grabble_is_loaded = false
~ b_grabble_is_aimed = false

// Climb up the sail
=== function climb_up_mast()
Vous montez au mât.
~ b_player_is_on_top_of_mast = true

// Climb down the sail
=== function climb_down_mast()
Vous descendez du mât.
~ b_player_is_on_top_of_mast = true

// Lower the sail
=== function lower_sail()
Vous descendez la voile.
~ b_sail_is_down = true

=== function angel_jump()
Vous sautez depuis le mât et attaquez. #anim:Player:mast_attack
        ~ b_player_is_on_top_of_mast = false
