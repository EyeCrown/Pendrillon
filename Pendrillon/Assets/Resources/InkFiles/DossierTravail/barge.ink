// BARGE SCENE


// Variables

// Scene
=== barge ===
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Passeur:PASSEUR
#actor:Prompter:SOUFFLEUR
// Start the scene
-> scene_1

// Scène 1
= scene_1
#sleep:10
PASSEUR: ... #anim:Passeur:neutre1
#sleep:5
PASSEUR: J'ai connu des passagers plus loquaces... #anim:Passeur:neutre2 #playsound:VOX_Ferryman_passagersloquaces
#sleep:5
SOUFFLEUR: Psssst... Hé ! #anim:neutre2 #playsound:VOX_Souffleur_pssthe
SOUFFLEUR: Par ici, l'ami. #anim:Souffleur:wavehand #playsound:VOX_Souffleur_parici
SOUFFLEUR: Je ne sais pas si c'est le trac qui te paralyse, mais... c'est à ton tour de donner la réplique ! #anim:Souffleur:neutre2 #playsound:VOX_Souffleur_tracparalyse
#sleep:6
#audience:booing
#sleep:2
SOUFFLEUR: Hé ! Qu'est-ce que tu fabriques ? Tu as oublier ton texte, c'est ça ? #anim:Souffleur:neutre2 #playsound:VOX_Souffleur_oublietexeteQ
#sleep:4
SOUFFLEUR: Permets-moi de te rafraîchir la mémoire, l'ami : « Ma mère m'a toujours dit... ». #anim:Souffleur:neutre1 #playsound:VOX_NPC_Souffleur_rafraichirmemoire
    * [Ma mère m'a toujours dit...] PLAYER: Ma mère m'a toujours dit... #anim:Player:neutre1 #playsound:VOX_Player_meretoujoursdit
- SOUFFLEUR: « ...qu'enfant, déjà, je n'étais pas très bavard. ». #anim:Passeur:neutre1 #playsound:VOX_Souffleur_pasbavard
    * [...qu'enfant, déjà, je n'étais pas très bavard.] PLAYER: ...qu'enfant, déjà, je n'étais pas très bavard. #audience:debate #anim:Player:neutre1 #playsound:VOX_Player_pasbavard
- SOUFFLEUR: Psssst... Hé, l'ami ! #anim:Souffleur:colere2 #playsound:VOX_Souffleur_pssthecolere
SOUFFLEUR: Quand je te souffle le texte, je n'y met pas le ton... #anim:Souffleur:neutre1
SOUFFLEUR: Ce n'est pas mon métier, tu piges ? Après tout je ne suis pas acteur... #anim:Souffleur:neutre2
SOUFFLEUR: Alors que toi, si, pas vrai ? #anim:Souffleur:neutre1
SOUFFLEUR: Si l'on en croit ton CV... #anim:Souffleur:neutre1
SOUFFLEUR: Alors met-y de l'émotion, l'ami ! #anim:Souffleur:neutre2
#sleep:4
PASSEUR: Vraiment ? J'ai pourtant ouï-dire qu'en matière de baratin, tu n'étais pas le dernier... #anim:Passeur:neutre2 #playsound:VOX_Ferryman_baratinpasdernier
#sleep:5
SOUFFLEUR : Ah, pardon, j'en oublie mes devoirs : « Il est vrai... ». #anim:Souffleur:neutre2 #playsound:VOX_Souffleur_pardondevoirs
    * [Ah, pardon, j'en oublie mes devoirs...] PLAYER: Ah, pardon, j'en oublie mes devoirs... #anim:Player:neutre2 #playsound:VOX_Player_pardondevoirs #anim:Passeur:tristesse2 #audience:booing
- SOUFFLEUR: Hé ! Ne répète pas bêtement tout ce que je dis, l'ami. Le public se rend bien compte que quelque chose cloche... #anim:Souffleur:deception3
SOUFFLEUR: Reprenons : « Il est vrai que j'ai ce talent-là, mais... ». #anim:Souffleur:deception1
    * [Il est vrai que j'ai ce talent-là, mais...] PLAYER: Il est vrai que j'ai ce talent-là, mais... #anim:Player:neutre1 #playsound:VOX_Player_ilestvraitalent
- SOUFFLEUR: N'oublie pas d'incarner ton personnage, l'ami ! Souviens-toi : l'é-mo-tion ! #anim:Souffleur:colere2
- SOUFFLEUR: « Un talent est une ressource précieuse, aussi je l'utilise à bon escient. ». #anim:Souffleur:neutre1
    * [(Avec intensité) Un talent est une ressource précieuse...] PLAYER: Un talent est une ressource précieuse, aussi je l'utilise à bon escient. #anim:Player:neutre3 #audience:ovation
- SOUFFLEUR: C'est exaltant, pas vrai ? #anim:Souffleur:joie2
SOUFFLEUR: Le public réagit à tes répliques, mais aussi à ton jeu de scène ! Tu brûles littéralement les planches, l'ami ! #anim:Souffleu:joie3 #playsound:VOX_Souffleur_publicreagit
#sleep:2
- PASSEUR: Hahaha, je vois, je vois... #anim:Passeur:laugh #playsound:VOX_Ferryman_hahajevois
- PASSEUR: De toute façon, ce n'est pas auprès de moi qu'il faudra se montrer éloquent... #anim:Passeur:neutre2 #playsound:VOX_Ferryman_detoutefacon
#sleep:3
SOUFFLEUR: « Je ne suis pas un homme de mauvaise compagnie. Je suis tout disposé à faire de ce voyage un moment agréable.... ». #anim:Souffleur:neutre2
    * [Je ne suis pas un homme de mauvaise compagnie.] PLAYER: Je ne suis pas un homme de mauvaise compagnie. Je suis tout disposé à faire de ce voyage un moment agréable.... #anim:Player:neutre3 #playsound:VOX_Player_pasmauvaisecompagnie
- SOUFFLEUR: « De quoi veux-tu que l'on parle ? ». #anim:Souffleur:neutre1
    * [De quoi veux-tu que l'on parle ?] PLAYER: De quoi veux-tu que l'on parle, Passeur ? #anim:Player:question1
- PASSEUR: Je connais la raison de ta présence ici, mais peut-être n’est-ce pas ton cas... #anim:Passeur:neutre3
PASSEUR: Commence par te présenter : qui es-tu ? #anim:Passeur:question1 #playsound:VOX_Ferryman_commencepresenter
#sleep:6
#audience:debate
- SOUFFLEUR: ... #anim:Souffleur:neutre1
#sleep:2
- SOUFFLEUR: C'est là qu'on va avoir un petit problème, l'ami. #anim:Souffleur:neutre1
SOUFFLEUR: Le metteur en scène de cette pièce, le célèbre Jean Ornicar... son nom te dit sans doute quelque chose. #anim:Souffleur:neutre2
SOUFFLEUR: Le respectable Ornicar a quitté la troupe. En assez mauvais termes, vois-tu. #anim:Souffleur:neutre1
#sleep:2
SOUFFLEUR: Là où le bât blesse... c'est qu'il n'a jamais terminé d'écrire tes répliques. #anim:Souffleur:neutre2
SOUFFLEUR: On aurait dû te prévenir avant, navré l'ami... #anim:Souffleur:neutre1
SOUFFLEUR: À partir de maintenant... tu vas devoir improviser ! Bonne chance ! #anim:Player:stress3
#sleep:3
#audience:booing
- PASSEUR: Peut-être ne m'as-tu pas entendu. Je disais : qui es-tu ? #playsound:VOX_Ferryman_quiestu
    * [Je suis Merlin...] PLAYER: Je réponds au doux nom de Merlin... #anim:Player:bow #playsound:VOX_Player_Merlin
        ~ p_name = "Merlin"
    * [Mon nom est Ambroise...] PLAYER: Je réponds au doux nom de Ambroise... #anim:Player:bow #playsound:VOX_Player_Ambroise
        ~ p_name = "Ambroise"
    * [On m'appelle Octave...] PLAYER: Je réponds au doux nom de Octave... #anim:Player:bow #playsound:VOX_Player_Octave
        ~ p_name = "Octave"
- #audience:ovation
- PASSEUR: Désormais que je sais qui tu es, dis-moi : comment t'es-tu retrouvé ici, {p_name} ? #anim:Passeur:question1
- PLAYER: Un jour où je me trouvais à quai, je reçus la missive d'un expéditeur inconnu. Habituellement, une lettre de cette nature finit au feu, mais un détail attira mon attention... #anim:Player:neutre3 #playsound:VOX_Player_unjour
    * [L'écriture.] PLAYER: La lettre était dotée d’une impeccable calligraphie. Ce détail, vois-tu, n’es pas à prendre à la légère. Une si belle écriture ne peut signifier qu’une chose : notre expéditeur est du genre fortuné. #anim:Player:neutre3 #playsound:VOX_Player_lalettreecriture
    * [Le destinataire.] PLAYER: La lettre était destiné à un certain {p_name} Jehovah Banes. Cette personne n’est autre que moi-même. Rien d’étonnant pourrait-on dire. Au contraire : la seule personne à m’appeler ainsi est ma mère. Or, ma mère est absolument et irrémédiablement illétrée... #anim:Player:neutre3 #playsound:VOX_Player_lalettredestinataire{p_name}
    * [L'odeur.] PLAYER: J’ai reçu bien des lettres dans ma vie, certaines avaient l’odeur du purin, du sel marin ou encore celle des impôts impayés, mais jamais encore n’avais-je reçu une missive à l’odeur si... délicate. L'odeur d'un expéditeur fortuné. #anim:Player:neutre3 #playsound:VOX_Player_lalettreodeur
- PLAYER: La lettre me donnait rendez-vous pour « une cause de la plus haute importance ». Piqué de curiosité, je décidais de me rendre à minuit au lieu du mystérieux rendez-vous : la cale de mon propre navire. #anim:Player:neutre2 #playsound:VOX_Player_transitionsecretmeeting
- -> secret_meeting

// Scène 2
= scene_2
#sleep:5
PASSEUR: ... #anim:Passeur:neutre1
#sleep:3
PASSEUR: Pourquoi avoir accepté une mission si périlleuse ? #anim:Passeur:question1 #playsound:VOX_Ferryman_pourquoimission
    * [Pour la fortune !] PLAYER: Pour la fortune, évidemment ! #anim:Player:gloire #playsound:VOX_Player_pourlafortune #light:Player 
    * [Pour la gloire !] PLAYER: Pour la gloire, cela va sans dire ! #anim:Player:gloire #playsound:VOX_Player_pourlagloire #light:Player
    * [Pour l'aventure !] PLAYER: Pour l'aventure bien entendu ! #anim:Player:gloire #playsound:VOX_Player_pourlaventure #light:Player
- #audience:applause
- PASSEUR: Tout de même... De là à te confronter à une créature mythique telle que le Léviathan... #anim:Passeur:surprise2 #playsound:VOX_Ferryman_toutdememe
PLAYER: À dire vrai... #anim:Player:neutre1
    * [Je ne crois pas au Léviathan.] PLAYER: Je ne crois pas à ces histoires à dormir debout... Je prévoyais de faire le voyage, prétendre avoir terassé le monstre et retourner à bon port, l'esprit léger. #anim:Player:neutre2
        PASSEUR: Dans ton histoire, tu racontes pourtant avoir promis de ramener le cœur de la bête. #anim:Passeur:surprise1
            ** [J'avais un plan.] PLAYER: Personne n'a jamais vu le Léviathan de près : un cœur de baleine aurait suffit à faire illusion... #anim:Player:neutre2
            ** [Je n'avais pas pensé à ça.] PLAYER: Je suis un homme de l'improvisation. J'aurai trouvé quelque chose... #anim:Player:neutre2
    * [Je rêvais le voir.] PLAYER: Je rêve de l'apercevoir, depuis petit. Ma mère me racontait des récits de marins l'ayant aperçu, au loin.  #anim:Player:neutre2
        PASSEUR: N'étais-tu pas effrayé ? #anim:Passeur:question1
            ** [Si, mais tout de même...] PLAYER: Seul un idiot ne le serait pas. Mais ce sont ces histoires de créatures mythiques qui ont fait de moi le marin que je suis, alors... #anim:Player:stress1
            ** [Pas le moins du monde.] PLAYER: Ce sont ces histoires de créatures mythiques qui ont fait de moi le marin que je suis. J'étais prêt à prendre tous les risques... #anim:Player:neutre3
- PASSEUR: Et que s'est-il passé après ? #anim:Passeur:question2 #wait:4
    * [(Pensif)] #anim:Player:thoughtful
    * [(Triste)] #anim:Player:triste3
    * [(Courroucé)] #anim:Player:colere2
- PLAYER: ...
    * [(Mentir) J'ai tué le monstre.] PLAYER: J'ai trouvé le monstre à l'endroit indiqué par la carte, et je l'ai tué, avec l'aide de mon équipage. Quelle bataille avons-nous livrée ! #anim:Player:joie2
    * [(Éluder la question) Rien...] PLAYER: Je me suis rendu sur place, je n'ai trouvé aucune créature, bien entendu, et je suis rentré. Fin de l'histoire. Passionnant, n'est-ce pas ? #anim:Player:neutre1
- #sleep:4
- PASSEUR: Pourquoi ne pas me dire ce qu'il s'est réellement passé ? Ton âme s'en verra peut-être allégée... #anim:Passeur:neutre2 #playsound:VOX_Ferryman_pourquoidireverite
PLAYER: Le voyage a duré près d'une année. Puis, après moult pérpéties, nous sommes revenus... #anim:Player:neutre2 #playsound:VOX_Player_voyagedure1an
    * [Plus chargés que prévu.] PLAYER: ... plus chargés que prévu, disons. #playsound:VOX_Player_pluscharges
    * [Plus nombreux qu'à l'aller] PLAYER: ... plus nombreux qu'à l'aller, pour ainsi dire. #playsound:VOX_Player_plusnombreux
#sleep:5
- -> trip_return

// Scène 3
= scene_3
#sleep:5
PASSEUR: Ainsi, ton amie s'est faite arrêter par les gardes... #anim:Passeur:neutre:1 #playsound:VOX_Ferryman_ainsitonami
#sleep:5
PASSEUR: Tu es bien silencieux... Que ressentais-tu, à cet instant ? #anim:Passeur:question1 #playsound:VOX_Ferryman_tuesbiensilencieux
    * [(Furieux)] #anim:Player:colere3
    * [(Impuissant)] #anim:Player:triste3
    * [(Anéanti)] #anim:Player:triste3
- #sleep:4
- PASSEUR: Ton regard suffit à m'apporter une réponse... #anim:Passeur:neutre1 #playsound:VOX_Ferryman_tonregard
- #sleep:5
- PASSEUR: Tu devais te sentir bien seul... Dis-moi plutôt : où t'es-tu rendu, après cela ? #anim:Passeur:question #playsound:VOX_Ferryman_tudevais
    * [Tous les gardes en avaient après moi...] PLAYER: Tous les gardes de la ville étaient à mes trousses... #anim:Player:neutre3 #playsound:VOX_Player_touslesgardes
    * [J'ai trouvé un refuge...] PLAYER: J'ai trouvé un endroit pour passer la nuit... #anim:Player:neutre3 #playsound:VOX_Player_trouveunendroit
- -> church_night

// Scène 4
= scene_4
#sleep:5
PASSEUR: Cette prêtresse fit honneur à l'hospitalité de la Déesse... #anim:Passeur:neutre1 #playsound:VOX_Ferryman_pretressehonneur
    * [Tout à fait.] PLAYER: Jamais n'a t-on vu âme plus acceuillante. Cependant... #anim:Player:neutre2 #playsound:VOX_Player_jamaisame
    * [En un sens...] PLAYER: D'une certaine manière, j'en conviens... Mais... #anim:Player:neutre2 #playsound:VOX_Player_certainemaniere
    * [C'est ce que je pensais.] PLAYER: La même pensée me traversai l'esprit, alors que je m'endormais... Toutefois... #anim:Player:neutre2 #playsound:VOX_Player_penseetraverseesprit
- PASSEUR: Quoi donc ? #anim:Passeur:question1 #playsound:VOX_Ferryman_quoidonc
    * [(Colère froide)] #anim:Player:colere3
    * [(Tragique)] #anim:Player:triste3
    * [(Déception)] #anim:Player:deception2
- #audience:choc
- PASSEUR: Parle, je t'en prie. #anim:Passeur:neutre2 #playsound:VOX_Ferryman_parlejetenprie
- PLAYER: À mon réveil... #anim:Player:neutre2 #playsound:VOX_Player_amonreveil
    * [Une mauvaise surprise m'attendait.] PLAYER: ... une surprise des plus désagréables m'attendait... #anim:Player:neutre2 #playsound:VOX_Player_unemauvaisesurprise
    * [Je m'apprêtais à en découdre.] PLAYER: ... j'allais devoir livrer bataille... #anim:Player:neutre2 #playsound:VOX_Player_devoirlivrerbataille
    * [Je fus trahi.] PLAYER: ... je fus malheureux de constater qu'on m'avait trahi... #anim:Player:neutre2 #playsound:VOX_Player_amonreveil
- -> church_day

// Scène 5
= scene_5
#sleep:10
PASSEUR: Notre voyage s'avera des plus captivants, toutefois...  #anim:Passeur:neutre1 #playsound:VOX_Ferryman_voyagecaptivant
#sleep:2
PASSEUR: ... il arrive déjà à son terme, j'en ai peur. #anim:Passeur:show_door #playsound:VOX_Ferryman_voyagecaptivant2
#sleep:3
PASSEUR: Vois-tu ces portes, devant nous ? Dans quelques instants, tu sauras si nous pouvons faire demi-tour, ensemble... #anim:Passeur:show_door #playsound:VOX_Ferryman_voistuporte
PASSEUR: ... ou si c'est ici que nos chemins se sépareront. #anim:Passeur:neutre2 #playsound:VOX_Ferryman_voistuporte2
    * [Que va t-il se passer ?] PLAYER: Que va t-il se passer ? Parle donc, Passeur... et ne me ménage pas. #anim:Player:stress2 #playsound:VOX_Player_quevapassemenagepas
        PASSEUR: Cela, je ne puis te le dire, voyageur. Je connais ton passé, mais j'ignore tout de ton destin. #anim:Passeur:neutre1 #playsound:VOX_Ferryman_jenepuisteledire
    * [Où mènent ces portes ?] PLAYER: Où mènent ces portes, Passeur ? #anim:Player:stress2 #playsound:VOX_Player_oumeneporte
        PASSEUR: Tu le sauras bientôt, ou ne le saura jamais. Attendons un instant... #anim:Passeur:neutre1 #playsound:VOX_Ferryman_attendons
    * [(Rester silencieux).] #sleep:2
- PASSEUR: Si les portes s'ouvrent, alors nous seront tenus de passer...  #anim:Passeur:neutre2 #playsound:VOX_Ferryman_silesportes
    * [Qui nous y oblige ?] PLAYER: Qui nous y contraint, Passeur ? #anim:Player:question1  #playsound:VOX_Player_quinousycontraint
        PASSEUR: La Loi. #anim:Passeur:neutre1 #playsound:VOX_Ferryman_laloi
    * [Faisons demi-tour.] PLAYER: Faisons demi-tour, je t'en prie. #anim:Player:neutre3 #playsound_VOX_Player_faisonsdemitour
        PASSEUR: Je regrette, ce n'est pas à moi d'en décider. #anim:Passeur:neutre2 #playsound:VOX_Ferryman_jeregrettepasmadecision
    * [J'ai peur...] PLAYER: j'ai si peur... #anim:Player:stress3 #playsound:VOX_Player_jaisipeur
        PASSEUR: ... Je comprends. #anim:Passeur:neutre1 #playsound:VOX_Ferryman_jecomprends
- #sleep:5
- #anim:open_trial_doors
- #sleep:5
- PASSEUR: Tu vas devoir affronter ton destin. Ainsi en-ont décidé les portes, voyageur...
- -> tribunal_1

= end_scene
-> END