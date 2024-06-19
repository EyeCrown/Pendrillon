// TRIBUNAL SCENE 1

// Variables
VAR judge_explained_mask = false
VAR accuse_arle_to_disrespect_queen = false
VAR admit_disrespect_queen = false
VAR arle_lied = false
VAR arle_lied_again = false
VAR souffleur_speech_about_not_mocking_agath_done = false
VAR naida_name = "LA POISCAILLE"
VAR naida_name_on_text = "Naïda"
VAR verdict_is_innocent = false
VAR verdict_is_guilty = false

// Scene
=== tribunal_1 ===
-> start

= start
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Judge:JUGE ERNEST
#actor:Arle:ARLE
#actor:Naïda:???:NAÏDA:L'AFFREUSE SIREINE:LA POISCAILLE
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
        JUGE ERNEST: Les <b>Portes du Tribunal</b> se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribMerlin
    - p_name == "Ambroise":
        JUGE ERNEST: Les <b>Portes du Tribunal</b> se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribAmbroise
    - p_name == "Octave":
        JUGE ERNEST: Les <b>Portes du Tribunal</b> se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribOctave
    - else:
        JUGE ERNEST: Les <b>Portes du Tribunal</b> se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé. #playsound:VOX_Judge_lesportesdutribMerlin
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
- JUGE ERNEST: Le <b>Juge</b> appelle désormais à la barre le premier témoin de ce procès : <b>Arle</b>, la trublionne de la reine <b>Constance</b>. #playsound:Play_MUS_Story_SC_Trial_Arle #position:Arle:8:10 #box #wait:8 #playsound:VOX_Judge_jugeappellearle #anim:Judge:bell #anim:Arle:bow #audience:ovation
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
- -> judge_proceed_to_mention_the_sireine


// Arle leaves stage
= arle_leaves_stage
~ audience_judgement(20)
JUGE ERNEST: Euh... Si... Silence ! #playsound:VOX_Judge_euhsisilencesilence #anim:Judge:bell #audience:ovation
    -> judge_proceed_to_mention_the_sireine


// The judge proceed to mention the Sireine
= judge_proceed_to_mention_the_sireine
- JUGE ERNEST: <b>Accusé</b>, il est désormais temps de mentionner l'objet même de votre mission : le <shake a=0.5><b>Léviathan</b></shake>. #audience:choc
    * [Je l'ai affronté !] PLAYER: Je l'ai affronté, <b>Votre Honneur</b>. #audience:ovation
- JUGE ERNEST: Ainsi, vous avez véritablement affronté une créature marine ? #playsound:VOX_Judge_ainsiavezvousveritablecreature
    * [Pour Irène !] PLAYER: Je l'ai fait. Pour nul autre qu'<b>Irène</b>, <b>Votre Honneur</b>. #audience:ovation #playsound:VOX_Player_jelaifaitirene
        ~ audience_judgement(20)
    * [Pour la Couronne !] PLAYER: Je l'ai fait. Pour nul autre que la <b>Couronne</b>, <b>Votre Honneur</b>. #audience:ovation #playsound:VOX_Player_jelaifaitcouronne
        ~ audience_judgement(10)
    * [Je n'avais pas le choix...] PLAYER: Je l'ai fait. Je n'avais pas le choix, <b>Votre Honneur</b>... C'était elle ou nous. #audience:ovation #playsound:VOX_Player_jelaifaitoblige
        ~ audience_judgement(10)
-
{
    - b_player_won == true:
        JUGE ERNEST: Et vous avez triomphé de la bête. #audience:ovation #screenshake
        ~ audience_judgement(40)
    - else:
        JUGE ERNEST: Et vous avez été vaincu. #audience:booing
        ~ audience_judgement(-30)
}
JUGE ERNEST: <b>Accusé</b>, il est un sujet que nous n'avons pas encore évoqué lors de ce procès. #playsound:VOX_Judge_accuseilestsujetsireine #audience:debate
JUGE ERNEST: Ce sujet constitue pourtant le cœur de ce qu'il vous est reproché. #playsound:VOX_Judge_constituecoeur #audience:debate
JUGE ERNEST: Je veux bien entendu parler... de votre histoire d'amour avec une <b>Sireine</b>. #playsound:VOX_Judge_bienentenduhistoireamour #audience:choc
    ~ audience_judgement(-30)
    * [Laisser le silence retomber.]
- JUGE ERNEST: Mesdames et messieurs les jurés, je vous demande de garder votre calme. #playsound:VOX_Judge_gardezcalmejures #audienc:silent
JUGE ERNEST: Vous savez l'importance de la tâche qui vous incombe. Sachez vous en montrer digne. #playsound:VOX_Judge_savezimportancetache
JUGE ERNEST: J'appelle à la barre... la <b>Sireine</b>. #box #playsound:VOX_Judge_appellesireinebarre #position:Naïda:8:10 #wait:4 #anim:Judge:bell #audience:choc #audience:booing
JUGE ERNEST: Avant toute chose : je demande à la créature de ne pas prendre la parole. #playsound:VOX_Judge_creaturepasparole #audience:booing
JUGE ERNEST: Si tant est qu'elle soit capable de s'exprimer... #playsound:VOX_Judge_sitantestexprimer #audience:laughter
JUGE ERNEST: En effet, ce lieu saint ne saurait accueillir la voix d'une affreuse <b>Sireine</b> ! #playsound:VOX_Judge_eneffetlieusacre #audience:booing
L'AFFREUSE SIREINE: ... #audience:boing
    * [Vous allez regretter ces paroles !] PLAYER: Retirez ces sales paroles, maudit <b>Juge</b> ! <b>Naïda</b> vaut plus que vous tous réunis ! #playsound:VOX_Player_retirezsalesparoles #audience:choc
        ~ audience_judgement(-20)
    * [Elle possède un nom.] PLAYER: L'affreuse <b>Sireine</b>, comme vous dites, possède un nom. <b>Naïda</b>. #playsound:VOX_Player_affreusesireine
        ~ audience_judgement(5)
- JUGE ERNEST: Ainsi, <b>la poiscaille</b> possède un nom ? #playsound:VOX_Judge_poiscalleaunnomq #audience:debate
LA POISCAILLE: ... #audience:booing
    * [(Menaçant) Appelez-la par son nom. {t(STRE, -20)}] // 30%
        {sc(STRE, -20): -> convince_name_naida_S | -> convince_name_naida_F}
            ** (convince_name_naida_S) PLAYER: <b>Votre Honneur</b>, si vous ne daignez pas appeler <b>Naïda</b> par son nom, par la <b>Déesse</b>, vous le paierez. #audience:choc #playsound:VOX_Player_menacerlejuge
                ~ audience_judgement(10)
                JUGE ERNEST: Bon, bon... Je consens à appeler la créature par ce qui lui sert de nom... #playsound:VOX_Judge_bonbonjeconsens #audience:applause
                JUGE ERNEST: Tant que celle-ci ne profane pas ces lieux de sa parole impie. #playsound:VOX_Judge_tantqueprofanepas #audience:ovation
                ~ naida_name = "NAÏDA"
                ~ naida_name_on_text = "Naïda"
            ** (convince_name_naida_F) PLAYER: <b>Votre Honneur</b>, si vous ne daignez pas appeler <b>Naïda</b> par son nom, par la <b>Déesse</b>, vous le paierez. #audience:choc #playsound:VOX_Player_menacerlejuge
                JUGE ERNEST: Peuh... Si vous croyez me faire peur, <b>Accusé</b>... Ce procès sera l'occasion de rebaptiser votre amie : <b>la poiscaille</b>. #playsound:VOX_Judge_peuhfairepeur #audience:ovation
                ~ naida_name_on_text = "la poiscaille"
                ~ audience_judgement(-10)
    * [(Calme) Tout être a droit à un nom.{t(CHAR, 0)}] // 60%
        {sc(CHAR, 0): -> force_name_naida_S | -> force_name_naida_F}
            ** (force_name_naida_S) PLAYER: <b>Votre Honneur</b>, je vous demande de faire preuve d'humanité en appelant <b>Naïda</b> par son nom. #audience:debate #playsound:VOX_Player_attendrirlejuge
                ~ audience_judgement(10)
                JUGE ERNEST: Bon, bon... Je consens à appeler la créature par ce qui lui sert de nom... #playsound:VOX_Judge_bonbonjeconsens #audience:applause
                JUGE ERNEST: Tant que celle-ci ne profane pas ces lieux de sa parole impie. #playsound:VOX_Judge_tantqueprofanepas #audience:ovation
                ~ naida_name = "NAÏDA"
                ~ naida_name_on_text = "Naïda"
            ** (force_name_naida_F) PLAYER: <b>Votre Honneur</b>, je vous demande de faire preuve d'humanité en appelant <b>Naïda</b> par son nom. #audience:debate #playsound:VOX_Player_attendrirlejuge
                JUGE ERNEST: Peuh... Si vous croyez m'attendrir, <b>Accusé</b>... Ce procès sera l'occasion de rebaptiser votre amie : <b>la poiscaille</b>. #playsound:VOX_Judge_peuhattendriraccuse #audience:ovation
                ~ naida_name_on_text = "la poiscaille"
                ~ audience_judgement(-10)
- SOUFFLEUR: Je sais ce que tu penses, l'ami... #playsound:VOX_Souffleur_jesaiscequetupenses
SOUFFLEUR: La pièce prend des tournures <b>particulièrement sombres</b>... #playsound:VOX_Souffleur_lapieceprendtournuresombre
SOUFFLEUR: Mais ainsi sont fait nos mythes, pas vrai ? #playsound:VOX_Souffleur_mythes
SOUFFLEUR: Le moment risque d'être difficile pour le personnage de <b>Naïda</b>. Elle saura rester digne, ne t'en fais pas ! #playsound:VOX_Souffleur_difficilenaida
SOUFFLEUR: Quand à toi, essaye de la défendre du mieux que tu le peux auprès du <b>Juge</b>, mais surtout du public ! #playsound:VOX_Souffleur_essaiededefendre
SOUFFLEUR: Fais de ton mieux, entendu ? Bon courage, l'ami ! #playsound:VOX_Souffleur_faisdetonmieux
{
    - naida_name_on_text == "la poiscaille":
        JUGE ERNEST: Commencez par nous raconter comment vous avez fait la rencontre de <b>{naida_name_on_text}</b>, voulez-vous ? #playsound:VOX_Judge_commencerrencontrepoiscaille
    - naida_name_on_text == "Naïda":
        JUGE ERNEST: Commencez par nous raconter comment vous avez fait la rencontre de <b>{naida_name_on_text}</b>, voulez-vous ? #playsound:VOX_Judge_commencerencontrenaida
    - else:
        JUGE ERNEST: Commencez par nous raconter comment vous avez fait la rencontre de <b>{naida_name_on_text}</b>, voulez-vous ? #playsound:VOX_Judge_commencerencontrenaida
}
- (player_and_naida_met)
    * [À l'intérieur du Léviathan.] PLAYER: Lorsque le <shake a=0.5><b>Léviathan</b></shake> nous a avalé, mon équipage et moi-même... Nous nous sommes retrouvés à l'intérieur de son estomac. #audience:choc
        PLAYER: C'est là que j'ai fait la rencontre du peuple des <b>Sireines</b>. #audience:debate
        PLAYER: Durant près d'une année, j'ai appris à les connaître.
        PLAYER: À apprécier vivre à leurs côtés... #audience:debate
    * [Cela ne vous regarde pas.] PLAYER: Notre histoire ne vous regarde en rien, <b>Votre Honneur</b>.
        JUGE ERNEST: Allons, allons... Que diriez-vous d'un marché, <b>Accusé</b> ? #playsound:VOX_Judge_allonsallonsmarche
        JUGE ERNEST: Vous témoignez de votre histoire, et je consens à appeler votre amie par son nom.  #playsound:VOX_Judge_temoignezhistoire
        ** [Pas question.] PLAYER: Vous avez perdu ma confiance, <b>Votre Honneur</b>. Il n'en est pas question.
            JUGE ERNEST: Si vous ne témoignez pas de votre histoire, <b>Accusé</b>... vous serez jugés coupables, tous les deux. #playsound:VOX_Judge_temoignezpascoupable #audience:booing
            -> player_and_naida_met
        ** [C'est entendu.] PLAYER: Entendu, <b>Votre Honneur</b>. #audience:applause
            -> player_and_naida_met
- JUGE ERNEST: Ainsi, vous avez découvert le peuple maudit qui fut jadis noyé, avalé par le <shake a=0.5><b>Léviathan</b></shake>... #playsound:VOX_Judge_ainsipeuplejadis
    * [Ils ne sont pas maudits. {t(CHAR, 0)}] // 60%
        {sc(CHAR, 0): -> sireine_are_not_cursed_S | -> sireine_are_not_cursed_F}
        ** (sireine_are_not_cursed_S) PLAYER: <b>Votre Honneur</b>, j'ai toutes les raisons de penser que le peuple des <b>Sireines</b> n'est en rien maudit. #audience:debate
            PLAYER: Ne pensez-vous pas que si la <b>Déesse</b> avait voulu que le <b>Déluge</b> ne les tue, ils ne seraient pas vivants aujourd'hui ? #audience:applause
            ~ audience_judgement(10)
        ** (sireine_are_not_cursed_F) PLAYER: Sont-ils réellement maudits ? Qui peut le dire ? #audience:debate
            ~ audience_judgement(-10)
    * [Vous seul êtes maudit. {t(STRE, 0)}] // 60%
        {sc(STRE, 0): -> judge_is_cursed_S | -> judge_is_cursed_F}
        ** (judge_is_cursed_S) PLAYER: <b>Votre Honneur</b>, s'il est un être maudit en ces lieux, c'est bien vous. #audience:debate
            PLAYER: Un siècle à souffrir, accroché à une roue...
            PLAYER: Si la <b>Déesse</b> avait voulu abréger vos souffrances, ne l'aurait-elle pas fait ? #audience:applause
            ~ audience_judgement(10)
        ** (judge_is_cursed_F) PLAYER: C'est vous qui êtes maudit, pas eux ! #audience:debate
            ~ audience_judgement(-10)
    * [Rester silencieux.] JUGE ERNEST: Vous semblez n'avoir rien à répondre... #playsound:VOX_Judge_semblezavoirrienrepondre #audience:debate
        ~ audience_judgement(-10)
- JUGE ERNEST: <b>Accusé</b>, il est une question qui est dans tous les esprits... #playsound:VOX_Judge_accusequestionesprits
JUGE ERNEST: Comment avez-vous pu tomber amoureux d'une engeance du <b>Déluge</b> ? #playsound:VOX_Judge_commentamoureuxdeluge
    * [(Convaincre) Elle est plus proche de nous que vous. {t(DEXT, -5)}] // 65%
        {sc(DEXT, -5): -> closer_to_us_S | -> closer_to_us_F}
        ** (closer_to_us_S) PLAYER: <b>Votre Honneur</b>... Les <b>Sireines</b> sont plus proches des humains que vous ne l'êtes vous-même... #audience:choc #playsound:VOX_Player_sireineplusprocheshumains
            PLAYER: <b>Naïda</b> a un cœur qui bat : le vôtre n'a-t-il pas cessé il y a bien longtemps ? #audience:debate #playsound:VOX_Player_naidaauncoeur
            PLAYER: Lorsqu'elle se blesse, son sang coule : est-ce votre cas ? #audience:debate #playsound:VOX_Player_sonsangcoule
            PLAYER: Un jour... Elle mourra. #audience:silent #playsound:VOX_Player_unjourellemourra
            PLAYER: Peut-on en dire autant de vous ? #audience:ovation #playsound:VOX_Player_peutonendireautant
            ~ audience_judgement(20)
        ** (closer_to_us_F) PLAYER: <b>Votre Honneur</b>... Les <b>Sireines</b> sont plus proches des humains que vous ne l'êtes vous-même... #audience:choc #playsound:VOX_Player_sireineplusprocheshumains
            PLAYER: <b>Naïda</b> a un cœur qui bat : le vôtre n'a-t-il pas cessé il y a bien longtemps ? #audience:debate #playsound:VOX_Player_naidaauncoeur
            PLAYER: Lorsqu'elle se blesse, son sang coule : est-ce votre cas ? #audience:debate #playsound:VOX_Player_sonsangcoule
            PLAYER: Un jour... Elle mourra. #audience:silent #playsound:VOX_Player_unjourellemourra
            PLAYER: Peut-on en dire autant de vous ? #audience:booing #playsound:VOX_Player_peutonendireautant
            ~ audience_judgement(-10)
    * [(Persuader) J'ai un cœur.{t(CHAR, 10)}] // 70%
        {sc(CHAR, 10): -> we_have_a_heart_S | -> we_have_a_heart_F}
        ** (we_have_a_heart_S) PLAYER: Pour la simple raison que j'ai un cœur, <b>Votre Honneur</b>. #audience:debate #playsound:VOX_Player_jaiuncoeurvotrehonneur
            PLAYER: <b>Naïda</b> aussi en possède un. Et vous, est-ce votre cas ? #audience:choc #playsound:VOX_Player_naidaaussi
            PLAYER: Le vôtre n'a-t-il pas cessé de battre il y a des centaines d'années, attaché à votre roue ? #playsound:VOX_Player_levotreestmort
            PLAYER: Par quel droit un être auquel il manque le cœur peut-il procéder au jugement de ceux qui jouissent et souffrent d'en posséder un ? #audience:ovation #playsound:VOX_Player_commentjugersanscoeur
                ~ audience_judgement(30)
        ** (we_have_a_heart_F) PLAYER: Pour la simple raison que j'ai un cœur, <b>Votre Honneur</b>. #audience:debate #playsound:VOX_Player_jaiuncoeurvotrehonneur
            PLAYER: <b>Naïda</b> aussi en possède un. Et vous, est-ce votre cas ? #audience:choc #playsound:VOX_Player_naidaaussi
            PLAYER: Le vôtre n'a-t-il pas cessé de battre il y a des centaines d'années, attaché à votre roue ? #playsound:VOX_Player_levotreestmort
            PLAYER: Par quel droit un être auquel il manque un cœur peut-il procéder au jugement de ceux qui jouissent et souffrent d'en posséder un ? #audience:booing #playsound:VOX_Player_commentjugersanscoeur
                ~ audience_judgement(-10)
    * [Rester silencieux.] JUGE ERNEST: Aucune réponse... Le cœur a ses raisons... #playsound:VOX_Judge_lecoeurasesraisons #audience:debate
        ~ audience_judgement(-10)
- JUGE ERNEST: <b>Accusé</b>, ne souffrez-vous d'aucune honte à défendre ce peuple que le <b>Déluge</b> a puni ? //#playsound:VOX_Judge_accuseaucunehonte
    * [Nos ancêtres sont communs. {t(DEXT, 15)}] // 75%
        {sc(DEXT, 15): -> we_have_same_ancesters_S | -> we_have_same_ancesters_F}
        ** (we_have_same_ancesters_S) PLAYER: <b>Votre Honneur</b>, nos ancêtres et ceux des <b>Sireines</b> sont les mêmes. #audience:choc #playsound:VOX_Player_memesancetres
            PLAYER: Lorsque <b>Miraterre</b> sombra, certains de nos ancêtres furent sauvés du <b>Déluge</b>, sauvés par la <b>Déesse</b>... #audience:debate #playsound:VOX_Player_miraterresombra
            PLAYER: D'autres n'eurent pas cette chance... Fort heureusement, ils échappèrent à la noyade, eux aussi... #audience:debate #playsound:VOX_Player_dautrespascettechance
            PLAYER: Sauvés par le <shake a=0.5><b>Léviathan</b></shake>. #audience:choc #playsound:VOX_Player_sauvesparleleviathan
            PLAYER: Les deux facettes d'une même pièce... Les deux destins d'un <b>même peuple</b>. #audience:ovation #playsound:VOX_Player_deuxfacettesmemepiece
            ~ audience_judgement(20)
        ** (we_have_same_ancesters_F) PLAYER: <b>Votre Honneur</b>, nos ancêtres et ceux des <b>Sireines</b> sont les mêmes. #audience:choc #playsound:VOX_Player_memesancetres
            PLAYER: Lorsque <b>Miraterre</b> sombra, certains de nos ancêtres furent sauvés du <b>Déluge</b>, sauvés par la <b>Déesse</b>... #audience:debate #playsound:VOX_Player_miraterresombra
            PLAYER: D'autres n'eurent pas cette chance... Fort heureusement, ils échappèrent à la noyade, eux aussi... #audience:debate #playsound:VOX_Player_dautrespascettechance
            PLAYER: Sauvés par le <shake a=0.5><b>Léviathan</b></shake>. #audience:choc #playsound:VOX_Player_sauvesparleleviathan
            PLAYER: Les deux facettes d'une même pièce... Les deux destins d'un <b>même peuple</b>. #audience:booing #playsound:VOX_Player_deuxfacettesmemepiece
            ~ audience_judgement(-10)
    * [Nous pourrions nous unir. {t(CHAR, 10)}] // 70%
        {sc(CHAR, 10): -> we_could_unify_S | -> we_could_unify_F}
        ** (we_could_unify_S) PLAYER: Nos deux peuples pourraient s'unir, <b>Votre Honneur</b>. Faire la paix, du moins. #audience:debate #playsound:VOX_Player_uniondespeuples
            PLAYER: Avant le <b>Déluge</b>, nous ne formions qu'une seule et même communauté... #audience:debate #playsound:VOX_Player_memecommunaute
            PLAYER: Il serait temps d'abandonner notre haine, et de leur montrer... à eux, nos frères et nos sœurs... le respect qu'ils méritent. #audience:ovation #playsound:VOX_Player_abandonnerlahaine
            ~ audience_judgement(20)
        ** (we_could_unify_F) PLAYER: Nos deux peuples pourraient s'unir, <b>Votre Honneur</b>. Faire la paix, du moins. #audience:debate #playsound:VOX_Player_uniondespeuples
            PLAYER: Avant le <b>Déluge</b>, nous ne formions qu'une seule et même communauté... #audience:debate #playsound:VOX_Player_memecommunaute
            PLAYER: Il serait temps d'abandonner notre haine, et de leur montrer... à eux, nos frères et nos sœurs... le respect qu'ils méritent. #audience:booing #playsound:VOX_Player_abandonnerlahaine
            ~ audience_judgement(-10)
    * [Rester silencieux.] JUGE ERNEST: Vous préférez garder le silence... #playsound:VOX_Judge_preferezgardersilencepointpointp #audience:debate
        ~ audience_judgement(-10)
        -> are_sireine_doomed
- JUGE ERNEST: Insinuez-vous que l'infâme créature... Le <shake a=0.5><b>Léviathan</b></shake> lui-même, aurait <b>sauvé</b> ces gens ? #playsound:VOX_Judge_insinuezcreatureinfame
    * [Ma présence en est la preuve. {t(CHAR, 20)}] // 80%
        {sc(CHAR, 20): -> i_am_the_proof_S | -> i_am_the_proof_F}
        ** (i_am_the_proof_S) PLAYER: <b>Votre Honneur</b>, ma présence en ces lieux devrait répondre à votre interrogation... #audience:debate #playsound:VOX_Player_mapresencerepond
            PLAYER: Dois-je vous rappeler que le <shake a=0.5><b>Léviathan</b></shake> m'a avalé, avec tout mon équipage ? #audience:debate #playsound:VOX_Player_doisjerappeler
            PLAYER: Pourtant, je suis ici, devant vous. En chair et en os... #anim:Player:bow #audience:ovation #playsound:VOX_Player_pourtantjesuisici
            ~ audience_judgement(10)
        ** (i_am_the_proof_F) PLAYER: <b>Votre Honneur</b>, ma présence en ces lieux devrait répondre à votre interrogation... #audience:debate #playsound:VOX_Player_mapresencerepond
            PLAYER: Dois-je vous rappeler que le <shake a=0.5><b>Léviathan</b></shake> m'a avalé, avec tout mon équipage ? #audience:debate #playsound:VOX_Player_doisjerappeler
            PLAYER: Pourtant, je suis ici, devant vous. En chair et en os... #anim:Player:bow #audience:booing #playsound:VOX_Player_pourtantjesuisici
            ~ audience_judgement(-10)
    * [Êtes-vous donc idiot ? {t(STRE, 10)}] // 70%
        {sc(STRE, 10): -> are_you_dumb_S | -> are_you_dumb_F}
        ** (are_you_dumb_S) PLAYER: <b>Votre Honneur</b>, êtes-vous stupide ? #audience:choc #playsound:VOX_Player_etesvousstupide
            PLAYER: N'avez-vous donc rien remarqué ? Le <shake a=0.5><b>Léviathan</b></shake> m'a avalé, et pourtant... #audience:debate #playsound:VOX_Player_rienremarquelevi
            PLAYER: Je ne suis point un spectre, contrairement à vous ! #audience:laughter #playsound:VOX_Player_pasunspectre
            PLAYER: ... Sauf votre respect, <b>Votre Honneur</b>. #audience:ovation #playsound:VOX_Player_saufvotrerespecthonneur
            ~ audience_judgement(20)
        ** (are_you_dumb_F) PLAYER: <b>Votre Honneur</b>, êtes-vous stupide ? #audience:choc #playsound:VOX_Player_etesvousstupide
            PLAYER: N'avez-vous donc rien remarqué ? Le <shake a=0.5><b>Léviathan</b></shake> m'a avalé, et pourtant... #audience:debate #playsound:VOX_Player_rienremarquelevi
            PLAYER: Je ne suis point un spectre, contrairement à vous ! #audience:debate #playsound:VOX_Player_pasunspectre
            PLAYER: ... Sauf votre respect, <b>Votre Honneur</b>. #audience:booing #playsound:VOX_Player_saufvotrerespecthonneur
            ~ audience_judgement(-10)
- (are_sireine_doomed) JUGE ERNEST: Ainsi, vous semblez penser que les <b>Sireines</b> ne sont pas des créatures damnées ? #playsound:VOX_Judge_sireinespasdamnesq #audience:debate
    * [Irène était une Sireine. {t(CHAR, -10)}] // 50%
        {sc(CHAR, -10): -> irene_was_a_sireine_S | -> irene_was_a_sireine_F}
        ** (irene_was_a_sireine_S) PLAYER: <b>Votre Honneur</b>, n'avez-vous donc pas compris ? #audience:debate #playsound:VOX_Player_honneurpascompris
            PLAYER: <b>Irène</b> elle-même... Votre propre fille... #playsound:VOX_Player_irenevotrefille
            PLAYER: ... était une <b>Sireine</b>. #audience:choc #playsound:VOX_Player_cestunesireneomg
            PLAYER: Elle fut retrouvée, sur un rocher, en pleine tempête. Pour quelle raison se trouvait-elle en pleine mer ? #audience:debate
            PLAYER: Comment expliquer autrement qu'elle ne fut pas noyée ? #audience:applause
            PLAYER: En conspuant Naïda, ainsi que les siens, c'est la <b>Déesse</b> elle-même que vous insultez ! #audience:ovation
            ~ audience_judgement(30)
        ** (irene_was_a_sireine_F) PLAYER: <b>Votre Honneur</b>, n'avez-vous donc pas compris ? #audience:debate #playsound:VOX_Player_honneurpascompris
            PLAYER: <b>Irène</b> elle-même... Votre propre fille... #playsound:VOX_Player_irenevotrefille
            PLAYER: ... était une <b>Sireine</b>. #audience:choc #playsound:VOX_Player_cestunesireneomg
            PLAYER: Elle fut retrouvée, sur un rocher, en pleine tempête. Pour quelle raison se trouvait-elle en pleine mer ? #audience:debate
            PLAYER: Comment expliquer autrement qu'elle ne fut pas noyée ? #audience:debate
            PLAYER: En conspuant <b>Naïda</b>, ainsi que les siens, c'est la <b>Déesse</b> elle-même que vous insultez ! #audience:booing
                ~ audience_judgement(-10)
    * [Pas maudites mais bénies. {t(DEXT, 0)}] // 60%
        {sc(DEXT, 0): -> sireine_are_blessed_S | -> sireine_are_blessed_F}
        ** (sireine_are_blessed_S) PLAYER: <b>Votre Honneur</b>, si un peuple, avalé par les Eaux lors du <b>Déluge</b>, a pu survivre jusqu'à aujourd'hui... #audience:debate #playsound:VOX_Player_lepeupleasurvecu
            PLAYER: Ne pensez-vous pas qu'il en va de la volonté de la <b>Déesse</b> elle-même ? #audience:debate #playsound:VOX_Player_cestladeesequilavoulu
            PLAYER: Le peuple des <b>Sireines</b> est béni ! Béni de la <b>Déesse</b> ! #audience:ovation #playsound:VOX_Player_bravoladeesse
            ~ audience_judgement(20)
        ** (sireine_are_blessed_F) PLAYER: <b>Votre Honneur</b>, si un peuple, avalé par les Eaux lors du <b>Déluge</b>, a pu survivre jusqu'à aujourd'hui... #audience:debate #playsound:VOX_Player_lepeupleasurvecu
            PLAYER: Ne pensez-vous pas qu'il en va de la volonté de la <b>Déesse</b> elle-même ? #audience:debate #playsound:VOX_Player_cestladeesequilavoulu
            PLAYER: Le peuple des <b>Sireines</b> est béni ! Béni de la <b>Déesse</b> ! #audience:booing #playsound:VOX_Player_bravoladeesse
            ~ audience_judgement(-10)
    * [Rester silencieux.] JUGE ERNEST: Vous préférez garder le silence ? Passons... #playsound:VOX_Judge_preferezgardersilence2 #audience:debate
        ~ audience_judgement(-10)
- JUGE ERNEST: Ces paroles seront vos dernières, <b>Accusé</b>. #playsound:VOX_Judge_parolesdernieresaccuse
JUGE ERNEST: Ainsi ce procès arrive à sa <b>conclusion</b>... #playsound:VOX_Judge_procesconclusiono
JUGE ERNEST: Je demande désormais solennellement aux jurés de bien vouloir rendre leur <b>verdict</b>... #playsound:VOX_Judge_demandejuresverdict #audience:ovation
- -> trial_verdict

// Trial verdict
= trial_verdict
{
    - t_audience_judgement >= 50:
        ~ verdict_is_innocent = true
        -> player_is_innocent
    - else:
        ~ verdict_is_guilty = true
        -> player_is_guilty
}

// Player is innocent
= player_is_innocent
JUGE ERNEST: Mesdames et messieurs les jurés... #playsound:VOX_Judge_mesdamesmessieursjures
JUGE ERNEST: Qui vote... <shake a=0.5><b>coupable</b></shake> ? #playsound:VOX_Judge_quicoupable #box #wait:1 #audience:applause
JUGE ERNEST: Et maintenant... #playsound:VOX_Judge_etmaintenant #audience:debate
JUGE ERNEST: Qui vote... <shake a=0.5><b>innocent</b></shake> ? #playsound:VOX_Judge_quiinnocent #box #wait:1.4 #audience:ovation #anim:Player:bow
~ audience_judgement(100) // La balance penche complètement si innocent
{
    - p_name == "Merlin":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisMerlin #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - p_name == "Ambroise":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisAmbroise #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - p_name == "Octave":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisOctave #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - else:
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisMerlin #playsound:Play_MUS_Story_SC_Trial_ResultRoll
}
JUGE ERNEST: <shake a=0.5><b>INNOCENT</b></shake> !!! #playsound:Play_MUS_Story_SC_Trial_Innocent #playsound:VOX_Judge_INNOCENT #audience:ovation #anim:Judge:bell
JUGE ERNEST: L'<b>Accusé</b>, ainsi que <b>Naïda la Sireine</b>, peuvent retrouver leur liberté. #playsound:VOX_Judge_accuseetnaidelibres #audience:ovation #anim:Judge:bell
- -> naida_speech

// Player is guilty
= player_is_guilty
JUGE ERNEST: Mesdames et messieurs les jurés... #playsound:VOX_Judge_mesdamesmauvais
JUGE ERNEST: Qui vote... <shake a=0.5><b>innocent</b></shake> ? #playsound:VOX_Judge_quivotemauvaisinnocent #box #wait:1 #audience:applause
JUGE ERNEST: Et maintenant... #playsound:VOX_Judge_etmaintenantmauvais #audience:debate
JUGE ERNEST: Qui vote... <shake a=0.5><b>coupable</b></shake> ? #playsound:VOX_Judge_quicoupablemauvais #box #wait:1.4 #audience:ovation #anim:Player:bow
{
    - p_name == "Merlin":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisMerlin #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - p_name == "Ambroise":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisAmbroise #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - p_name == "Octave":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisOctave #playsound:Play_MUS_Story_SC_Trial_ResultRoll
}
- JUGE ERNEST: <shake a=0.5><b>COUPABLE</b></shake> !!! #playsound:Play_MUS_Story_SC_Trial_Coupable #playsound:VOX_Judge_COUPABLE #audience:ovation #anim:Judge:bell
~ audience_judgement(-100) // La balance penche complètement si coupable
JUGE ERNEST: Coulez-le, ainsi que <b>l'affreuse Sireine</b>, où la <b>Déesse</b> ne saurait le trouver... #playsound:VOX_Judge_coulezle #audience:ovation 
JUGE ERNEST: ... Au fond des océans ! #playsound:VOX_Judge_aufonddesoceans #audience:ovation #anim:Judge:bell
- -> naida_speech

= naida_speech
NAÏDA: Avant cela, si vous le permettez... #audience:choc #playsound:VOX_Naida_avantcelasi #playsound:Play_MUS_Story_SC_Trial_NaidaSpeech
NAÏDA: Je voudrais dire quelques mots. #audience:debate #playsound:VOX_Naida_jevoudraisdiremo
NAÏDA: Je resterai digne, et ferai montre de respect, car j'ai souffert de ne pas l'avoir obtenu de votre part à tous... #audience:silent #playsound:VOX_Naida_resteraidigne #audience:empathy
NAÏDA: Que nos ancêtres aient été ou non des semblables, des frères... cela, pour moi, ne change rien. #audience:applause #playsound:VOX_Naida_quenos
NAÏDA: Je voudrais simplement dire à quel point il est étrange, pour une créature telle que moi... #playsound:VOX_Naida_jevoudraissimplement
NAÏDA: Une pauvre <b>Sireine</b>... Une poiscaille... #playsound:VOX_Naida_unepauvresireine #audience:empathy
NAÏDA: Combien il est étrange de constater que vous autres, humains, ayez donné à ce système, le nom de « Justice ». #audience:debate #playsound:VOX_Naida_combienilestetrange
{
    - verdict_is_innocent: NAÏDA: Aujourd'hui, elle nous est favorable...  L'aurait-elle été hier ? #audience:debate #playsound:VOX_Naida_aujourdhuifavorable
    - verdict_is_guilty: NAÏDA: Aujourd'hui, elle nous est défavorable... L'aurait-elle été demain ? #audience:debate #playsound:VOX_Naida_aujourdhuidefavo
}
{
    - p_name == "Merlin":
        NAÏDA: Je remercie <b>Merlin</b> de s'être battu pour qu'on me nomma bien, par <b>mon nom</b>. #audience:applause #playsound:VOX_Naida_remercieMerlin
    - p_name == "Ambroise":
        NAÏDA: Je remercie <b>Ambroise</b> de s'être battu pour qu'on me nomma bien, par <b>mon nom</b>. #audience:applause #playsound:VOX_Naida_remercieAmbroise
    - p_name == "Octave":
        NAÏDA: Je remercie <b>Octave</b> de s'être battu pour qu'on me nomma bien, par <b>mon nom</b>. #audience:applause #playsound:VOX_Naida_remercieOctave
    - else:
        NAÏDA: Je remercie <b>Merlin</b> de s'être battu pour qu'on me nomma bien, par <b>mon nom</b>. #audience:applause #playsound:VOX_Naida_remercieMerlin
}
- NAÏDA: Car <b>les noms</b>, voyez-vous, sont le <b>cœur battant</b> de toute chose. Les noms sont <b>importants</b>. #audience:applause #playsound:VOX_Naida_carlesnoms
NAÏDA: Ainsi il m'apparaît, pour conclure notre histoire, qu'en donnant à un système partial et imparfait, le nom même d'une <b>vertu</b>... #audience:silent #playsound:VOX_Naida_ainsiilmapparait
NAÏDA: En lui donnant le nom de <b>« Justice »</b>... #audience:debate #playsound:VOX_Naida_enluidonnantjustice
NAÏDA: Vous autres humains ayez commis une erreur... <shake a=0.5><b>cruelle</b></shake>. #anim:Naida:bow #box #audience:ovation #playsound:VOX_Naida_vousautreshumains #curtains:close #wait:10 #audience:ovation
- -> cast_salutation
