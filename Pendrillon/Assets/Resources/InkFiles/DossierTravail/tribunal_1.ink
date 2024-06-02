// TRIBUNAL SCENE 1

// Variables
VAR arle_patience = 5
VAR accuse_alre_to_disrespect_queen = false
VAR admit_disrespect_queen = false
VAR arle_lied = false
VAR arle_lied_again = false
VAR arle_left_the_play = false
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
#actor:Naïda:???:NAÏDA:L'AFFREUSE SIREINE:LA POISCAILLE
// Set the location
#set:forest // En attendant d'avoir le décors trial
// Set the actor's positions
#position:Player:8:2
#position:Judge:0:5
#position:Arle:10:20
#position:Capucine:4:20
#position:JudMarcelloge:4:20
#position:Agathe:4:20
#position:Naïda:4:20

// Start the scene
#open_curtains
#audience:shock
#judge_bell
#audience:debate
#audience:silent
// Le juge est encore seul sur scène
#scene_open_to_judge
#audience:ovation
#wait:5
#audience:ovation
#wait:4
- JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent
JUGE ERNEST: Les Portes du Tribunal se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de Miraterre, et descendant du peuple qui fut sauvé.
JUGE ERNEST: Ainsi est-il accusé, non par le règne des Hommes, mais par celui de la Déesse Irène.
JUGE ERNEST: De celle-ci nous nous ferons les yeux, les oreilles et le cœur, comme la Loi l'exige. #audience:ovation
JUGE ERNEST: Silence ! J'exige le silence ! #anim:Judge:bell #audience:silent
- JUGE ERNEST: L'homme est accusé, par ordre croissant de gravité...
{
    - is_accused_of("bribe guards"): JUGE ERNEST: ... De tentative de corruption à l'égard de représentants de l'autorité Royale... #box #audience:booing #screenshake
        ~ audience_judgement(-0.02)
}
{
    - is_accused_of("blasphemy"): JUGE ERNEST: ... De blasphème... #box #audience:booing #screenshake
        ~ audience_judgement(-0.02)
}
- JUGE ERNEST: ... De violence à l'encontre de représentants de l'autorité Royale... #box #audience:laughter
    ~ audience_judgement(0.05)
{
    - is_accused_of("sacred degradations"): JUGE ERNEST: ... De dégradations de biens sacrés... #box #audience:booing #screenshake
    ~ audience_judgement(-0.02)
}
{
    - is_accused_of("crown outrage"): JUGE ERNEST: ... D'outrage à la Couronne... #box #audience:booing #screenshake
        ~ audience_judgement(-0.02)
}
{
    - is_accused_of("judge outrage"): JUGE ERNEST: ... D'outrage au Juge de droit divin, Ernest... #box #audience:choc #sreenshake
        ~ audience_judgement(-0.02)
}
- {is_accused_of("crown outrage") == true}JUGE ERNEST: ... D'outrage à la Couronne... #box #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... D'actes hérétiques... #box #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... De Haute trahison... #box #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... ainsi que, pour conclure...
- JUGE ERNEST: ... D'amour impie. #box #audience:choc #screenshake
    ~ audience_judgement(-0.1)
- JUGE ERNEST: Le Juge demande désormais à l'accusé de faire son entrée. #move(Player) #audience:booing
- JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent
- JUGE ERNEST: Au nom de la Déesse, le Juge demande le silence !
- JUGE ERNEST: Accusé, prenez place.
    * [Prendre place.] #move(Player)
    * [Protester.] PLAYER: Ce procès constitue une terrible injustice ! #audience:debate
        ~ audience_judgement(-0.02)
        JUGE ERNEST: Silence ! #anim:Judge:bell #audience:silent
        JUGE ERNEST: Accusé, vous ne pouvez vous comporter en ce lieu sacré comme vous le faites dans un vulgaire rafiot. 
        JUGE ERNEST: Ne prenez la parole que lorsque le Juge vous la donne.
            ** [Hors de question !] PLAYER: Je suis un homme libre, citoyen de plein droit de Miraterre. Je puis parler librement ! #audience:booing #anim:Judge:bell
                ~ audience_judgement(-0.02)
                JUGE ERNEST: Accusé, je ne le répèterai pas deux fois : ceci est un lieu saint. Sachez rester à votre place.
                *** [Entendu.] PLAYER: C'est entendu. #anim:Judge:bell
                    ---- (agree_with_judge) JUGE ERNEST: Vous ai-je donné la parole ? Taisez-vous donc. Le Juge n'a nul besoin de votre assentiment.
                    ~ audience_judgement(-0.01)
                    **** [Prendre place en silence.] #move(Player)
                *** [Prendre place en silence.] #move(Player)
            ** [Entendu.] PLAYER: C'est entendu.
                -> agree_with_judge
            ** [Prendre place en silence.] #move(Player)
    * [Mon nom est {p_name}, pas Accusé.] PLAYER: Mon nom est {p_name} et non Accusé, votre Honneur. #audience:debate
        JUGE ERNEST: Silence ! #audience:silent
        JUGE ERNEST: Ici, vous n'avez plus de nom. Soyez déjà reconnaissant d'avoir encore votre langue pour pouvoir répondre de vos crimes.
        JUGE ERNEST: Désormais, taisez-vous, Accusé !
- SOUFFLEUR: Psssst... Hé, l’ami ! J’ai l’impression que tu vas passer un sale quart d’heure...
SOUFFLEUR: Il semblerait que tes choix durant toute la pièce vont te retomber dessus les uns après les autres !
SOUFFLEUR: Mais tu as peut-être encore une chance de t’en sortir, si tu parviens à obtenir l’approbation du public !
SOUFFLEUR: N'oublie pas : dans ce procès, c'est le public que tu dois convaincre, pas le Juge ! Bonne chance, l’ami !
    -> witness_arle

// Witness Arle
= witness_arle
- JUGE ERNEST: Le Juge appelle désormais à la barre le premier témoin de ce procès : Arle, la trublionne de la reine  Constance. #anim:Judge:bell #move(Arle) #anim:Arle:bow #audience:applause
JUGE ERNEST: Décrivez au jury votre rencontre avec l'accusé, je vous prie.
ARLE: Votre Honneur, vous n'êtes pas sans ignorer que j'ai l'immense privilège d'occuper, au sein de la Couronne, un rôle de tout premier plan...
    * [(Se moquer) Contrairement à cette pièce.] PLAYER: Ce qui n'est pas le cas de ton rôle dans cette pièce... #audience:laughter #anim:Arle:angry
        ~ audience_judgement(0.05)
        ARLE: Pour qui tu te prends, abruti ? #anim:Arle:angry
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence, vous deux ! Silence ! #anim:Judge:bell #audience:silent
    * [Ne pas l'interrompre.]
- JUGE ERNEST: Poursuivez, je vous prie. #anim:Arle:bow
    * [(Se moquer) Même Son Honneur s'ennuie.] PLAYER: Son Honneur en personne s'ennuie de ton discours ! Si ça continue, le public va déceder d'ennui. #audience:laughter #anim:Arle:angry
        ARLE: C'est toi qui va mourir si tu continues à m'interrompre, minable !
        ~ audience_judgement(0.05)
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Je ne le répèterai pas : faites le silence ! #anim:Judge:bell #audience:silent
        JUGE ERNEST: Poursuivez, témoin. #anim:Arle:bow
        ARLE: Où en étais-je ? Ah oui : un rôle de tout premier plan.
    * [Ne rien dire.]
- ARLE: J'aime à penser que je suis, pour ce rôle, une actrice à la hauteur.
    * [(Se moquer) Toi, une bonne actrice ?] PLAYER: Toi, une bonne actrice ? En voilà une nouvelle à ressuciter les noyés ! #audience:laughter #anim:Arle:angry
        ~ audience_judgement(0.05)
        ARLE: Tu vas te taire, oui ?! #anim:Arle:angry
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent
        JUGE ERNEST: Accusé, cessez d'interrompre le témoin ! Quant à vous...
    * [Se taire.]
- JUGE ERNEST: Veuillez ne pas vous répandre en détails inutiles. #audience:laughter #anim:Arle:sad1
ARLE: ... Hmfrr...
ARLE: Je disais, donc, que sa Majesté Constance m'a chargée de transmettre à messire le scélérat une mission de la plus haute importance.
    * [Jouer correctement la comédie ?] PLAYER: Si la mission était de jouer correctement, permets-moi de te dire que c'est un échec cuisant... #audience:laughter anim:Arle:angry
        ~ audience_judgement(0.05)
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Le Juge exige le silence ! #anim:Judge:bell #audience:silent
        JUGE ERNEST: Ce procès n'est pas une fanfaronnade ! Membres du jury, soyez dignes de la tâche qui vous incombe !
        JUGE ERNEST: Quant à vous, cessez d'objecter quand la parole ne vous a pas été donnée par le Juge en personne !
        JUGE ERNEST: Témoin, vous mentionniez une mission confiée à l'accusé par la Couronne.
    * [Rester silencieux.]
- JUGE ERNEST: Précisez quelle était la nature de cette mision, je vous prie. #anim:Arle:bow
ARLE: La mission que la reine Constance me fit l'honneur de transmettre à messire l'infâme accusé, était de tuer le Léviathan, et d'en ramener l'organe vital.
ARLE: Je veux bien entendu parler de son cœur, Votre Honneur. #audience:laughter #anim:Judge:bell #anim:Arle:bow
JUGE ERNEST: Bien, bien... Est-ce tout ?
ARLE: Puis-ajouter une dernière chose, Votre Honneur ?
    * [(En priant) Irène, pitié, faites-la taire.] PLAYER: Ô Irène, ayez pitié de nous, pauvres humains ! Ô, je vous en conjure : faites-la taire ! #audience:laughter anim:Arle:angry
        ~ audience_judgement(0.05)
        ARLE: Cesse de m'interrompre, morveux ! #anim:Arle:angry
        {make_arle_angry(): -> arle_leaves_stage}
    * [La laisser continuer.]
- JUGE ERNEST: Soyez brève. #anim:Arle:bow
ARLE: Entendez bien que mon ambition, Votre Honneur, n'est point de prêter à mon image plus d'éloges qu'elle n'en mérite.
JUGE ERNEST: Bon, bon... Concluez.
ARLE: Je voulais simplement signifier, au profit de la Vérité ainsi que la Justice, qu'à peine notre bonne reine Constance m'eut chargée de confier à messire ladite mission...
ARLE: Mon cœur me fit comprendre que l'effroyable était bien loin d'être à la hauteur de la tâche. #audience:laughter #audience:applause #anim:Arle:bow
    ~ audience_judgement(-0.01)
- JUGE ERNEST: J'en appelle à l'accusé : qu'avez-vous à dire pour votre défense ?
    * [On ne m'a confié aucune mission.] PLAYER: J'annonce, au jury comme à Votre Honneur, que jamais on ne me confia pareille mission. #audience:debate
        ARLE: Le gredin ment, Votre Honneur ! #audience:debate
        JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent
        JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre.
        JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole.
        JUGE ERNEST: La Vérité sort de la bouche du Juge. #audience:ovation #anim:Juge:mask
        {
            - t_1_accept_mission_with_positivity: JUGE ERNEST: « Cela serait pour moi un véritable honneur. J'accepte de ramener le cœur du Léviathan. ».
                ~ audience_judgement(-0.1)
            - t_1_accept_mission_with_negativity: JUGE ERNEST: « Puisque je n'ai point le loisir de me soustraire à la tâche... J'accepte de ramener le cœur du Léviathan. ».
                ~ audience_judgement(-0.1)
        }
        -> accusation_of_disrespecting_queen
    * [Arle vient d'insulter notre reine.] PLAYER: Je crois, Votre Honneur, et mesdames et messieurs les jurés, qu'Arle a trahit son manque de respect pour la reine Constance. #audience:debate
        ~ accuse_alre_to_disrespect_queen = true
        ARLE: Objection ! L'immonde messire raconte des balivernes !
        JUGE ERNEST: Silence, témoin ! Je ne vous ai pas donné la parole ! #anim:Arle:sad #anim:Judge:bell #audience:silent
        JUGE ERNEST: Pouvez-vous en avancer la preuve, Accusé ?
            ** [En me désavouant, elle désavoue la reine.] PLAYER: Certainement. En prétextant savoir que je n'étais pas à la hauteur de la tâche...
                PLAYER: ... Arle a sous-entendu que la reine avait fait preuve de bêtise en me désignant. #audience:choc #audience:debate
                JUGE ERNEST: L'accusé a raison sur ce point. #anim:Juge:bell #audience:applause #anim:Arle:angry
                ~ audience_judgement(0.05)
            ** [Je retire mon accusation.] PLAYER: J'en suis malheuresement incapable, Votre Honneur. Je retire mon accusation. #audience:booing #anim:Arle:laughter
                ~ audience_judgement(-0.02)
    * [(Se moquer) Ma mission est à ma hauteur, et toi...] PLAYER: Je n'ai rien à objecter, Votre Honneur, sinon à remarquer que la reine confie à chacun une mission à la hauteur de son talent.
        PLAYER: À moi, elle confia la lourde tâche de tuer le Léviathan. À elle, la mission toute aussi difficile de m'apporter une carte... #audience:laugh #anim:Judge:bell
        ~ audience_judgement(0.05)
        {make_arle_angry(): -> arle_leaves_stage}
        ARLE: Votre Honneur ! Vous voyez bien que le saligot essaye de décridibiliser ma perfor... je veux dire, mon témoignage ! #audience:laughter
        JUGE ERNEST: Euh... Je... Oui... silence ! Je vous demande de faire le silence ! #anim:Juge:bell #audience:applause 
- (accusation_of_being_forced) JUGE ERNEST: Passons à la suite, voulez-vous ? #anim:Juge:bell
JUGE ENRNEST: Témoin, avez-vous autre chose à ajouter ?
ARLE: J'accuse l'abjecte messire de n'avoir accepté la mission sacrée, confiée par notre bonne reine, que parce qu'il en était contraint ! #audience:debate
JUGE ERNEST: Accusé, qu'avez-vous à répondre ?
    * [C'est parfaitement faux !] PLAYER: 
    * [Personne n'a le droit de me contraindre !]
    * [(Se moquer) Que le témoin a ]
- JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole.
JUGE ERNEST: La vérité sort de la bouche du Juge. #audience:ovation #anim:Juge:mask
- (accusation_of_disrespecting_queen) JUGE ERNEST: Poursivons, poursuivons...
JUGE ERNEST: Témoin, avez-vous ne autre révélation à faire ?
ARLE: Bien entendu, Votre Honneur. {accuse_alre_to_disrespect_queen: L'affreux messire m'a accusé de manquer de respect à notre reine, mais celui-ci l'a tout bonnement humilié. | Je voudrais témoigner du fait que l'affreux messire a humilié notre reine.} #audience:choc #anim:Judge:bell
JUGE ENRNEST: Poursivez, je vous prie.
ARLE: Le terrible messire a cru bon de se moquer de la reine en faisant un bon mot, Votre Honneur.
    * [C'est faux !] PLAYER: Votre Honneur, elle ment ! #audience:debate
        JUGE ERNEST: Silence ! Ne vous ai-je pas déjà dit que vous n'avez aucun droit de prendre la parole quand bon vous semble, Accusé ? #anim:Judge:bell #audience:booing
        ~ audience_judgement(-0.02)
    * [Je l'avoue, Votre Honneur...] PLAYER: J'ai honte d'admettre qu'elle dit la vérité, votre Honneur... #audience:booing
        JUGE ERNEST: Silence ! Ne vous ai-je pas déjà dit que vous n'avez aucun droit de prendre la parole quand bon vous semble, Accusé ? #anim:Judge:bell #audience:booing
        ~ audience_judgement(-0.02)
        ~ admit_disrespect_queen = true
        JUGE ERNEST: Puisque l'Accusé a admit avoir prononcé ces terribles paroles...
        -> accusation_of_disrespecting_irene
    * [Ne rien dire.]
- JUGE ERNEST: Quelles paroles exactes témoignez-vous avoir entendu l'Accusé prononcer ?
ARLE: L'abjecte messire a dit, je cite : « Constance et son inconstance m'inspirent l'indifférence. ». #audience:laughter
JUGE ERNEST: Accusé, qu'avez-vous à dire pour votre défense ?
        * [J'admets avoir dit cela.] PLAYER: J'ai le regret d'admettre avoir fait ce jeu de mot, Votre Honneur... #audience:booing #anim:Judge:bell
            JUGE ERNEST: Ainsi avouez-vous avoir manqué de respect à la reine. #anim:Judge:bell
            ~ audience_judgement(-0.05)
        * [Je n'ai rien dit de tel.] PLAYER: Votre Honneur, mesdames et messieurs les jurés, je jure n'avoir rien dit de tel. #audience:debate
            ARLE: Menteur ! Menteur !
            JUGE ERNEST: Silence ! Par Irène, je demande le silence ! #anim:Judge:bell #audience:silent
            JUGE ERNEST: La vérité sort de la bouche du Juge. #audience:ovation #anim:Juge:mask
            {
                - t_1_respect_the_crown: JUGE ERNEST: « Je braverai tous les dangers pour notre bonne reine ! ». #audience:ovation #anim:Arle:angry #anim:Player:bow
                    JUGE ERNEST: Témoin, que le Juge ne vous reprenne plus à mentir lors d'un procès divin. #anim:Arle:stressed #audience:booing
                    ~ audience_judgement(0.1)
                    ~ arle_lied = true
                - t_1_disrespect_the_crown: JUGE ERNEST: « Constance et son inconstance m'inspirent l'indifférence. ». #audience:booing #anim:Player:stressed #anim:Arle:bow
                    ~ audience_judgement(-0.1)
            }
- (accusation_of_disrespecting_irene) JUGE ERNEST: Passons à la suite, voulez-vous ? #anim:Judge:bell
JUGE ERNEST: Témoin, avez-vous d'autres accusations à faire ? {arle_lied: Tâchez de ne plus inventer des faits.}
ARLE: J'en ai peur...
ARLE: Votre Honneur, il est en effet un ultime acte duquel je dois témoigner...
ARLE: Celui-ci va choquer nos chers jurés, j'en ai peur... #audience:debate
JUGE ERNEST: Alors, alors. La Vérité ne saurait souffir d'une quelconque censure. Poursuivez, je vous prie. #anim:Arle:bow
ARLE: Alors que je lui confiais la mission qui lui était dûe... L'horripilant Accusé a insulté la Déesse en personne... #audience:choc
    ~ audience_judgement(-0.1)
JUGE ERNEST: Est-ce vrai ? La déesse elle-même ? Notre Sauveuse, Irène ? Répondez, Accusé. Et vite !
    * [J'avoue mon pêché...] PLAYER: Votre Honneur... Mesdames et messieurs les jurés... J'avoue ce pêché, en effet. #audience:choc
        ~ audience_judgement(-0.1)
    * [C'est un mensonge !] PLAYER: Votre Honneur, c'est un mensonge ! Moi, insulter la Déesse ? Pas même sous la torture, vous m'entendez !
        ARLE: Un mensonge, un de plus ! #audience:debate
        JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent
        JUGE ERNEST: ...
        JUGE ERNEST: La Vérité sort de la bouche du Juge. #audience:ovation #anim:Juge:mask
        {
            - t_1_respect_irene: JUGE ERNEST: « J'honorerai la Déesse, j'en fais le serment ! ». #audience:ovation #anim:Arle:angry #anim:Player:bow
                ~ audience_judgement(0.1)
                ~ arle_lied_again = true
            - t_1_disrespect_irene: JUGE ERNEST: « Je me fiche de la Déesse comme du dernier crachin ! ». #audience:booing #anim:Player:stressed #anim:Arle:bow
                ~ audience_judgement(-0.1)
        }
- JUGE ERNEST: {arle_lied_again == false: Accusé, ces paroles sont insoutenables, et par la Loi ainsi que la Foi, elle seront punies. | Accusé, je remercie la Déesse que vous n'ayez pas profané son nom comme le témoin le prétendait.}
- JUGE ERNEST: {arle_lied_again == false: Témoin, la Déesse vous remercie pour votre témoignage. Vous pouvez quitter ce tribunal, désormais... | Témoin, profaner de tels mensonges à l'égard de l'Accusé est un acte grave ! La Déesse vous couvre de honte ! Hors de ma vue !} #audience:booing
    -> witnesses_capucine_and_marcello

// Witnesses Capucine and marcello
= witnesses_capucine_and_marcello
- JUGE ERNEST: Capucine dite « {capucine_surname} », accompagnée de Marcello, alias « {marcello_surname} ». #audience:ovation
CAPUCINE: Votre Honneur, avec tout mon respect... J'apprécierais d'être nommée simplement Capucine. #anim:Capucine:angry #audience:laughter
JUGE ERNEST: Bon, bon... Je tâcherais d'y penser. #anim:Capucine:bow
MARCELLO: Votre Horreur, moi aussi je voudrais être nommé Capucine... Euh... je veux dire Marcello, Vot' Horreur. #audience:laughter
CAPUCINE: Ferme-la, tu veux ? N'en demande pas trop à Son Honneur.
CAPUCINE: Votre Honneur, veuillez excuser cet fieffé personnage. Sa place est dans une taverne... ou même une étable. #audience:laughter
CAPUCINE: ... Pas dans un tel lieu. #anim:Capucine:bow #audience:ovation
JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent
JUGE ERNEST: Veuillez raconter aux jurés votre rencontre avec l'accusé. Et soyez brefs, voulez-vous ?
CAPUCINE: Je vous remercie, Votre Honneur. #anim:Capucine:bow
CAPUCINE: Vous n'êtes pas sans savoir, Votre Honneur, que tout navire qui arrive à Miraterre doit être fouillé par des gardes de la Couronne.
CAPUCINE: Aussi mon camarade et moi avons-nous pénétré sur le rafiot du vil personnage pour y faire notre inspection.
MARCELLO: J'avais entendu du bruit dans la cale, vot' Horreur.
CAPUCINE: Ferme-là, tu veux ? C'est à moi de raconter. #audience:laughter
CAPUCINE: Mon camarade a effectivement entendu du bruit, et moi j'ai eu l'idée d'aller voir de plus près.
MARCELLO: Parle-lui de l'odeur, cheffe ! #audience:laughter
CAPUCINE: La ferme, j'ai dit ! #audience:laughter
CAPUCINE: Mon camarade n'a pas tort, cependant : l'odeur du rafiot était épouvantable... À l'image du fiéffé gredin à ma gauche.
    * [À ta gauche, pas ta droite.] PLAYER: À ta gauche, pas ta droite. Quoique, à bien y réfléchir... #audience:laughter #anim:Capucine:bow
    * [Elle confond les hommes...] PLAYER: Je crois, Votre Honneur, que Madame la témoin confond les hommes... #audience:laughter #anim:Capucine:bow
- JUGE ERNEST: Silence ! Poursuivez, je vous prie. #anim:Judge:bell #audience:silent
CAPUCINE: Permettez-moi de vous épargner les détails, Votre Honneur : le malendrin cachait quelqu'un dans sa cale puante. #audience:choc
    ~ audience_judgement(-0.1)
    * [C'est toi qui pue.] PLAYER: Votre Honneur, si j'admets que ma cale sent parfois la morue... Ce n'est rien en comparaison de l'odeur de Madame la témoin. #audience:laughter
    * [C'est toi qui devrait te cacher.] PLAYER: Votre Honneur, je n'ai caché personne, en revanche...
        PLAYER: Puis-je suggérer à {capucine_surname} de cacher ce qui lui sert de visage ? #audience:laughter #anim:Capucine:angry
- SOUFFLEUR: Psssst... Hé, l'ami ! Ces deux-là adorent faire rire le public, même à leur dépend...
SOUFFLEUR: Tu n'arriveras à rien en te moquant d'eux !
SOUFFLEUR: Puis-je te suggérer une autre idée ? Adresse-toi au juge en invoquant « le droit de la Lame ».
SOUFFLEUR: Retiens bien : « le droit de la Lame », compris ? Fais-moi confiance, c'est ta seule chance !
JUGE ERNEST: Accusé, est-ce la vérité ? Cachiez-vous illégallement quelqu'un dans la cale de votre navire ?
    * [J'en appelle à la Loi !] PLAYER: Votre Honneur, je souhaiterais invoquer le.. euh..
        ** [Le droit de la Larme.] PLAYER: ... le droit de la Larme, Votre Honneur. #audience:laughter
            JUGE ERNEST: Sans doute l'Accusé fait-il référence au droit de la Lame ? #audience:debate
            ~ audience_judgement(0.1)
        ** [Le droit de la Lame.] PLAYER: ... le droit de la Lame, Votre Honneur. #audience:choc
            ~ audience_judgement(0.1)
        ** [Le droit de la Larve.] PLAYER: ... le droit de la Larve, Votre Honneur. #audience:laughter
            JUGE ERNEST: Sans doute l'Accusé fait-il référence au droit de la Lame ? #audience:debate
            ~ audience_judgement(0.1)
- JUGE ERNEST: Bien, bien... Le Juge rappelle aux jurés que le droit de la Lame consiste à défier en duel son opposant lors d'un procès. #audience:debate
JUGE ERNEST: C'est une vieille loi, qui n'a plus été invoquée depuis des décénnies, mais soit... #audience:ovation
JUGE ERNEST: Lequel des deux témoins voulez-vous défier ?
    * [Défier Capucine à un duel de poirier.] PLAYER: Votre Honneur, je souhaiterais défier Capucine dite « {capucine_surname} » à un duel... de poirier ! #audience:ovation
        JUGE ERNEST: Un duel... de poirier ? #audience:laughter
        JUGE ERNEST: Ab... absolument ! Comme l'exige la coutume, en effet... Témoin, acceptez-vous les conditions du duel ? #audience:debate
        CAPUCINE: Volontier, Votre Honneur. #audience:ovation #anim:Capucine:happy #anim:Marcello:laugh
        JUGE ERNEST: Ainsi l'issue de cette confrontation entre le témoin et l'Accusé sera décidée par le droit de la Lame ! #audience:ovation #anim:Judge:bell #anim:Marcello:applause
        -> duel_against_capucine
    * [Défier Marcello à un concours de pompes.] PLAYER: Votre Honneur, je souhaiterais défier Marcello, autrement nommé « {marcello_surname} » à un concours... de pompes ! #audience:ovation
        JUGE ERNEST: Un concours... de pompes ? #audience:laughter
        JUGE ERNEST: Ab... absolument ! Comme l'exige la coutume, en effet... Témoin, acceptez-vous les conditions du duel ? #audience:debate
        MARCELLO: J'accepte, vot' Horreur ! #audience:ovation #anim:Marcello:happy #anim:Capucine:laugh
        JUGE ERNEST: Ainsi l'issue de cette confrontation entre le témoin et l'Accusé sera décidée par le droit de la Lame ! #audience:ovation #anim:Judge:bell #anim:Capucine:applause
        -> duel_against_marcello

// Witness Agathe
= witness_agathe
- JUGE ERNEST: Témoins, veuillez regagner l'assistance. #audience:applause
JUGE ERNEST: J'en appelle désormais à notre dernier témoin.
JUGE ERNEST: La respectable prêtresse Agathe ! #audience:ovation #move(Agathe)
JUGE ERNEST: Prêtresse Agathe, nous vous remercions de quitter la demeure d'Irène afin de vous joindre à nous lors de ce procès. #audience:applause #anim:Agathe:bow
JUGE ERNEST: Je vous en prie, prêtresse, veillez nous raconter votre rencontre avec l'Accusé.
AGATHE: J'ai acceuilli l'Accusé au sein de ma chapelle, par une nuit d'averse.
JUGE ERNEST: Avez-vous pour habitude de laisser des manants entrer en ce lieu saint ?
    * [Sans ça, elle se sentirait bien seule...] PLAYER: Sans cela, elle se sentirait bien seule, la pauvre... #audience:booing
        ~ audience_judgement(-0.02)
        {souffleur_speech_about_mocking_agath()}
        JUGE ERNEST: Prêtresse, veuillez faire fi de l'Accusé, je vous prie. Poursuivez...
    * [Ne rien dire.]
- AGATHE: La Déesse ne fait pas d'exception lorsqu'il s'agit d'aider l'un de ses enfants. #audience:ovation
JUGE ERNEST: Bien, bien. Continuez, je vous prie...
AGATHE: L'Accusé et moi avons discuté une partie de la nuit.
JUGE ERNEST: Sur quel sujet portait votre entretien, prêtresse ?
AGATHE: Notre discussion concernait la Déesse, Votre Honneur.
    * [Pour changer...] PLAYER: Ce n'est pas comme si la prêtresse avait cet unique sujet en tête... #audience:booing
        JUGE ERNEST: Accusé, cessez d'interrompre une personne dont la parole compte bien davantage que la votre ! #audience:applause
        ~ audience_judgement(-0.02)
        {souffleur_speech_about_mocking_agath()}
        JUGE ERNEST: Prêtresse, veuillez excuser l'Accusé. Pouvez-vous nous résumer la teneur de ces échanges ?
    * [Ne pas l'interrompre.] JUGE ERNEST: Bien entendu. Pouvez-vous nous en résumer la teneur, je vous prie ?
- AGATHE: Je voudrais d'abord préciser qu'à ce moment-là, je n'avais pas idée de l'ignominie dont l'Accusé s'était rendu coupable... #audience:debate
AGATHE: Je pensais avoir affaire à un simple vagabond ayant volé une miche de pain pour calmer sa faim...
AGATHE: Lorsque j'évoquais l'acte délictueux auquel l'Accusé avait semble t-il procédé...
{
    - t_3_lie_abot_being_innocent: AGATHE: L'Accusé a menti en prétextant qu'il était innocent. #audience:booing
        ~ audience_judgement(-0.01)
        JUGE ERNEST: L'Accusé est un fieffé menteur, comme ce procès nous l'a maintes fois démontré.
    - t_3_did_not_lie_abot_being_innocent: AGATHE: L'Accusé, je dois l'avouer, n'a pas cherché à me mentir. #audience:applause
        ~ audience_judgement(0.1)
        JUGE ERNEST: Mentir sous le toit d'Irène aurait été un pêché... #audience:applause
}
- JUGE ERNEST: Poursuivez, je vous en prie.
{
    - t_3_show_no_regrets: AGATHE: L'Accusé a évoqué, au sujet de son crime, n'avoir aucun regret. #audience:booing
        ~ audience_judgement(-0.02)
        JUGE ERNEST: Cela n'étonne ni le Juge, ni les jurés, prêtresse. Poursuivez...
    - t_3_show_some_regrets: AGATHE: À sa décharge, l'Accusé a évoqué, au sujet de son crime, avoir quelques regrets. #audience:applause
        ~ audience_judgement(0.1)
        JUGE ERNEST: Je vous remercie de faire preuve d'équité en le précisant, prêtresse Agathe. #audience:applause #anim:Agathe:bow
    - t_3_show_plenty_regrets: AGATHE: À sa décharge, l'Accusé a évoqué, au sujet de son crime, éprouver d'immenses regrets. #audience:applause
        ~ audience_judgement(0.2)
        JUGE ERNEST: Je vous remercie de faire preuve d'équité en le précisant, prêtresse Agathe. #audience:applause #anim:Agath:bow
}
- AGATHE: Lorsque je lui proposai d'implorer la Déesse...
{
    - t_3_implore_irene: AGATHE: Celui-ci le fit, non sans émotions. #audience:applause
        ~ audience_judgement(0.1)
    - t_3_blame_irene: AGATHE: L'Accusé, à la place, accusa la vénérable Irène ! #audience:choc
        ~ audience_judgement(-0.03)
        JUGE ERNEST: Quelle lâcheté ! #audience:booing
}
- AGATHE: Je lui conseillai ensuite d'éclairer la lampe de la Déesse, afin qu'elle éclaire ses soucis d'une lumière nouvelle.
JUGE ERNEST: L'a t-il fait, prêtresse ?
{
    - t_3_light_on_irene_torch: AGATHE: Il alluma la torche, en effet. #audience:applause
        ~ audience_judgement(0.05)
    - t_3_no_light_on_irene_torch: AGATHE: La torche resta éteinte, j'en ai peur... #audience:booing
        ~ audience_judgement(-0.01)
        JUGE ERNEST: La lumière divine n'aurrait pu effacer l'ombre de son âme... #audience:applause
}
- ERNEST: Ensuite, prêtresse, quel sujet avez-vous évoqué avec l'Accusé ?
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
~ audience_judgement(0.4)
. #audience:laughter // Laisser ça là : permet d'aller à la ligne de manière invisible
JUGE ERNEST: Euh... Si... Silence ! #anim:Judge:bell #audience:ovation
JUGE ERNEST: Je... J'appelle à la barre nos deux prochains témoins.
    -> witnesses_capucine_and_marcello

// Duel against Capucine
= duel_against_capucine
~ temp dext_difficulty = 40
~ temp capucine_sc = 100
~ temp nb_turn_against_capucine = 1
// Les deux présentoirs sont soulevés par des câbles pour faire de la place
JUGE ERNEST: Le Juge demande aux deux duellistes de s'approcher des jurés. #anim:Judge:bell
JUGE ERNEST: Lorsque la cloche sonnera, vous devrez faire le.. euh.. le poirier ! #audience:laughter
JUGE ERNEST: Celui ou celle qui tiendra le plus longtemps remportera le défi. Tenez-vous prêts... #audience:ovation #screenshake
JUGE ERNEST: À vos marques...
JUGE ERNEST: ... prêts... #screenshake #audience:ovation
JUGE ERNEST: ... partez ! #anim:Judge:bell #screenshake #audience:ovation
- (start_duel)
    * [Faire le poirier. {t(DEXT, dext_difficulty)}]
        {sc(DEXT, dext_difficulty): -> round_against_capucine_S | -> defeat_against_capucine}
- (next_round_against_capucine)
    ~ nb_turn_against_capucine += 1
    JUGE ERNEST: Le témoin Capucine {tient bon elle aussi | parvient à tenir le bon bout | continue d'impressionner les jurés | tient encore le coup | réussit une nouvelle fois | parvient à tenir malgré la douleur } ! #audience:ovation
    JUGE ERNEST: C'est désormais à l'Accusé de {ne pas s'effondrer | ne pas échouer lamentablement | ne pas décevoir les jurés | faire une nouvelle fois preuve de talent | tenir encore un peu | tenir toujours un peu plus }! #audience:ovation
    + [Tenir le coup. {t(DEXT, dext_difficulty)}]
        {sc(DEXT, dext_difficulty): -> round_against_capucine_S | -> defeat_against_capucine}
- (round_against_capucine_S)
    ~ dext_difficulty -= 5
    ~ capucine_sc -= 5
    JUGE ERNEST: L'Accusé {a tenu bon | a une nouvelle fois réussi | impresionne par ses talents au poirier | nous délivre une novelle fois une performance impressionnante |  semble désormais inarrêtable | réussit à nouveau }: qu'en sera t-il de notre témoin ? ({capucine_sc}% que Capucine réussisse) #audience:ovation
    {roll_ai_sc(capucine_sc): -> next_round_against_capucine | -> victory_against_capucine}
    #audience:ovation
- (defeat_against_capucine) JUGE ERNEST: Nous avons un vainqueur !
    JUGE ERNEST: Après {nb_turn_against_capucine < 2: un total ridicule de | un total impressionnant de} {nb_turn_against_capucine} tour{nb_turn_against_capucine > 1:s}, c'est le témoin Capucine qui remporte le duel !
    ~ audience_judgement(-0.1)
    MARCELLO: Impressionnant, cheffe ! Vous n'avez la tête qui tourne ? #audience:laughter
    CAPUCINE: S.. si, un peu... Mets-la en veilleuse, tu veux ? #audience:laughter
    JUGE ERNEST: Ainsi en a jugé... euh la Déesse ! L'Accusé perd le duel ! #audience:booing #screenshake
    -> witness_agathe
- (victory_against_capucine) JUGE ERNEST: Nous avons un vainqueur !
    JUGE ERNEST: Après {nb_turn_against_capucine < 2: un total ridicule de | un total impressionnant de} {nb_turn_against_capucine} tour{nb_turn_against_capucine > 1:s}, c'est l'Accusé qui remporte le duel !
    JUGE ERNEST: Ainsi en a jugé... euh la Déesse ! L'Accusé remporte le duel ! #audience:ovation #screenshake
    ~ audience_judgement(0.4)
    MARCELLO : L'important, c'est de participer, cheffe ! #anim:Marcello:applause
    CAPUCINE: La ferme, tu veux ? #audience:laughter
    -> witness_agathe
    
// Duel against Marcello
= duel_against_marcello
~ temp stre_difficulty = 40
~ temp marcello_sc = 100
~ temp nb_turn_against_marcello = 1
// Les deux présentoirs sont soulevés par des câbles pour faire de la place
JUGE ERNEST: Le Juge demande aux deux duellistes de s'approcher des jurés. #anim:Judge:bell
JUGE ERNEST: Lorsque la cloche sonnera, vous devrez faire le.. euh.. des pompes ! #audience:laughter
JUGE ERNEST: Celui qui en fera le plus grand nombre remportera le défi. Tenez-vous prêts... #audience:ovation #screenshake
JUGE ERNEST: À vos marques...
JUGE ERNEST: ... prêts... #screenshake #audience:ovation
JUGE ERNEST: ... partez ! #anim:Judge:bell #screenshake #audience:ovation
- (start_duel)
    * [Faire une pompe. {t(STRE, stre_difficulty)}]
        {sc(STRE, stre_difficulty): -> round_against_marcello_S | -> defeat_against_marcello}
- (next_round_against_marcello)
    ~ nb_turn_against_marcello += 1
    JUGE ERNEST: Le témoin Marcello {tient bon lui aussi | parvient à tenir le bon bout | continue d'impressionner les jurés | tient encore le coup | réussit une nouvelle fois | parvient à tenir malgré la douleur } ! #audience:ovation
    JUGE ERNEST: C'est désormais à l'Accusé de {ne pas s'effondrer | ne pas échouer lamentablement | ne pas décevoir les jurés | faire une nouvelle fois preuve de talent | tenir encore un peu | tenir toujours un peu plus }! #audience:ovation
    + [Faire une nouvelle pompe. {t(STRE, stre_difficulty)}]
        {sc(STRE, stre_difficulty): -> round_against_marcello_S | -> defeat_against_marcello}
- (round_against_marcello_S)
    ~ stre_difficulty -= 5
    ~ marcello_sc -= 5
    JUGE ERNEST: L'Accusé {a tenu bon | a une nouvelle fois réussi | impresionne par ses talents | nous délivre une novelle fois une performance impressionnante |  semble désormais inarrêtable | réussit à nouveau }: qu'en sera t-il de notre témoin ? ({marcello_sc}% que Marcello réussisse) #audience:ovation
    {roll_ai_sc(marcello_sc): -> next_round_against_marcello | -> victory_against_marcello}
    #audience:ovation
- (defeat_against_marcello) JUGE ERNEST: Nous avons un vainqueur !
    JUGE ERNEST: Après {nb_turn_against_marcello < 2: un total ridicule de | un total impressionnant de} {nb_turn_against_marcello} pompe{nb_turn_against_marcello > 1:s}, c'est le témoin Marcello qui remporte le duel !
    MARCELLO: Vous avez vu ça, cheffe ? #anim:Marcello:happy
    CAPUCINE: J'ai vu, j'ai vu... Mets-la en, veilleuse, tu veux ? #audience:laughter
    JUGE ERNEST: Ainsi en a jugé... euh la Déesse ! L'Accusé perd le duel ! #audience:booing #screenshake
    ~ audience_judgement(-0.1)
    -> witness_agathe
- (victory_against_marcello) JUGE ERNEST: Nous avons un vainqueur !
    JUGE ERNEST: Après {nb_turn_against_marcello < 2: un total ridicule de | un total impressionnant de} {nb_turn_against_marcello} pompe{nb_turn_against_marcello > 1:s}, c'est l'Accusé qui remporte le duel !
    JUGE ERNEST: Ainsi en a jugé... euh la Déesse ! L'Accusé remporte le duel ! #audience:ovation #screenshake
    ~ audience_judgement(0.4)
    MARCELLO: L'important c'est de participer pas vrai cheffe ? #anim:Marcello:applause
    CAPUCINE : Pas du tout, abruti. #audience:laughter
    CAPUCINE: Tu viens de te faire ridiculiser par l'autre minable ! #audience:laughter
    -> witness_agathe

// The player talked about stained glass 1
= talk_about_stained_glass_1
AGATHE: J'ai évoqué avec l'Accusé l'histoire de la Déesse et des marins qui la sauvèrent de la tempête.
JUGE ERNEST: Une histoire des plus émouvantes... Qu'a t-il eu à dire à ce sujet, prêtresse ?
{
    - t_3_is_with_irene_saviors:
        AGATHE: Il fit preuve de la plus grande des xxx à l'égard des marins et du bébé, Votre Honneur. #audience:applause
            ~ audience_judgement(0.2)
    - t_3_is_against_irene_saviors:
        AGATHE: Il s'en prit aux marins, prétextant qu'ils étaient ignares d'aller sauver le bébé, en proie à la tempête. #audience:boing
        ~ audience_judgement(-0.3)
    - else:
        AGATHE: Il est resté silencieux, et m'a écouté avec respect, Votre Honneur. #audience:applause
        ~ audience_judgement(0.1)
}
- JUGE ERNEST: Ensuite, prêtresse ?
{
    - t_3_rant_about_edgar_the_traquenard: AGATHE: Ensuite, il ne cessa de mentionner un certain Edgard le Traquenard, Votre Honneur... #audience:laughter
        JUGE ERNEST: Comment dites-vous ? Edgar le Traquenard ? #audience:laughter
        AGATHE: Il semblerait, oui... Il en parlait avec des yeux fous, Votre Honneur. #audience:laughter
        JUGE ERNEST: Passons, passons...
}
- JUGE ERNEST: Avez-vous évoqué la fin de cette histoire, prêtresse ? Celle-ci est des plus attendrissantes... #audience:applause
AGATHE: Je n'ai pas manqué de le faire, Votre Honneur.
JUGE ERNEST: Bien, bien. Et quelle fut sa réaction, quand il apprit que la lumière d'un phare, au loin, sauva les marins et l'enfant ?
{
    - t_3_believe_in_lighthouse_sacred_light: AGATHE: Il en fut profondémment ému, Votre Honneur. #audience:ovation
        JUGE ERNEST: Voilà qui est tout à son honneur. #audience:applause
        ~ audience_judgement(0.2)
    - t_3_does_not_believe_in_lighthouse_sacred_light: AGATHE: Il... Il évoqua que cette histoire tenait davantage du mythe que de la réalité. #audience:choc
        JUGE ERNEST: Vraiment ? Irène en soit témoin : l'Accusé n'a aucun cœur. #audience:booing
}
- JUGE ERNEST: Votre discussion s'est-elle arrêtée là, prêtresse ?
{
    - t_3_stained_glass_2_talk:
        -> talk_about_stained_glass_2
    - t_3_stained_glass_3_talk:
        -> talk_about_stained_glass_3
    - else:
        AGATHE: Rien de plus, Votre Honneur. L'Accusé alla dormir un peu, puis fut arrêté le lendemain, à son réveil.
        -> judge_proceed_to_mention_the_leviathan
}

// The player talked about stained glass 2
= talk_about_stained_glass_2
AGATHE: L'Accusé et moi avons discuté des prédiction d'Irène, et de la manière dont elle sauva nos ancêtres...


// The player talked about stained glass 3
= talk_about_stained_glass_3
AGATHE: Le sujet que nous avons abordé après cela, Votre Honneur...
AGATHE: ... C'est vous. #audience:choc
JUGE ERNEST: Je vois... #audience:debate
JUGE ERNEST: Et qu'a eu à dire l'Accusé, au sujet du Juge ?

// The judge proceed to mention the Leviathan
= judge_proceed_to_mention_the_leviathan
JUGE ERNEST: Accusé, nous nous devons désormais d'aborder le sujet du Léviathan. #audience:debate
JUGE ERNEST: En effet, vous fûtes missioné, par la Couronne rappelons-le, de vous rendre en mer...
JUGE ERNEST: ... afin d'y terrasser le terrible Léviathan. #audience:choc
JUGE ERNEST: Avez-vous tenu parole, Accusé ? Avez-vous, oui ou non, ramené le cœur de la créature ? #audience:ovation
    * [Je l'ai fait !] PLAYER: Bien entendu, Votre Honneur ! #audience:applause
        JUGE ERNEST: Allons, allons... Nous savons que cela est faux.
    * [Bien sûr que non.] PLAYER: Non, comme vous le savez sans doute déjà. Je n'ai pu accomplir cette mission, Votre Honneur.
    * [J'ai eu un léger contretemps...] PLAYER: Votre Honneur, c'était mon souhait le plus cher, mais nous avons subi un contretemps.
        JUGE ERNEST: Un contretemps, vous dites ?
- JUGE ERNEST: Un tel sujet ne doit pas être abordé avec légèreté, Accusé...
JUGE ERNEST: Veillez raconter au jurés ainsi qu'eu Juge ce qu'il s'est passé lorsque vous avez trouvé l'emplacement indiqué par la carte.
    * [Une tempête déchirait les eaux...] PLAYER: Une terrible tempête déchirait l'océan...
    * [Je livrai une bataille contre l'océan...] PLAYER: Je livrai une véritable bataille contre l'océan...
    * [Je me démenai pour sauver mon équipage...] PLAYER: Je faisais tout ce qui était en mon pouvoir pour sauver mon équipage d'une mort certaine...
// Player va raconter la tempête (flashback)
- (tempest_flashback)
    -> tempest

// The judge proceed to mention the sireine
= judge_proceed_to_mention_the_sireine
JUGE ERNEST: Accusé, il est un sujet que nous n'avons pas encore évoqué lors de ce procès. #audience:debate
JUGE ERNEST: Ce sujet constitue pourtant le cœur de ce qu'il vous est repproché. #audience:debate
JUGE ERNEST: Je veux bien entendu parler... de l'amour impie. #audience:choc



















