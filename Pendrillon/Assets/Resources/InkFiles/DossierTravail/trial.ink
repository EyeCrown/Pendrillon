// TRIAL PROPERTIES
VAR t_audience_judgement = 0.5 // Compris entre 0 et 1

// SECRET MEETING
VAR t_1_disrespect_the_crown = false
VAR t_1_respect_the_crown = false
VAR t_1_disrespect_irene = false
VAR t_1_respect_irene = false
VAR t_1_gold_digger = false

// TRIP RETURN SCENE
VAR t_2_lawfull = false
VAR t_2_lawless = false
VAR t_2_have_bribed_guards = false
VAR t_2_against_law = false
VAR t_2_against_crown = false
VAR t_2_show_regrets = false
VAR t_2_show_no_regrets = false
VAR t_2_jester_attacked = false
VAR t_2_bribe_guards = false
VAR t_2_try_but_fail_bribing_guards = false
VAR t_2_try_and_succeed_bribing_guards = false

// CHURCH NIGHT SCENE
VAR t_3_implore_irene = false
VAR t_3_blame_irene = false
VAR t_3_show_no_regrets = false
VAR t_3_show_some_regrets = false
VAR t_3_show_plenty_regrets = false
VAR t_3_no_light_on_irene_torch = false
VAR t_3_light_on_irene_torch = false
VAR t_3_doubt_about_irene_cryings = false
VAR t_3_insult_interest_about_irene = false
VAR t_3_not_believing_irene_predictions = false
VAR t_3_insult_irene_savior = false
VAR t_3_moved_by_baby_irene = false
VAR t_3_fake_about_feeling_for_the_baby = false
VAR t_3_religion_is_to_make_naive_cry = false
VAR t_3_does_not_know_ernest = false
VAR t_3_know_ernest = true
VAR t_3_rant_about_edgar_the_traquenard = false
VAR t_3_does_not_believe_in_lighthouse_sacred_light = false
VAR t_3_believe_in_lighthouse_sacred_light = false
VAR t_3_know_fishermen_holy_gift = false
VAR t_3_does_not_know_fishermen_holy_gift = false
VAR t_3_does_not_believe_the_sacred_writings = false
VAR t_3_question_if_irene_is_a_sireine = false
VAR t_3_question_judge_position = false
VAR t_3_show_judge_respect = false
VAR t_3_validate_judge_position = false
VAR t_3_defend_sireine = false
VAR t_3_criticise_irene_coldness = false
VAR t_3_law_should_not_be_lax = false
VAR t_3_law_can_be_lax = false

// CHURCH DAY
VAR t_4_statue_is_broken = false
VAR t_4_church_is_burnt = false

// Let the trial register a player choice by changing the given variable to true
=== function trial(pVariable) ===
~ pVariable = true 
#trial
#playsound:Play_SFX_Story_JudgeBellFar

// Return if player is accused of the given felony
=== function is_accused_of(pFelony) ===
~ temp isAccused = false
{ 
    - pFelony == "bribe guards":
        ~ isAccused = t_2_bribe_guards
    - pFelony == "blasphemy":
        {
            - t_1_disrespect_irene or t_3_blame_irene or t_3_doubt_about_irene_cryings or t_3_insult_interest_about_irene or t_3_not_believing_irene_predictions or t_3_insult_irene_savior or t_3_religion_is_to_make_naive_cry or t_3_does_not_believe_in_lighthouse_sacred_light or t_3_does_not_believe_the_sacred_writings or t_3_criticise_irene_coldness: 
                ~ isAccused = true
            - else:
                ~ isAccused = false
        }
    - pFelony == "sacred degradations":
        {
            - t_4_statue_is_broken or t_4_church_is_burnt:
                ~ isAccused = true
            - else:
                ~ isAccused = false
        }
    - pFelony == "crown outrage":
        {
            - t_1_disrespect_the_crown or t_2_against_crown:
                ~ isAccused = true
            - else:
                ~ isAccused = false
        }
    - pFelony == "judge outrage":
        {
            - t_3_question_judge_position:
                ~ isAccused = true
            - else:
                ~ isAccused = false
        }
}
~ return isAccused

// Audience judgment system
=== function audience_judgement(pScore) ===
// À recoder en faisant un vrai algo, comme l'applaudimètre
~ t_audience_judgement += pScore
{
    - t_audience_judgement < 0:
        ~ t_audience_judgement = 0
    - t_audience_judgement > 1:
        ~ t_audience_judgement = 1
}