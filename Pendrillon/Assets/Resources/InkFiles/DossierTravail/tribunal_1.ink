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
#audience:discussion
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
- {is_accused_of("blasphemy") == true}JUGE ERNEST: ... De blasphème... #audience:booing #screenshake
- JUGE ERNEST: ... De violence à l'encontre de représentants de l'autorité Royale... #audience:laugh
- {is_accused_of("sacred degradations") == true}JUGE ERNEST: ... De dégradations de biens sacrés... #audience:booing
- {is_accused_of("crown outrage") == true}JUGE ERNEST: ... D'outrage à la Couronne... #audience:booing #screenshake
- JUGE ERNEST: ... D'actes hérétiques... #audience:booing #screenshake
- {is_accused_of("judge outrage") == true}JUGE ERNEST: ... D'outrage au Juge de droit divin, Ernest... #audience:silent #screenshake
- JUGE ERNEST: ... De Haute trahison... #audience:booing #screenshake
- JUGE ERNEST: ... ainsi que, pour conclure... 
- JUGE ERNEST: ... D'amour impie. #audience:shock #screenshake
#sleep:4
- JUGE ERNEST: Je demande désormais à l'accusé de faire son entrée.
#move(Player)
#audience:booings
#sleep:4
- JUGE ERNEST: Silence ! Silence !
#anim:Judge:bell
- JUGE ERNEST: Au nom de la Déesse, je demande le silence !
#audience:silent

// Player va raconter la tempête (flashback)
-> tempest