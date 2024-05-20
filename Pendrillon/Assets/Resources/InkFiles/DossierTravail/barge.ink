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
#sleep:10
PASSEUR: ...
#sleep:5
PASSEUR: J'ai connu des passagers plus loquaces...
#sleep:5
SOUFFLEUR: Psssst... Hé !
SOUFFLEUR: Par ici, l'ami.
SOUFFLEUR: Je ne sais pas si c'est le trac qui te paralyse, mais... c'est à ton tour de donner la réplique !
#sleep:6
#audience:booing
#sleep:2
SOUFFLEUR: Hé ! Qu'est-ce que tu fabriques ? Tu as oublier ton texte, c'est ça ?
#sleep:4
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
#sleep:4
PASSEUR: Vraiment ? J'ai pourtant ouï-dire qu'en matière de baratin, tu n'étais pas le dernier...
#sleep:5
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
#sleep:2
#anim:Passeur:laugh
- PASSEUR: Hahaha, je vois, je vois...
- PASSEUR: De toute façon, ce n'est pas auprès de moi qu'il faudra se montrer éloquent...
#sleep:3
SOUFFLEUR: « Je ne suis pas un homme de mauvaise compagnie. Je suis tout disposé à faire de ce voyage un moment agréable.... ».
    * [Je ne suis pas un homme de mauvaise compagnie.] PLAYER: Je ne suis pas un homme de mauvaise compagnie. Je suis tout disposé à faire de ce voyage un moment agréable.... #anim:Player:eloquent
- SOUFFLEUR: « De quoi veux-tu que l'on parle ? ».
    * [De quoi veux-tu que l'on parle ?] PLAYER: De quoi veux-tu que l'on parle, Passeur ? #anim:Player:question
- PASSEUR: Je connais la raison de ta présence ici, mais peut-être n’est-ce pas ton cas...
PASSEUR: Commence par te présenter : qui es-tu ?
#sleep:6
#audience:debate
- SOUFFLEUR: ...
#sleep:2
- SOUFFLEUR: C'est là qu'on va avoir un petit problème, l'ami.
SOUFFLEUR: Je pensais avoir prévu le coup, mais...
SOUFFLEUR: Je n'avais pas réalisé que ça arriverai si tôt.
SOUFFLEUR: Le metteur en scène de cette pièce, le célèbre Jean Ornicar... son nom te dit sans doute quelque chose.
SOUFFLEUR: Le respectable Ornicar a quitté la troupe. En assez mauvais termes, vois-tu.
#sleep:2
SOUFFLEUR: Là où le bât blesse... c'est qu'il n'a jamais terminé d'écrire tes répliques.
SOUFFLEUR: On aurait dû te prévenir avant, navré l'ami...
SOUFFLEUR: À partir de maintenant... tu vas devoir improviser ! Bonne chance ! #anim:Player:stress
#sleep:3
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
        ~ p_job = "explorer"
    * [... un chasseur de baleines.] PLAYER: ...un chasseur de baleines.
        ~ p_job = "hunter"
    * [... un pirate.] PLAYER: ...un pirate aux ordres de personne.
        ~ p_job = "pirate"
- #audience:ovation
- PASSEUR: Désormais que je sais qui tu es, dis-moi : comment t'es-tu retrouvé ici, {p_name} ?
- PLAYER: Un jour où je me trouvais à quai, je reçus une missive dont j’ignorais tout de l’expéditeur. Habituellement, je ne prête aucune attention à ce genre d’épistole, mais, cette fois-ci, un détail m’empêcha de la jeter directement au feu...
    * [L'écriture.] PLAYER: La lettre était dotée d’une impeccable calligraphie. Ce détail, voyez-vous, n’es pas à prendre à la légère. Une si belle écriture ne peut signifier qu’une chose : votre expéditeur est du genre fortuné.
    * [Le destinataire.] PLAYER: La lettre était destiné à un certain {p_name} Jehovah Banes. Cette personne n’est autre que moi-même. Rien d’étonnant me direz-vous. Détrompez-vous : la seule personne à m’appeler ainsi est ma mère. Or, ma mère est absolument et irrémédiablement illétrée...
    * [L'odeur.] PLAYER: J’ai reçu bien des lettres dans ma vie, certaines avaient l’odeur du purin, du sel marin ou encore celle des impôts impayés, mais jamais encore n’avais-je reçu une missive à l’odeur si... délicate. L'odeur d'un expéditeur fortuné.
- PLAYER: La lettre, d'un expéditeur inconnu, me donnait rendez-vous pour « une cause de la plus haute importance ». Piqué de curiosité, je décidais de me rendre à minuit au lieu du mystérieux rendez-vous : la cale de mon propre navire.
- -> end_scene

= end_scene
-> END