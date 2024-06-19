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
#set:empty
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
- SOUFFLEUR: Je vous demande de faire un <shake a=0.5><b>triomphe</b></shake> pour la <b>Troupe des Noyés</b> ! #audience:ovation
SOUFFLEUR: Dans le rôle de celui qui ne quitte jamais sa pagaie, le <b>Passeur</b> : <shake a=0.5><b>Nathaël Berthier</b></shake> ! #anim:Passeur:bow #audience:ovation
SOUFFLEUR: Dans le rôle de la garde <b>Capucine</b>, dite {capucine_surname} : <shake a=0.5><b>Mélanie Tomorrow</b></shake> ! #audience:ovation #anim:Capucine:bow #audience:ovation
SOUFFLEUR: Dans le rôle de son sbire <b>Marcello</b>, alias {marcello_surname} : <shake a=0.5><b>Bastien Belvaux</b></shake> ! #audience:ovation #anim:Marcello:bow #audience:ovation
{
    - arle_leaves_the_stage:
        SOUFFLEUR: Dans le rôle de la trublionne de la reine... euh... <b>Arle</b> : <shake a=0.5><b>Betty Desmier</b></shake> ! #audience:booing
    - else:
        SOUFFLEUR: Dans le rôle de la trublionne de la reine, <b>Arle</b> : <shake a=0.5><b>Betty Desmier</b></shake> ! #audience:ovation
}
- SOUFFLEUR: Dans le rôle de la prêtresse <b>Agathe</b> : <shake a=0.5><b>Marie Noelle Terracol</b></shake> ! #audience:ovation #anim:Agathe:bow #audience:ovation
SOUFFLEUR: Dans le rôle du <b>Juge Ernest</b> : <shake a=0.5><b>Cyrille Divry</b></shake> ! #audience:ovation #anim:Judge:bow #audience:ovation
SOUFFLEUR: Dans le rôle de la Sireine <b>Naïda</b> : <shake a=0.5><b>Leïla Larrodé</b></shake> ! #audience:ovation #anim:Naïda:bow #audience:ovation
SOUFFLEUR: Dans celui de votre serviteur, le <b>souffleur</b> : <shake a=0.5><b>Gweltaz Lavanan</b></shake> ! #audience:ovation
SOUFFLEUR: Et enfin...
SOUFFLEUR: ... Pour sa <b>première fois</b> sur les planches...
SOUFFLEUR: Dans le rôle du fameux <b>{p_name}</b> : la voix de <shake a=0.5><b>Antonin Leuret</b></shake> et le jeu d'acteur du <shake a=0.5><b>joueur</b></shake> !#anim:Player:bow #audience:ovation
- SOUFFLEUR: Mais un spectacle ne serait rien sans les <b>petites mains</b> derrière la scène...
SOUFFLEUR: Je parle du <b>staff technique</b>, sans qui ce spectacle n'aurait pu avoir lieu...
SOUFFLEUR: Dans le rôle du <b>sound designer</b> : <shake a=0.5><b>Romain Belet</b></shake> ! #audience:ovation
SOUFFLEUR: Dans le rôle du <b>game artist</b> : <shake a=0.5><b>Victorien Prévot</b></shake> ! #audience:ovation
SOUFFLEUR: Dans le rôle de l'<b>UX/UI designer</b> : <shake a=0.5><b>Lud.e Chatin</b></shake> ! #audience:ovation
SOUFFLEUR: Dans le rôle du <b>programmeur</b> : <shake a=0.5><b>Théo(phile) Carrasco</b></shake> ! #audience:ovation
SOUFFLEUR: Et dans le rôle du <b>game & narrative designer</b> : <shake a=0.5><b>Maxence Martiniani</b></shake> ! #audience:ovation
SOUFFLEUR: Merci pour votre accueil, <b>cher public</b> ! À la prochaine !
- #curtains:close #audience:ovation #playsound:Play_CrowdReaction_stopapplauseinfinite #wait:5
- -> end_of_the_show

= end_of_the_show
-> END