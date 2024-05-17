// BARGE SCENE


// Variables

// Scene
=== barge ===
// Define the actors of the scene
#actor:PLAYER:Player:PLAYER
#actor:Passeur:PASSEUR
#actor:Prompter:SOUFFLEUR
// Start the scene
-> scene_1

// Scène 1
= scene_1
#wait:10
PASSEUR: ...
PASSEUR : Texte de test. #anim:Passeur:laugh #after #wait:5
PASSEUR: J'ai connu des passagers plus loquaces... #wait:5
SOUFFLEUR: Psssst... Hé !
SOUFFLEUR: Par ici, l'ami.
SOUFFLEUR: Je ne sais pas si c'est le trac qui te paralyse, mais... c'est à ton tour de donner la réplique ! #anim:Souffleur:cool #wait:5 #playsound:son
SOUFFLEUR: Tu as oublier ton texte, c'est ça ? #wait:66 #anim
#sleep:36
SOUFFLEUR: Permets-moi de te rafraîchir la mémoire, l'ami : « Ma mère m'a toujours dit... ».
    * [Ma mère m'a toujours dit...] PLAYER: Ma mère m'a toujours dit...
- SOUFFLEUR: « ...qu'enfant, déjà, je n'étais pas très bavard. ».
    * [...qu'enfant, déjà, je n'étais pas très bavard.] PLAYER: ...qu'enfant, déjà, je n'étais pas très bavard. #audience:neutral 
- SOUFFLEUR: Psssst... Hé, l'ami !
SOUFFLEUR: Quand je te souffle le texte, je n'y met pas le ton...
SOUFFLEUR: Ce n'est pas mon métier, tu piges ? Après tout je ne suis pas acteur...
SOUFFLEUR: Alors que toi, si, pas vrai ?
SOUFFLEUR: Si l'on en croit ton CV...
SOUFFLEUR: Alors met-y de l'émotion, l'ami !
#wait:4
PASSEUR: Vraiment ? J'ai pourtant ouï-dire qu'en matière de baratin, tu n'étais pas le dernier...
#wait:5
SOUFFLEUR : Ah, pardon, j'en oublie mes devoirs : « Il est vrai... ».
    * [Ah, pardon, j'en oublie mes devoirs...] PLAYER: Ah, pardon, j'en oublie mes devoirs... #anim:Passeur:disappointed #audience:booings
- SOUFFLEUR: Hé ! Ne répète pas bêtement tout ce que je dis, l'ami. Le public se rend bien compte que quelque chose cloche...
SOUFFLEUR: Reprenons : « Il est vrai que j'ai ce talent-là, mais... ».
    * [Il est vrai que j'ai ce talent-là, mais...] PLAYER: Il est vrai que j'ai ce talent-là, mais...
- SOUFFLEUR: N'oublie pas d'incarner ton personnage, l'ami ! Souviens-toi : l'é-mo-tion !
- SOUFFLEUR: « Un talent est une ressource précieuse, aussi je l'utilise à bon escient. ».
    * [(Avec intensité) Un talent est une ressource précieuse...] PLAYER: Un talent est une ressource précieuse, aussi je l'utilise à bon escient. #anim:Player:charisma #audience:ovation
- SOUFFLEUR: C'est exaltant, pas vrai ?
SOUFFLEUR: Le public réagit à tes répliques, mais aussi à ton jeu de scène ! Tu brûles littéralement les planches, l'ami !
#wait:2
#anim:Passeur:laugh
- PASSEUR: Hahaha, je vois, je vois...
- PASSEUR: De toute façon, ce n'est pas auprès de moi qu'il faudra se montrer éloquent...
#wait:3
SOUFFLEUR: « Je ne suis pas un homme de mauvaise compagnie. Je suis tout disposé à faire de ce voyage un moment agréable.... ».
    * [Je ne suis pas un homme de mauvaise compagnie.] PLAYER: Je ne suis pas un homme de mauvaise compagnie. Je suis tout disposé à faire de ce voyage un moment agréable.... #anim:Player:eloquent
- SOUFFLEUR: « Que veux-tu savoir, Passeur ? ».
    * [Que veux-tu savoir, Passeur ?] PLAYER: Que veux-tu savoir, Passeur ? #anim:Player:question
- PASSEUR: Je connais la raison de ta présence ici, mais peut-être n’est-ce pas ton cas...
PASSEUR: Commence par te présenter : qui es-tu ?
#wait:6
#audience:debate
- SOUFFLEUR: ...
#wait:2
- SOUFFLEUR: C'est là qu'on va avoir un petit problème, l'ami.
SOUFFLEUR: Je pensais avoir prévu le coup, mais...
SOUFFLEUR: Je n'avais pas réalisé que ça arriverai si tôt.
SOUFFLEUR: Le metteur en scène de cette pièce, vois-tu... Le célèbre Jean Ornicar... son nom te dit sans doute quelque chose.
SOUFFLEUR: Le respectable Ornicar a quitté la troupe. Et en assez mauvais termes, tu comprends ?
#wait:2
SOUFFLEUR: Là où le bât blesse... c'est qu'il n'a jamais terminé d'écrire tes répliques.
SOUFFLEUR: On aurait dû te prévenir avant, je suis navré...
SOUFFLEUR: Quoi qu'il en soit, à partir de maintenant... tu vas devoir improviser ! Bonne chance, l'ami !
#wait:3
#audience:booing
#playsound:throat_clearing
- PASSEUR: Peut-être ne m'as-tu pas entendu. Je disais : qui es-tu ?
    * [Je suis Merlin...] PLAYER: Je répond au doux nom de Merlin... #anim:Player:bow
        ~ p_name = "Merlin"
    * [Mon nom est Ambroise...] PLAYER: Je répond au doux nom de Ambroise... #anim:Player:bow
        ~ p_name = "Ambroise"
    * [On m'appelle Octave...] PLAYER: Je répond au doux nom de Octave... #anim:Player:bow
        ~ p_name = "Octave"
- #audience:applause
    * [... un explorateur.] PLAYER: ...un explorateur au service de la Couronne.
    * [... un chasseur de baleines.] PLAYER: ...un chasseur de baleines.
    * [... un pirate.] PLAYER: ...un pirate aux ordres de personne.
- #audience:ovation
- -> end_scene

= end_scene
-> END