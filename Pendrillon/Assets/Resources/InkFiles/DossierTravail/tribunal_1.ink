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
#sleep:5
#audience:debate
#audience:silent
// Le juge est encore seul sur scène
#scene_open_to_judge
#sleep:6
#audience:ovation
#sleep:4
- JUGE ERNEST: Silence ! Silence !
#anim:Judge:bell
#audience:silent
JUGE ERNEST: Les Portes du Tribunal se sont ouvertes pour un homme du nom de {p_name} Jehovah Banes, citoyen de plein droit de Miraterre, et descendants du peuple Sauvé. 
JUGE ERNEST: Ainsi est-il accusé, non par le règne des Hommes, mais par celui de la Déesse Irène.
JUGE ERNEST: De celle-ci nous nous ferons les yeux, les oreilles et le cœur, comme la Loi l'exige.
#audience:ovation
JUGE ERNEST: Silence ! J'exige le silence !
#anim:Judge:bell
#audience:silent
- JUGE ERNEST: L'homme est accusé, par ordre croissant de gravité... #audience:booing
- {is_accused_of("bribe guards") == true}JUGE ERNEST: ... De tentative de corruption à l'égard de représentants de l'autorité Royale... #audience:booing
    ~ audience_judgement(-0.02)
- {is_accused_of("blasphemy") == true}JUGE ERNEST: ... De blasphème... #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... De violence à l'encontre de représentants de l'autorité Royale... #audience:laugh
    ~ audience_judgement(0.05)
- {is_accused_of("sacred degradations") == true}JUGE ERNEST: ... De dégradations de biens sacrés... #audience:booing
    ~ audience_judgement(-0.02)
- {is_accused_of("crown outrage") == true}JUGE ERNEST: ... D'outrage à la Couronne... #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... D'actes hérétiques... #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- {is_accused_of("judge outrage") == true}JUGE ERNEST: ... D'outrage au Juge de droit divin, Ernest... #audience:silent #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... De Haute trahison... #audience:booing #screenshake
    ~ audience_judgement(-0.02)
- JUGE ERNEST: ... ainsi que, pour conclure...
- JUGE ERNEST: ... D'amour impie. #audience:shock #screenshake
    ~ audience_judgement(-0.1)
#sleep:4
- JUGE ERNEST: Le Juge demande désormais à l'accusé de faire son entrée.
#move(Player)
#audience:booings
#sleep:4
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

// Player va raconter la tempête (flashback)
-> tempest