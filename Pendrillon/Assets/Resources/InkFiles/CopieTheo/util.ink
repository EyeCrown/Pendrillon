// UTILS


////////// UTILS VARIABLES //////////

// Debug
CONST print_debug = false // Set if the debug logs are printed or not
CONST print_debug_trial = true // Set if the debug logs of the trial are printed or not
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
    }
    ~ temp threshold = ((stat*10)+pDifficulty+modifier)
    // Min difficulty is 90%
    {
        - threshold >= 90:
            ~ threshold = 90
    }
    ~ temp result = true
    ~ D100 = roll_D100()
    {
        - D100 <= threshold:
            // Gain XP
            ~ gain_XP(pStat, threshold)
            // // Get current stat level of the player
            ~ check_level_up(pStat)
            // Skillcheck success
            ~ result = true
        - else:
            // Skillcheck failure
            ~ result = false
    }
    {
        - print_debug:
            Skill check: [{pStat}], [{pDifficulty}]
            The skill check result is {result}
            _______________
    }
    {
        - export_mode == false && result == true:
            [{D100} / {threshold} SUCCES]
        - export_mode == false && result == false:
            [{D100} / {threshold} FAILURE]
    }
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
    }
    ~ temp threshold = ((stat*10)+pDifficulty+modifier)
    // Min difficulty is 90%
    {
        - threshold >= 90:
            ~ threshold = 90
    }
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

// Gain XP
=== function gain_XP(pStat, pThreshold)
~ temp xp_to_add = sqrt(100-pThreshold)
    {
        - pStat == "char":
            {
                - p_char >= 10:
                    ~ xp_to_add = 0
            }
            ~ p_char_xp += xp_to_add
        - pStat == "stre":
            {
                - p_stre >= 10:
                    ~ xp_to_add = 0
            }
            ~ p_stre_xp += xp_to_add
        - pStat == "dext":
            {
                - p_dext >= 10:
                    ~ xp_to_add = 0
            }
            ~ p_dext_xp += xp_to_add
    }

// If the player level up, it changes its stats accordingly
=== function check_level_up(pStat)
    ~ temp stat = 0
    ~ temp stat_xp = 0
    ~ temp next_level_stat_threshold = 0
    {
        - pStat == "char":
            ~ stat = p_char
            ~ stat_xp = p_char_xp
        - pStat == "stre":
            ~ stat = p_stre
            ~ stat_xp = p_stre_xp
        - pStat == "dext":
            ~ stat = p_dext
            ~ stat_xp = p_dext_xp
    }
    ~ next_level_stat_threshold = get_XP_threshold(stat+1)
    //La stat XP est de {stat_xp} et le threshold est de {next_level_stat_threshold}.
    {
        - stat_xp >= next_level_stat_threshold:
            {
                - pStat == "char":
                    ~ p_char += 1
                    // Vous avez level up ! Votre {pStat} est maintenant de {p_char}.
                - pStat == "stre":
                    ~ p_stre += 1
                    // Vous avez level up ! Votre {pStat} est maintenant de {p_stre}.
                - pStat == "dext":
                    ~ p_dext += 1
                    // Vous avez level up ! Votre {pStat} est maintenant de {p_dext}.
            }
    }

// Return the square root of a predetermined number
=== function sqrt(pNumber)
    ~ temp result = 0
    {
        - pNumber == 0:
            ~ result = 0
        - pNumber == 5:
            ~ result = 2.23
        - pNumber == 10:
            ~ result = 3.16
        - pNumber == 15:
            ~ result = 3.87
        - pNumber == 20:
            ~ result = 4.47
        - pNumber == 25:
            ~ result = 5
        - pNumber == 30:
            ~ result = 5.47
        - pNumber == 35:
            ~ result = 5.91
        - pNumber == 40:
            ~ result = 6.32
        - pNumber == 45:
            ~ result = 6.7
        - pNumber == 50:
            ~ result = 7.0
        - pNumber == 55:
            ~ result = 7.41
        - pNumber == 60:
            ~ result = 7.74
        - pNumber == 65:
            ~ result = 8.06
        - pNumber == 70:
            ~ result = 8.36
        - pNumber == 75:
            ~ result = 8.66
        - pNumber == 80:
            ~ result = 8.94
        - pNumber == 85:
            ~ result = 9.21
        - pNumber == 90:
            ~ result = 9.48
        - pNumber == 95:
            ~ result = 9.74
        - pNumber == 100:
            ~ result = 10
        - else:
            ~ result = 8.36 // Valeur par défault en cas de bug (70%)
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

// Roll an AI skill check and return the result
=== function roll_ai_sc(pTreshold)
    ~ temp D100 = 0
    ~ temp result = true
    ~ D100 = roll_D100()
    {
        - D100 < pTreshold:
            ~ result = true
        - else:
            ~ result = false
    }
    ~ return result