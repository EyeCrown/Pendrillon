// INTRO SCENE

// Scene
=== intro ===
-> archetype_choice

= archetype_choice
#intro
// Define the actors of the scene
#actor:Player:PLAYER:VOYAGEUR
// Set the location
#set:barge
// Set the actor's positions
#position:Player:4:1
#position:Passeur:4:3

// Audience reaction
#playsound:Play_AMB_SC_Theater_CrowdChatter
#playsound:Play_MUS_Story_SC_Barque_Intro
//#anim:Player:kneeling
//#look:Player:Passeur
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3

// Start the scene
- (choose_archetype) Choisissez votre archétype.
    L'archétype influence la répartition de vos statistiques.
    + [Beau Parleur] #audience:applause
        Le <shake>Beau Parleur</shake> sait manier les mots et faire preuve de charisme.
        Voulez-vous incarner le rôle d'un <shake>Beau Parleur</shake> ?
        ++ [À bien y réfléchir...]
            -> choose_archetype
        ++ [Je veux incarner un blablateur !] #audience:ovation
            ~ p_archetype = "Beau Parleur"
    + [Force de la Nature] #audience:applause
        La <shake>Force de la Nature</shake> sait manier les poings et faire trembler ses détracteurs.
        Voulez-vous incarner le rôle d'une <shake>Force de la Nature</shake> ?
        ++ [Peut-être pas...]
            -> choose_archetype
        ++ [Je veux incarner une brute !] #audience:ovation
            ~ p_archetype = "Force de la Nature"
    + [Acrobate] #audience:applause
        L'<shake>Acrobate</shake> sait se montrer agile et faire preuve d'adresse.
        Voulez-vous incarner le rôle d'un <shake>Acrobate</shake> ?
        ++ [J'hésite encore...]
            -> choose_archetype
        ++ [Je veux incarner un athlète !] #audience:ovation
            ~ p_archetype = "Acrobate"
- -> barge