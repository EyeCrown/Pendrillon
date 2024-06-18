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
#position:Arle:4:3
#position:Judge:4:5
#position:Player:4:7
#position:Naïda:4:8

// Le juge est encore seul sur scène
#playsound:Play_MUS_Story_SC_Trial_Conclusion
#playsound:Play_CrowdReaction_applauseinfinite
// Start the scene
- #wait:5
- #audience:ovation
- #wait:5
- #audience:ovation
- #wait:4
- #playsound:Play_CrowdReaction_applauseinfinite
- #curtains:open #wait:5 #audience:ovation #wait:2 #audience:ovation #wait:3 #audience:ovation #wait:1
- #audience:ovation
- #wait:10
- #anim:Passeur:bow #anim:Player:bow #anim:Naïda:bow #anim:Judge:bow #anim:Arle:bow
//- #curtains:close
- #audience:ovation #wait:5
- -> end_of_the_show

= end_of_the_show
-> END