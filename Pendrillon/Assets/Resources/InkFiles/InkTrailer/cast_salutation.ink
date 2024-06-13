// CAST SALUTATION SCENE

// Scene
=== cast_salutations ===
-> salutations

= salutations
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Naïda:NAÏDA
#actor:Agathe:AGATHE
#actor:Judge:JUGE ERNEST
#actor:Capucine:CAPUCINE
#actor:Marcello:MARCELLO
#actor:Arle:ARLE // Arle, toujours pendue à la corde ?
// Set the location
#set:forest // Réfléchir décors
// Set the actor's positions
#position:Player:4:2
#position:Naïda:4:3
#position:Passeur:4:4
#position:Agathe:4:5
#position:Judge:4:6
#position:Capucine:4:7
#position:Marcello:4:8
#position:Arle:4:9

// Start the scene
//#open_curtains
#audience:debate
#audience:silent
// Le juge est encore seul sur scène
#audience:ovation
#wait:5
#audience:ovation
#wait:4
- #curtains:open // Scripter l'avancée des acteurs, puis leur salut, puis recul, puis avancent à nouveau, puis dernier salut -> rideaux qui se ferment
- #audience:ovation #wait:5
- #audience:ovation #wait:5
- #curtains:close
- -> end_of_the_show

= end_of_the_show
-> END