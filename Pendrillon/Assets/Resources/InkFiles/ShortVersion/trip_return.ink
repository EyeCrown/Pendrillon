// TRIP RETURN SCENE


// Variables
VAR sireine_is_hidden = false // If the sireine is hidden or not
VAR sireine_hideout = "none" // The sireine hideout
VAR weapon_on_hand = true // If the player's weapon is on hand or not
VAR has_bone = false // Can be found in the back crate
VAR has_coconut = false // Can be found in the front crate
VAR player_is_stinky = false // Player is stinky if he searches through the back crate
VAR player_is_hidden = false // Define if the player is hidden or not
VAR player_won_battle = false // Define if the player won the battle or not

// Scene
=== trip_return ===
-> start

= start
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Naïda:PERSONNAGE MASQUÉ
#actor:Marcello:MARCELLO
#actor:Capucine:CAPUCINE
// Set the location
#set:cale
// Set the actor's positions
#position:Player:11:3
#position:Naïda:Naïda:-2:10
#position:Marcello:11:7
#position:Capucine:9:9
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:2

// Start the scene
#playsound:Play_MUS_Story_SC_TripReturn_Intro
- PLAYER: <bounce a=0.05><b>(Au Passeur)</b></bounce> Comme tu le sais, mon amie n'avait <b>aucun droit</b> de se trouver à <b>Miraterre</b>. #audience:hush
PLAYER: Sa seule présence enfreignait une <shake a=0.5><b>Loi Capitale</b></shake>. #trial
- PLAYER: Pour <b>échapper aux gardes</b>, mon amie <b>se cacha</b> dans une des caisses de la cale de mon navire. #audience:debate
PLAYER: Cependant... quand les gardes fouillèrent le bateau, ils <b>la trouvèrent</b> et <b>l'emmenèrent</b>. #audience:empathy
    -> barge.scene_4