// PLAYER PROPERTIES

// Variables
VAR p_gold = 0

// States
VAR p_name = "VOYAGEUR" // Player's name
VAR p_applause_points = 0 // Player's applausemeter points (-1 to 1)
VAR p_applause_state = "neutral" // Player's applausemeter state (rotten_tomato, booings, neutral, cheerings, standing_ovation)
VAR p_archetype = "Beau Parleur" // L'archétype du joueur
CONST p_coeff_xp = 0.4 // Le coefficient de courbe d'XP
CONST p_xp_max = 135 // Le score d'XP max d'une stat (au lvl 10)

// Stats
VAR p_char = 3 // Player's charisma stat
VAR p_stre = 3 // Player's strength stat
VAR p_dext = 3 // Player's dexterity stat
VAR p_comp = 1 // Player's composition stat
VAR p_luck = 1 // Player's luck stat

// XP Points
VAR p_char_xp = 6.5 // Player's charisma XP points
VAR p_stre_xp = 6.5 // Player's strength XP points
VAR p_dext_xp = 6.5 // Player's decterity XP points

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
            ~ p_char = 4
            ~ p_stre = 3
            ~ p_dext = 3
            ~ p_char_xp = 13.5
            ~ p_stre_xp = 6.5
            ~ p_dext_xp = 6.5
        - pArchetype == "Force de la Nature":
            ~ p_archetype = "Force de la Nature"
            ~ p_char = 3
            ~ p_stre = 4
            ~ p_dext = 3
            ~ p_char_xp = 6.5
            ~ p_stre_xp = 13.5
            ~ p_dext_xp = 6.5
        - pArchetype == "Acrobate":
            ~ p_archetype = "Acrobate"
            ~ p_char = 3
            ~ p_stre = 3
            ~ p_dext = 4
            ~ p_char_xp = 6.5
            ~ p_stre_xp = 6.5
            ~ p_dext_xp = 13.5
    }

// Get the XP Threshold at a given level
=== function get_XP_threshold(pLevel)
    ~ temp result = 0
    {
        - pLevel == 1:
            ~ result = 0.45
        - pLevel == 2:
            ~ result = 2.5
        - pLevel == 3:
            ~ result = 6.5
        - pLevel == 4:
            ~ result = 13.5
        - pLevel == 5:
            ~ result = 24
        - pLevel == 6:
            ~ result = 37.5
        - pLevel == 7:
            ~ result = 55.5
        - pLevel == 8:
            ~ result = 77
        - pLevel == 9:
            ~ result = 104
        - pLevel == 10:
            ~ result = 135
        - pLevel == 11:
            ~ result = 9999 // Evite d'éventuels bugs
    }
    ~ return result