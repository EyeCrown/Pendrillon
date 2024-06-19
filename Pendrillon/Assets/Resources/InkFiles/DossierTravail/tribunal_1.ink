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
#actor:Capucine:CAPUCINE:CAPUCINE LA LARBINE:CAPUCINE LA MARCASSINE:CAPUCINE LA TARTINE
#actor:Marcello:MARCELLO:MARCELLOGRE:MARCELLOTARIE:MARCELLOCROUPIE
#actor:Agathe:AGATHE
// Set the location
#set:trial
// Set the actor's positions

// Start the scene
#audience:debate
#audience:silent
// Le juge est encore seul sur scène
#audience:ovation
#wait:5
#audience:ovation

- JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent #playsound:VOX_Judge_silencesilence
{
    - p_name == "Merlin":
        JUGE ERNEST: Les <b>Portes du Tribunal</b> se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribMerlin #curtains:open
    - p_name == "Ambroise":
        JUGE ERNEST: Les <b>Portes du Tribunal</b> se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribAmbroise #curtains:open
    - p_name == "Octave":
        JUGE ERNEST: Les <b>Portes du Tribunal</b> se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribOctave #curtains:open
    - else:
        JUGE ERNEST: Les <b>Portes du Tribunal</b> se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribMerlin #curtains:open
}
- JUGE ERNEST: Ainsi est-il accusé, non par le règne des Hommes, mais par celui de la <b>Déesse Irène</b>. #playsound:VOX_Judge_ainsiaccusenonregne
JUGE ERNEST: De celle-ci nous nous ferons les yeux, les oreilles et le cœur, comme la <b>Loi</b> l'exige. #audience:ovation #playsound:VOX_Judge_decelleciyeux
JUGE ERNEST: Silence ! J'exige le silence ! #anim:Judge:bell #audience:silent #playsound:VOX_Judge_silencejexige
- JUGE ERNEST: L'homme est <b>accusé</b>, par ordre croissant de <b>gravité</b>... #playsound:VOX_Judge_lhommeestaccuse
{
    - is_accused_of("bribe guards"): JUGE ERNEST: ... De <shake a=0.5><b>tentative de corruption</b></shake> à l'égard de représentants de l'autorité Royale... #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #playsound:VOX_Judge_corruption #box #audience:booing #screenshake
        ~ audience_judgement(-10)
}
{
    - is_accused_of("attack guards"): JUGE ERNEST: ... De <shake a=0.5><b>violence</b></shake> à l'encontre de représentants de l'autorité Royale... #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #playsound:VOX_Judge_violence #audience:laughter
        ~ audience_judgement(-10)
}
{
    - is_accused_of("crown outrage"): JUGE ERNEST: ... D'<shake a=0.5><b>outrage</b> à la <b>Couronne</b></shake>... #playsound:VOX_Judge_outragecouronne #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #box #audience:booing #screenshake
        ~ audience_judgement(-10)
}
{
    - is_accused_of("blasphemy"): JUGE ERNEST: ... De <shake a=0.5><b>blasphème</b></shake>... #playsound:VOX_Judge_blaspheme #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #box #audience:booing #screenshake
        ~ audience_judgement(-10)
}
{
    - is_accused_of("judge outrage"): JUGE ERNEST: ... D'<shake a=0.5><b>outrage</b> au <b>Juge</b></shake> de droit divin, Ernest... #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #playsound:VOX_Judge_outragejuge #box #audience:choc #sreenshake
        ~ audience_judgement(-10)
}
- JUGE ERNEST: ... D'<shake a=0.5><b>actes hérétiques</b></shake>... #playsound:VOX_Judge_heretique #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #box #audience:booing #screenshake
    ~ audience_judgement(-10)
- JUGE ERNEST: ... De <shake a=0.5><b>Haute trahison</b></shake>... #playsound:VOX_Judge_hautetrahison #playsound:Play_MUS_Story_SC_Trial_ChefAccusation #box #audience:booing #screenshake
    ~ audience_judgement(-10)
- JUGE ERNEST: ... ainsi que, pour conclure... #playsound:VOX_Judge_pourconclure
- JUGE ERNEST: ... D'<shake a=0.5><b>amour impie</b></shake>. #playsound:VOX_Judge_amourimpie #box #audience:choc #screenshake #playsound:Play_MUS_Story_SC_Trial_ChefAccusation
    ~ audience_judgement(-10)
- JUGE ERNEST: Le <b>Juge</b> demande désormais à l'<b>Accusé</b> de faire son entrée. #playsound:VOX_Judge_jugedemandeaccuseentre #audience:booing
- JUGE ERNEST: Silence ! Silence ! #position:Player:10:1 #wait:5 #audience:booing #box #playsound:VOX_Judge_silencesilence2 #anim:Judge:bell #audience:silent
- JUGE ERNEST: Au nom de la <b>Déesse</b>, le <b>Juge</b> demande le silence ! #playsound:VOX_Judge_aunomdeladeessesil
- JUGE ERNEST: <b>Accusé</b>, prenez place. #playsound:VOX_Judge_accuseprenez
    * [Garder le silence.]
    * [Protester.] PLAYER: Ce procès constitue une terrible injustice ! #playsound:VOX_Player_ceprocesinjustice #audience:debate
        ~ audience_judgement(-10)
        JUGE ERNEST: Silence ! #playsound:VOX_Judge_silence #anim:Judge:bell #audience:silent
        JUGE ERNEST: <b>Accusé</b>, vous ne pouvez vous comporter en ce lieu sacré comme vous le faites dans un vulgaire rafiot. #playsound:VOX_Judge_accuselieusacre
        JUGE ERNEST: Ne prenez la parole que lorsque le <b>Juge</b> vous la donne. #playsound:VOX_Judge_accusezneprenezparole
            ** [Hors de question !] PLAYER: Je suis un homme libre, citoyen de plein droit de <b>Miraterre</b>. Je puis parler librement ! #audience:booing #playsound:VOX_Player_jesuislibre #anim:Judge:bell
                ~ audience_judgement(-10)
                JUGE ERNEST: <b>Accusé</b>, je ne le répéterai pas deux fois : ceci est un lieu saint. Sachez rester à votre place. #playsound:VOX_Judge_accuserepete
                *** [Entendu.] PLAYER: C'est entendu. #playsound:VOX_Player_cestentendutrib1 #anim:Judge:bell
                    ---- (agree_with_judge) JUGE ERNEST: Vous ai-je donné la parole ? Taisez-vous donc. Le <b>Juge</b> n'a nul besoin de votre assentiment. #playsound:VOX_Judge_vousaijedonne
                    ~ audience_judgement(-10)
                    **** [Garder le silence.]
                *** [Garder le silence.]
            ** [Entendu.] PLAYER: C'est entendu.
                -> agree_with_judge
            ** [Garder le silence.]
    * [Mon nom est {p_name}, pas Accusé.] PLAYER: Mon nom est {p_name} et non <b>Accusé</b>, votre Honneur. #audience:debate
        JUGE ERNEST: Silence ! #playsound:VOX_Judge_silence2 #audience:silent
        JUGE ERNEST: Ici, vous n'avez plus de nom. Soyez déjà reconnaissant d'avoir encore votre langue pour pouvoir répondre de vos crimes. #playsound:VOX_Judge_iciplusdenom
        JUGE ERNEST: Désormais, taisez-vous, <b>Accusé</b> ! #playsound:VOX_Judge_desormaistaisez
- SOUFFLEUR: Psssst... Hé, l’ami ! J’ai l’impression que tu vas passer un sale quart d’heure... #playsound:VOX_Souffleur_pssthe5
SOUFFLEUR: Il semblerait que tes choix durant toute la pièce vont te retomber dessus les uns après les autres ! #playsound:VOX_Souffleur_choixretomber
SOUFFLEUR: Mais tu as peut-être encore une chance de t’en sortir, si tu parviens à obtenir l’approbation du public ! #playsound:VOX_Souffleur_unechancedetensortir
SOUFFLEUR: N'oublie pas : dans ce procès, c'est le public que tu dois convaincre, pas le <b>Juge</b> ! Bonne chance, l’ami ! #playsound:VOX_Souffleur_dansceproces
    -> witness_arle

// Witness Arle
= witness_arle
- JUGE ERNEST: Le <b>Juge</b> appelle désormais à la barre le premier témoin de ce procès : <b>Arle</b>, la trublionne de la reine <b>Constance</b>. #playsound:Play_MUS_Story_SC_Trial_Arle #position:Arle:8:10 #box #playsound:VOX_Judge_jugeappellearle #wait:8  #anim:Judge:bell #anim:Arle:bow #audience:ovation
JUGE ERNEST: Décrivez au jury votre rencontre avec l'<b>Accusé</b>, je vous prie. #playsound:VOX_Judge_decrivezjuryarle
ARLE: <b>Votre Honneur</b>, vous n'êtes pas sans ignorer que j'ai l'immense privilège d'occuper, au sein de la <b>Couronne</b>, un rôle de tout premier plan... #playsound:VOX_Arle_immenseprivilege
    * [Ne pas l'interrompre.]
    * [(Se moquer) Contrairement à cette pièce.] PLAYER: Ce qui n'est pas le cas de ton rôle dans cette pièce... #audience:laughter #playsound:VOX_Player_cequinestpastoncasrolepiece #anim:Arle:angry
        ~ audience_judgement(5)
        ARLE: Pour qui tu te prends, <shake a=0.5><b>abruti</b></shake> ? #anim:Arle:angry #playsound:VOX_Arle_pourquitutepr
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence, vous deux ! Silence ! #playsound:VOX_Judge_silencevous2 #anim:Judge:bell #audience:silent
- JUGE ERNEST: Poursuivez, je vous prie. #playsound:VOX_Judge_poursuivez #anim:Arle:bow
    * [Ne rien dire.]
    * [(Se moquer) Même Son Honneur s'ennuie.] PLAYER: <b>Son Honneur</b> en personne baille en t'écoutant ! Si ça continue, le public va décéder d'ennui. #audience:laughter #playsound:VOX_Player_sonhonneurbaille #anim:Arle:angry
        ARLE: C'est toi qui vas mourir si tu continues à m'interrompre, <shake a=0.5><b>minable</b></shake> ! #playsound:VOX_Arle_cesttoi
        ~ audience_judgement(5)
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Je ne le répéterai pas : faites le silence ! #playsound:VOX_Judge_silencejerepetepas #anim:Judge:bell #audience:silent
        JUGE ERNEST: Poursuivez, témoin. #playsound:VOX_Judge_poursuiveztemoin #anim:Arle:bow
        ARLE: Où en étais-je ? Ah oui : un rôle de tout premier plan. #playsound:VOX_Arle_ouenetaisje
- ARLE: J'aime à penser que je suis, pour ce rôle, une actrice à la hauteur. #playsound:VOX_Arle_jiaimeapenser
    * [Se taire.]
    * [(Se moquer) Toi, une bonne actrice ?] PLAYER: Toi, une bonne actrice ? En voilà une nouvelle à ressusciter les noyés ! #audience:laughter #playsound:VOX_Player_toibonneactrice #anim:Arle:angry
        ~ audience_judgement(5)
        ARLE: Tu vas te <shake a=0.5><b>taire</b></shake>, oui ?! #anim:Arle:angry #playsound:VOX_Arle_tuvastetaireoui
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Silence ! #playsound:VOX_Judge_silencesilence2 #anim:Judge:bell #audience:silent
        JUGE ERNEST: <b>Accusé</b>, cessez d'interrompre le témoin ! Quant à vous... #playsound:VOX_Judge_accusecessezdinterrompre
- JUGE ERNEST: Veuillez ne pas vous répandre en détails inutiles. #playsound:VOX_Judge_veuilleznepasvousrepandre #audience:laughter #anim:Arle:sad
ARLE: ... <shake a=0.5><b>Hmfrr</b></shake>... #playsound:VOX_Arle_hmfrfr
ARLE: Je disais, donc, que sa <b>Majesté Constance</b> m'a chargée de transmettre à messire le <shake a=0.5><b>scélérat</b></shake> une mission de la plus haute importance. #playsound:VOX_Arle_jedisaisdonc
    * [Rester silencieux.]
    * [(Se moquer) Jouer correctement la comédie ?] PLAYER: Si la mission était de jouer correctement, permets-moi de te dire que c'est un échec cuisant... #audience:laughter #playsound:VOX_Player_missionjouercorrect #anim:Arle:angry
        ~ audience_judgement(5)
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Le <b>Juge</b> exige le silence ! #playsound:VOX_Judge_silencelejugeexige #anim:Judge:bell #audience:silent
        JUGE ERNEST: Ce procès n'est pas une fanfaronnade ! Membres du jury, soyez dignes de la tâche qui vous incombe ! #playsound:VOX_Judge_ceprocesfanfaronnade
        JUGE ERNEST: Quant à vous, cessez d'objecter quand la parole ne vous a pas été donnée par le <b>Juge</b> en personne ! #playsound:VOX_Judge_quantavous
        JUGE ERNEST: Témoin, vous mentionniez une mission confiée à l'<b>Accusé</b> par la <b>Couronne</b>. #playsound:VOX_Judge_temoinmentionniez
- JUGE ERNEST: Précisez quelle était la nature de cette mission, je vous prie. #playsound:VOX_Judge_precisezlanature #anim:Arle:bow
ARLE: La mission que la reine <b>Constance</b> me fit l'honneur de transmettre à messire l'infâme <b>Accusé</b>, était de tuer le <shake a=0.5><b>Léviathan</b></shake>, et d'en ramener l'organe vital. #audience:choc #playsound:VOX_Arle_lamissiondelareine
ARLE: Je veux bien entendu parler de son cœur, <b>Votre Honneur</b>. #audience:laughter #anim:Judge:bell #anim:Arle:bow #playsound:VOX_Arle_jeveuxparlercoeur
JUGE ERNEST: Bien, bien... Ensuite ? #playsound:VOX_Judge_biebienensuite
- ARLE: Je voudrais, <b>Votre Honneur</b>, témoigner du fait que, lorsque j'abordais avec le <shake a=0.5><b>détestable</b></shake> messire, le sujet du meurtre... #playsound:VOX_Arle_jevoudraistemoigner
ARLE: ... celui-ci n'eût aucun scrupule à accepter d'ôter une vie. #audience:choc #playsound:VOX_Arle_cuicineutaucun
JUGE ERNEST: Vraiment ? <b>Accusé</b>, qu'avez-vous à répondre ? #playsound:VOX_Judge_vraimentaccuserepondre
    * [J'ai refusé de tuer !] PLAYER: J'ai toujours refusé de tuer, <b>Votre Honneur</b> ! #playsound:VOX_Player_toujoursrefusedetuer #audience:debate
        ARLE: Mais bien sûr... Quel fieffé menteur ! #audience:debate #playsound:VOX_Arle_fieffementeur
        JUGE ERNEST: Silence ! le <b>Juge</b> exige le silence ! #playsound:VOX_Judge_silencelejugeexige2 #anim:Judge:bell
        {
            - judge_explained_mask == false: JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre. #playsound:VOX_Judge_cetribunallumiere #playsound:Play_MUS_Story_SC_Trial_LaVerite1
                JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole. #playsound:VOX_Judge_cessezlaveriteparle #playsound:Play_MUS_Story_SC_Trial_LaVerite2
                ~ judge_explained_mask = true
        }
        JUGE ERNEST: <shake a=0.5>La Vérité sort de la bouche du Juge.</shake> #playsound:VOX_Judge_laveritesort #audience:ovation #anim:Juge:mask #playsound:Play_MUS_Story_SC_Trial_LaVerite3
        {
            - t_1_accept_to_kill == true: JUGE ERNEST: « Tuer ne me dérange nullement. ». #playsound:VOX_Judge_playercitationtuer #audience:choc
                ~ audience_judgement(-10)
                JUGE ERNEST: Ainsi il apparaît que vous avez menti, <b>Accusé</b>. #playsound:VOX_Judge_ansivousavezmenti
                ~ audience_judgement(-10)
            - t_1_refuse_to_kill == true: JUGE ERNEST: « Ôter une vie n'est pas dans mes pratiques. ». #playsound:VOX_Judge_playercitationoter  #audience:ovation
                ~ audience_judgement(10)
                JUGE ERNEST: Ainsi, l'<b>Accusé</b> dit la vérité. #playsound:VOX_Judge_ainsiaccuseverite #audience:applause
                ~ audience_judgement(10)
                JUGE ERNEST: Témoin, que l'on ne vous reprenne plus à mentir en ces lieux ! #playsound:VOX_Judge_temoinquelonnevousreprenne #anim:Arle:stressed #audience:booing
        }
    * [C'est la vérité...] PLAYER: J'admets avoir accepté de tuer, <b>Votre Honneur</b>... #playsound:VOX_Player_jadmetsacceptetuer #audience:choc
        ~ audience_judgement(-10)
        JUGE ERNEST: Silence ! le <b>Juge</b> exige le silence ! #playsound:VOX_Judge_silencelejugeexige #anim:Judge:bell
    * [(Se moquer) Plutôt mourir que de l'écouter...] PLAYER: Que j'aurais accepté de m'ôter ma propre vie pour éviter d'être témoin de son jeu de scène ! #playsound:VOX_Player_prefereoterproprevie #audience:laughter
        ~ audience_judgement(5)
        ARLE: Tu te crois drôle, avorton ? #playsound:VOX_Arle_tutecroisdrole
        {make_arle_angry(): -> arle_leaves_stage}
- ARLE: <b>Votre Honneur</b>, puis-je ajouter quelque chose ? #playsound:VOX_Arle_ajouterqqch
    * [La laisser continuer.]
    * [(Se moquer) <b>Irène</b>, pitié, faites-la taire.] PLAYER: Ô <b>Irène</b>, ayez pitié de nous, pauvres humains ! Ô, je vous en conjure : faites-la taire ! #audience:laughter #playsound:VOX_Player_oireneayezpitie #anim:Arle:angry
        ~ audience_judgement(5)
        ARLE: Cesse de m'interrompre, <shake a=0.5><b>morveux</b></shake> ! #anim:Arle:angry #playsound:VOX_Arle_cessedeminterrompre
        {make_arle_angry(): -> arle_leaves_stage}
- JUGE ERNEST: Soyez brève. #playsound:VOX_Judge_soyezbreve #anim:Arle:bow
ARLE: Entendez bien que mon ambition, <b>Votre Honneur</b>, n'est point de prêter à mon image plus d'éloges qu'elle n'en mérite. #playsound:VOX_Arle_ecoutezbienambition
JUGE ERNEST: Bon, bon... Concluez. #playsound:VOX_Judge_bonbonconcluez #audience:laughter
ARLE: Je voulais simplement signifier, au profit de la Vérité ainsi que la Justice, qu'à peine notre bonne reine <b>Constance</b> m'eut chargée de confier à messire ladite mission... #playsound:VOX_Arle_simplementsignifier
ARLE: Mon cœur me fit comprendre que l'<shake a=0.5><b>effroyable</b></shake> messire était bien loin d'être à la hauteur de la tâche. #audience:laughter #audience:applause #anim:Arle:bow #playsound:VOX_Arle_moncoeurfitcomprendre
    ~ audience_judgement(-10)
- JUGE ERNEST: J'en appelle à l'<b>Accusé</b> : qu'avez-vous à dire pour votre défense ? #playsound:VOX_Judge_jenappellequavezvous
    * [Je me suis montré à la hauteur.] PLAYER: <b>Votre Honneur</b>, messieurs les jurés...
        PLAYER: J'espère que ce procès sera l'occasion de démontrer que j'ai bel et bien été à la hauteur de cette tâche. #anim:Player:bow #audience:applause
        -> accusation_of_disrespecting_queen
    * [Arle vient d'insulter notre reine.] PLAYER: Je crois, <b>Votre Honneur</b>, et mesdames et messieurs les jurés, qu'<b>Arle</b> a trahit son manque de respect pour la reine <b>Constance</b>. #audience:debate
        ~ accuse_arle_to_disrespect_queen = true
        ARLE: Objection ! L'<shake a=0.5><b>immonde</b></shake> messire raconte des balivernes ! #playsound:VOX_Arle_objection
        JUGE ERNEST: Silence, témoin ! Je ne vous ai pas donné la parole ! #playsound:VOX_Judge_silencetemoinjeneevousaipas #anim:Arle:sad #anim:Judge:bell #audience:silent
        JUGE ERNEST: Pouvez-vous en avancer la preuve, <b>Accusé</b> ? #playsound:VOX_Judge_pouvezvousfournirpreuve
            ** [En me désavouant, elle désavoue la reine.] PLAYER: Certainement. En prétextant savoir que je n'étais pas à la hauteur de la tâche...
                PLAYER: ... <b>Arle</b> a sous-entendu que la reine avait fait preuve de bêtise en me désignant. #audience:choc #audience:debate
                JUGE ERNEST: L'<b>Accusé</b> a raison sur ce point. #playsound:VOX_Judge_accusearaisonici #anim:Juge:bell #audience:applause #anim:Arle:angry
                ~ audience_judgement(10)
            ** [Je retire mon accusation.] PLAYER: J'en suis malheureusement incapable, <b>Votre Honneur</b>. Je retire mon accusation. #audience:booing #anim:Arle:laughter
                ~ audience_judgement(-10)
    * [(Se moquer) Ma mission est à ma hauteur, et toi...] PLAYER: Je n'ai rien à objecter, <b>Votre Honneur</b>, sinon à remarquer que la reine confie à chacun une mission à la hauteur de son talent. #playsound:VOX_Player_rienaobjecter
        PLAYER: À moi, elle confia la lourde tâche de tuer le <shake a=0.5><b>Léviathan</b></shake>. À elle, la mission toute aussi difficile de m'apporter une carte... #audience:laugh #playsound:VOX_Player_lourdetachetuerlevi #anim:Judge:bell
        ~ audience_judgement(5)
        {make_arle_angry(): -> arle_leaves_stage}
        ARLE: <b>Votre Honneur</b> ! Vous voyez bien que le <shake a=0.5><b>saligaud</b></shake> essaye de décrédibiliser ma perfor... je veux dire, mon témoignage ! #playsound:VOX_Arle_vothsaligaud #audience:laughter
        JUGE ERNEST: Euh... Je... Oui... silence ! Je vous demande de faire le silence ! #playsound:VOX_Judge_jeeuhouisilence #anim:Juge:bell #audience:applause 
- (accusation_of_being_forced) JUGE ERNEST: Passons à la suite, voulez-vous ? #playsound:VOX_Judge_passonssuitevoulez #anim:Juge:bell
JUGE ERNEST: Témoin, avez-vous autre chose à ajouter ? #playsound:VOX_Judge_temoinautrechose
ARLE: J'accuse l'<shake a=0.5><b>abject</b></shake> messire de n'avoir accepté la mission sacrée, confiée par notre bonne reine, que parce qu'il en était contraint ! #audience:debate #playsound:VOX_Arle_abjectmessiremissionsac
JUGE ERNEST: <b>Accusé</b>, qu'avez-vous à répondre ? #playsound:VOX_Judge_accusequerepondrevous
    * [C'est parfaitement faux !] PLAYER: <b>Votre Honneur</b>, je récuse cette accusation ! Elle ment ! #audience:debate
        JUGE ERNEST: Silence ! le <b>Juge</b> vous ordonne de vous taire ! #playsound:VOX_Judge_lejugevousordonnetaire #anim:judge:bell
        {
            - judge_explained_mask == false: JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre. #playsound:VOX_Judge_cetribunallumiere #playsound:Play_MUS_Story_SC_Trial_LaVerite1
                JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole. #playsound:VOX_Judge_cessezlaveriteparle #playsound:Play_MUS_Story_SC_Trial_LaVerite2
                ~ judge_explained_mask = true
        }
        JUGE ERNEST: <shake a=0.5>La Vérité sort de la bouche du Juge.</shake> #playsound:Play_MUS_Story_SC_Trial_LaVerite3 #playsound:VOX_Judge_laveritesort #audience:ovation #anim:Juge:mask 
        {
            - t_1_accept_mission_with_positivity: JUGE ERNEST: « Cela serait pour moi un véritable honneur de ramener le cœur du <shake a=0.5><b>Léviathan</b></shake>. ». #playsound:VOX_Judge_playercitationhonneurramener
                ~ audience_judgement(-10)
            - t_1_accept_mission_with_negativity: JUGE ERNEST: « Puisque je n'ai point le loisir de me soustraire à la tâche... J'accepte de ramener le cœur du <shake a=0.5><b>Léviathan</b></shake>. ». #playsound:VOX_Judge_playercitationpointloisirtache
                ~ audience_judgement(-10)
        }
    * [C'est vrai.] PLAYER: C'est vrai, bien entendu. Qui, dans cette salle, aurait accepté de courir un tel risque ? #audience:debate
        ~ audience_judgement(10)
    * [(Se moquer) J'ai accepté pour mettre fin à la scène.] PLAYER: Que je n'ai accepté, <b>Votre Honneur</b>, que pour mettre fin à une scène désastreuse... #audience:laughter #playsound:VOX_Player_quepourmettrefinscene
        PLAYER: En arrivant en retard, elle pensait faire languir le public... #playsound:VOX_Player_languirpublicenretard
        PLAYER: Mais en réalité le faisait-elle fuir de la salle à toutes jambes ! #audience:laughter #anim:Player:bow #playsound:VOX_Player_fuirsalletoutejambes
        ~ audience_judgement(5)
        ARLE: Moi ? La <wiggle a=0.1>vedette</wiggle> de cette pièce ? Faire fuir le public ?! #playsound:VOX_Arle_vedettepiece
        {make_arle_angry(): -> arle_leaves_stage}
- (accusation_of_disrespecting_queen) JUGE ERNEST: Poursuivons, poursuivons... #playsound:VOX_Judge_poursuivonsx2
JUGE ERNEST: Témoin, avez-vous une autre révélation à faire ? #playsound:VOX_Judge_temoinautrerevelation
{
- accuse_arle_to_disrespect_queen == true : ARLE: Bien entendu, <b>Votre Honneur</b>. L'<shake a=0.5><b>horripliant</b></shake> messire m'a accusé de manquer de respect à notre reine, mais celui-ci l'a tout bonnement humilié. #playsound:VOX_Arle_bienentendumanquerespect #audience:choc #anim:Judge:bell
- accuse_arle_to_disrespect_queen == false : ARLE: Bien entendu, <b>Votre Honneur</b>. Je voudrais témoigner du fait que l'<shake a=0.5><b>affreux</b></shake> messire a humilié notre reine. #audience:choc #anim:Judge:bell #playsound:VOX_Arle_bienentendutemoinger
} 
- JUGE ERNEST: Poursuivez, je vous prie. #playsound:VOX_Judge_poursuivezsvp
ARLE: Le <shake a=0.5><b>terrible</b></shake> messire a cru bon de se moquer de la reine en faisant un bon mot, <b>Votre Honneur</b>. #playsound:VOX_Arle_teriblemessiremoquer
    * [Ce n'est pas ce que vous croyez.] PLAYER: Ce n'est pas ce que vous pensez, votre Honneur... #audience:debate
        JUGE ERNEST: Silence ! Cessez de prendre la parole quand bon vous semble, <b>Accusé</b> ! #playsound:VOX_Judge_silencecessezparolebonvoussemble #anim:Judge:bell #audience:booing
        ~ audience_judgement(-10)
        ~ admit_disrespect_queen = true
    * [C'est faux !] PLAYER: <b>Votre Honneur</b>, elle ment ! #audience:debate
        JUGE ERNEST: Silence ! Cessez de prendre la parole quand bon vous semble, <b>Accusé</b> ! #playsound:VOX_Judge_silencecessezparolebonvoussemble #anim:Judge:bell #audience:booing
        ~ audience_judgement(-10)
    * [Ne rien dire.]
- JUGE ERNEST: Quelles paroles exactes témoignez-vous avoir entendu l'<b>Accusé</b> prononcer ? #playsound:VOX_Judge_quellesparolesexactes
ARLE: L'<shake a=0.5><b>abject</b></shake> messire a dit, je cite : « <b>Constance</b> et son inconstance m'inspirent l'indifférence. ». #audience:laughter #playsound:VOX_Arle_constanceinonstance
JUGE ERNEST: <b>Accusé</b>, qu'avez-vous à dire pour votre défense ? #playsound:VOX_Judge_accusequediredefense
        * [J'admets avoir dit cela.] PLAYER: J'ai le regret d'admettre avoir fait ce jeu de mots, <b>Votre Honneur</b>... #audience:booing #anim:Judge:bell
            JUGE ERNEST: Ainsi avouez-vous avoir manqué de respect à la reine. #playsound:VOX_Judge_ainsimanquerespectrein #anim:Judge:bell
            ~ audience_judgement(-10)
        * [Je n'ai rien dit de tel.] PLAYER: <b>Votre Honneur</b>, mesdames et messieurs les jurés, je jure n'avoir rien dit de tel. #audience:debate
            ARLE: Menteur ! Menteur ! #playsound:VOX_Arle_menteurmenteur
            JUGE ERNEST: Silence ! Par <b>Irène</b>, je demande le silence ! #playsound:VOX_Judge_silenceparirene #anim:Judge:bell #audience:silent
            {
                - judge_explained_mask == false: JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre. #playsound:VOX_Judge_cetribunallumiere #playsound:Play_MUS_Story_SC_Trial_LaVerite1
                    JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole. #playsound:VOX_Judge_cessezlaveriteparle #playsound:Play_MUS_Story_SC_Trial_LaVerite2
                    ~ judge_explained_mask = true
            }
            JUGE ERNEST: <shake a=0.5>La vérité sort de la bouche du Juge.</shake> #playsound:VOX_Judge_laveritesort #audience:ovation #anim:Juge:mask #playsound:Play_MUS_Story_SC_Trial_LaVerite3
            {
                - t_1_respect_the_crown: JUGE ERNEST: « Je braverai tous les dangers pour notre bonne reine ! ». #playsound:VOX_Judge_playercitationjebraveraidangers #audience:ovation #anim:Arle:angry #anim:Player:bow
                    JUGE ERNEST: Témoin, que le <b>Juge</b> ne vous reprenne plus à mentir lors d'un procès divin. #playsound:VOX_Judge_temoinjugereprenneplus #anim:Arle:stressed #audience:booing
                    ~ audience_judgement(10)
                    ~ arle_lied = true
                - t_1_disrespect_the_crown: JUGE ERNEST: « <b>Constance</b> et son inconstance m'inspirent l'indifférence. ». #playsound:VOX_Judge_constanceetinconstance #audience:booing #anim:Player:stressed #anim:Arle:bow
                    ~ audience_judgement(-10)
            }
- (accusation_of_disrespecting_irene) JUGE ERNEST: Passons à la suite, voulez-vous ? #playsound:VOX_Judge_passonssuitesvp #anim:Judge:bell
JUGE ERNEST: Témoin, avez-vous d'autres accusations à faire ? #playsound:VOX_Judge_temoinautreaccusationsfaire
{
    - arle_lied: 
        JUGE ERNEST: Tâchez de ne plus inventer des faits. #playsound:VOX_Judge_tachezplusinventerfaits #audience:booing #anim:Arle:angry
}
- ARLE: J'en ai peur... #playsound:VOX_Arle_jenaipeurptptp
ARLE: <b>Votre Honneur</b>, il est en effet un ultime acte duquel je dois témoigner... #playsound:VOX_Arle_ultimeacte
ARLE: Celui-ci va choquer nos chers jurés, j'en ai peur... #audience:debate #playsound:VOX_Arle_tousleschoquer
JUGE ERNEST: Alors, alors. La Vérité ne saurait souffrir d'une quelconque censure. Poursuivez, je vous prie. #playsound:VOX_Judge_alorsalors #anim:Arle:bow
ARLE: Alors que je lui confiais la mission qui lui était due... L'horripilant <b>Accusé</b> a insulté la <b>Déesse</b> en personne... #audience:choc #playsound:VOX_Arle_confiaismission
    ~ audience_judgement(-10)
JUGE ERNEST: Est-ce vrai ? La <b>Déesse</b> elle-même ? Répondez, <b>Accusé</b>. Et vite ! #playsound:VOX_Judge_estcevrailadeesse
    * [J'avoue mon péché...] PLAYER: <b>Votre Honneur</b>... Mesdames et messieurs les jurés... J'avoue ce péché, en effet. #audience:choc
        ~ audience_judgement(-10)
    * [C'est un mensonge !] PLAYER: <b>Votre Honneur</b>, c'est un mensonge ! Moi, insulter la <b>Déesse</b> ? Pas même sous la torture, vous m'entendez ! #playsound:VOX_Player_votrehonneurmensonge
        ARLE: Un mensonge, un de plus ! #audience:debate #playsound:VOX_Arle_unmensongedepkus
        JUGE ERNEST: Silence ! Silence ! #playsound:VOX_Judge_silencesilence2 #anim:Judge:bell #audience:silent
        {
            - judge_explained_mask == false: JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre. #playsound:VOX_Judge_cetribunallumiere #playsound:Play_MUS_Story_SC_Trial_LaVerite1
                JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole. #playsound:VOX_Judge_cessezlaveriteparle #playsound:Play_MUS_Story_SC_Trial_LaVerite2
                ~ judge_explained_mask = true
        }
        JUGE ERNEST: <shake a=0.5>La Vérité sort de la bouche du Juge.</shake> #playsound:VOX_Judge_laveritesort #audience:ovation #anim:Juge:mask #playsound:Play_MUS_Story_SC_Trial_LaVerite3
        {
            - t_1_respect_irene: JUGE ERNEST: « J'honorerai la <b>Déesse</b>, j'en fais le serment ! ». #playsound:VOX_Judge_playercitationladeesehoneur #audience:ovation #anim:Arle:angry #anim:Player:bow
                ~ audience_judgement(20)
                ~ arle_lied_again = true
            - t_1_disrespect_irene: JUGE ERNEST: « Je me fiche de la <b>Déesse Irène</b> comme du dernier crachin ! ». #playsound:VOX_Judge_playercitationjemefichedeese #audience:booing #anim:Player:stressed #anim:Arle:bow
                ~ audience_judgement(-10)
            - t_1_gold_digger: JUGE ERNEST: « PLAYER: Si j'accepte, ce ne serait ni pour la reine, ni pour la <b>Déesse</b>, mais pour mon seul profit. ». #playsound:VOX_Judge_playercitationjadorelargent #audience:booing #anim:Player:stressed
                ~ audience_judgement(-10)
        }
{
    - arle_lied_again == false: 
        JUGE ERNEST: <b>Accusé</b>, ces paroles sont insoutenables, et par la <b>Loi</b> ainsi que la <b>Foi</b>, elles seront punies. #playsound:VOX_Judge_accusecesparolsinsoutenables #audience:booing
        JUGE ERNEST: Témoin, la <b>Déesse</b> vous remercie pour votre témoignage. Vous pouvez quitter ce tribunal, désormais... #playsound:VOX_Judge_temoindeesseremercietemoignage #audience:ovation
    - arle_lied_again == true:
        JUGE ERNEST: <b>Accusé</b>, je remercie la <b>Déesse</b> que vous n'ayez pas profané son nom comme le témoin le prétendait. #playsound:VOX_Judge_accuseceremercieladeessepasprofane #audience:ovation
        JUGE ERNEST: Témoin, profaner de tels mensonges à l'égard de l'<b>Accusé</b> est un acte grave ! La <b>Déesse</b> vous couvre de honte ! Hors de ma vue ! #playsound:VOX_Judge_temoindprofanerdeessecouvrehonte #audience:booing
}
-
{
    - arle_leaves_the_stage == false:
        JUGE ERNEST: J'appelle à la barre nos deux prochains témoins. #playsound:VOX_Judge_jappellebarreCapuMa #rope:Arle
    - else:
        JUGE ERNEST: J'appelle à la barre nos deux prochains témoins. #playsound:VOX_Judge_jappellebarreCapuMa
}
- -> witnesses_capucine_and_marcello

// Witnesses Capucine and marcello
= witnesses_capucine_and_marcello
- #playsound:Play_MUS_Story_SC_Trial_Guards
{
    - capucine_surname == "la larbine" && marcello_surname == "Marcellogre":
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #playsound:VOX_Judge_LarbineMarcellogre #audience:ovation
    - capucine_surname == "la larbine" && marcello_surname == "Marcellotarie":
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #playsound:VOX_Judge_LarbineMarcellotarie #audience:ovation
    - capucine_surname == "la larbine" && marcello_surname == "Marcellocroupie":
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #playsound:VOX_Judge_LarbineMarcellocroupie #audience:ovation
    - capucine_surname == "la marcassine" && marcello_surname == "Marcellogre":
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #playsound:VOX_Judge_MarcassineMarcellogre #audience:ovation
    - capucine_surname == "la marcassine" && marcello_surname == "Marcellotarie":
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #playsound:VOX_Judge_MarcassineMarcellotarie #audience:ovation
    - capucine_surname == "la marcassine" && marcello_surname == "Marcellocroupie":
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #playsound:VOX_Judge_MarcassineMarcellocroupie #audience:ovation
    - capucine_surname == "la tartine" && marcello_surname == "Marcellogre":
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #playsound:VOX_Judge_TartineMarcellogre #audience:ovation
    - capucine_surname == "la tartine" && marcello_surname == "Marcellotarie":
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #playsound:VOX_Judge_TartineMarcellotarie #audience:ovation
    - capucine_surname == "la tartine" && marcello_surname == "Marcellocroupie":
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #playsound:VOX_Judge_TartineMarcellocroupie #audience:ovation
    - else:
        JUGE ERNEST: <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> », accompagnée de <b>Marcello</b>, alias « <bounce a=0.05>{marcello_surname}</bounce> ». #position:Capucine:8:10 #position:Marcello:8:12 #box #wait:8 #playsound:VOX_Judge_LarbineMarcellogre #audience:ovation
}
- CAPUCINE: <b>Votre Honneur</b>, avec tout mon respect... J'apprécierais d'être nommée simplement <b>Capucine</b>. #wait:3 #playsound:VOX_Capucine_avectoutmonrespect #anim:Capucine:angry #audience:laughter
JUGE ERNEST: Bon, bon... Je tâcherais d'y penser. #playsound:VOX_Judge_bonbonjetacheraidypenser #anim:Capucine:bow
MARCELLO: <b>Votre Horreur</b>, moi aussi je voudrais être nommé <b>Capucine</b>... Euh... je veux dire <b>Marcello</b>, <b>Vot' Horreur</b>. #playsound:VOX_Marcello_vothorreur #audience:laughter
CAPUCINE: Ferme-la, tu veux ? N'en demande pas trop à <b>Son Honneur</b>. #playsound:VOX_Capucine_fermelaveuxtu
CAPUCINE: <b>Votre Honneur</b>, veuillez excuser ce fieffé personnage. Sa place est dans une taverne... ou même une étable. #playsound:VOX_Capucine_veuillezexcuser #audience:laughter
JUGE ERNEST: Silence ! Silence ! #playsound:VOX_Judge_silencesilence #anim:Judge:bell #audience:silent
JUGE ERNEST: Veuillez raconter aux jurés votre rencontre avec l'<b>Accusé</b>. Et soyez brefs, voulez-vous ? #playsound:VOX_Judge_raconterjuresrencontre
CAPUCINE: Je vous remercie, <b>Votre Honneur</b>. #playsound:VOX_Capucine_jevousremercie #anim:Capucine:bow
CAPUCINE: Vous n'êtes pas sans savoir, <b>Votre Honneur</b>, que tout navire qui arrive à <b>Miraterre</b> doit être fouillé par des gardes de la <b>Couronne</b>. #playsound:VOX_Capucine_vousnetespassanssavoir
CAPUCINE: Aussi mon camarade et moi avons-nous pénétré sur le rafiot du vil personnage pour y faire notre inspection. #playsound:VOX_Capucine_aussimoncamarade
MARCELLO: J'avais entendu du bruit dans la cale, <b>Vot' Horreur</b>. #playsound:VOX_Marcello_dubruitvothorreur
CAPUCINE: Ferme-là, tu veux ? C'est à moi de raconter. #anim:Capucine:angry #playsound:VOX_Capucine_fermelatuveux #audience:laughter
CAPUCINE: Mon camarade a effectivement entendu du bruit, et moi j'ai eu l'idée d'aller voir de plus près. #playsound:VOX_Capucine_moncamarade
MARCELLO: Parle-lui de l'odeur, cheffe ! #playsound:VOX_Marcello_parleluiodeur #audience:laughter
CAPUCINE: La ferme, j'ai dit ! #anim:Capucine:angry #playsound:VOX_Capucine_lafermejaidit #audience:laughter
CAPUCINE: Mon camarade n'a pas tort, cependant : l'odeur du rafiot était épouvantable... À l'image du fieffé gredin à ma gauche. #playsound:VOX_Capucine_lodeurepouvantable
    * [À ta droite, pas ta gauche.] PLAYER: À ta droite, pas ta gauche. Quoique, à bien y réfléchir... #audience:laughter #anim:Capucine:bow #playsound:VOX_Player_atadroitepastagauche
    * [Elle confond les hommes...] PLAYER: Je crois, <b>Votre Honneur</b>, que Madame la témoin confond les hommes... #audience:laughter #anim:Capucine:bow #playsound:VOX_Player_jecroisconfondleshommes
- JUGE ERNEST: Silence ! Poursuivez, je vous prie. #playsound:VOX_Judge_silencepoursuivez2 #anim:Judge:bell #audience:silent
CAPUCINE: Permettez-moi de vous épargner les détails, <b>Votre Honneur</b> : le malandrin cachait quelqu'un dans sa cale puante. #playsound:VOX_Capucine_permettezepargnerdetails #audience:choc
    ~ audience_judgement(-10)
    * [L'odeur est arrivée avec vous.] PLAYER: <b>Votre Honneur</b>, sans accuser personne... #audience:debate
        PLAYER: L'odeur susmentionnée a fait son apparition en même temps que <bounce a=0.05>{capucine_surname}</bounce> et son sbire. #audience:laughter
    * [C'est toi qui devrais te cacher.] PLAYER: <b>Votre Honneur</b>, je n'ai caché personne, en revanche...
        PLAYER: Puis-je suggérer à <bounce a=0.05>{capucine_surname}</bounce> de cacher ce qui lui sert de visage ? #audience:laughter #anim:Capucine:angry
- SOUFFLEUR: Psssst... Hé, l'ami ! Ces deux-là adorent faire rire le public, même à leurs dépens... #playsound:VOX_Souffleur_pssthe6
SOUFFLEUR: Tu n'arriveras à rien en te moquant d'eux ! #playsound:VOX_Souffleur_entemoquand
SOUFFLEUR: Puis-je te suggérer une autre idée ? Adresse-toi au <b>Juge</b> en invoquant <b>« le droit de la Lame »</b>. #playsound:VOX_Souffleur_uneautreideejuge
SOUFFLEUR: Retiens bien : <b>« le droit de la Lame »</b>, compris ? Fais-moi confiance, c'est ta seule chance ! #playsound:VOX_Souffleur_droitdelalame
JUGE ERNEST: <b>Accusé</b>, est-ce la vérité ? Cachiez-vous illégalement quelqu'un dans la cale de votre navire ? #playsound:VOX_Judge_accuseestceverite
    * [J'en appelle à la Loi !] PLAYER: <b>Votre Honneur</b>, je souhaiterais invoquer le.. euh.. #playsound:VOX_Player_votrehonneurinvoquereuh
        ** [Le droit de la Larme.] PLAYER: ... le droit de la Larme, <b>Votre Honneur</b>. #playsound:VOX_Player_larme #audience:laughter
            JUGE ERNEST: Sans doute l'<b>Accusé</b> fait-il référence au droit de la Lame ? #audience:debate #playsound:VOX_Judge_droitlamehesitation
            ~ audience_judgement(10)
        ** [Le droit de la Lame.] PLAYER: ... le droit de la Lame, <b>Votre Honneur</b>. #playsound:VOX_Player_lame #audience:choc
            ~ audience_judgement(10)
        ** [Le droit de la Larve.] PLAYER: ... le droit de la Larve, <b>Votre Honneur</b>. #playsound:VOX_Player_larve #audience:laughter
            JUGE ERNEST: Sans doute l'<b>Accusé</b> fait-il référence au droit de la Lame ? #audience:debate #playsound:VOX_Judge_droitlamehesitation
            ~ audience_judgement(10)
- JUGE ERNEST: Bien, bien... Le <b>Juge</b> rappelle aux jurés que le droit de la Lame consiste à défier en duel son opposant lors d'un procès. #playsound:VOX_Judge_bienbiendroitlame #audience:debate
JUGE ERNEST: C'est une vieille loi, qui n'a plus été invoquée depuis des décennies, mais soit... #playsound:VOX_Judge_vieilleloi #audience:ovation
JUGE ERNEST: Lequel des deux témoins voulez-vous défier ? #playsound:VOX_Judge_lequeltemoindefi
    * [Défier Capucine à un duel de poirier.] 
        {
            - capucine_surname == "la larbine":
                PLAYER: <b>Votre Honneur</b>, je souhaiterais défier <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> » à un duel... de poirier ! #audience:ovation #playsound:VOX_Player_defielarbine #playsound:Play_MUS_Story_SC_Trial_Defi
            - capucine_surname == "la marcassine":
                PLAYER: <b>Votre Honneur</b>, je souhaiterais défier <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> » à un duel... de poirier ! #audience:ovation #playsound:VOX_Player_defiemarcassine #playsound:Play_MUS_Story_SC_Trial_Defi
            - capucine_surname == "la tartine":
                PLAYER: <b>Votre Honneur</b>, je souhaiterais défier <b>Capucine</b> dite « <bounce a=0.05>{capucine_surname}</bounce> » à un duel... de poirier ! #audience:ovation #playsound:VOX_Player_defietartine #playsound:Play_MUS_Story_SC_Trial_Defi
            - else:
                PLAYER: <b>Votre Honneur</b>, je souhaiterais défier <b>Capucine</b> dite « <bounce a=0.05>la larbine</bounce> » à un duel... de poirier ! #audience:ovation #playsound:VOX_Player_defielarbine #playsound:Play_MUS_Story_SC_Trial_Defi
        }
        JUGE ERNEST: Un duel... de poirier ? #playsound:VOX_Judge_duelpoirier #audience:laughter
        JUGE ERNEST: Ab... absolument ! Comme l'exige la coutume, en effet... Témoin, acceptez-vous les conditions du duel ? #playsound:VOX_Judge_ababsolument #audience:debate
        CAPUCINE: Volontiers, <b>Votre Honneur</b>. #playsound:VOX_Capucine_volontiersvotrehonneur #audience:ovation #anim:Capucine:happy #anim:Marcello:laugh
        JUGE ERNEST: Ainsi l'issue de cette confrontation entre le témoin et l'<b>Accusé</b> sera décidée par <b>le droit de la Lame</b> ! #playsound:VOX_Judge_ainsiconfontationtemoinaccuse #audience:ovation #anim:Judge:bell #anim:Marcello:applause
        -> duel_against_capucine
    * [Défier Marcello à un concours de pompes.] 
        {
            - marcello_surname == "Marcellogre":
                PLAYER: <b>Votre Honneur</b>, je souhaiterais défier <b>Marcello</b>, autrement nommé « <bounce a=0.05>{marcello_surname}</bounce> » à un concours... de pompes ! #audience:ovation #playsound:VOX_Player_defiemarcellogre #playsound:Play_MUS_Story_SC_Trial_Defi
            - marcello_surname == "Marcellotarie":
                PLAYER: <b>Votre Honneur</b>, je souhaiterais défier <b>Marcello</b>, autrement nommé « <bounce a=0.05>{marcello_surname}</bounce> » à un concours... de pompes ! #audience:ovation #playsound:VOX_Player_defiemarcellotarie #playsound:Play_MUS_Story_SC_Trial_Defi
            - marcello_surname == "Marcellocroupie":
                PLAYER: <b>Votre Honneur</b>, je souhaiterais défier <b>Marcello</b>, autrement nommé « <bounce a=0.05>{marcello_surname}</bounce> » à un concours... de pompes ! #audience:ovation #playsound:VOX_Player_defiemarcellocroupie #playsound:Play_MUS_Story_SC_Trial_Defi
            - else:
                PLAYER: <b>Votre Honneur</b>, je souhaiterais défier <b>Marcello</b>, autrement nommé « <bounce a=0.05>Marcellogre</bounce> » à un concours... de pompes ! #audience:ovation #playsound:VOX_Player_defiemarcellogre #playsound:Play_MUS_Story_SC_Trial_Defi
        }
        JUGE ERNEST: Un concours... de pompes ? #playsound:VOX_Judge_concourspompes #audience:laughter
        JUGE ERNEST: Ab... absolument ! Comme l'exige la coutume, en effet... Témoin, acceptez-vous les conditions du duel ? #playsound:VOX_Judge_ababsolument #audience:debate
        MARCELLO: J'accepte, <b>Vot' Horreur</b> ! #playsound:VOX_Marcello_jaccepte #audience:ovation #anim:Marcello:happy #anim:Capucine:laugh
        JUGE ERNEST: Ainsi l'issue de cette confrontation entre le témoin et l'<b>Accusé</b> sera décidée par le droit de la Lame ! #playsound:VOX_Judge_ainsiconfontationtemoinaccuse #audience:ovation #anim:Judge:bell #anim:Capucine:applause
        -> duel_against_marcello

// Witness Agathe
= witness_agathe
- JUGE ERNEST: Témoins, veuillez regagner l'assistance. #audience:applause #rope:Capucine #rope:Marcello #move:Player:13:5 #move:Player:10:5 #move:Player:10:1
JUGE ERNEST: J'en appelle désormais à notre dernier témoin. #playsound:VOX_Judge_jenappellederniertemoin
JUGE ERNEST: La respectable prêtresse <b>Agathe</b> ! #position:Agathe:8:10 #box #wait:8 #playsound:VOX_Judge_pretresseagathe #audience:ovation #playsound:Play_MUS_Story_SC_Trial_Agathe
JUGE ERNEST: Prêtresse Agathe, nous vous remercions de quitter la demeure d'<b>Irène</b> afin de vous joindre à nous lors de ce procès. #playsound:VOX_Judge_quitterdemeureirene #audience:applause #anim:Agathe:bow
JUGE ERNEST: Je vous en prie, veuillez nous raconter votre rencontre avec l'<b>Accusé</b>. #playsound:VOX_Judge_jevousprieracontezrencontre
AGATHE: J'ai accueilli l'<b>Accusé</b> au sein de ma chapelle, par une nuit d'averse. #playsound:VOX_Agathe_accueilliaccuse
JUGE ERNEST: Avez-vous pour habitude de laisser des manants entrer en ce lieu saint ? #playsound:VOX_Judge_habitudemanantsq
    * [Sans ça, elle se sentirait bien seule...] PLAYER: Sans cela, elle se sentirait bien seule, la pauvre... #audience:booing
        ~ audience_judgement(-10)
        {souffleur_speech_about_mocking_agath()}
        JUGE ERNEST: Prêtresse, veuillez faire fi de l'<b>Accusé</b>, je vous prie. Poursuivez... #playsound:VOX_Judge_fairefiaccuse
    * [Ne rien dire.]
- AGATHE: La <b>Déesse</b> ne fait pas d'exception lorsqu'il s'agit d'aider l'un de ses enfants. #audience:ovation #playsound:VOX_Agathe_deessepasexceptions
JUGE ERNEST: Bien, bien. Continuez, je vous prie... #playsound:VOX_Judge_bienbiencontinuezspv2
AGATHE: L'<b>Accusé</b> et moi avons discuté une partie de la nuit. #playsound:VOX_Agathe_discutenuit
JUGE ERNEST: Sur quel sujet portait votre entretien, prêtresse ? #playsound:VOX_Judge_quelsujetentretien
AGATHE: Notre discussion concernait la <b>Déesse</b>, <b>Votre Honneur</b>. #playsound:VOX_Agathe_discussiondeeese
    * {souffleur_speech_about_not_mocking_agath_done == false} [Pour changer...] PLAYER: Ce n'est pas comme si la prêtresse avait cet unique sujet en tête... #audience:booing
        JUGE ERNEST: <b>Accusé</b>, cessez d'interrompre une personne dont la parole compte bien davantage que la vôtre ! #playsound:VOX_Judge_Maccusecesserinterrompre #audience:applause
        ~ audience_judgement(-10)
        {souffleur_speech_about_mocking_agath()}
        {souffleur_speech_about_agath_testimonial()}
    * [Garder le silence.]
        {souffleur_speech_about_agath_testimonial()}
- AGATHE: Je voudrais d'abord préciser qu'à ce moment-là... #playsound:VOX_Agathe_precisermomentla
AGATHE: Je n'avais pas idée de l'ignominie dont l'<b>Accusé</b> s'était rendu coupable... #audience:debate #playsound:VOX_Agathe_pasideeignominie
AGATHE: Je pensais avoir affaire à un simple vagabond ayant volé une miche de pain pour calmer sa faim... #audience:debate #playsound:VOX_Agathe_pensaisavoirsimplevaga
{
    - t_3_implore_irene: AGATHE: Voyant que l'<b>Accusé</b> était aux prises avec sa conscience, je lui proposai d'implorer la <b>Déesse</b>... #playsound:VOX_Agathe_voyantaccuse
        JUGE ERNEST: Le fit-il, prêtresse ? #playsound:VOX_Judge_lefitil1
        AGATHE: Il le fit, non sans émotions. #audience:applause #playsound:VOX_Agathe_illefitnonsans
        ~ audience_judgement(10)
    - t_3_blame_irene: AGATHE: Voyant que l'<b>Accusé</b> était aux prises avec sa conscience, je lui proposai d'implorer la <b>Déesse</b>... #playsound:VOX_Agathe_voyantimplorer
        JUGE ERNEST: Le fit-il, prêtresse ? #playsound:VOX_Judge_lefitil2
        AGATHE: Non, j'en ai peur. L'<b>Accusé</b>, à la place, accusa la vénérable <b>Irène</b> ! #audience:choc #playsound:VOX_Agathe_nonjenaipeur
        ~ audience_judgement(-10)
}
- AGATHE: Je lui suggérai d'éclairer la lampe de la <b>Déesse</b>, afin qu'elle éclaire ses tourments d'une lumière nouvelle. #playsound:VOX_Agathe_suggereeclairer
JUGE ERNEST: Fit-il briller la lampe d'<b>Irène</b> ? #playsound:VOX_Judge_fitilbrillerlamp
{
    - t_3_light_on_irene_torch: AGATHE: Il alluma la lampe, en effet. #audience:applause #playsound:VOX_Agathe_ilaalumalalampe
        ~ audience_judgement(10)
        {
            - t_3_no_light_on_irene_torch: AGATHE: ... mais l'éteint aussitôt. #audience:booing #playsound:VOX_Agathe_maisleteintaussi
            ~ audience_judgement(-10)
        }
    - t_3_no_light_on_irene_torch: AGATHE: La lampe resta éteinte, j'en ai peur... #audience:booing #playsound:VOX_Agathe_lalamperesta
        ~ audience_judgement(-10)
}
- JUGE ERNEST: Ensuite, prêtresse, quel sujet avez-vous évoqué avec l'<b>Accusé</b> ? #playsound:VOX_Judge_ensuitequelsujet
{
    - t_3_stained_glass_1_talk:
        -> talk_about_stained_glass_1
    - t_3_stained_glass_2_talk:
        -> talk_about_stained_glass_2
    - t_3_stained_glass_3_talk:
        -> talk_about_stained_glass_3
}
// Player va raconter la tempête (flashback)
- -> judge_proceed_to_mention_the_leviathan

// Arle leaves stage
= arle_leaves_stage
~ audience_judgement(20)
JUGE ERNEST: Euh... Si... Silence ! #playsound:VOX_Judge_euhsisilencesilence #anim:Judge:bell #audience:ovation
JUGE ERNEST: Je... J'appelle à la barre nos deux prochains témoins. #playsound:VOX_Judge_jejappellebarre
    -> witnesses_capucine_and_marcello

// Duel against Capucine
= duel_against_capucine
~ temp dext_difficulty = 60
~ temp capucine_sc = 90
~ temp nb_turn_against_capucine = 1
// Les deux présentoirs sont soulevés par des câbles pour faire de la place
JUGE ERNEST: Le <b>Juge</b> demande aux deux duellistes de s'approcher des jurés. #playsound:VOX_Judge_jugedemandeduellistes #anim:Judge:bell
JUGE ERNEST: Lorsque la cloche sonnera, vous devrez faire le.. euh.. le poirier ! #move:Player:10:5 #move:Player:13:5 #move:Player:13:4 #move:Capucine:8:6 #move:Capucine:13:6 #move:Capucine:13:7 #playsound:VOX_Judge_clochesonnerafairepoirier #audience:laughter
JUGE ERNEST: Celui ou celle qui tiendra le plus longtemps <b>remportera le défi</b>. Tenez-vous prêts... #playsound:VOX_Judge_tiendrapluslongtempsremporte #audience:ovation
JUGE ERNEST: À vos marques... #playsound:VOX_Judge_amarques
JUGE ERNEST: ... prêts... #playsound:VOX_Judge_pret #audience:ovation
JUGE ERNEST: ... <shake a=0.5><b>partez</b></shake> ! #playsound:VOX_Judge_partez #anim:Judge:bell #audience:ovation
- (start_duel)
    * [Faire le poirier. {t(DEXT, dext_difficulty)}]
        {sc(DEXT, dext_difficulty): -> round_against_capucine_S | -> defeat_against_capucine}
- (next_round_against_capucine)
    {
        - nb_turn_against_capucine == 1:
            JUGE ERNEST: Le témoin <b>Capucine</b> tient bon elle aussi ! #anim:Capucine:poirier #audience:ovation #playsound:VOX_Judge_capucineholds1 #playsound:Play_MUS_Story_SC_Trial_CapucineHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de ne pas s'effondrer ! #audience:ovation #playsound:VOX_Judge_accusetoholdpoirier1
        - nb_turn_against_capucine == 2:
            JUGE ERNEST: Le témoin <b>Capucine</b> parvient à tenir le bon bout ! #anim:Capucine:poirier #audience:ovation #playsound:VOX_Judge_capucineholds2 #playsound:Play_MUS_Story_SC_Trial_CapucineHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de ne pas échouer lamentablement! #audience:ovation #playsound:VOX_Judge_accusetoholdpoirier2
        - nb_turn_against_capucine == 3:
            JUGE ERNEST: Le témoin <b>Capucine</b> continue d'impressionner les jurés ! #anim:Capucine:poirier #audience:ovation #playsound:VOX_Judge_capucineholds3 #playsound:Play_MUS_Story_SC_Trial_CapucineHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de ne pas décevoir les jurés ! #audience:ovation #playsound:VOX_Judge_accusetoholdpoirier3
        - nb_turn_against_capucine == 4:
            JUGE ERNEST: Le témoin <b>Capucine</b> tient encore le coup ! #anim:Capucine:poirier #audience:ovation #playsound:VOX_Judge_capucineholds4 #playsound:Play_MUS_Story_SC_Trial_CapucineHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de faire une nouvelle fois preuve de talent ! #audience:ovation #playsound:VOX_Judge_accusetoholdpoirier4
        - nb_turn_against_capucine == 5:
            JUGE ERNEST: Le témoin <b>Capucine</b> réussit une nouvelle fois ! #anim:Capucine:poirier #audience:ovation #playsound:VOX_Judge_capucineholds5 #playsound:Play_MUS_Story_SC_Trial_CapucineHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de tenir encore un peu ! #audience:ovation #playsound:VOX_Judge_accusetoholdpoirier5
        - nb_turn_against_capucine == 6:
            JUGE ERNEST: Le témoin <b>Capucine</b> parvient à tenir malgré la douleur ! #anim:Capucine:poirier #audience:ovation #playsound:VOX_Judge_capucineholds6 #playsound:Play_MUS_Story_SC_Trial_CapucineHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de tenir toujours un peu plus ! #audience:ovation #playsound:VOX_Judge_accusetoholdpoirier6
        - nb_turn_against_capucine >= 7:
            JUGE ERNEST: Le témoin <b>Capucine</b> tient bon elle aussi ! #anim:Capucine:poirier #audience:ovation #playsound:VOX_Judge_capucineholds1 #playsound:Play_MUS_Story_SC_Trial_CapucineHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de tenir toujours un peu plus ! #audience:ovation #playsound:VOX_Judge_accusetoholdpoirier6
        - else:
            JUGE ERNEST: Le témoin <b>Capucine</b> tient bon elle aussi ! #anim:Capucine:poirier #audience:ovation #playsound:VOX_Judge_capucineholds1 #playsound:Play_MUS_Story_SC_Trial_CapucineHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de tenir toujours un peu plus ! #audience:ovation #playsound:VOX_Judge_accusetoholdpoirier6
    }
    ~ nb_turn_against_capucine += 1
    + [Tenir le coup. {t(DEXT, dext_difficulty)}]
        {sc(DEXT, dext_difficulty): -> round_against_capucine_S | -> defeat_against_capucine}
- (round_against_capucine_S)
    ~ dext_difficulty -= 5
    ~ capucine_sc -= 5
    {
        - nb_turn_against_capucine == 1:
            JUGE ERNEST: L'<b>Accusé</b> a tenu bon : qu'en sera-t-il de notre témoin ? ({capucine_sc}% que Capucine réussisse) #anim:Player:poirier #audience:ovation #playsound:VOX_Judge_accuseholdspoirier1 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_capucine == 2:
            JUGE ERNEST: L'<b>Accusé</b> a une nouvelle fois réussi : qu'en sera-t-il de notre témoin ? ({capucine_sc}% que Capucine réussisse) #anim:Player:poirier #audience:ovation #playsound:VOX_Judge_accuseholdspoirier2 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_capucine == 3:
            JUGE ERNEST: L'<b>Accusé</b> impressionne par ses talents au poirier : qu'en sera-t-il de notre témoin ? ({capucine_sc}% que Capucine réussisse) #anim:Player:poirier #audience:ovation #playsound:VOX_Judge_accuseholdspoirier3 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_capucine == 4:
            JUGE ERNEST: L'<b>Accusé</b> nous délivre une nouvelle fois une performance impressionnante : qu'en sera-t-il de notre témoin ? ({capucine_sc}% que Capucine réussisse) #anim:Player:poirier #audience:ovation #playsound:VOX_Judge_accuseholdspoirier4 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_capucine == 5:
            JUGE ERNEST: L'<b>Accusé</b> semble désormais inarrêtable : qu'en sera-t-il de notre témoin ? ({capucine_sc}% que Capucine réussisse) #anim:Player:poirier #audience:ovation #playsound:VOX_Judge_accuseholdspoirier5 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_capucine >= 6:
            JUGE ERNEST: L'<b>Accusé</b> réussit à nouveau : qu'en sera-t-il de notre témoin ? ({capucine_sc}% que Capucine réussisse) #anim:Player:poirier #audience:ovation #playsound:VOX_Judge_accuseholdspoirier6 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - else:
            JUGE ERNEST: L'<b>Accusé</b> réussit à nouveau : qu'en sera-t-il de notre témoin ? ({capucine_sc}% que Capucine réussisse) #anim:Player:poirier #audience:ovation #playsound:VOX_Judge_accuseholdspoirier6 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
    }
    {roll_ai_sc(capucine_sc): -> next_round_against_capucine | -> victory_against_capucine}
    #audience:ovation
- (defeat_against_capucine) JUGE ERNEST: Nous avons un vainqueur ! #anim:Player:fail #playsound:VOX_Judge_nousavonsvainqueurpoirier #playsound:Play_MUS_Story_SC_Trial_UnVainqueur
    JUGE ERNEST: Après {nb_turn_against_capucine < 2: un total ridicule de | un total impressionnant de} {nb_turn_against_capucine} tour{nb_turn_against_capucine > 1:s}, c'est le témoin <b>Capucine</b> qui remporte le duel ! #anim:Player:angry #anim:Capucine:happy #playsound:VOX_Judge_capucinewins
    ~ audience_judgement(-10)
    MARCELLO: Impressionnant, cheffe ! Vous n'avez la tête qui tourne ? #audience:laughter #playsound:VOX_Marcello_impressionnant
    CAPUCINE: S.. si, un peu... Mets-la en veilleuse, tu veux ? #playsound:VOX_Capucine_tetequitourne #audience:laughter
    JUGE ERNEST: Ainsi en a jugé... euh la <b>Déesse</b> ! L'<b>Accusé</b> perd le duel ! #playsound:VOX_Judge_accuseloosCapu #audience:booing #screenshake
    -> witness_agathe
- (victory_against_capucine) JUGE ERNEST: Nous avons un vainqueur ! #anim:Capucine:fail #playsound:VOX_Judge_nousavonsvainqueurpoirier #playsound:Play_MUS_Story_SC_Trial_UnVainqueur
    JUGE ERNEST: Après {nb_turn_against_capucine < 2: un total ridicule de | un total impressionnant de} {nb_turn_against_capucine} tour{nb_turn_against_capucine > 1:s}, c'est l'<b>Accusé</b> qui remporte le duel ! #anim:Player:happy #anim:Capucine:angry #playsound:VOX_Judge_accusewinspoirier
    JUGE ERNEST: Ainsi en a jugé... euh la <b>Déesse</b> ! L'<b>Accusé</b> remporte le duel ! #playsound:VOX_Judge_accusewinsCapu #audience:ovation #trial
    ~ audience_judgement(30) 
    MARCELLO: L'important, c'est de participer, cheffe ! #playsound:VOX_Marcello_importantpar #anim:Marcello:applause
    CAPUCINE: La ferme, tu veux ? #anim:Capucine:angry #audience:laughter #playsound:VOX_Capucine_lafermetuveux
    -> witness_agathe
    
// Duel against Marcello
= duel_against_marcello
~ temp stre_difficulty = 60
~ temp marcello_sc = 90
~ temp nb_turn_against_marcello = 1
// Les deux présentoirs sont soulevés par des câbles pour faire de la place
JUGE ERNEST: Le <b>Juge</b> demande aux deux duellistes de s'approcher des jurés. #playsound:VOX_Judge_jugedemandeduellistes #anim:Judge:bell
JUGE ERNEST: Lorsque la cloche sonnera, vous devrez faire le.. euh.. des pompes ! #move:Player:10:5 #move:Player:13:5 #move:Player:13:4 #move:Marcello:8:6 #move:Marcello:13:6 #move:Marcello:13:7 #playsound:VOX_Judge_clochesonnedespompes #audience:laughter
JUGE ERNEST: Celui qui en fera le plus grand nombre <b>remportera le défi</b>. Tenez-vous prêts... #playsound:VOX_Judge_pompesplusgrandnombre #audience:ovation
JUGE ERNEST: À vos marques... #playsound:VOX_Judge_amarques
JUGE ERNEST: ... prêts... #playsound:VOX_Judge_pret #audience:ovation
JUGE ERNEST: ... <shake a=0.5><b>partez</b></shake> ! #playsound:VOX_Judge_partez #anim:Judge:bell #audience:ovation
- (start_duel)
    * [Faire une pompe. {t(STRE, stre_difficulty)}]
        {sc(STRE, stre_difficulty): -> round_against_marcello_S | -> defeat_against_marcello}
- (next_round_against_marcello)
    {
        - nb_turn_against_marcello == 1:
            JUGE ERNEST: Le témoin <b>Marcello</b> tient bon lui aussi ! #anim:Marcello:pushup #playsound:VOX_Judge_marcelloholds1 #audience:ovation #playsound:Play_MUS_Story_SC_Trial_MarcelloHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de ne pas s'effondrer ! #audience:ovation #playsound:VOX_Judge_accusetoholdpompes1
        - nb_turn_against_marcello == 2:
            JUGE ERNEST: Le témoin <b>Marcello</b> parvient à tenir le bon bout ! #anim:Marcello:pushup #playsound:VOX_Judge_marcelloholds2 #audience:ovation #playsound:Play_MUS_Story_SC_Trial_MarcelloHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de ne pas échouer lamentablement! #audience:ovation #playsound:VOX_Judge_accusetoholdpompes2
        - nb_turn_against_marcello == 3:
            JUGE ERNEST: Le témoin <b>Marcello</b> continue d'impressionner les jurés ! #anim:Marcello:pushup #playsound:VOX_Judge_marcelloholds3 #audience:ovation #playsound:Play_MUS_Story_SC_Trial_MarcelloHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de ne pas décevoir les jurés ! #audience:ovation #playsound:VOX_Judge_accusetoholdpompes3
        - nb_turn_against_marcello == 4:
            JUGE ERNEST: Le témoin <b>Marcello</b> tient encore le coup ! #anim:Marcello:pushup #playsound:VOX_Judge_marcelloholds4 #audience:ovation #playsound:Play_MUS_Story_SC_Trial_MarcelloHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de faire une nouvelle fois preuve de talent ! #audience:ovation #playsound:VOX_Judge_accusetoholdpompes4
        - nb_turn_against_marcello == 5:
            JUGE ERNEST: Le témoin <b>Marcello</b> réussit une nouvelle fois ! #anim:Marcello:pushup #playsound:VOX_Judge_marcelloholds5 #audience:ovation #playsound:Play_MUS_Story_SC_Trial_MarcelloHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de tenir encore un peu ! #audience:ovation #playsound:VOX_Judge_accusetoholdpompes5
        - nb_turn_against_marcello == 6:
            JUGE ERNEST: Le témoin <b>Marcello</b> parvient à tenir malgré la douleur ! #anim:Marcello:pushup #playsound:VOX_Judge_marcelloholds6 #audience:ovation #playsound:Play_MUS_Story_SC_Trial_MarcelloHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de tenir toujours un peu plus ! #audience:ovation #playsound:VOX_Judge_accusetoholdpompes6
        - nb_turn_against_marcello >= 7:
            JUGE ERNEST: Le témoin <b>Marcello</b> réussit une nouvelle fois ! #anim:Marcello:pushup #playsound:VOX_Judge_marcelloholds5 #audience:ovation #playsound:Play_MUS_Story_SC_Trial_MarcelloHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de tenir toujours un peu plus ! #audience:ovation #playsound:VOX_Judge_accusetoholdpompes6
        - else:
            JUGE ERNEST: Le témoin <b>Marcello</b> réussit une nouvelle fois ! #anim:Marcello:pushup #playsound:VOX_Judge_marcelloholds5 #audience:ovation #playsound:Play_MUS_Story_SC_Trial_MarcelloHolds
            JUGE ERNEST: C'est désormais à l'<b>Accusé</b> de tenir toujours un peu plus ! #audience:ovation #playsound:VOX_Judge_accusetoholdpompes6
    }
    ~ nb_turn_against_marcello += 1
    + [Faire une nouvelle pompe. {t(STRE, stre_difficulty)}]
        {sc(STRE, stre_difficulty): -> round_against_marcello_S | -> defeat_against_marcello}
- (round_against_marcello_S)
    ~ stre_difficulty -= 5
    ~ marcello_sc -= 5
    {
        - nb_turn_against_marcello == 1:
            JUGE ERNEST: L'<b>Accusé</b> a tenu bon : qu'en sera-t-il de notre témoin ? ({marcello_sc}% que Marcello réussisse) #anim:Player:pushup #audience:ovation #playsound:VOX_Judge_accuseholdspompe1 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_marcello == 2:
            JUGE ERNEST: L'<b>Accusé</b> a une nouvelle fois réussi : qu'en sera-t-il de notre témoin ? ({marcello_sc}% que Marcello réussisse) #anim:Player:pushup #audience:ovation #playsound:VOX_Judge_accuseholdspompe2 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_marcello == 3:
            JUGE ERNEST: L'<b>Accusé</b> impressionne par ses talents : qu'en sera-t-il de notre témoin ? ({marcello_sc}% que Marcello réussisse) #anim:Player:pushup #audience:ovation #playsound:VOX_Judge_accuseholdspompe3 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_marcello == 4:
            JUGE ERNEST: L'<b>Accusé</b> nous délivre une nouvelle fois une performance impressionnant : qu'en sera-t-il de notre témoin ? ({marcello_sc}% que Marcello réussisse) #anim:Player:pushup #audience:ovation #playsound:VOX_Judge_accuseholdspompe4 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_marcello == 5:
            JUGE ERNEST: L'<b>Accusé</b> semble désormais inarrêtable : qu'en sera-t-il de notre témoin ? ({marcello_sc}% que Marcello réussisse) #anim:Player:pushup #audience:ovation #playsound:VOX_Judge_accuseholdspompe5 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - nb_turn_against_marcello >= 6:
            JUGE ERNEST: L'<b>Accusé</b> réussit à nouveau : qu'en sera-t-il de notre témoin ? ({marcello_sc}% que Marcello réussisse) #anim:Player:pushup #audience:ovation #playsound:VOX_Judge_accuseholdspompe6 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
        - else:
            JUGE ERNEST: L'<b>Accusé</b> réussit à nouveau : qu'en sera-t-il de notre témoin ? ({marcello_sc}% que Marcello réussisse) #anim:Player:pushup #audience:ovation #playsound:VOX_Judge_accuseholdspompe6 #playsound:Play_MUS_Story_SC_Trial_PlayerHolds
    }
    {roll_ai_sc(marcello_sc): -> next_round_against_marcello | -> victory_against_marcello}
    #audience:ovation
- (defeat_against_marcello) JUGE ERNEST: Nous avons un vainqueur ! #anim:Player:fail #playsound:VOX_Judge_nousavonsvainqueur #playsound:Play_MUS_Story_SC_Trial_UnVainqueur
    JUGE ERNEST: Après {nb_turn_against_marcello < 2: un total ridicule de | un total impressionnant de} {nb_turn_against_marcello} pompe{nb_turn_against_marcello > 1:s}, c'est le témoin <b>Marcello</b> qui remporte le duel ! #anim:Player:angry #anim:Marcello:happy #playsound:VOX_Judge_temoinmarcellowins
    MARCELLO: Vous avez vu ça, cheffe ? #playsound:VOX_Marcello_vousavezcvucacheffe #anim:Marcello:happy
    CAPUCINE: J'ai vu, j'ai vu... Mets-la en, veilleuse, tu veux ? #audience:laughter
    JUGE ERNEST: Ainsi en a jugé... euh la <b>Déesse</b> ! L'<b>Accusé</b> perd le duel ! #playsound:VOX_Judge_accuseloosCapu #audience:booing #trial
    ~ audience_judgement(-10)
    -> witness_agathe
- (victory_against_marcello) JUGE ERNEST: Nous avons un vainqueur ! #anim:Marcello:fail #playsound:VOX_Judge_nousavonsvainqueurpoirier2 #playsound:Play_MUS_Story_SC_Trial_UnVainqueur
    JUGE ERNEST: Après {nb_turn_against_marcello < 2: un total ridicule de | un total impressionnant de} {nb_turn_against_marcello} pompe{nb_turn_against_marcello > 1:s}, c'est l'<b>Accusé</b> qui remporte le duel ! #anim:Player:happy #anim:Marcello:angry #playsound:VOX_Judge_accusewinspoirier
    JUGE ERNEST: Ainsi en a jugé... euh la <b>Déesse</b> ! L'<b>Accusé</b> remporte le duel ! #playsound:VOX_Judge_accusewinsCapu #audience:ovation #screenshake
    ~ audience_judgement(30)
    MARCELLO: L'important c'est de participer pas vrai cheffe ? #playsound:VOX_Marcello_importantpar2 #anim:Marcello:applause
    CAPUCINE : Pas du tout, abruti. #audience:laughter
    CAPUCINE: Tu viens de te faire ridiculiser par l'autre minable ! #audience:laughter
    -> witness_agathe

// The player talked about stained glass 1
= talk_about_stained_glass_1
AGATHE: J'ai évoqué avec l'<b>Accusé</b> l'histoire de la <b>Déesse</b> et des marins qui la sauvèrent de la tempête. #playsound:VOX_Agathe_evoquehistoire #audience:empathy
- JUGE ERNEST: Une histoire des plus émouvantes... Qu'a-t-il eu à dire à ce sujet, prêtresse ? #playsound:VOX_Judge_unehistoireemouvantepretresse
{
    - t_3_is_with_irene_saviors:
        AGATHE: Il fit preuve du plus grand des soutiens à l'égard des marins et du bébé, <b>Votre Honneur</b>. #audience:applause #playsound:VOX_Agathe_plusgranddessoutiens
            ~ audience_judgement(10)
    - t_3_is_against_irene_saviors:
        AGATHE: Il s'en prit aux marins, prétextant qu'ils étaient ignares d'aller sauver le bébé, en proie à la tempête. #audience:boing #playsound:VOX_Agathe_ilsenpritauxmarins
        ~ audience_judgement(-10)
    - else:
        AGATHE: Il est resté silencieux, et m'a écouté avec respect, <b>Votre Honneur</b>. #audience:applause #playsound:VOX_Agathe_ilestrestesilence
        ~ audience_judgement(10)
}
- JUGE ERNEST: Ensuite, prêtresse ? #playsound:VOX_Judge_ensuitepretresse
{
    - t_3_rant_about_edgar_the_traquenard: AGATHE: Ensuite, il ne cessa de mentionner un certain <b><wiggle a=0.1>Edgar le Traquenard</wiggle></b>, <b>Votre Honneur</b>... #audience:laughter #playsound:VOX_Agathe_ensuiteilnecessa
        ~ audience_judgement(10)
        JUGE ERNEST: Comment dites-vous ? <b>Edgar</b>... <b><wiggle a=0.1>le Traquenard</wiggle></b> ? #playsound:VOX_Judge_commentedgar #audience:laughter
        AGATHE: Il semblerait, oui... Il en parlait avec des yeux fous, <b>Votre Honneur</b>. #audience:laughter #playsound:VOX_Agathe_ilsembleraitoui
        JUGE ERNEST: Passons, passons... #playsound:VOX_Judge_passonspassons
}
- JUGE ERNEST: Avez-vous évoqué avec l'<b>Accusé</b> la fin de l'histoire ? Celle-ci est des plus attendrissantes... #playsound:VOX_Judge_evoquefinhistoire #audience:applause
AGATHE: Je n'ai pas manqué de le faire, <b>Votre Honneur</b>. #playsound:VOX_Agathe_jenaipasmanque
JUGE ERNEST: Bien, bien. Et quelle fut sa réaction, quand il apprit que la lumière du phare, au loin, sauva les marins et l'enfant ? #playsound:VOX_Judge_bienbienquellereactionlumierephare #audience:empathy
{
    - t_3_believe_in_lighthouse_sacred_light: AGATHE: Il en fut profondément ému, <b>Votre Honneur</b>. #audience:ovation #playsound:VOX_Agathe_ilenfutprofond
        JUGE ERNEST: Voilà qui est tout à son honneur. #playsound:VOX_Judge_voilatoutasonhonneur #audience:applause
        ~ audience_judgement(10)
    - t_3_does_not_believe_in_lighthouse_sacred_light: AGATHE: Il... Il évoqua que cette histoire tenait davantage du mythe que de la réalité. #audience:choc #playsound:VOX_Agathe_ililevoqua
        JUGE ERNEST: Vraiment ? <b>Irène</b> en soit témoin : l'<b>Accusé</b> n'a aucun cœur. #playsound:VOX_Judge_vraimentirenetemoinaucunoeur #audience:booing
        ~ audience_judgement(-10)
}
- JUGE ERNEST: Votre discussion s'est-elle arrêtée là, prêtresse ? #playsound:VOX_Judge_discussionarretelapre
{
    - t_3_stained_glass_2_talk:
        -> talk_about_stained_glass_2
    - t_3_stained_glass_3_talk:
        -> talk_about_stained_glass_3
    - else: AGATHE: Oui, <b>Votre Honneur</b>. Après ça, l'<b>Accusé</b> alla dormir, puis fut arrêté le lendemain, à son réveil. #playsound:VOX_Agathe_ouivotre
        -> judge_proceed_to_mention_the_leviathan
}

// The player talked about stained glass 2
= talk_about_stained_glass_2
AGATHE: L'<b>Accusé</b> et moi avons discuté des prédictions d'<b>Irène</b>, et de la manière dont elle sauva nos ancêtres... #playsound:VOX_Agathe_laccuseetmoiavonspredictions
AGATHE: Nous avons récité la <b>comptine des Noyés</b>. #audience:applause #playsound:VOX_Agathe_nousavonsrecite
JUGE ERNEST: Bien, bien... Mais encore, prêtresse ? #playsound:VOX_Judge_bienbienmaisencorecomptine
    -> talk_about_stained_glass_3

// The player talked about stained glass 3
= talk_about_stained_glass_3
AGATHE: L'ultime sujet que nous abordâmes, <b>Votre Honneur</b>... #playsound:VOX_Agathe_lultimesujet
AGATHE: ... Ce fut <b>vous</b>. #audience:choc #playsound:VOX_Agathe_cefutvous
JUGE ERNEST: Je vois... #playsound:VOX_Judge_jevoispointpointpoint #audience:hush
JUGE ERNEST: Et qu'a eu à dire l'<b>Accusé</b> au sujet du <b>Juge</b> ? #playsound:VOX_Judge_quaeuadirelaccusejuge #audience:silent
{
    - t_3_say_judge_is_not_human:
        AGATHE: L'<b>Accusé</b>... #playsound:VOX_Agathe_laccuseptptpt
        AGATHE: L'<b>Accusé</b> contesta votre humanité, <b>Votre Honneur</b>.#audience:choc #playsound:VOX_Agathe_contestahuma
        ~ audience_judgement(-10)
        JUGE ERNEST: Je vois... #playsound:VOX_Judge_jevois2
    - t_3_question_judge_position: AGATHE: L'<b>Accusé</b> remit en question votre position de <b>Juge</b>, <b>Votre Honneur</b>. #audience:choc #playsound:VOX_Agathe_remitenquestionjuge
        JUGE ERNEST: Je vois, je vois... #playsound:VOX_Judge_jevoisjevois
        JUGE ERNEST: Le <b>Juge</b> laissera les jurés décider de son sort... Puisse-t-il finir au fond des Eaux ! #playsound:VOX_Judge_jugelaisserajuresdecidersortpuisse #audience:ovation
        ~ audience_judgement(-10)
    - t_3_show_judge_respect: AGATHE: L'<b>Accusé</b> fit montre de respect à votre égard, <b>Votre Honneur</b>. #audience:applause #playsound:VOX_Agathe_fitmontrederespect
        ~ audience_judgement(10)
        JUGE ERNEST: Grand bien lui fasse. #playsound:VOX_Judge_grandbienluifasse
}
{
    - t_3_look_away_judge_stained_glass: AGATHE: Une dernière chose : lorsque je suggérai à l'<b>Accusé</b> de regarder le vitrail vous représentant... #playsound:VOX_Agathe_dernierechose
    AGATHE: Celui-ci détourna le regard, <b>Votre Honneur</b>. #audience:debate #playsound:VOX_Agathe_ildetournaleregard
    ~ audience_judgement(-10)
    JUGE ERNEST: Je vois... #playsound:VOX_Judge_jevois3
}
{
    - t_3_say_judge_is_not_human == false && t_3_question_judge_position == false && t_3_show_judge_respect == false && t_3_look_away_judge_stained_glass == false: AGATHE: Il ne dit rien vous concernant, <b>Votre Honneur</b>. #audience:applause #playsound:VOX_Agathe_ilneditrienvousconcernant
        JUGE ERNEST: Sans doute est-ce pour le mieux... #playsound:VOX_Judge_sansdoutepourlemieux #audience:applause
        ~ audience_judgement(10)
}
- -> judge_proceed_to_mention_the_leviathan

// The judge proceed to mention the Leviathan
= judge_proceed_to_mention_the_leviathan
- JUGE ERNEST: Ainsi se clôt votre témoignage, prêtresse. #playsound:VOX_Judge_ainsiclottemoingnagepre #audience:applause
JUGE ERNEST: Chacun vous remercie pour votre dévouement. #playsound:VOX_Judge_chacunremerciedevouement #audience:ovation #rope:Agathe
JUGE ERNEST: <b>Accusé</b>, nous nous devons désormais d'aborder le sujet du <shake a=0.5><b>Léviathan</b></shake>. #playsound:VOX_Judge_accusesujetleviathan #audience:debate
JUGE ERNEST: En effet, vous fûtes missionné par la <b>Couronne</b>, afin de vous rendre en mer... #playsound:VOX_Judge_eneffetmissonnecouronne
JUGE ERNEST: ... et d'y terrasser le terrible <shake a=0.5><b>Léviathan</b></shake>. #playsound:VOX_Judge_terrasserleviathan #audience:choc
JUGE ERNEST: Avez-vous tenu parole, <b>Accusé</b> ? Avez-vous, oui ou non, ramené le cœur de la créature ? #playsound:VOX_Judge_aveznvousdtenuparole #audience:ovation
    * [Je l'ai fait !] PLAYER: Bien entendu, <b>Votre Honneur</b> ! #playsound:VOX_Player_bienentenduvotrehonneur #audience:applause
        ~ audience_judgement(10)
        JUGE ERNEST: Assez de ces mensonges ! Nous savons que cela est faux. #playsound:VOX_Judge_assezmensongessavonsfaux
        ~ audience_judgement(-20)
    * [Bien sûr que non.] PLAYER: Je n'ai pu accomplir cette mission, <b>Votre Honneur</b>. #playsound:VOX_Player_jenaipuaccomplir
        JUGE ERNEST: Ainsi, vous pensez pouvoir vous soustraire à vos engagements à l'égard de la <b>Couronne</b>. #playsound:VOX_Judge_ainsipensezsoustraire
        ~ audience_judgement(-10)
    * [J'ai eu un léger contretemps...] PLAYER: <b>Votre Honneur</b>, c'était mon souhait le plus cher, mais nous avons subi un contretemps. #playsound:VOX_Player_votrehonneurmonsouhaitcher
        JUGE ERNEST: Un contretemps, vous dites ? #playsound:VOX_Judge_uncontratempsq
        ~ audience_judgement(-10)
- JUGE ERNEST: Un tel sujet ne doit pas être abordé avec légèreté, <b>Accusé</b>... #playsound:VOX_Judge_telsujetpaslegere
JUGE ERNEST: Veuillez raconter aux jurés ainsi qu'au <b>Juge</b> ce qu'il s'est passé lorsque vous avez trouvé l'emplacement indiqué par la carte. #playsound:VOX_Judge_racontersceneleviathan 
    * [Une tempête déchirait les eaux...] PLAYER: Une terrible tempête déchirait l'océan... #playsound:VOX_Player_unetemperedechirait #box
    * [Je livrai une bataille contre l'océan...] PLAYER: Je livrai une véritable bataille contre l'océan... #playsound:VOX_Player_jelivraiunebataillecontre #box
    * [Je me démenai pour sauver mon équipage...] PLAYER: Je faisais tout ce qui était en mon pouvoir pour sauver mon équipage d'une mort certaine... #playsound:VOX_Player_toutmonpouvoirequipage #box
// Player va raconter la tempête (flashback)
- #audience:ovation
- (tempest_flashback)
    -> tempest