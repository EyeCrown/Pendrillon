// UTILS


////////// UTILS VARIABLES //////////

// Debug
CONST print_debug = false // Set if the debug logs are printed or not
CONST export_mode = false // Set if the game is in export mode or not

// Stats names
CONST CHAR = "char" // Char variable
CONST STRE = "stre" // Stre variable
CONST DEXT = "dext" // Dext variable
CONST COMP = "comp" // Comp variable
CONST LUCK = "luck" // Luck variable

// Applausemeter
CONST APPLAUSEMETER_NOTCH_VALUE = 0.5 // The value of a notch on the applausemeter
CONST APPLAUSEMETER_STANDING_OVATION_SUCCESS_MULT = 0
CONST APPLAUSEMETER_STANDING_OVATION_FAILURE_MULT = -1.8
CONST APPLAUSEMETER_CHEERINGS_SUCCESS_MULT = 1.2
CONST APPLAUSEMETER_CHEERINGS_FAILURE_MULT = -1.5
CONST APPLAUSEMETER_NEUTRAL_SUCCESS_MULT = 1
CONST APPLAUSEMETER_NEUTRAL_FAILURE_MULT = -1
CONST APPLAUSEMETER_BOOINGS_SUCCESS_MULT = 1.5
CONST APPLAUSEMETER_BOOINGS_FAILURE_MULT = -1.2
CONST APPLAUSEMETER_ROTTEN_TOMATOES_SUCCESS_MULT = 1.8
CONST APPLAUSEMETER_ROTTEN_TOMATOES_FAILURE_MULT = -0

////////// UTILS FUNCTIONS //////////

// Perform a skill check (sc) and return the result
=== function sc(pStat, pDifficulty) ===
    ~ temp stat = p_char
    ~ temp modifier = p_char_mod
    ~ temp D100 = 0
    {
        - pStat == "char":
            ~ stat = p_char
            ~ modifier = p_char_mod
        - pStat == "stre":
            ~ stat = p_stre
            ~ modifier = p_stre_mod
        - pStat == "dext":
            ~ stat = p_dext
            ~ modifier = p_dext_mod
        - pStat == "comp":
            ~ stat = p_comp
            ~ modifier = p_comp_mod
        - pStat == "luck":
            ~ stat = p_luck
            ~ modifier = p_luck_mod
    }
    ~ temp threshold = ((stat*10)+pDifficulty+modifier)
    ~ temp result = true
    ~ D100 = roll_D100()
    {
        - D100 < threshold:
            ~ result = true
            // Modify the applausemeter
            ~ add_applausemeter(threshold_to_applausemeter_points(threshold, result))
        - else:
            ~ result = false
            // Modify the applausemeter
            ~ add_applausemeter(threshold_to_applausemeter_points(threshold, result))
    }
    {
        - print_debug:
            Skill check: [{pStat}], [{pDifficulty}]
            The skill check result is {result}
            _______________
    }
    {
        - export_mode == false && result == true:
            [{D100} / {threshold}: SUCCES]
        - export_mode == false && result == false:
            [{D100} / {threshold}: FAILURE]
    }
    //{export_mode == false && result == false: [{D100} / {threshold}: FAILURE]}
    ~ return result

// Calculate the percentage of success of an action tied with a skill check
=== function t(pStat, pDifficulty) ===
~ temp stat = p_char
~ temp full_stat = ""
    ~ temp modifier = p_char_mod
    {
        - pStat == "char":
            ~ stat = p_char
            ~ modifier = p_char_mod
            ~ full_stat = "Charisma"
        - pStat == "stre":
            ~ stat = p_stre
            ~ modifier = p_stre_mod
            ~ full_stat = "Strength"
        - pStat == "dext":
            ~ stat = p_dext
            ~ modifier = p_dext_mod
            ~ full_stat = "Dexterity"
        - pStat == "comp":
            ~ stat = p_comp
            ~ modifier = p_comp_mod
            ~ full_stat = "Composition"
        - pStat == "luck":
            ~ stat = p_luck
            ~ modifier = p_luck_mod
            ~ full_stat = "Luck"
    }
    ~ temp threshold = ((stat*10)+pDifficulty+modifier)
    // Print the percentage
    {export_mode == false: ({full_stat} {threshold}%)}

// Roll a D100 and return the result
=== function roll_D100() ===
    ~ temp result = RANDOM(1, 100)
    {
        - print_debug:
            _______________
            The D100 result is {result}
    }
    ~ return result

// Convert action threshold to applausemeter points
=== function threshold_to_applausemeter_points(pThreshold, pSuccess) ===
    ~ return ((100 - pThreshold) * get_applausemeter_multiplier(pThreshold, pSuccess)/100.0)*APPLAUSEMETER_NOTCH_VALUE

// Add a given amount to the applausemeter (can be negative)
=== function add_applausemeter(pAmount) ===
    {
        - print_debug:
            _______________
            Applausemeter changes: {pAmount}
    }
    ~ p_applause_points += pAmount
    {
        - p_applause_points > 1:
            ~ p_applause_points = 1
        - p_applause_points < 0:
            ~ p_applause_points = 0
    }

// Set the applausemeter state
=== function set_applausemeter_state(pState) ===
    ~ p_applause_state = pState

// Get the applausemeter's multiplier of a given value
=== function get_applausemeter_multiplier(pThreshold, pSuccess) ===
    ~ temp applausemeter_mult = 0
    {   
        - p_applause_state == "standing_ovation":
        {
            - pSuccess:
                ~ applausemeter_mult = APPLAUSEMETER_STANDING_OVATION_SUCCESS_MULT
            - else:
                ~ applausemeter_mult = APPLAUSEMETER_STANDING_OVATION_FAILURE_MULT
        }
        - p_applause_state == "cheerings":
        {
            - pSuccess:
                ~ applausemeter_mult = APPLAUSEMETER_CHEERINGS_SUCCESS_MULT
            - else:
                ~ applausemeter_mult = APPLAUSEMETER_CHEERINGS_FAILURE_MULT
        }
        - p_applause_state == "neutral":
        {
            - pSuccess:
                ~ applausemeter_mult = APPLAUSEMETER_NEUTRAL_SUCCESS_MULT
            - else:
                ~ applausemeter_mult = APPLAUSEMETER_NEUTRAL_FAILURE_MULT
        }
        - p_applause_state == "booings":
        {
            - pSuccess:
                ~ applausemeter_mult = APPLAUSEMETER_BOOINGS_SUCCESS_MULT
            - else:
                ~ applausemeter_mult = APPLAUSEMETER_BOOINGS_FAILURE_MULT
        }
        - p_applause_state == "rotten_tomatoes":
        {
            - pSuccess:
                ~ applausemeter_mult = APPLAUSEMETER_ROTTEN_TOMATOES_SUCCESS_MULT
            - else:
                ~ applausemeter_mult = APPLAUSEMETER_ROTTEN_TOMATOES_FAILURE_MULT
        }
    }
    ~ return applausemeter_mult

// Add the item to the inventory
=== function add_to_inventory(pItem) ===
{
    - print_debug:
        {pItem} ajouté à l'inventaire.
        (DEBUG: Inventaire non codé.)
        _______________
}