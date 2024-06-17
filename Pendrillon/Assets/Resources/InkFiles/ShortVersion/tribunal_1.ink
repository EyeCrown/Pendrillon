// TRIBUNAL SCENE 1

// Variables
VAR judge_explained_mask = false
VAR accuse_arle_to_disrespect_queen = false
VAR admit_disrespect_queen = false
VAR arle_lied = false
VAR arle_lied_again = false
VAR souffleur_speech_about_not_mocking_agath_done = false

// Scene
=== tribunal_1 ===
-> start

= start
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Judge:JUGE ERNEST
#actor:Arle:ARLE
// Set the location
#curtains:open
#set:trial
// Set the actor's positions

// Start the scene
//#open_curtains
#audience:debate
#audience:silent
// Le juge est encore seul sur scène
#audience:ovation
#wait:5
#audience:ovation
#wait:4
- JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent #playsound:VOX_Judge_silencesilence
{
    - p_name == "Merlin":
        JUGE ERNEST: Les Portes du Tribunal se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribMerlin
    - p_name == "Ambroise":
        JUGE ERNEST: Les Portes du Tribunal se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribAmbroise
    - p_name == "Octave":
        JUGE ERNEST: Les Portes du Tribunal se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribOctave
    - else:
        JUGE ERNEST: Les Portes du Tribunal se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribMerlin
}
- JUGE ERNEST: Ainsi est-il accusé, non par le règne des Hommes, mais par celui de la <b>Déesse Irène</b>. #playsound:VOX_Judge_ainsiaccusenonregne
JUGE ERNEST: De celle-ci nous nous ferons les yeux, les oreilles et le cœur, comme la <b>Loi</b> l'exige. #audience:ovation #playsound:VOX_Judge_decelleciyeux
JUGE ERNEST: Silence ! J'exige le silence ! #anim:Judge:bell #audience:silent #playsound:VOX_Judge_silencejexige
- JUGE ERNEST: L'homme est accusé, par ordre croissant de gravité... #playsound:VOX_Judge_lhommeestaccuse
{
    - is_accused_of("bribe guards"): JUGE ERNEST: ... De tentative de corruption à l'égard de représentants de l'autorité Royale... #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #playsound:VOX_Judge_corruption #box #audience:booing #screenshake
        ~ audience_judgement(-10)
}
{
    - is_accused_of("attack guards"): JUGE ERNEST: ... De violence à l'encontre de représentants de l'autorité Royale... #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #playsound:VOX_Judge_violence #audience:laughter
        ~ audience_judgement(-10)
}
{
    - is_accused_of("crown outrage"): JUGE ERNEST: ... D'outrage à la <b>Couronne</b>... #playsound:VOX_Judge_outragecouronne #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #box #audience:booing #screenshake
        ~ audience_judgement(-10)
}
{
    - is_accused_of("blasphemy"): JUGE ERNEST: ... De blasphème... #playsound:VOX_Judge_blaspheme #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #box #audience:booing #screenshake
        ~ audience_judgement(-10)
}
{
    - is_accused_of("judge outrage"): JUGE ERNEST: ... D'outrage au Juge de droit divin, Ernest... #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #playsound:VOX_Judge_outragejuge #box #audience:choc #sreenshake
        ~ audience_judgement(-10)
}
- JUGE ERNEST: ... D'actes hérétiques... #playsound:VOX_Judge_heretique #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #box #audience:booing #screenshake
    ~ audience_judgement(-10)
- JUGE ERNEST: ... De Haute trahison... #playsound:VOX_Judge_hautetrahison #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #box #audience:booing #screenshake
    ~ audience_judgement(-10)
- JUGE ERNEST: ... ainsi que, pour conclure... #playsound:VOX_Judge_pourconclure
- JUGE ERNEST: ... D'amour impie. #playsound:VOX_Judge_amourimpie #box #audience:choc #screenshake #playsound:Play_MUS_Story_SC_Trial_ChefAccusation
    ~ audience_judgement(-10)
- JUGE ERNEST: Le Juge demande désormais à l'accusé de faire son entrée. #playsound:VOX_Judge_jugedemandeaccuseentre #audience:booing
- JUGE ERNEST: Silence ! Silence ! #position:Player:10:1 #wait:5 #audience:booing #box #playsound:VOX_Judge_silencesilence2 #anim:Judge:bell #audience:silent
- JUGE ERNEST: Au nom de la Déesse, le Juge demande le silence ! #playsound:VOX_Judge_aunomdeladeessesil
- JUGE ERNEST: Accusé, prenez place. #playsound:VOX_Judge_accuseprenez
    * [Garder le silence.]
    * [Protester.] PLAYER: Ce procès constitue une terrible injustice ! #playsound:VOX_Player_ceprocesinjustice #audience:debate
        ~ audience_judgement(-10)
        JUGE ERNEST: Silence ! #playsound:VOX_Judge_silence #anim:Judge:bell #audience:silent
        JUGE ERNEST: Accusé, vous ne pouvez vous comporter en ce lieu sacré comme vous le faites dans un vulgaire rafiot. #playsound:VOX_Judge_accuselieusacre
        JUGE ERNEST: Ne prenez la parole que lorsque le Juge vous la donne. #playsound:VOX_Judge_accusezneprenezparole
            ** [Hors de question !] PLAYER: Je suis un homme libre, citoyen de plein droit de <b>Miraterre</b>. Je puis parler librement ! #audience:booing #playsound:VOX_Player_jesuislibre #anim:Judge:bell
                ~ audience_judgement(-10)
                JUGE ERNEST: Accusé, je ne le répéterai pas deux fois : ceci est un lieu saint. Sachez rester à votre place. #playsound:VOX_Judge_accuserepete
                *** [Entendu.] PLAYER: C'est entendu. #playsound:VOX_Player_cestentendutrib1 #anim:Judge:bell
                    ---- (agree_with_judge) JUGE ERNEST: Vous ai-je donné la parole ? Taisez-vous donc. Le Juge n'a nul besoin de votre assentiment. #playsound:VOX_Judge_vousaijedonne
                    ~ audience_judgement(-10)
                    **** [Garder le silence.]
                *** [Garder le silence.]
            ** [Entendu.] PLAYER: C'est entendu.
                -> agree_with_judge
            ** [Garder le silence.]
    * [Mon nom est {p_name}, pas Accusé.] PLAYER: Mon nom est {p_name} et non Accusé, votre Honneur. #audience:debate
        JUGE ERNEST: Silence ! #playsound:VOX_Judge_silence2 #audience:silent
        JUGE ERNEST: Ici, vous n'avez plus de nom. Soyez déjà reconnaissant d'avoir encore votre langue pour pouvoir répondre de vos crimes. #playsound:VOX_Judge_iciplusdenom
        JUGE ERNEST: Désormais, taisez-vous, Accusé ! #playsound:VOX_Judge_desormaistaisez
- SOUFFLEUR: Psssst... Hé, l’ami ! J’ai l’impression que tu vas passer un sale quart d’heure... #playsound:VOX_Souffleur_pssthe5
SOUFFLEUR: Il semblerait que tes choix durant toute la pièce vont te retomber dessus les uns après les autres ! #playsound:VOX_Souffleur_choixretomber
SOUFFLEUR: Mais tu as peut-être encore une chance de t’en sortir, si tu parviens à obtenir l’approbation du public ! #playsound:VOX_Souffleur_unechancedetensortir
SOUFFLEUR: N'oublie pas : dans ce procès, c'est le public que tu dois convaincre, pas le Juge ! Bonne chance, l’ami ! #playsound:VOX_Souffleur_dansceproces
    -> witness_arle

// Witness Arle
= witness_arle
- JUGE ERNEST: Le Juge appelle désormais à la barre le premier témoin de ce procès : Arle, la trublionne de la reine Constance. #playsound:Play_MUS_Story_SC_Trial_Arle #position:Arle:8:10 #box #wait:8 #playsound:VOX_Judge_jugeappellearle #anim:Judge:bell #anim:Arle:bow #audience:ovation
JUGE ERNEST: Décrivez au jury votre rencontre avec l'accusé, je vous prie. #playsound:VOX_Judge_decrivezjuryarle
ARLE: <i>Votre Honneur</i>, vous n'êtes pas sans ignorer que j'ai l'immense privilège d'occuper, au sein de la <b>Couronne</b>, un rôle de tout premier plan... #playsound:VOX_Arle_immenseprivilege
    * [Ne pas l'interrompre.]
    * [(Se moquer) Contrairement à cette pièce.] PLAYER: Ce qui n'est pas le cas de ton rôle dans cette pièce... #audience:laughter #playsound:VOX_Player_cequinestpastoncasrolepiece #anim:Arle:angry
        ~ audience_judgement(5)
        ARLE: Pour qui tu te prends, abruti ? #anim:Arle:angry #playsound:VOX_Arle_pourquitutepr
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence, vous deux ! Silence ! #playsound:VOX_Judge_silencevous2 #anim:Judge:bell #audience:silent
- JUGE ERNEST: Poursuivez, je vous prie. #playsound:VOX_Judge_poursuivez #anim:Arle:bow
    * [Ne rien dire.]
    * [(Se moquer) Même Son Honneur s'ennuie.] PLAYER: <i>Son Honneur</i> en personne baille en t'écoutant ! Si ça continue, le public va décéder d'ennui. #audience:laughter #playsound:VOX_Player_sonhonneurbaille #anim:Arle:angry
        ARLE: C'est toi qui vas mourir si tu continues à m'interrompre, minable ! #playsound:VOX_Arle_cesttoi
        ~ audience_judgement(5)
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Je ne le répéterai pas : faites le silence ! #playsound:VOX_Judge_silencejerepetepas #anim:Judge:bell #audience:silent
        JUGE ERNEST: Poursuivez, témoin. #playsound:VOX_Judge_poursuiveztemoin #anim:Arle:bow
        ARLE: Où en étais-je ? Ah oui : un rôle de tout premier plan. #playsound:VOX_Arle_ouenetaisje
- ARLE: J'aime à penser que je suis, pour ce rôle, une actrice à la hauteur. #playsound:VOX_Arle_jiaimeapenser
    * [Se taire.]
    * [(Se moquer) Toi, une bonne actrice ?] PLAYER: Toi, une bonne actrice ? En voilà une nouvelle à ressusciter les noyés ! #audience:laughter #playsound:VOX_Player_toibonneactrice #anim:Arle:angry
        ~ audience_judgement(5)
        ARLE: Tu vas te taire, oui ?! #anim:Arle:angry #playsound:VOX_Arle_tuvastetaireoui
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Silence ! #playsound:VOX_Judge_silencesilence2 #anim:Judge:bell #audience:silent
        JUGE ERNEST: Accusé, cessez d'interrompre le témoin ! Quant à vous... #playsound:VOX_Judge_accusecessezdinterrompre
- JUGE ERNEST: Veuillez ne pas vous répandre en détails inutiles. #playsound:VOX_Judge_veuilleznepasvousrepandre #audience:laughter #anim:Arle:sad
ARLE: ... Hmfrr... #playsound:VOX_Arle_hmfrfr
ARLE: Je disais, donc, que sa Majesté Constance m'a chargée de transmettre à messire le scélérat une mission de la plus haute importance. #playsound:VOX_Arle_jedisaisdonc
    * [Rester silencieux.]
    * [(Se moquer) Jouer correctement la comédie ?] PLAYER: Si la mission était de jouer correctement, permets-moi de te dire que c'est un échec cuisant... #audience:laughter #playsound:VOX_Player_missionjouercorrect #anim:Arle:angry
        ~ audience_judgement(5)
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Le Juge exige le silence ! #playsound:VOX_Judge_silencelejugeexige #anim:Judge:bell #audience:silent
        JUGE ERNEST: Ce procès n'est pas une fanfaronnade ! Membres du jury, soyez dignes de la tâche qui vous incombe ! #playsound:VOX_Judge_ceprocesfanfaronnade
        JUGE ERNEST: Quant à vous, cessez d'objecter quand la parole ne vous a pas été donnée par le Juge en personne ! #playsound:VOX_Judge_quantavous
        JUGE ERNEST: Témoin, vous mentionniez une mission confiée à l'accusé par la <b>Couronne</b>. #playsound:VOX_Judge_temoinmentionniez
- JUGE ERNEST: Précisez quelle était la nature de cette mission, je vous prie. #playsound:VOX_Judge_precisezlanature #anim:Arle:bow
ARLE: La mission que la reine Constance me fit l'honneur de transmettre à messire l'infâme accusé, était de tuer le <b>Léviathan</b>, et d'en ramener l'organe vital. #audience:choc #playsound:VOX_Arle_lamissiondelareine
ARLE: Je veux bien entendu parler de son cœur, <i>Votre Honneur</i>. #audience:laughter #anim:Judge:bell #anim:Arle:bow #playsound:VOX_Arle_jeveuxparlercoeur
JUGE ERNEST: Bien, bien... Ensuite ? #playsound:VOX_Judge_biebienensuite
- ARLE: Je voudrais, <i>Votre Honneur</i>, témoigner du fait que, lorsque j'abordais avec le détestable messire, le sujet du meurtre... #playsound:VOX_Arle_jevoudraistemoigner
ARLE: ... celui-ci n'eût aucun scruple à accepter d'ôter une vie. #audience:choc #playsound:VOX_Arle_cuicineutaucun
JUGE ERNEST: Vraiment ? Accusé, qu'avez-vous à répondre ? #playsound:VOX_Judge_vraimentaccuserepondre
    * [J'ai refusé de tuer !] PLAYER: J'ai toujours refusé de tuer, <i>Votre Honneur</i> ! #playsound:VOX_Player_toujoursrefusedetuer #audience:debate
        ARLE: Mais bien sûr... Quel fieffé menteur ! #audience:debate #playsound:VOX_Arle_fieffementeur
        JUGE ERNEST: Silence ! le Juge exige le silence ! #playsound:VOX_Judge_silencelejugeexige2 #anim:Judge:bell
        {
            - judge_explained_mask == false: JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre. #playsound:VOX_Judge_cetribunallumiere #playsound:Play_MUS_Story_SC_Trial_LaVerite1
                JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole. #playsound:VOX_Judge_cessezlaveriteparle #playsound:Play_MUS_Story_SC_Trial_LaVerite2
                ~ judge_explained_mask = true
        }
        JUGE ERNEST: <shake>La Vérité sort de la bouche du Juge.</shake> #playsound:VOX_Judge_laveritesort #audience:ovation #anim:Juge:mask #playsound:Play_MUS_Story_SC_Trial_LaVerite3
        {
            - t_1_accept_to_kill == true: JUGE ERNEST: « Tuer ne me dérange nullement. ». #playsound:VOX_Judge_playercitationtuer #audience:choc
                ~ audience_judgement(-10)
                JUGE ERNEST: Ainsi il apparaît que vous avez menti, Accusé. #playsound:VOX_Judge_ansivousavezmenti
                ~ audience_judgement(-10)
            - t_1_refuse_to_kill == true: JUGE ERNEST: « Ôter une vie n'est pas dans mes pratiques. ». #playsound:VOX_Judge_playercitationoter  #audience:ovation
                ~ audience_judgement(10)
                JUGE ERNEST: Ainsi, l'Accusé dit la vérité. #playsound:VOX_Judge_ainsiaccuseverite #audience:applause
                ~ audience_judgement(10)
                JUGE ERNEST: Témoin, que l'on ne vous reprenne plus à mentir en ces lieux ! #playsound:VOX_Judge_temoinquelonnevousreprenne #anim:Arle:stressed #audience:booing
        }
    * [C'est la vérité...] PLAYER: J'admets avoir accepté de tuer, <i>Votre Honneur</i>... #playsound:VOX_Player_jadmetsacceptetuer #audience:choc
        ~ audience_judgement(-10)
        JUGE ERNEST: Silence ! le Juge exige le silence ! #playsound:VOX_Judge_silencelejugeexige #anim:Judge:bell
    * [(Se moquer) Plutôt mourir que de l'écouter...] PLAYER: Que j'aurais accepté de m'ôter ma propre vie pour éviter d'être témoin de son jeu de scène ! #playsound:VOX_Player_prefereoterproprevie #audience:laughter
        ~ audience_judgement(5)
        ARLE: Tu te crois drôle, avorton ? #playsound:VOX_Arle_tutecroisdrole
        {make_arle_angry(): -> arle_leaves_stage}
- ARLE: <i>Votre Honneur</i>, puis-je ajouter quelque chose ? #playsound:VOX_Arle_ajouterqqch
    * [La laisser continuer.]
    * [(Se moquer) Irène, pitié, faites-la taire.] PLAYER: Ô <b>Irène</b>, ayez pitié de nous, pauvres humains ! Ô, je vous en conjure : faites-la taire ! #audience:laughter #playsound:VOX_Player_oireneayezpitie #anim:Arle:angry
        ~ audience_judgement(5)
        ARLE: Cesse de m'interrompre, morveux ! #anim:Arle:angry #playsound:VOX_Arle_cessedeminterrompre
        {make_arle_angry(): -> arle_leaves_stage}
- JUGE ERNEST: Soyez brève. #playsound:VOX_Judge_soyezbreve #anim:Arle:bow
ARLE: Entendez bien que mon ambition, <i>Votre Honneur</i>, n'est point de prêter à mon image plus d'éloges qu'elle n'en mérite. #playsound:VOX_Arle_ecoutezbienambition
JUGE ERNEST: Bon, bon... Concluez. #playsound:VOX_Judge_bonbonconcluez #audience:laughter
ARLE: Je voulais simplement signifier, au profit de la Vérité ainsi que la Justice, qu'à peine notre bonne reine Constance m'eut chargée de confier à messire ladite mission... #playsound:VOX_Arle_simplementsignifier
ARLE: Mon cœur me fit comprendre que l'effroyable messire était bien loin d'être à la hauteur de la tâche. #audience:laughter #audience:applause #anim:Arle:bow #playsound:VOX_Arle_moncoeurfitcomprendre
    ~ audience_judgement(-10)
- JUGE ERNEST: J'en appelle à l'accusé : qu'avez-vous à dire pour votre défense ? #playsound:VOX_Judge_jenappellequavezvous
    * [Je me suis montré à la hauteur.] PLAYER: <i>Votre Honneur</i>, messieurs les jurés...
        PLAYER: J'espère que ce procès sera l'occasion de démontrer que j'ai bel et bien été à la hauteur de cette tâche. #anim:Player:bow #audience:applause
        -> accusation_of_disrespecting_queen
    * [Arle vient d'insulter notre reine.] PLAYER: Je crois, <i>Votre Honneur</i>, et mesdames et messieurs les jurés, qu'Arle a trahit son manque de respect pour la reine Constance. #audience:debate
        ~ accuse_arle_to_disrespect_queen = true
        ARLE: Objection ! L'immonde messire raconte des balivernes ! #playsound:VOX_Arle_objection
        JUGE ERNEST: Silence, témoin ! Je ne vous ai pas donné la parole ! #playsound:VOX_Judge_silencetemoinjeneevousaipas #anim:Arle:sad #anim:Judge:bell #audience:silent
        JUGE ERNEST: Pouvez-vous en avancer la preuve, Accusé ? #playsound:VOX_Judge_pouvezvousfournirpreuve
            ** [En me désavouant, elle désavoue la reine.] PLAYER: Certainement. En prétextant savoir que je n'étais pas à la hauteur de la tâche...
                PLAYER: ... Arle a sous-entendu que la reine avait fait preuve de bêtise en me désignant. #audience:choc #audience:debate
                JUGE ERNEST: L'accusé a raison sur ce point. #playsound:VOX_Judge_accusearaisonici #anim:Juge:bell #audience:applause #anim:Arle:angry
                ~ audience_judgement(10)
            ** [Je retire mon accusation.] PLAYER: J'en suis malheureusement incapable, <i>Votre Honneur</i>. Je retire mon accusation. #audience:booing #anim:Arle:laughter
                ~ audience_judgement(-10)
    * [(Se moquer) Ma mission est à ma hauteur, et toi...] PLAYER: Je n'ai rien à objecter, <i>Votre Honneur</i>, sinon à remarquer que la reine confie à chacun une mission à la hauteur de son talent. #playsound:VOX_Player_rienaobjecter
        PLAYER: À moi, elle confia la lourde tâche de tuer le <b>Léviathan</b>. À elle, la mission toute aussi difficile de m'apporter une carte... #audience:laugh #playsound:VOX_Player_lourdetachetuerlevi #anim:Judge:bell
        ~ audience_judgement(5)
        {make_arle_angry(): -> arle_leaves_stage}
        ARLE: <i>Votre Honneur</i> ! Vous voyez bien que le saligaud essaye de décrédibiliser ma perfor... je veux dire, mon témoignage ! #playsound:VOX_Arle_vothsaligaud #audience:laughter
        JUGE ERNEST: Euh... Je... Oui... silence ! Je vous demande de faire le silence ! #playsound:VOX_Judge_jeeuhouisilence #anim:Juge:bell #audience:applause 
- (accusation_of_being_forced) JUGE ERNEST: Passons à la suite, voulez-vous ? #playsound:VOX_Judge_passonssuitevoulez #anim:Juge:bell
JUGE ERNEST: Témoin, avez-vous autre chose à ajouter ? #playsound:VOX_Judge_temoinautrechose
ARLE: J'accuse l'abject messire de n'avoir accepté la mission sacrée, confiée par notre bonne reine, que parce qu'il en était contraint ! #audience:debate #playsound:VOX_Arle_abjectmessiremissionsac
JUGE ERNEST: Accusé, qu'avez-vous à répondre ? #playsound:VOX_Judge_accusequerepondrevous
    * [C'est parfaitement faux !] PLAYER: <i>Votre Honneur</i>, je récuse cette accusation ! Elle ment ! #audience:debate
        JUGE ERNEST: Silence ! le Juge vous ordonne de vous taire ! #playsound:VOX_Judge_lejugevousordonnetaire #anim:judge:bell
        {
            - judge_explained_mask == false: JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre. #playsound:VOX_Judge_cetribunallumiere #playsound:Play_MUS_Story_SC_Trial_LaVerite1
                JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole. #playsound:VOX_Judge_cessezlaveriteparle #playsound:Play_MUS_Story_SC_Trial_LaVerite2
                ~ judge_explained_mask = true
        }
        JUGE ERNEST: <shake>La Vérité sort de la bouche du Juge.</shake> #playsound:Play_MUS_Story_SC_Trial_LaVerite3 #playsound:VOX_Judge_laveritesort #audience:ovation #anim:Juge:mask 
        {
            - t_1_accept_mission_with_positivity: JUGE ERNEST: « Cela serait pour moi un véritable honneur de ramener le cœur du <b>Léviathan</b>. ». #playsound:VOX_Judge_playercitationhonneurramener
                ~ audience_judgement(-10)
            - t_1_accept_mission_with_negativity: JUGE ERNEST: « Puisque je n'ai point le loisir de me soustraire à la tâche... J'accepte de ramener le cœur du <b>Léviathan</b>. ». #playsound:VOX_Judge_playercitationpointloisirtache
                ~ audience_judgement(-10)
        }
    * [C'est vrai.] PLAYER: C'est vrai, bien entendu. Qui, dans cette salle, aurait accepté de courir un tel risque ? #audience:debate
        ~ audience_judgement(10)
    * [(Se moquer) J'ai accepté pour mettre fin à la scène.] PLAYER: Que je n'ai accepté, <i>Votre Honneur</i>, que pour mettre fin à une scène désastreuse... #audience:laughter #playsound:VOX_Player_quepourmettrefinscene
        PLAYER: En arrivant en retard, elle pensait faire languir le public... #playsound:VOX_Player_languirpublicenretard
        PLAYER: Mais en réalité le faisait-elle fuir de la salle à toutes jambes ! #audience:laughter #anim:Player:bow #playsound:VOX_Player_fuirsalletoutejambes
        ~ audience_judgement(5)
        ARLE: Moi ? La <shake>vedette</shake> de cette pièce ? Faire fuir le public ?! #playsound:VOX_Arle_vedettepiece
        {make_arle_angry(): -> arle_leaves_stage}
- (accusation_of_disrespecting_queen) JUGE ERNEST: Poursuivons, poursuivons... #playsound:VOX_Judge_poursuivonsx2
JUGE ERNEST: Témoin, avez-vous une autre révélation à faire ? #playsound:VOX_Judge_temoinautrerevelation
{
- accuse_arle_to_disrespect_queen == true : ARLE: Bien entendu, <i>Votre Honneur</i>. L'horripilant messire m'a accusé de manquer de respect à notre reine, mais celui-ci l'a tout bonnement humilié. #playsound:VOX_Arle_bienentendumanquerespect #audience:choc #anim:Judge:bell
- accuse_arle_to_disrespect_queen == false : ARLE: Bien entendu, <i>Votre Honneur</i>. Je voudrais témoigner du fait que l'affreux messire a humilié notre reine. #audience:choc #anim:Judge:bell #playsound:VOX_Arle_bienentendutemoinger
} 
- JUGE ERNEST: Poursuivez, je vous prie. #playsound:VOX_Judge_poursuivezsvp
ARLE: Le terrible messire a cru bon de se moquer de la reine en faisant un bon mot, <i>Votre Honneur</i>. #playsound:VOX_Arle_teriblemessiremoquer
    * [Ce n'est pas ce que vous croyez.] PLAYER: Ce n'est pas ce que vous pensez, votre Honneur... #audience:debate
        JUGE ERNEST: Silence ! Cessez de prendre la parole quand bon vous semble, Accusé ! #playsound:VOX_Judge_silencecessezparolebonvoussemble #anim:Judge:bell #audience:booing
        ~ audience_judgement(-10)
        ~ admit_disrespect_queen = true
    * [C'est faux !] PLAYER: <i>Votre Honneur</i>, elle ment ! #audience:debate
        JUGE ERNEST: Silence ! Cessez de prendre la parole quand bon vous semble, Accusé ! #playsound:VOX_Judge_silencecessezparolebonvoussemble #anim:Judge:bell #audience:booing
        ~ audience_judgement(-10)
    * [Ne rien dire.]
- JUGE ERNEST: Quelles paroles exactes témoignez-vous avoir entendu l'Accusé prononcer ? #playsound:VOX_Judge_quellesparolesexactes
ARLE: L'abject messire a dit, je cite : « Constance et son inconstance m'inspirent l'indifférence. ». #audience:laughter #playsound:VOX_Arle_constanceinonstance
JUGE ERNEST: Accusé, qu'avez-vous à dire pour votre défense ? #playsound:VOX_Judge_accusequediredefense
        * [J'admets avoir dit cela.] PLAYER: J'ai le regret d'admettre avoir fait ce jeu de mots, <i>Votre Honneur</i>... #audience:booing #anim:Judge:bell
            JUGE ERNEST: Ainsi avouez-vous avoir manqué de respect à la reine. #playsound:VOX_Judge_ainsimanquerespectrein #anim:Judge:bell
            ~ audience_judgement(-10)
        * [Je n'ai rien dit de tel.] PLAYER: <i>Votre Honneur</i>, mesdames et messieurs les jurés, je jure n'avoir rien dit de tel. #audience:debate
            ARLE: Menteur ! Menteur ! #playsound:VOX_Arle_menteurmenteur
            JUGE ERNEST: Silence ! Par <b>Irène</b>, je demande le silence ! #playsound:VOX_Judge_silenceparirene #anim:Judge:bell #audience:silent
            {
                - judge_explained_mask == false: JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre. #playsound:VOX_Judge_cetribunallumiere #playsound:Play_MUS_Story_SC_Trial_LaVerite1
                    JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole. #playsound:VOX_Judge_cessezlaveriteparle #playsound:Play_MUS_Story_SC_Trial_LaVerite2
                    ~ judge_explained_mask = true
            }
            JUGE ERNEST: <shake>La vérité sort de la bouche du Juge.</shake> #playsound:VOX_Judge_laveritesort #audience:ovation #anim:Juge:mask #playsound:Play_MUS_Story_SC_Trial_LaVerite3
            {
                - t_1_respect_the_crown: JUGE ERNEST: « Je braverai tous les dangers pour notre bonne reine ! ». #playsound:VOX_Judge_playercitationjebraveraidangers #audience:ovation #anim:Arle:angry #anim:Player:bow
                    JUGE ERNEST: Témoin, que le Juge ne vous reprenne plus à mentir lors d'un procès divin. #playsound:VOX_Judge_temoinjugereprenneplus #anim:Arle:stressed #audience:booing
                    ~ audience_judgement(10)
                    ~ arle_lied = true
                - t_1_disrespect_the_crown: JUGE ERNEST: « Constance et son inconstance m'inspirent l'indifférence. ». #playsound:VOX_Judge_constanceetinconstance #audience:booing #anim:Player:stressed #anim:Arle:bow
                    ~ audience_judgement(-10)
            }
- (accusation_of_disrespecting_irene) JUGE ERNEST: Passons à la suite, voulez-vous ? #playsound:VOX_Judge_passonssuitesvp #anim:Judge:bell
JUGE ERNEST: Témoin, avez-vous d'autres accusations à faire ? {arle_lied: Tâchez de ne plus inventer des faits.} #playsound:VOX_Judge_temoinautreaccusationsfaire #playsound:VOX_Judge_tachezplusinventerfaits
ARLE: J'en ai peur... #playsound:VOX_Arle_jenaipeurptptp
ARLE: <i>Votre Honneur</i>, il est en effet un ultime acte duquel je dois témoigner... #playsound:VOX_Arle_ultimeacte
ARLE: Celui-ci va choquer nos chers jurés, j'en ai peur... #audience:debate #playsound:VOX_Arle_tousleschoquer
JUGE ERNEST: Alors, alors. La Vérité ne saurait souffrir d'une quelconque censure. Poursuivez, je vous prie. #playsound:VOX_Judge_alorsalors #anim:Arle:bow
ARLE: Alors que je lui confiais la mission qui lui était due... L'horripilant Accusé a insulté la <b>Déesse</b> en personne... #audience:choc #playsound:VOX_Arle_confiaismission
    ~ audience_judgement(-10)
JUGE ERNEST: Est-ce vrai ? La déesse elle-même ? Répondez, Accusé. Et vite ! #playsound:VOX_Judge_estcevrailadeesse
    * [J'avoue mon péché...] PLAYER: <i>Votre Honneur</i>... Mesdames et messieurs les jurés... J'avoue ce péché, en effet. #audience:choc
        ~ audience_judgement(-10)
    * [C'est un mensonge !] PLAYER: <i>Votre Honneur</i>, c'est un mensonge ! Moi, insulter la <b>Déesse</b> ? Pas même sous la torture, vous m'entendez ! #playsound:VOX_Player_votrehonneurmensonge
        ARLE: Un mensonge, un de plus ! #audience:debate #playsound:VOX_Arle_unmensongedepkus
        JUGE ERNEST: Silence ! Silence ! #playsound:VOX_Judge_silencesilence2 #anim:Judge:bell #audience:silent
        {
            - judge_explained_mask == false: JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre. #playsound:VOX_Judge_cetribunallumiere #playsound:Play_MUS_Story_SC_Trial_LaVerite1
                JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole. #playsound:VOX_Judge_cessezlaveriteparle #playsound:Play_MUS_Story_SC_Trial_LaVerite2
                ~ judge_explained_mask = true
        }
        JUGE ERNEST: <shake>La Vérité sort de la bouche du Juge.</shake> #playsound:VOX_Judge_laveritesort #audience:ovation #anim:Juge:mask #playsound:Play_MUS_Story_SC_Trial_LaVerite3
        {
            - t_1_respect_irene: JUGE ERNEST: « J'honorerai la <b>Déesse</b>, j'en fais le serment ! ». #playsound:VOX_Judge_playercitationladeesehoneur #audience:ovation #anim:Arle:angry #anim:Player:bow
                ~ audience_judgement(20)
                ~ arle_lied_again = true
            - t_1_disrespect_irene: JUGE ERNEST: « Je me fiche de la <b>Déesse Irène</b> comme du dernier crachin ! ». #playsound:VOX_Judge_playercitationjemefichedeese #audience:booing #anim:Player:stressed #anim:Arle:bow
                ~ audience_judgement(-10)
            - t_1_gold_digger: JUGE ERNEST: « PLAYER: Si j'accepte, ce ne serait ni pour la reine, ni pour la <b>Déesse</b>, mais pour mon seul profit. ». #playsound:VOX_Judge_playercitationjadorelargent #audience:booing #anim:Player:stressed
                ~ audience_judgement(-10)
        }
- JUGE ERNEST: {arle_lied_again == false: Accusé, ces paroles sont insoutenables, et par la <b>Loi</b> ainsi que la <b>Foi</b>, elles seront punies. | Accusé, je remercie la <b>Déesse</b> que vous n'ayez pas profané son nom comme le témoin le prétendait.} #playsound:VOX_Judge_accusecesparolsinsoutenables #playsound:VOX_Judge_accuseceremercieladeessepasprofane
- JUGE ERNEST: {arle_lied_again == false: Témoin, la <b>Déesse</b> vous remercie pour votre témoignage. Vous pouvez quitter ce tribunal, désormais... | Témoin, profaner de tels mensonges à l'égard de l'Accusé est un acte grave ! La <b>Déesse</b> vous couvre de honte ! Hors de ma vue !} #playsound:VOX_Judge_temoindeesseremercietemoignage #playsound:VOX_Judge_temoindprofanerdeessecouvrehonte #audience:booing #rope:Arle
    -> judge_proceed_to_mention_the_leviathan

// Arle leaves stage
= arle_leaves_stage
~ audience_judgement(20)
JUGE ERNEST: Euh... Si... Silence ! #playsound:VOX_Judge_euhsisilencesilence #anim:Judge:bell #audience:ovation
    -> judge_proceed_to_mention_the_leviathan

// The judge proceed to mention the Leviathan
= judge_proceed_to_mention_the_leviathan
JUGE ERNEST: Accusé, nous nous devons désormais d'aborder le sujet du <b>Léviathan</b>. #playsound:VOX_Judge_accusesujetleviathan #audience:debate
JUGE ERNEST: En effet, vous fûtes missionné par la <b>Couronne</b>, afin de vous rendre en mer... #playsound:VOX_Judge_eneffetmissonnecouronne
JUGE ERNEST: ... et d'y terrasser le terrible <b>Léviathan</b>. #playsound:VOX_Judge_terrasserleviathan #audience:choc
    -> tribunal_2