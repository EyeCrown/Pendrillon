// CAST SALUTATION SCENE

// Scene
=== cast_salutation ===
-> salutation

= salutation
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Naïda:NAÏDA
#actor:Agathe:AGATHE
#actor:Judge:JUGE ERNEST
#actor:Capucine:CAPUCINE
#actor:Marcello:MARCELLO
#actor:Arle:ARLE // Arle, toujours pendue à la corde ?
// Set the location
//#set:trial
// Set the actor's positions
#position:Passeur:4:2
#position:Naïda:4:3
#position:Player:4:4
#position:Judge:4:6
#position:Agathe:4:8
#position:Capucine:4:9
#position:Marcello:4:10
#position:Arle:4:11

// Le juge est encore seul sur scène
#playsound:Play_MUS_Story_SC_Trial_Conclusion
// Start the scene
- #wait:5
- #audience:ovation
- #wait:5
- #audience:ovation
- #wait:4
- #curtains:open #wait:5 #audience:ovation #wait:2 #audience:ovation #wait:3 #audience:ovation #wait:1
- #audience:ovation
- #wait:10
- #anim:Player:bow #anim:Naïda:bow #anim:Agathe:bow #anim:Judge:bow #anim:Capucine:bow #anim:Marcello:bow #anim:Arle:bow 
//- #curtains:close
- #audience:ovation #wait:5
- -> end_of_the_show

= end_of_the_show
-> END