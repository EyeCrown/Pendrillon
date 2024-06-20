// INTRO SCENE

// Scene
=== intro ===
-> archetype_choice

= archetype_choice
#set:empty
#intro
// Define the actors of the scene
#actor:Player:PLAYER:VOYAGEUR
// Set the location
#position:Player:16:10

// Audience reaction
#playsound:Play_AMB_SC_Theater_CrowdChatter

// Start the scene
- (choose_archetype) Choisissez votre archétype.
    L'archétype influence la répartition de vos statistiques.
    + [Beau Parleur]
        Le <shake a=0.5>Beau Parleur</shake> sait manier les mots et faire preuve de charisme. #anim:Player:charisma_archetype
        Voulez-vous incarner le rôle d'un <shake>Beau Parleur</shake> ?
        ++ [À bien y réfléchir...]
            -> choose_archetype
        ++ [Je veux incarner un blablateur !]
            ~ select_archetype("Beau Parleur")
    + [Force de la Nature]
        La <shake a=0.5>Force de la Nature</shake> sait manier les poings et faire trembler ses détracteurs. #anim:Player:strength_archetype
        Voulez-vous incarner le rôle d'une <shake>Force de la Nature</shake> ?
        ++ [Peut-être pas...]
            -> choose_archetype
        ++ [Je veux incarner une brute !]
            ~ select_archetype("Force de la Nature")
    + [Acrobate]
        L'<shake a=0.5>Acrobate</shake> sait se montrer agile et faire preuve d'adresse. #anim:Player:dexterity_archetype
        Voulez-vous incarner le rôle d'un <shake>Acrobate</shake> ?
        ++ [J'hésite encore...]
            -> choose_archetype
        ++ [Je veux incarner un athlète !]
            ~ select_archetype("Acrobate")
- #wait:1 #rope:Player
- -> barge