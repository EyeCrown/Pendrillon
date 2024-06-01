// TRIBUNAL SCENE 1

// Variables
VAR accuse_alre_to_disrespect_queen = false
VAR admit_disrespect_queen = false
VAR arle_lied = false

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
#set:trial
// Set the actor's positions
#position:Player:4:2
#position:Judge:0:0
#position:Arle:0:0
#position:Capucine:0:0
#position:JudMarcelloge:0:0
#position:Agathe:0:0
#position:Naïda:0:0

// Start the scene
#open_curtains
#audience:shock
#judge_bell
#audience:debate
#audience:silent
// Le juge est encore seul sur scène
#scene_open_to_judge
#audience:ovation
- JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell
JUGE ERNEST: Les Portes du Tribunal se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de Miraterre, et descendant du peuple qui fut sauvé.
JUGE ERNEST: Ainsi est-il accusé, non par le règne des Hommes, mais par celui de la Déesse Irène.
JUGE ERNEST: De celle-ci nous nous ferons les yeux, les oreilles et le cœur, comme la Loi l'exige. #audience:ovation
JUGE ERNEST: Silence ! J'exige le silence ! #anim:Judge:bell #audience:silent
- JUGE ERNEST: L'homme est accusé, par ordre croissant de gravité... #audience:booing
{
    - is_accused_of("bribe guards"): JUGE ERNEST: ... De tentative de corruption à l'égard de représentants de l'autorité Royale... #audience:booing
        ~ audience_judgement(-0.02)
}
{
    - is_accused_of("blasphemy"): JUGE ERNEST: ... De blasphème... #audience:booing #screenshake
        ~ audience_judgement(-0.02)
}
- JUGE ERNEST: ... De violence à l'encontre de représentants de l'autorité Royale... #audience:laugh
    ~ audience_judgement(0.05)
{
    - is_accused_of("sacred degradations"): JUGE ERNEST: ... De dégradations de biens sacrés... #audience:booing
    ~ audience_judgement(-0.02)
}
{
    - is_accused_of("crown outrage"): JUGE ERNEST: ... D'outrage à la Couronne... #audience:booing #screenshake
        ~ audience_judgement(-0.02)
}
{
    - is_accused_of("judge outrage"): JUGE ERNEST: ... D'outrage au Juge de droit divin, Ernest... #audience:choc #sreenshake
        ~ audience_judgement(-0.02)
}
- {is_accused_of("crown outrage") == true}JUGE ERNEST: ... D'outrage à la Couronne... #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... D'actes hérétiques... #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... De Haute trahison... #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... ainsi que, pour conclure...
- JUGE ERNEST: ... D'amour impie. #audience:shock #screenshake
    ~ audience_judgement(-0.1)
- JUGE ERNEST: Le Juge demande désormais à l'accusé de faire son entrée. #move(Player) #audience:booings
- JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell
- JUGE ERNEST: Au nom de la Déesse, le Juge demande le silence !
- JUGE ERNEST: Accusé, prenez place.
    * [Prendre place.] #move(Player)
    * [Protester.] PLAYER: Ce procès constitue une terrible injustice ! #audience:debate
        ~ audience_judgement(-0.02)
        JUGE ERNEST: Silence !
        JUGE ERNEST: Accusé, vous ne pouvez vous comporter en ce lieu sacré comme vous le faites dans un vulgaire rafiot. 
        JUGE ERNEST: Ne prenez la parole que lorsque le Juge vous la donne.
            ** [Hors de question !] PLAYER: Je suis un homme libre, citoyen de plein droit de Miraterre. Je puis parler librement ! #audience:booing #anim:Judge:bell
                ~ audience_judgement(-0.02)
                JUGE ERNEST: Accusé, je ne le répèterai pas deux fois : ceci est un lieu saint. Sachez rester à votre place.
                *** [Entendu.] PLAYER: C'est entendu. #anim:Judge:bell
                    --- (agree_with_judge) JUGE ERNEST: Vous ai-je donné la parole ? Taisez-vous donc. Le Juge n'a nul besoin de votre assentiment.
                    ~ audience_judgement(-0.01)
                    **** [Prendre place en silence.] #move(Player)
                *** [Prendre place en silence.] #move(Player)
            ** [Entendu.] PLAYER: C'est entendu.
                -> agree_with_judge
            ** [Prendre place en silence.] #move(Player)
    * [Mon nom est {p_name}, pas Accusé.] PLAYER: Mon nom est {p_name} et non Accusé, votre Honneur.
SOUFFLEUR: Psssst... Hé, l’ami ! J’ai l’impression que tu vas passer un sale quart d’heure...
SOUFFLEUR: Il semblerait que les choix que tu as fait durant toute la pièce vont te retomber dessus l’un après l’autre !
SOUFLLEUR: Mais tu as peut-être encore une chance de t’en sortir, si tu parviens à obtenir l’approbation du public !
SOUFFLEUR: N'oublie pas : c'est le public que tu dois convaincre, pas le Juge ! Bonne chance, l’ami !
- JUGE ERNEST: Le Juge appelle désormais à la barre le premier témoin de ce procès : Arle. #anim:Judge:bell #move(Arle) #anim:Arle:bow
- JUGE ERNEST: Décrivez au jury votre rencontre avec l'accusé, je vous prie.
ARLE: Votre Honneur, vous n'êtes pas sans ignorer que j'ai l'immense privilège d'occuper, au sein de la Couronne, un rôle de tout premier plan...
JUGE ERNEST: Poursuivez, je vous prie. #anim:Arle:bow
ARLE: J'aime à penser que je suis, pour ce rôle, une actrice à la hauteur.
JUGE ERNEST: Veuillez ne pas vous répandre en détails inutiles. #audience:laugh #anim:Arle:sad1
ARLE: ...
ARLE: Je disais, donc, que sa Majesté Constance m'a chargée de transmettre à messire le scélérat 
une mission de la plus haute importance.
    * [Scélérat toi même.] PLAYER: Scélérat toi même, crétine ! #audience:laugh
        ~ audience_judgement(0.01)
        JUGE ERNEST: Silence ! Le Juge egige le silence ! #anim:Judge:bell
        JUGE ERNEST: Ce procès n'est pas une fanfaronnade ! Membres du jury, soyez dignes de la tâche qui vous incombe !
        JUGE ERNEST: Quant à vous, cessez d'objecter quand la parole ne vous a pas été donnée par le Juge en personne !
        ~ audience_judgement(-0.02)
        JUGE ERNEST: Témoin, vous mentionniez une mission confiée à l'accusé par la Couronne.
    * [Rester silencieux.]
JUGE ERNEST: Précisez quelle était la nature de cette mision, je vous prie. #anim:Arle:bow
ARLE: La mission que la reine Constance me fit l'honneur de transmettre à messire l'infâme accusé, était de tuer le Léviathan, et d'en ramener l'organe vital.
ARLE: Je veux bien entendu parler de son cœur, Votre Honneur. #audience:laugh #anim:Judge:bell
JUGE ERNEST: Bien, bien... Est-ce tout ?
ARLE: Puis-ajouter une dernière chose, Votre Honneur ?
JUGE ERNEST: Soyez brève. #anim:Arle:bow
ARLE: Entendez bien que mon ambition, Votre Honneur, n'est point de prêter à mon image plus d'éloges qu'elle n'en mérite.
JUGE ERNEST: Bon, bon... Concluez.
ARLE: Je voulais simplement signifier, au profit de la Vérité ainsi que la Justice, qu'à peine notre bonne reine Constance m'eut chargée de confier à messire ladite mission, mon cœur me fit comprendre que l'effroyable était bien loin d'être à la hauteur de la tâche. #audience:laugh #audience:applause #anim:Arle:bow 
    ~ audience_judgement(-0.01)
- JUGE ERNEST: J'en appelle à l'accusé : qu'avez-vous à dire pour votre défense ?
    * [On ne m'a confié aucune mission.] PLAYER: J'annonce, au jury comme à Votre Honneur, que jamais on ne me confia pareille mission. #audience:debate
        ARLE: Le gredin ment, Votre Honneur ! #audience:debate
        JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell
        JUGE ERNEST: Ce tribunal est le lieu auprès duquel la lumière de la Vérité ne saurait produire nulle ombre.
        JUGE ERNEST: Cessez de parler, car désormais, c'est la Vérité elle-même qui va prendre la parole.
        JUGE ERNEST: La Vérité sort de la bouche du Juge. #audience:ovation #anim:Juge:mask
        {
            - t_1_accept_mission_with_positivity: JUGE ERNEST: « Cela serait pour moi un véritable honneur. J'accepte de ramener le cœur du Léviathan. ».
                ~ audience_judgement(-0.1)
            - t_1_accept_mission_with_negativity: JUGE ERNEST: « Puisque je n'ai point le loisir de me soustraire à la tâche... J'accepte de ramener le cœur du Léviathan. ».
                ~ audience_judgement(-0.1)
        }
    * [Arle doute t-elle de notre reine ?] PLAYER: Je crois, Votre Honneur, et mesdames et messieurs les jurés, qu'Arle a trahit son manque de respect pour la reine Constance. #audience:debate
        ~ accuse_alre_to_disrespect_queen = true
        ARLE: Objection ! L'immonde messire raconte des balivernes !
        JUGE ERNEST: Silence, témoin ! Jee ne vous ai pas donné la parole ! #anim:Juge:bell #anim:Arle:sad
        JUGE ERNEST: Pouvez-vous en avancer la preuve, Accusé ?
            * [En me désavouant, elle désavoue la reine.] PLAYER: Certainement. En prétextant savoir que je n'étais pas à la hauteur de la tâche...
                PLAYER: ... Arle a sous-entendu que la reine avait fait preuve de bêtise en me désignant. #audience:choc #audience:debate
                JUGE ERNEST: L'accusé a raison sur ce point. #anim:Juge:bell #audience:applause #anim:Arle:angry
                ~ audience_judgement(0.05)
            * [Je retire mon accusation.] PLAYER: J'en suis malheuresement incapable, Votre Honneur. Je retire mon accusation. #audience:booing #anim:Arle:laugh
                ~ audience_judgement(-0.02)
    * [Je n'ai rien à objecter.] PLAYER: Je n'ai rien à objecter, Votre Honneur. #audience:booing #anim:Judge:bell
        ~ audience_judgement(-0.01)
- JUGE ERNEST: Passons à la suite, voulez-vous ? #anim:Juge:bell
JUGE ENRNEST: Témoin, avez-vous autre chose à ajouter ?
ARLE: Bien entendu, Votre Honneur. {accuse_alre_to_disrespect_queen: L'affreux Messire m'a accusé de manquer de respect à notre reine, mais celui-ci l'a tout bonnement humilié. | Je voudrais témoigner du fait que l'affreux Messire a humilié notre reine.} #audience:choc #anim:Judge:bell
JUGE ENRNEST: Poursivez, je vous prie.
ARLE: Le terrible Messire a cru bon de se moquer de la reine en faisant un bon mot, Votre Honneur.
    * [C'est faux !] PLAYER: Votre Honneur, elle ment ! #audience:debate
        JUGE ERNEST: Silence ! Ne vous ai-je pas déjà dit que vous n'avez aucun droit de prendre la parole quand bon vous semble, Accusé ? #anim:Judge:bell #audience:booing
        ~ audience_judgement(-0.02)
    * [Je l'avoue, Votre Honneur...] PLAYER: J'ai honte d'admettre qu'elle dit la vérité, votre Honneur... #audience:booing
        JUGE ERNEST: Silence ! Ne vous ai-je pas déjà dit que vous n'avez aucun droit de prendre la parole quand bon vous semble, Accusé ? #anim:Judge:bell #audience:booing
        ~ audience_judgement(-0.02)
        ~ admit_disrespect_queen = true
    * [Ne rien dire.]
{
    - admit_disrespect_queen: JUGE ERNEST: Puisque l'Accusé a admit avoir prononcé ces terribles paroles... Je demande au témoin de poursuivre. -> arle_accuse_player_to_disrespect_irene
    - else: JUGE ERNEST: Quelles paroles exactes témoignez-vous avoir entendu l'Accusé prononcer ?
        ARLE: L'abjecte Messire a dit, je cite : « Constance et son inconstance m'inspirent l'indifférence. ». #audience:choc
        JUGE ERNEST: Accusé, qu'avez-vous à dire pour votre défense ?
            * [J'admets avoir dit cela.] PLAYER: J'ai le regret d'admettre avoir fait ce jeu de mot, Votre Honneur... #audience:booing #anim:Judge:bell
                JUGE ERNEST: Ainsi avouez-vous avoir manqué de respect à la reine. #anim:Judge:bell
                ~ audience_judgement(-0.05)
                -> arle_accuse_player_to_disrespect_irene
            * [Je n'ai rien dit de tel.] PLAYER: Votre Honneur, mesdames et messieurs les jurés, je jure n'avoir rien dit de tel. #audience:debate
                ARLE: Menteur ! Menteur !
                JUGE ERNEST: Silence ! Par Irène, je demande le silence !
                JUGE ERNEST: La vérité sort de la bouche du Juge.
                {
                    - t_1_respect_the_crown: JUGE ERNEST: « Je braverai tous les dangers pour notre bonne reine ! ». #audience:ovation #anim:Arle:angry #anim:Player:bow
                        JUGE ERNEST: Témoin, que le Juge ne vous reprenne plus à mentir lors d'un procès divin. #anim:Arle:stressed #audience:booing
                        ~ audience_judgement(0.1)
                        ~ arle_lied = true
                    - t_1_disrespect_the_crown: JUGE ERNEST: « Constance et son inconstance m'inspirent l'indifférence. ». #audience:booing #anim:Player:stressed #anim:Arle:bow
                        ~ audience_judgement(-0.1)
                }
                -> arle_accuse_player_to_disrespect_irene
}
- (arle_accuse_player_to_disrespect_irene) JUGE ERNEST: Passons à la suite, voulez-vous ? #anim:Judge:bell
JUGE ERNEST: Témoin, avez-vous d'autres accusations à faire ? {arle_lied: Tâchez de ne plus inventer des faits.}
ARLE: J'en ai peur...
ARLE: Votre Honneur, il est en effet un ultime acte duquel je dois témoigner...
ARLE: Celui-ci va choquer nos chers jurés, j'en ai peur... #audience:debate
    JUGE ERNEST: Alors, alors. La Vérité ne saurait souffir d'une quelconque censure. Poursuivez, je vous prie. #anim:Arle:bow
// Player va raconter la tempête (flashback)
-> tempest



















