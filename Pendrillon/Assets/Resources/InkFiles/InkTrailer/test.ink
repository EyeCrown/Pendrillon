/*// BOSS BATTLE SCENE

// Player variables
VAR b_player_is_dead = false
VAR b_player_won = false
VAR b_player_hp = 10
VAR b_player_AP = 3
VAR b_player_nb_combo_attack = 0 // max per turn = 3
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
// Boss battle begin
-> default_state

- -> end_battle

// Default state
= default_state
// Checks if boss or player is dead
{
    - b_boss_is_dead:
        -> kill_boss
    - b_player_is_dead:
        -> kill_player
}
Default state : dans l’eau, avec sa queue dans l’eau aussi.
// Player attack
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
        Vous sautez depuis le mât et attaquez. #anim:Player:mast_attack
        ~ b_player_is_on_top_of_mast = false
    + {b_player_AP >= 1 && b_player_is_on_top_of_mast == true} [Descendre du mât. (1)]
        Vous descendez du mât. #anim:climb_down_mast
    + {b_player_AP >= 1 && b_player_is_on_top_of_mast == false && b_player_AP >= b_week_attack_AP} [Attaque faible. (1)]
        Vous effectuez une attaque faible. #anim:Player:attack
    + {b_player_AP >= 3 && b_player_is_on_top_of_mast == false && b_player_AP >= b_strong_attack_AP} [Attaque forte. (3)]
        Vous effectuez une attaque puissante. #anim:Player:strong_attack
    + [Se protéger.]
        Vous vous protégez et passez le tour.
- // Suite combat
// Boss attack
~ boss_attack()
// Next turn
- -> next_turn

// Next turn
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
= open_mouth_state
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





*/