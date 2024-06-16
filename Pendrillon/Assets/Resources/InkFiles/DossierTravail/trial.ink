// TRIAL PROPERTIES
VAR t_audience_judgement = 50 // Compris entre 0 et 100
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
// VAR t_1_accept_to_kill = true
// VAR t_1_refuse_to_kill = false
// VAR t_1_disrespect_the_crown = true
// VAR t_1_respect_the_crown = false
// VAR t_1_disrespect_irene = true
// VAR t_1_respect_irene = false
// VAR t_1_gold_digger = true
// VAR t_1_accept_mission_with_positivity = false
// VAR t_1_accept_mission_with_negativity = true

// TRIP RETURN SCENE
VAR t_2_lawfull = false
VAR t_2_lawless = false
VAR t_2_against_law = false
VAR t_2_against_crown = false
VAR t_2_show_regrets = false
VAR t_2_show_no_regrets = false
VAR t_2_has_attacked_guards = false
VAR t_2_bribe_guards = false
//Debug TRIBUNAL
// VAR t_2_lawfull = false
// VAR t_2_lawless = true
// VAR t_2_against_law = true
// VAR t_2_against_crown = true
// VAR t_2_show_regrets = false
// VAR t_2_show_no_regrets = true
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
// VAR t_3_implore_irene = false
// VAR t_3_blame_irene = true
// VAR t_3_no_light_on_irene_torch = true
// VAR t_3_light_on_irene_torch = true
// VAR t_3_doubt_about_irene_cryings = true
// VAR t_3_is_with_irene_saviors = false
// VAR t_3_is_against_irene_saviors = true
// VAR t_3_insult_interest_about_irene = true
// VAR t_3_not_believing_irene_predictions = true
// VAR t_3_moved_by_baby_irene = false
// VAR t_3_fake_about_feeling_for_the_baby = false
// VAR t_3_religion_is_to_make_naive_cry = true
// VAR t_3_rant_about_edgar_the_traquenard = true
// VAR t_3_does_not_believe_in_lighthouse_sacred_light = true
// VAR t_3_believe_in_lighthouse_sacred_light = false
// VAR t_3_does_not_believe_the_sacred_writings = true
// VAR t_3_question_if_irene_is_a_sireine = true
// VAR t_3_question_judge_position = true
// VAR t_3_show_judge_respect = false
// VAR t_3_say_judge_is_not_human = true
// VAR t_3_look_away_judge_stained_glass = true
// VAR t_3_validate_judge_position = false
// VAR t_3_criticise_irene_coldness = true
// VAR t_3_stained_glass_1_talk = true
// VAR t_3_stained_glass_2_talk = true
// VAR t_3_stained_glass_3_talk = true

// CHURCH DAY
VAR t_4_give_guards_surname = false

// Let the trial register a player choice by changing the given variable to true
=== function trial() ===
-
    {
        - t_souffleur_explanations_bell == false:
            SOUFFLEUR: Psssst... Hé, l'ami ! Tu as entendu ? #playsound:VOX_Souffleur_pssthe8
            SOUFFLEUR: C'est la <shake>Cloche du Destin™</shake> ! #playsound:VOX_Souffleur_clochedudestin
            SOUFFLEUR: Enfin, c'est comme ça que <i>moi</i> je l'appelle. #playsound:VOX_Souffleur_moijelappelle
            SOUFFLEUR: Tu l'entendras sonner lorsque tu feras un choix qui modifie le scénario de la pièce. #playsound:VOX_Souffleur_scenariodelapiece
            SOUFFLEUR: Cela signifie que ton choix aura des conséquences <b>majeures</b> sur la suite de l’histoire ! #playsound:VOX_Souffleur_consequencesmajeures
            SOUFFLEUR: Ne t’en fais pas, même si c'est imprévu, les autres acteurs aussi savent improviser ! #playsound:VOX_Souffleur_memeimprevu
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
                -  t_2_has_attacked_guards:
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
        - t_audience_judgement <= 0:
            ~ t_audience_judgement = 0
        - t_audience_judgement >= 100:
            ~ t_audience_judgement = 100
    }
    // Debug
    {
        - print_debug_trial: <> AP = {t_audience_judgement}
    }

// Makes Arle angry until she leaves stage
=== function make_arle_angry() ===
    ~ temp arle_leaves_the_stage = false
    ~ t_arle_patience -= 1
    {
        - t_arle_patience == 4:
            SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe9
            SOUFFLEUR: Je ne devrais pas te dire ça, mais... Notre amie n'aime pas trop qu'on se moque d'elle sur scène. #playsound:VOX_Souffleur_semoquer
            SOUFFLEUR: Elle dit que ça « l'empêche d'atteindre les sommets », tu piges ? #playsound:VOX_Souffleur_atteindresommets
            SOUFFLEUR: Si tu continues, je ne serai pas étonné qu'elle sorte de son personnage. #playsound:VOX_Souffleur_continuessorte
            SOUFFLEUR: À bon entendeur, l'ami ! #playsound:VOX_Souffleur_abonentendeud
        - t_arle_patience == 2:
            SOUFFLEUR: Psssst... Hé, l'ami ! C'est encore moi ! #playsound:VOX_Souffleur_pssthe10
            SOUFFLEUR: Je crois que tu es sur le point de la mettre hors d'elle, avec toutes tes moqueries... #playsound:VOX_Souffleur_jedroishorsdelle
            SOUFFLEUR: Cela dit, le public semble apprécier... #playsound:VOX_Souffleur_lepublicaime
            SOUFFLEUR: Peut-être que le spectacle n'en serait que plus amusant ? À toi d'en juger, l'ami ! #playsound:VOX_Souffleur_peutetrespectacle
        - t_arle_patience <= 0:
            ARLE: Il suffit ! Assez de moqueries ! Ferme-la !! #audience:silent #playsound:VOX_Arle_suffitdemoqueries
            ARLE: Et vous, public « adoré », vous ne me méritez pas ! Cessez de rire ! #audience:debate #playsound:VOX_Arle_publicadorelahonte
            ARLE: Auriez-vous le millième de mon talent, vous seriez sur scène plutôt que de l'autre côté ! #audience:choc #playsound:VOX_Arle_milliemedemontalent
            ARLE: Bande de ploucs ! Vous pensez qu'avoir payé votre ticket vous donne tous les droits ?! #audience:booing #playsound:VOX_Arle_bandedeploucs
            ARLE: Hé ! Laisse-moi ! Laisse-moi j'ai dit ! #rope:Arle #box #wait:2 #audience:laughter #playsound:VOX_Arle_helaissemoijaidit
            SOUFFLEUR: Oula, oula, oula... #playsound:VOX_Souffleur_oulaoula #wait:1 
            SOUFFLEUR: Ne t'en fais pas, l'ami : ce n'est pas la première fois qu'on doit la faire évacuer ! #playsound:VOX_Souffleur_entenfaispas
            SOUFFLEUR: Elle reviendra vite... Elle est accro au feu des projecteurs ! #playsound:VOX_Souffleur_accro
            SOUFFLEUR: Quoi qu'il en soit: <i>« Show must go on! »</i>, l'ami ! #playsound:VOX_Souffleur_show
            ~ arle_leaves_the_stage = true
    }
    ~ return arle_leaves_the_stage

// Souffleur speech about not mocking Agath
=== function souffleur_speech_about_mocking_agath()
    {
        - souffleur_speech_about_not_mocking_agath_done == false:
        SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe11
        SOUFFLEUR: Je connais bien le public, et ton approche risque de faire des étincelles ! #playsound:VOX_Souffleur_jeconnaislepublic
        SOUFFLEUR: Si tu veux avoir une chance de gagner ce procès, il va falloir tenir sa langue... #playsound:VOX_Souffleur_unechanceproces
        SOUFFLEUR: Se moquer d'Agathe ne fonctionnera pas, car le public l'apprécie énormément... #playsound:VOX_Souffleur_agathe
        SOUFFLEUR: On ne dirait pas comme ça, mais l'actrice qui l'incarne est un véritable monument ! #playsound:VOX_Souffleur_unmonument
        SOUFFLEUR: Pour ne rien arranger, une bonne partie d'entre eux sont favorables aux enseignements d'Irène... #playsound:VOX_Souffleur_enseignementsirene
        SOUFFLEUR: Prends ton mal en patience et laisse Agathe témoigner, elle se contentera de dire la stricte vérité. #playsound:VOX_Souffleur_agathe2
        SOUFFLEUR: Espérons que tu pourras t'en défendre une fois son témoignage terminé, entendu l'ami ? #playsound:VOX_Souffleur_temoignagetermien
    }
    ~ souffleur_speech_about_not_mocking_agath_done = true

// Souffleur speech about Agath testimonial 
== function souffleur_speech_about_agath_testimonial()
{
        - souffleur_speech_about_not_mocking_agath_done == false:
        SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe12
        SOUFFLEUR: Je vois que jusqu'à présent, tu as laissé Agathe parler : c'est exactement ce qu'il faut faire ! #playsound:VOX_Souffleur_agathe3
        SOUFFLEUR: Si tu veux avoir une chance de gagner ce procès, il va falloir tenir sa langue... #playsound:VOX_Souffleur_unechangelangue
        SOUFFLEUR: Tu vas devoir laisser Agathe parler, car le public l'apprécie énormément... #playsound:VOX_Souffleur_agathe4
        SOUFFLEUR: On ne dirait pas comme ça, mais l'actrice qui l'incarne est un véritable monument ! #playsound:VOX_Souffleur_catherine
        SOUFFLEUR: Prends ton mal en patience et laisse Agathe témoigner, elle se contentera de dire la stricte vérité. #playsound:VOX_Souffleur_laisseagathe
        SOUFFLEUR: Espérons que tu pourras t'en défendre une fois son témoignage terminé, entendu l'ami ? #playsound:VOX_Souffleur_esperonsdefendreplustard
    }