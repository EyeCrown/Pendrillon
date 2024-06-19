// CHURCH NIGHT SCENE


// Variables
VAR claim_to_be_free = false
VAR irene_torch_is_on = false

// Scene
=== church_night ===
-> start

= start
// Define the actors
#actor:Player:PLAYER
#actor:Agathe:UNE VOIX:PRÊTRESSE AGATHE:AGATHE:PRÊTRESSE
// Set the location
#set:church_night
// Set the actor's positions
#position:Player:8:9
#position:Agathe:4:5
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3
- PLAYER: <bounce a=0.05><b>(Au Passeur)</b></bounce> L'église d'<b>Irène</b>...
PLAYER: Une prêtresse du nom d'<b>Agathe</b> m'offrit l'hospitalité.
PLAYER: Je pus <b>passer la nuit</b> en ce lieu saint, cependant...
    -> barge.scene_5