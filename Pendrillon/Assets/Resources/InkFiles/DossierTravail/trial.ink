// TRIAL PROPERTIES
VAR t_audience_judgement = 0.5 // Compris entre 0 et 1
VAR t_arle_patience = 5 // Patience de Arle (0 = Arle pète un câble)
VAR t_souffleur_explanations_bell = false

// SECRET MEETING
VAR t_1_accept_to_kill = false
VAR t_1_refuse_to_kill = false
VAR t_1_disrespect_the_crown = false
VAR t_1_respect_the_crown = false
VAR t_1_disrespect_irene = false
VAR t_1_respect_irene = false
VAR t_1_gold_digger = false
VAR t_1_accept_mission_with_positivity = false
VAR t_1_accept_mission_with_negativity = false
// DEBUG TRIBUNAL
// VAR t_1_accept_to_kill = false
// VAR t_1_refuse_to_kill = true
// VAR t_1_disrespect_the_crown = true
// VAR t_1_respect_the_crown = false
// VAR t_1_disrespect_irene = false
// VAR t_1_respect_irene = true
// VAR t_1_gold_digger = false
// VAR t_1_accept_mission_with_positivity = false
// VAR t_1_accept_mission_with_negativity = true

// TRIP RETURN SCENE
VAR t_2_lawfull = false
VAR t_2_lawless = false
VAR t_2_against_law = false
VAR t_2_against_crown = false
VAR t_2_show_regrets = false
VAR t_2_show_no_regrets = false
VAR t_2_bribe_guards = false
VAR t_2_attack_guards = false
//Debug TRIBUNAL
// VAR t_2_lawfull = true
// VAR t_2_lawless = false
// VAR t_2_against_law = false
// VAR t_2_against_crown = true
// VAR t_2_show_regrets = true
// VAR t_2_show_no_regrets = false
// VAR t_2_bribe_guards = true
// VAR t_2_attack_guards = true

// CHURCH NIGHT SCENE
VAR t_3_implore_irene = false
VAR t_3_blame_irene = false
VAR t_3_no_light_on_irene_torch = false
VAR t_3_light_on_irene_torch = false
VAR t_3_doubt_about_irene_cryings = false
VAR t_3_is_with_irene_saviors = false
VAR t_3_is_against_irene_saviors = false
VAR t_3_insult_interest_about_irene = false
VAR t_3_not_believing_irene_predictions = false
VAR t_3_moved_by_baby_irene = false
VAR t_3_fake_about_feeling_for_the_baby = false
VAR t_3_religion_is_to_make_naive_cry = false
VAR t_3_rant_about_edgar_the_traquenard = false
VAR t_3_does_not_believe_in_lighthouse_sacred_light = false
VAR t_3_believe_in_lighthouse_sacred_light = false
VAR t_3_does_not_believe_the_sacred_writings = false
VAR t_3_question_if_irene_is_a_sireine = false
VAR t_3_question_judge_position = false
VAR t_3_show_judge_respect = false
VAR t_3_say_judge_is_not_human = false
VAR t_3_look_away_judge_stained_glass = false
VAR t_3_validate_judge_position = false
VAR t_3_criticise_irene_coldness = false
VAR t_3_stained_glass_1_talk = false
VAR t_3_stained_glass_2_talk = false
VAR t_3_stained_glass_3_talk = false
//DEBUG TRIBUNAL
// VAR t_3_implore_irene = true
// VAR t_3_blame_irene = false
// VAR t_3_no_light_on_irene_torch = true
// VAR t_3_light_on_irene_torch = true
// VAR t_3_doubt_about_irene_cryings = false
// VAR t_3_is_with_irene_saviors = true
// VAR t_3_is_against_irene_saviors = false
// VAR t_3_insult_interest_about_irene = false
// VAR t_3_not_believing_irene_predictions = false
// VAR t_3_moved_by_baby_irene = true
// VAR t_3_fake_about_feeling_for_the_baby = false
// VAR t_3_religion_is_to_make_naive_cry = true
// VAR t_3_rant_about_edgar_the_traquenard = true
// VAR t_3_does_not_believe_in_lighthouse_sacred_light = true
// VAR t_3_believe_in_lighthouse_sacred_light = false
// VAR t_3_does_not_believe_the_sacred_writings = false
// VAR t_3_question_if_irene_is_a_sireine = true
// VAR t_3_question_judge_position = false
// VAR t_3_show_judge_respect = false
// VAR t_3_say_judge_is_not_human = true
// VAR t_3_look_away_judge_stained_glass = false
// VAR t_3_validate_judge_position = false
// VAR t_3_criticise_irene_coldness = false
// VAR t_3_stained_glass_1_talk = true
// VAR t_3_stained_glass_2_talk = true
// VAR t_3_stained_glass_3_talk = true

// CHURCH DAY
VAR t_4_give_guards_surname = false


// Let the trial register a player choice by changing the given variable to true
=== function trial() ===
    #playsound:Play_SFX_Story_JudgeBellFarTrial #screenshake
    #wait:0.5 #audience:choc
    {
        - t_souffleur_explanations_bell == false:
            SOUFFLEUR: Psssst... Hé, l'ami ! Tu as entendu ?
            SOUFFLEUR: C'est la <shake>Cloche du Destin™</shake> !
            SOUFFLEUR: Enfin, c'est comme ça que <i>moi</i> je l'appelle.
            SOUFFLEUR: Tu l'entendras sonner lorsque tu feras un choix qui modifie le scénario de la pièce.
            SOUFFLEUR: Cela signifie que ton choix aura des conséquences <b>majeures</b> sur la suite de l’histoire !
            SOUFFLEUR: Ne t’en fais pas, même si c'est imprévu, les autres acteurs aussi savent improviser !
            ~ t_souffleur_explanations_bell = true
    }

// Return if player is accused of the given felony
=== function is_accused_of(pFelony) ===
    ~ temp isAccused = false
    { 
        - pFelony == "bribe guards":
            {
                - t_2_bribe_guards: 
                    ~ isAccused = true
                - else:
                    ~ isAccused = false
            }
            ~ isAccused = t_2_bribe_guards
        - pFelony == "attack guards":
            {
                -  t_2_attack_guards:
                    ~ isAccused = true
                - else:
                    ~ isAccused = false
            }
        - pFelony == "blasphemy":
            {
                - t_1_disrespect_irene or t_3_blame_irene or t_3_doubt_about_irene_cryings or t_3_insult_interest_about_irene or t_3_not_believing_irene_predictions or t_3_religion_is_to_make_naive_cry or t_3_does_not_believe_in_lighthouse_sacred_light or t_3_does_not_believe_the_sacred_writings or t_3_criticise_irene_coldness: 
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
                - t_3_question_judge_position or t_3_say_judge_is_not_human:
                    ~ isAccused = true
                - else:
                    ~ isAccused = false
            }
    }
    ~ return isAccused

// Audience judgment system
=== function audience_judgement(pScore) ===
    ~ t_audience_judgement += pScore
    {
        - t_audience_judgement < 0:
            ~ t_audience_judgement = 0
        - t_audience_judgement > 1:
            ~ t_audience_judgement = 1
    }
    // Debug
    {
        - print_debug_trial: <> AP = {t_audience_judgement}
    }

// Makes Arle angry until she leaves stage
=== function make_arle_angry() ===
    ~ temp arle_leaves_stage = false
    ~ t_arle_patience -= 1
    {
        - t_arle_patience == 4:
            SOUFFLEUR: Psssst... Hé, l'ami !
            SOUFFLEUR: Je ne devrais pas te dire ça, mais... Notre amie n'aime pas trop qu'on se moque d'elle sur scène.
            SOUFFLEUR: Elle dit que ça « l'empêche d'atteindre les sommets », tu piges ?
            SOUFFLEUR: Si tu continues, je ne serai pas étonné qu'elle sorte de son personnage.
            SOUFFLEUR: À bon entendeur, l'ami !
        - t_arle_patience == 2:
            SOUFFLEUR: Psssst... Hé, l'ami ! C'est encore moi !
            SOUFFLEUR: Je crois que tu es sur le point de la mettre hors d'elle, avec toutes tes moqueries...
            SOUFFLEUR: Cela dit, le public semble apprécier...
            SOUFFLEUR: Peut-être que le spectacle n'en serait que plus amusant ? À toi d'en juger, l'ami !
        - t_arle_patience <= 0:
            ARLE: Il suffit ! Assez de moqueries ! Ferme-la !! #audience:silent
            ARLE: Et vous, public « adoré », vous ne me méritez pas ! Cessez de rire ! #audience:debate
            ARLE: Auriez-vous le millième de mon talent, vous seriez sur scène plutôt que de l'autre côté ! #audience:choc
            ARLE: Bande de ploucs ! Vous pensez qu'avoir payé votre ticket vous donne tous les droits ?! #audience:booing
            // Une corde emmène Arle
            ARLE: Hé ! Laisse-moi ! Laisse-moi j'ai dit ! #audience:laughter
            SOUFFLEUR: Oula, oula, oula...
            SOUFFLEUR: Ne t'en fais pas, l'ami : ce n'est pas la première fois qu'on doit la faire évacuer !
            SOUFFLEUR: Elle reviendra vite... Elle est accro au feu des projecteurs !
            SOUFFLEUR: Quoi qu'il en soit: « Show must go on! », l'ami !
            ~ arle_leaves_stage = true
            ~ arle_left_the_play = true
    }
    ~ return arle_leaves_stage

// Souffleur speech about not mocking Agath
=== function souffleur_speech_about_mocking_agath()
    {
        - souffleur_speech_about_not_mocking_agath_done == false:
        SOUFFLEUR: Psssst... Hé, l'ami !
        SOUFFLEUR: Je connais bien le public, et ton approche risque de faire des étincelles !
        SOUFFLEUR: Si tu veux avoir une chance de gagner ce procès, il va falloir tenir sa langue...
        SOUFFLEUR: Se moquer d'Agathe ne fonctionnera pas, car le public l'apprécie énormément...
        SOUFFLEUR: On ne dirait pas comme ça, mais l'actrice qui l'incarne est un véritable monument !
        SOUFFLEUR: Pour ne rien arranger, une bonne partie d'entre eux sont favorables aux enseignements d'Irène...
        SOUFFLEUR: Prends ton mal en patience et laisse Agathe témoigner, elle se contentera de dire la stricte vérité.
        SOUFFLEUR: Espérons que tu pourras t'en défendre une fois son témoignage terminé, entendu l'ami ?
    }
    ~ souffleur_speech_about_not_mocking_agath_done = true

// Souffleur speech about Agath testimonial 
== function souffleur_speech_about_agath_testimonial()
{
        - souffleur_speech_about_not_mocking_agath_done == false:
        SOUFFLEUR: Psssst... Hé, l'ami !
        SOUFFLEUR: Je vois que jusqu'à présent, tu as laissé Agathe parler : c'est exactement ce qu'il faut faire !
        SOUFFLEUR: Si tu veux avoir une chance de gagner ce procès, il va falloir tenir sa langue...
        SOUFFLEUR: Tu vas devoir laisser Agathe parler, car le public l'apprécie énormément...
        SOUFFLEUR: On ne dirait pas comme ça, mais l'actrice qui l'incarne est un véritable monument !
        SOUFFLEUR: Prends ton mal en patience et laisse Agathe témoigner, elle se contentera de dire la stricte vérité.
        SOUFFLEUR: Espérons que tu pourras t'en défendre une fois son témoignage terminé, entendu l'ami ?
    }