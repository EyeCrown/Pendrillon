// PLAYER PROPERTIES

// Variables
VAR p_gold = 0

// States
VAR p_name = "VOYAGEUR" // Player's name
VAR p_applause_points = 0 // Player's applausemeter points (-1 to 1)
VAR p_applause_state = "neutral" // Player's applausemeter state (rotten_tomato, booings, neutral, cheerings, standing_ovation)
VAR p_archetype = "Beau Parleur" // L'archétype du joueur

// Stats
VAR p_char = 5 // Player's charisma stat
VAR p_stre = 5 // Player's strength stat
VAR p_dext = 5 // Player's dexterity stat
VAR p_comp = 1 // Player's composition stat
VAR p_luck = 1 // Player's luck stat

// Modifiers
VAR p_char_mod = 0 // Player's charisma modifier stat
VAR p_stre_mod = 0 // Player's strength modifier stat
VAR p_dext_mod = 0 // Player's dexterity modifier stat
VAR p_comp_mod = 0 // Player's composition modifier stat
VAR p_luck_mod = 0 // Player's luck modifier stat

// Select player's archetype and modify its stats accordingly
=== function select_archetype(pArchetype)
{
    - pArchetype == "Beau Parleur":
        ~ p_archetype = "Beau Parleur"
        ~ p_char = 5
        ~ p_stre = 3
        ~ p_dext = 3
    - pArchetype == "Force de la Nature":
        ~ p_archetype = "Force de la Nature"
        ~ p_char = 3
        ~ p_stre = 5
        ~ p_dext = 3
    - pArchetype == "Acrobate":
        ~ p_archetype = "Acrobate"
        ~ p_char = 3
        ~ p_stre = 3
        ~ p_dext = 5
}