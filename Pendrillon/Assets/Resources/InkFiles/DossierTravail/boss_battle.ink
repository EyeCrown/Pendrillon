// BOSS BATTLE SCENE

// Player variables
VAR b_player_is_dead = false
VAR b_player_won = false
VAR b_player_hp = 10
VAR b_player_AP = 99
VAR b_player_is_on_top_of_mast = false

// Environement
VAR b_harpoon_is_loaded = true
VAR b_harpoon_is_aimed = false
VAR b_canon_is_loaded = false
VAR b_canon_is_aimed = false
VAR b_nb_canon_bullet_left = 3
VAR b_sail_is_down = false
VAR b_explosive_barrel_1_is_used = false
VAR b_explosive_barrel_1_is_loaded = false
VAR b_explosive_barrel_2_is_brought_and_not_used = true
VAR b_explosive_barrel_2_is_used = false
VAR b_explosive_barrel_2_is_loaded = false
VAR b_explosive_barrel_left = true

// Boss variables
// Base
VAR b_boss_is_dead = false
VAR b_boss_state = "default"
VAR b_boss_body_attack = 1
VAR b_boss_tail_attack = 1
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
- SOUFFLEUR: Psssst... Hé, l'ami ! #wait:3
SOUFFLEUR: Cette scène nous coûte une fortune en effets spéciaux à chaque spectacle...
SOUFFLEUR: Tu n'imagines pas le budget que ça représente, en terme de chorégraphie, de matériel, de main-d'oeuvre...
SOUFFLEUR: Sans parler des <shake>coûts d'entretiens</shake> !
SOUFFLEUR: Essayons d'en profiter pour en mettre plein les yeux au public, d'accord l'ami ?
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
    + [Utiliser le harpon]
        ++ {b_player_AP > 0 && b_player_is_on_top_of_mast == false && b_harpoon_is_loaded == false} [Remonter le harpon (AP)]
            ~ load_harpoon()
        ++ {b_player_AP > 0 && b_player_is_on_top_of_mast == false && b_harpoon_is_loaded == true && b_harpoon_is_aimed == false} [Viser avec le harpon (AP)]
            ~ aim_harpoon()
        ++ {b_player_AP > 0 && b_player_is_on_top_of_mast == false && b_harpoon_is_loaded == true} [Tirer. (AP)]
            ~ shoot_harpoon()
        ++ [Retourner sur le pont]
            -> default_state
    +  {b_nb_canon_bullet_left > 0} [Utiliser le canon]
        ++ {b_player_AP > 0 && b_canon_is_loaded == false} [Charger le canon (AP)]
            ~ load_canon()
        ++ {b_player_AP > 0 && b_canon_is_loaded == true && b_canon_is_aimed == false} [Viser avec le canon (AP)]
            ~ aim_canon()
        ++ {b_player_AP > 0 && b_canon_is_loaded == true} [Tirer avec le canon (AP)]
            ~ shoot_canon()
        ++ [Retourner sur le pont]
            -> main_menu
    + {b_explosive_barrel_left == true} [Utiliser les tonneaux explosifs]
        ++ {b_player_AP > 0 && b_explosive_barrel_1_is_used == false && b_explosive_barrel_1_is_loaded == false} [Charger le tonneau d'explosifs (AP)]
            ~ load_barrel_1()
        ++ {b_player_AP > 0 && b_explosive_barrel_1_is_used == false && b_explosive_barrel_1_is_loaded == true} [Lancer le tonneau explosif (AP)]
            ~ throw_barrel_1()
        ++ {b_player_AP > 0 && b_explosive_barrel_1_is_used == true && b_explosive_barrel_2_is_brought_and_not_used == true && b_explosive_barrel_2_is_used == false && b_explosive_barrel_2_is_loaded == false} [Charger le tonneau d'explosifs (AP)]
            ~ load_barrel_2()
        ++ {b_player_AP > 0 && b_explosive_barrel_1_is_used == true && b_explosive_barrel_2_is_brought_and_not_used == true && b_explosive_barrel_2_is_used == false && b_explosive_barrel_2_is_loaded == true} [Lancer le tonneau explosif (AP)]
            ~ throw_barrel_2()
        ++ [Retourner sur le pont]
            -> main_menu
    + [Monter au mât (AP)]
        ~ climb_up_mast()
        ** {b_player_AP > 0 && b_sail_is_down == false} [Baisser la voile (AP)]
            ~ lower_sail()
        ++ {b_player_AP > 0} [Saut de l'ange (AP)]
            ~ angel_jump()
        ++ {b_player_AP > 0} [Descendre du mât]
            Vous descendez du mât. #anim:climb_down_mast
- {b_player_AP>0: -> default_state | -> end_turn}


= open_mouth_state
Open mouth

= under_water_state
Under water

= on_boat_state
On boat

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
    * {b_harpoon_is_loaded == false} [Remonter le harpon (AP)]
        Vous remontez le harpon. #anim:load_harpoon
    * {b_harpoon_is_loaded == true} [Viser avec le harpon (AP)]
        Vous visez avec le harpon. #anim:aim_harpoon
    * {b_harpoon_is_loaded == true} [Tirer avec le harpon (AP)]
        Vous tirez avec le harpon. #anim:shoot_harpoon
    * {b_player_is_on_top_of_mast == false} [Monter au mât (AP)]
        Vous montez au mât. #anim:Player:climb_mast
            ~ b_player_is_on_top_of_mast = true
    * {b_player_is_on_top_of_mast == true} [Saut de l'ange (AP)]
        Vous sautez depuis le mât et attaquez. #anim:Player:mast_attack
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

// Use one action point
== function use_action_point()
    ~ b_player_AP -= 1

// Roll boss state
=== function roll_boss_state()
~    b_boss_state = "default"

// Roll the boss attack
=== function roll_boss_attack()
{
    - b_boss_state == "default":
        
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
    ~ use_action_point()

// Shoot with the grabble
=== function shoot_harpoon()
Vous tirez avec le harpon. #anim:shoot_harpoon
    ~ b_harpoon_is_loaded = false
    ~ b_harpoon_is_aimed = false
    ~ use_action_point()

// Climb up the sail
=== function climb_up_mast()
Vous montez au mât.
    ~ b_player_is_on_top_of_mast = true
    ~ use_action_point()

// Climb down the sail
=== function climb_down_mast()
Vous descendez du mât.
    ~ b_player_is_on_top_of_mast = true

// Lower the sail
=== function lower_sail()
Vous descendez la voile.
    ~ b_sail_is_down = true
    ~ use_action_point()

=== function angel_jump()
Vous sautez depuis le mât et attaquez. #anim:Player:mast_attack
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
    ~ use_action_point()

// Shoot with the canon
=== function shoot_canon()
Vous tirez avec le canon. #anim:shoot_canon
    ~ b_canon_is_loaded = false
    ~ b_canon_is_aimed = false
    ~ b_nb_canon_bullet_left -= 1
    ~ use_action_point()

// Load the barrel 1
=== function load_barrel_1()
Vous chargez le tonneau explosif. #anim:load_barrel_1
    ~ b_explosive_barrel_1_is_loaded = true
    ~ use_action_point()

// Throw the barrel 1
=== function throw_barrel_1()
Vous lancez le tonneau explosif. #anim:throw_barrel_1
    ~ b_explosive_barrel_1_is_used = true
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
    ~ use_action_point()