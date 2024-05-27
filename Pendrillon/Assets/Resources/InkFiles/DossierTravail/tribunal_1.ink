// TRIBUNAL SCENE 1

// Scene
=== tribunal_1 ===
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Judge:JUGE ERNEST
-> start

= start
#open_curtains
#audience:shock
#judge_bell
#audience:debate
#audience:silent
// Le juge est encore seul sur scène
#scene_open_to_judge
#audience:ovation
- JUGE ERNEST: Silence ! Silence !
#anim:Judge:bell
#audience:silent
JUGE ERNEST: Les Portes du Tribunal se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de Miraterre, et descendant du peuple qui fut sauvé.
JUGE ERNEST: Ainsi est-il accusé, non par le règne des Hommes, mais par celui de la Déesse Irène.
JUGE ERNEST: De celle-ci nous nous ferons les yeux, les oreilles et le cœur, comme la Loi l'exige.
#audience:ovation
JUGE ERNEST: Silence ! J'exige le silence !
#anim:Judge:bell
#audience:silent
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
    - is_accused_of("judge outrage"): JUGE ERNEST: ... D'outrage au Juge de droit divin, Ernest... #audience:silent #screenshake
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
- JUGE ERNEST: Le Juge demande désormais à l'accusé de faire son entrée.
#move(Player)
#audience:booings
- JUGE ERNEST: Silence ! Silence !
#anim:Judge:bell
- JUGE ERNEST: Au nom de la Déesse, le Juge demande le silence !
#audience:silent
- JUGE ERNEST: Accusé, prenez place.
    * [Prendre place.]
        #move(Player)
    * [Protester.] PLAYER: Ce procès constitue une terrible injustice !
        #audience:debate
        ~ audience_judgement(-0.02)
        #audience:silent
        JUGE ERNEST: Silence !
        JUGE ERNEST: Accusé, vous ne pouvez vous comporter en ce lieu sacré comme vous le faites dans un vulgaire rafiot. 
        JUGE ERNEST: Ne prenez la parole que lorsque le Juge vous la donne.
            ** [Hors de question !] PLAYER: Je suis un homme libre, citoyen de plein droit de Miraterre. Je puis parler librement !
                #audience:booing
                ~ audience_judgement(-0.02)
                #anim:Judge:bell
                #audience:silent
                JUGE ERNEST: Accusé, je ne le répèterai pas deux fois : ceci est un lieu saint. Sachez rester à votre place.
                *** [Entendu.] PLAYER: C'est entendu.
                    #anim:Judge:bell
                    --- (agree_with_judge) JUGE ERNEST: Vous ai-je donné la parole ? Taisez-vous donc. Le Juge n'a nul besoin de votre assentiment.
                    ~ audience_judgement(-0.01)
                    **** [Prendre place en silence.]
                        #move(Player)
                *** [Prendre place en silence.]
                    #move(Player)
            ** [Entendu.] PLAYER: C'est entendu.
                -> agree_with_judge
            ** [Prendre place en silence.]
                #move(Player)
- JUGE ERNEST: Le Juge appelle désormais à la barre le premier témoin de ce procès : Arle.
#move(Arle)
#anim:Arle:bow_audience
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
ARLE: Je voulais simplement signifier, au profit de la Vérité ainsi que la Justice, qu'à peine notre bonne Reine Constance m'eut chargée de confier à messire ladite mission, mon cœur me fit comprendre que l'effroyable était bien loin d'être à la hauteur de la tâche. #audience:laugh #audience:applause #anim:Arle:bow
- JUGE ERNEST: J'en appelle à l'accusé : qu'avez-vous à dire pour votre défense ?
    * [On ne m'a confié aucune mission.] PLAYER: J'annonce, au jury comme à Votre Honneur, que jamais on ne me confia pareille mission. #audience:debate
        ARLE: Le gredin ment, Votre Honneur !
    * [Arle doute t-elle de notre reine ?]
    * [Je n'ai rien à objecter.]
-
// Player va raconter la tempête (flashback)
-> tempest