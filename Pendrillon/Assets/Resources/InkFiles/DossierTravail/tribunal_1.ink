// TRIBUNAL SCENE 1

// Variables
VAR arle_patience = 5
VAR accuse_alre_to_disrespect_queen = false
VAR admit_disrespect_queen = false
VAR arle_lied = false
VAR arle_lied_again = false
VAR arle_left_the_play = false

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
- (arle_witness) JUGE ERNEST: Le Juge appelle désormais à la barre le premier témoin de ce procès : Arle, la trublionne de la reine  Constance. #anim:Judge:bell #move(Arle) #anim:Arle:bow #audience:applause
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
    * [(Se moquer) Toi, une bonne actrice ?] PLAYER: Toi, une bonne actrice ? En voilà une nouvelle à ressuciter les noyés ! #audience:laughter anim:Arle:angry
        ~ audience_judgement(0.05)
        ARLE: Tu vas te taire, oui ?! #anim:Arle:angry
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent
        JUGE ERNEST: Accusé, cessez d'interrompre le témoin ! Quant à vous...
    * [Se taire.]
- JUGE ERNEST: Veuillez ne pas vous répandre en détails inutiles. #audience:laughter #anim:Arle:sad1
ARLE: ... Hmfrr...
ARLE: Je disais, donc, que sa Majesté Constance m'a chargée de transmettre à messire le scélérat une mission de la plus haute importance.
    * [Jouer correctement la comédie ?] PLAYER: Si la mission était de jouer correctement, permets-moi de te dire que c'est un échec... #audience:laughter anim:Arle:angry
        ~ audience_judgement(0.05)
        {make_arle_angry(): -> arle_leaves_stage}
        JUGE ERNEST: Silence ! Le Juge exige le silence ! #anim:Judge:bell #audience:silent
        JUGE ERNEST: Ce procès n'est pas une fanfaronnade ! Membres du jury, soyez dignes de la tâche qui vous incombe !
        JUGE ERNEST: Quant à vous, cessez d'objecter quand la parole ne vous a pas été donnée par le Juge en personne !
        JUGE ERNEST: Témoin, vous mentionniez une mission confiée à l'accusé par la Couronne.
    * [Rester silencieux.]
- JUGE ERNEST: Précisez quelle était la nature de cette mision, je vous prie. #anim:Arle:bow
ARLE: La mission que la reine Constance me fit l'honneur de transmettre à messire l'infâme accusé, était de tuer le Léviathan, et d'en ramener l'organe vital.
ARLE: Je veux bien entendu parler de son cœur, Votre Honneur. #audience:laughter #anim:Judge:bell
JUGE ERNEST: Bien, bien... Est-ce tout ?
ARLE: Puis-ajouter une dernière chose, Votre Honneur ?
    * [(En priant) Irène, pitié, faites-la taire.] PLAYER: Ô Irène, ayez pitié de nous, pauvres humains ! Ô, je vous en conjure : faites la taire ! #audience:laughter anim:Arle:angry
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
- (witnesses_capucine_and_marcello) JUGE ERNEST: Capucine dite « {capucine_surname} », accompagnée de Marcello, alias « {marcello_surname} ».
CAPUCINE: Votre Honneur, avec tout mon respect... J'apprécierais d'être nommée simplement Capucine. #anim:Capucine:angry
JUGE ERNEST: Bon, non... Je tâcherais d'y penser. #anim:Capucine:bow
MARCELLO: Votre Horreur, moi aussi je voudrais être nommé Capucine... Euh... je veux dire Marcello, Vot' Horreur. #audience:laughter
CAPUCINE: Ferme-la, tu veux ? N'en demande pas trop à Son Honneur.
CAPUCINE: Votre Honneur, veuillez excuser cet fieffé personnage. Sa place est dans une taverne... ou même une étable. #audience:laughter
CAPUCINE: ... Pas dans un tel lieu. #anim:Capucine:bow #audience:applause
JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent
JUGE ERNEST: Veuillez raconter aux jurés votre rencontre avec l'accusé. Et soyez brefs, voulez-vous ?
CAPUCINE: Je vous remercie, Votre Honneur. #anim:Capucine:bow
CAPUCINE: Vous n'êtes pas sans savoir, Votre Honneur, que tout navire qui arrive à Miraterre doit être fouillé par des gardes de la Couronne.
CAPUCINE: Aussi mon camarade et moi avons-nous pénétré sur le rafiot du vil personnage pour y faire notre inspection.
MARCELLO: J'avais entendu du bruit dans la cale, vot' Horreur. #audience:laughter
CAPUCINE: Ferme-là, tu veux ? C'est à moi de raconter.
CAPUCINE: Mon camarade a effectivement entendu du bruit, et j'ai eu l'idée d'aller voir de plus près.
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
        ** [Le droit de la Lame.] PLAYER: ... le droit de la Lame, Votre Honneur. #audience:choc
        ** [Le droit de la Larve.] PLAYER: ... le droit de la Larve, Votre Honneur. #audience:laughter
            JUGE ERNEST: Sans doute l'Accusé fait-il référence au droit de la Lame ? #audience:debate
- JUGE ERNEST: Bien, bien... Le Juge rappelle aux jurés que le droit de la Lame consiste à défier, en duel, son opposant lors d'un procès.
JUGE ERNEST: C'est une vieille loi, qui n'a plus été invoquée depuis des décénnies, mais soit...
JUGE ERNEST: Lequel des deux témoins voulez-vous défier ?
    * [Défier Capucine.]
    * [Défier Marcello.]
    
// Player va raconter la tempête (flashback)
-> tempest

// Arle leaves stage
= arle_leaves_stage
JUGE ERNEST: ... #audience:laughter
JUGE ERNEST: Euh... Silence ?
JUGE ERNEST: Je... J'appelle à la barre notre second témoin. Nos second et troisième témoins, pour être exact.
    -> witnesses_capucine_and_marcello













