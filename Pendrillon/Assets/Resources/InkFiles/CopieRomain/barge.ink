// BARGE SCENE


// Variables

// Scene
=== barge ===
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Passeur:PASSEUR
#actor:Prompter:SOUFFLEUR
#playsound:Play_AMB_SC_Barque_Ambiance
#playsound:Play_AMB_SC_Theater_CrowdChatter

#set:barge

#position:Player:4:1
#position:Passeur:4:3
#position:Prompter:7:5


// Start the scene
-> scene_1

// Scène 1
= scene_1
PASSEUR: Héhé, je vois, je vois... #anim:Passeur:colere 

PASSEUR: Héhé, je vois, je vois... #anim:Passeur:joie #playsound:Play_SFX_Story_JudgeBellFar
PASSEUR: Héhé, je vois, je vois... #anim:Passeur:deception


SOUFFLEUR: Permets-moi de te rafraîchir la mémoire, l'ami : « Ma mère m'a toujours dit... ». #anim:Souffleur:neutre #playsound:VOX_NPC_Souffleur_rafraichirmemoire
    * [Ma mère m'a toujours dit...] PLAYER: Ma mère m'a toujours dit... #anim:Player:neutre #playsound:VOX_Player_meretoujoursdit #playsound:Play_MUS_Story_SC_Barque_BadViolin1
- SOUFFLEUR: « ...qu'enfant, déjà, je n'étais pas très bavard. ». #anim:Passeur:neutre #playsound:VOX_Souffleur_pasbavard
    * [...qu'enfant, déjà, je n'étais pas très bavard.] PLAYER: ...qu'enfant, déjà, je n'étais pas très bavard. #audience:debate #anim:Player:neutre #playsound:VOX_Player_pasbavard #playsound:Play_MUS_Story_SC_Barque_BadViolin2
PASSEUR: Vraiment ? J'ai pourtant ouï dire qu'en matière de baratin, tu n'étais pas le dernier... #anim:Passeur:neutre #playsound:VOX_Ferryman_baratinpasdernier
SOUFFLEUR: Psssst... Hé, l'ami ! #anim:Souffleur:colere #playsound:VOX_Souffleur_pssthecolere
SOUFFLEUR: Quand je te souffle le texte, je n'y mets pas le ton... #anim:Souffleur:neutre
SOUFFLEUR: Ce n'est pas mon métier, tu piges ? #anim:Souffleur:neutre
SOUFFLEUR: Mais toi tu es acteur, pas vrai ? #anim:Souffleur:neutre
SOUFFLEUR: Alors mets-y de l'émotion, l'ami ! #anim:Souffleur:neutre
- SOUFFLEUR: Reprenons : « Il est vrai que j'ai ce talent-là, mais... ». #anim:Souffleur:deception
    * [Il est vrai que j'ai ce talent-là, mais...] PLAYER: Il est vrai que j'ai ce talent-là, mais... #anim:Player:neutre #playsound:VOX_Player_ilestvraitalent
- SOUFFLEUR: N'oublie pas d'incarner ton personnage, l'ami ! Souviens-toi : l'é-mo-tion ! #anim:Souffleur:colere
- SOUFFLEUR: « Un talent est une ressource précieuse, aussi, je l'utilise à bon escient. ». #anim:Souffleur:neutre
    * [(Avec intensité) Un talent est une ressource précieuse...] PLAYER: Un talent est une ressource précieuse, aussi je l'utilise à bon escient. #anim:Player:neutre #audience:ovation #playsound:Play_MUS_Story_SC_Barque_AGoodActor
- SOUFFLEUR: C'est exaltant, pas vrai ? #anim:Souffleur:joie
SOUFFLEUR: Le public réagit à tes répliques, mais aussi à ton jeu de scène ! Tu brûles littéralement les planches, l'ami ! #anim:Souffleur:joie #playsound:VOX_Souffleur_publicreagit
- PASSEUR: Héhé, je vois, je vois... #anim:Passeur:laugh #playsound:VOX_Ferryman_hahajevois
- PASSEUR: De toute façon, ce n'est pas auprès de moi qu'il faudra se montrer éloquent... #anim:Passeur:neutre #playsound:VOX_Ferryman_detoutefacon
SOUFFLEUR: « Je ne suis pas un homme de mauvaise compagnie. Je suis tout disposé à faire de ce voyage un moment agréable.... ». #anim:Souffleur:neutre
    * [Je ne suis pas un homme de mauvaise compagnie.] PLAYER: Je ne suis pas un homme de mauvaise compagnie. Je suis tout disposé à faire de ce voyage un moment agréable.... #anim:Player:neutre #playsound:VOX_Player_pasmauvaisecompagnie
- SOUFFLEUR: « De quoi veux-tu que l'on parle ? ». #anim:Souffleur:neutre
    * [De quoi veux-tu que l'on parle ?] PLAYER: De quoi veux-tu que l'on parle, Passeur ? #anim:Player:question
- PASSEUR: Je connais la raison de ta présence ici, mais peut-être n’est-ce pas ton cas... #anim:Passeur:neutre
PASSEUR: Commence par te présenter : qui es-tu ? #anim:Passeur:question #playsound:VOX_Ferryman_commencepresenter
#audience:debate
- SOUFFLEUR: ... #anim:Souffleur:neutre
- SOUFFLEUR: C'est là qu'on va avoir un petit problème, l'ami. #anim:Souffleur:neutre
SOUFFLEUR: Le metteur en scène de cette pièce, le célèbre Jean Ornicar... son nom te dit sans doute quelque chose... #anim:Souffleur:neutre
SOUFFLEUR: Le respectable Ornicar a quitté la troupe. En assez mauvais terme, vois-tu. #anim:Souffleur:neutre
SOUFFLEUR: Là où le bât blesse... c'est qu'il n'a jamais terminé d'écrire tes répliques. #anim:Souffleur:neutre
SOUFFLEUR: On aurait dû te prévenir avant, navré l'ami... #anim:Souffleur:neutre
SOUFFLEUR: À partir de maintenant... tu vas devoir improviser ! Bonne chance ! #anim:Player:stress
#audience:booing
- PASSEUR: Peut-être ne m'as-tu pas entendu. Je disais : qui es-tu ? #playsound:VOX_Ferryman_quiestu
    * [Je suis Merlin...] PLAYER: Je réponds au doux nom de Merlin... #anim:Player:bow #playsound:VOX_Player_Merlin #playsound:Play_MUS_Story_SC_Barque_ANewName
        ~ p_name = "Merlin"
    * [Mon nom est Ambroise...] PLAYER: Je réponds au doux nom de Ambroise... #anim:Player:bow #playsound:VOX_Player_Ambroise #playsound:Play_MUS_Story_SC_Barque_ANewName
        ~ p_name = "Ambroise"
    * [On m'appelle Octave...] PLAYER: Je réponds au doux nom de Octave... #anim:Player:bow #playsound:VOX_Player_Octave #playsound:Play_MUS_Story_SC_Barque_ANewName
        ~ p_name = "Octave"
- #audience:ovation
- PASSEUR: Désormais que je sais qui tu es, dis-moi : comment t'es-tu retrouvé ici, {p_name} ? #anim:Passeur:question
- PLAYER: Un jour où je me trouvais...
    * [À l'auberge...]
    * [Sur mon navire...]
    * [???]
- PLAYER: Un jour où je me trouvais à quai, je reçus la missive d'un expéditeur inconnu. Habituellement, une lettre de cette nature aurait fini au feu, mais un détail attira mon attention... #anim:Player:neutre #playsound:VOX_Player_unjour #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter1
    * [L'écriture.] PLAYER: La lettre était dotée d’une impeccable calligraphie. Ce détail, vois-tu, n’es pas à prendre à la légère. Une si belle écriture ne peut signifier qu’une chose : notre expéditeur est du genre fortuné. #anim:Player:neutre #playsound:VOX_Player_lalettreecriture #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter2
    * [Le destinataire.] PLAYER: La lettre était destinée à un certain {p_name} Jehovah Banes. Cette personne n’est autre que moi-même. Rien d’étonnant pourrait-on dire. Au contraire : la seule personne à m’appeler ainsi est ma mère. Or, ma mère est absolument et irrémédiablement illetrée... #anim:Player:neutre #playsound:VOX_Player_lalettredestinataire{p_name} #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter2
    * [L'odeur.] PLAYER: J’ai reçu bien des lettres dans ma vie, certaines avaient l’odeur du purin, du sel marin ou encore celle des impôts impayés, mais jamais encore n’avais-je reçu une missive à l’odeur si... délicate. L'odeur d'un expéditeur fortuné. #anim:Player:neutre #playsound:VOX_Player_lalettreodeur #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter2
- PLAYER: La lettre me donnait rendez-vous pour « une cause de la plus haute importance ». Piqué de curiosité, je décidais de me rendre à minuit au lieu du mystérieux rendez-vous : la cale de mon propre navire. #anim:Player:neutre #playsound:VOX_Player_transitionsecretmeeting #playsound:Stop_AMB_SC_Barque_Ambiance #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter3
- -> secret_meeting

// Scène 2
= scene_2
#playsound:Play_AMB_SC_Barque_Ambiance
PASSEUR: ... #anim:Passeur:neutre
PASSEUR: Pourquoi avoir accepté une mission si périlleuse ? #anim:Passeur:question #playsound:VOX_Ferryman_pourquoimission
    * [Pour la fortune !] PLAYER: Pour la fortune, évidemment ! #anim:Player:gloire #playsound:VOX_Player_pourlafortune #light:Player #playsound:Play_MUS_Story_SC_Barque_AFairReward
    * [Pour la gloire !] PLAYER: Pour la gloire, cela va sans dire ! #anim:Player:gloire #playsound:VOX_Player_pourlagloire #light:Player #playsound:Play_MUS_Story_SC_Barque_AFairReward
    * [Pour l'aventure !] PLAYER: Pour l'aventure bien entendu ! #anim:Player:gloire #playsound:VOX_Player_pourlaventure #light:Player #playsound:Play_MUS_Story_SC_Barque_AFairReward
- #audience:applause
- PASSEUR: Tout de même... De là à te confronter à une créature mythique telle que le Léviathan... #anim:Passeur:surprise #playsound:VOX_Ferryman_toutdememe
PLAYER: À dire vrai... #anim:Player:neutre
    * [Je ne crois pas au Léviathan.] PLAYER: Je ne crois pas à ces histoires à dormir debout... Je prévoyais de faire le voyage, prétendre avoir terassé le monstre et retourner à bon port, l'esprit léger. #anim:Player:neutre
        PASSEUR: Dans ton histoire, tu racontes pourtant avoir promis de ramener le cœur de la bête. #anim:Passeur:surprise
            ** [J'avais un plan.] PLAYER: Personne n'a jamais vu le Léviathan de près : un cœur de baleine aurait suffit à faire illusion... #anim:Player:neutre
            ** [Je n'avais pas pensé à ça.] PLAYER: Je suis un homme de l'improvisation. J'aurai trouvé quelque chose... #anim:Player:neutre
    * [Je rêvais le voir.] PLAYER: Je rêve de l'apercevoir, depuis petit. Ma mère me racontait des récits de marins l'ayant aperçu, au loin.  #anim:Player:neutre
        PASSEUR: N'étais-tu pas effrayé ? #anim:Passeur:question
            ** [Si, mais tout de même...] PLAYER: Seul un idiot ne le serait pas. Mais ce sont ces histoires de créatures mythiques qui ont fait de moi le marin que je suis, alors... #anim:Player:stress
            ** [Pas le moins du monde.] PLAYER: Ce sont ces histoires de créatures mythiques qui ont fait de moi le marin que je suis. J'étais prêt à prendre tous les risques... #anim:Player:neutre
- PASSEUR: Et que s'est-il passé après ? #anim:Passeur:question2 #wait:4
    * [(Pensif)] #anim:Player:thoughtful #playsound:Play_MUS_Story_SC_Barque_Undeserved
    * [(Triste)] #anim:Player:triste #playsound:Play_MUS_Story_SC_Barque_Undeserved
    * [(Courroucé)] #anim:Player:colere #playsound:Play_MUS_Story_SC_Barque_Undeserved
- PLAYER: ...
    * [(Mentir) J'ai tué le monstre.] PLAYER: J'ai trouvé le monstre à l'endroit indiqué par la carte, et je l'ai tué, avec l'aide de mon équipage. Quelle bataille avons-nous livrée ! #anim:Player:joie
    * [(Éluder la question) Rien...] PLAYER: Je me suis rendu sur place, je n'ai trouvé aucune créature, bien entendu, et je suis rentré. Fin de l'histoire. Passionnant, n'est-ce pas ? #anim:Player:neutre
- PASSEUR: Pourquoi ne pas me dire ce qu'il s'est réellement passé ? Ton âme s'en verra peut-être allégée... #anim:Passeur:neutre #playsound:VOX_Ferryman_pourquoidireverite
PLAYER: Le voyage a duré près d'une année. Puis, après moult pérpéties, nous sommes revenus... #anim:Player:neutre #playsound:VOX_Player_voyagedure1an
    * [Plus chargés que prévu.] PLAYER: ... plus chargés que prévu, disons. #playsound:VOX_Player_pluscharges #playsound:Play_MUS_Story_SC_Barque_ANewFriend
    * [Plus nombreux qu'à l'aller] PLAYER: ... plus nombreux qu'à l'aller, pour ainsi dire. #playsound:VOX_Player_plusnombreux playsound:Stop_AMB_SC_Barque_Ambiance #playsound:Play_MUS_Story_SC_Barque_ANewFriend
- -> trip_return

// Scène 3
= scene_3
#playsound:Play_AMB_SC_Barque_Ambiance
PASSEUR: Ainsi, ton amie s'est faite arrêter par les gardes... #anim:Passeur:neutre:1 #playsound:VOX_Ferryman_ainsitonami
PASSEUR: Tu es bien silencieux... Que ressentais-tu, à cet instant ? #anim:Passeur:question #playsound:VOX_Ferryman_tuesbiensilencieux
    * [(Furieux)] #anim:Player:colere #playsound:Play_MUS_Story_SC_Barque_LostAFriend
    * [(Impuissant)] #anim:Player:triste #playsound:Play_MUS_Story_SC_Barque_LostAFriend
    * [(Anéanti)] #anim:Player:triste #playsound:Play_MUS_Story_SC_Barque_LostAFriend
- PASSEUR: Ton regard suffit à m'apporter une réponse... #anim:Passeur:neutre #playsound:VOX_Ferryman_tonregard
- PASSEUR: Tu devais te sentir bien seul... Dis-moi plutôt : où t'es-tu rendu, après cela ? #anim:Passeur:question #playsound:VOX_Ferryman_tudevais
    * [Tous les gardes en avaient après moi...] PLAYER: Tous les gardes de la ville étaient à mes trousses... #anim:Player:neutre #playsound:VOX_Player_touslesgardes #playsound:Play_MUS_Story_SC_Barque_ToChurch
    * [J'ai trouvé un refuge...] PLAYER: J'ai trouvé un endroit pour passer la nuit... #anim:Player:neutre #playsound:VOX_Player_trouveunendroit #playsound:Play_MUS_Story_SC_Barque_ToChurch #playsound:Stop_AMB_SC_Barque_Ambiance
- -> church_night

// Scène 4
= scene_4
#playsound:Play_AMB_SC_Barque_Ambiance
PASSEUR: Cette prêtresse fit honneur à l'hospitalité de la Déesse... #anim:Passeur:neutre #playsound:VOX_Ferryman_pretressehonneur
    * [Tout à fait.] PLAYER: Jamais n'a t-on vu âme plus acceuillante. Cependant... #anim:Player:neutre #playsound:VOX_Player_jamaisame
    * [En un sens...] PLAYER: D'une certaine manière, j'en conviens... Mais... #anim:Player:neutre #playsound:VOX_Player_certainemaniere
    * [C'est ce que je pensais.] PLAYER: La même pensée me traversai l'esprit, alors que je m'endormais... Toutefois... #anim:Player:neutre #playsound:VOX_Player_penseetraverseesprit
- PASSEUR: Quoi donc ? #anim:Passeur:question #playsound:VOX_Ferryman_quoidonc
    * [(Colère froide)] #anim:Player:colere #playsound:Play_MUS_Story_SC_Barque_Treason
    * [(Tragique)] #anim:Player:triste #playsound:Play_MUS_Story_SC_Barque_Treason
    * [(Déception)] #anim:Player:deception #playsound:Play_MUS_Story_SC_Barque_Treason
- #audience:choc
- PASSEUR: Parle, je t'en prie. #anim:Passeur:neutre #playsound:VOX_Ferryman_parlejetenprie
- PLAYER: À mon réveil... #anim:Player:neutre #playsound:VOX_Player_amonreveil
    * [Une mauvaise surprise m'attendait.] PLAYER: ... une surprise des plus désagréables m'attendait... #anim:Player:neutre #playsound:VOX_Player_unemauvaisesurprise
    * [Je m'apprêtais à en découdre.] PLAYER: ... j'allais devoir livrer bataille... #anim:Player:neutre #playsound:VOX_Player_devoirlivrerbataille
    * [Je fus trahi.] PLAYER: ... je fus malheureux de constater qu'on m'avait trahi... #anim:Player:neutre #playsound:VOX_Player_amonreveil #playsound:Stop_AMB_SC_Barque_Ambiance
- -> church_day

// Scène 5
= scene_5
#playsound:Play_AMB_SC_Barque_Ambiance
PASSEUR: Notre voyage s'avera des plus captivants, toutefois...  #anim:Passeur:neutre #playsound:VOX_Ferryman_voyagecaptivant
PASSEUR: ... il arrive déjà à son terme, j'en ai peur. #anim:Passeur:show_door #playsound:VOX_Ferryman_voyagecaptivant2 #playsound:Play_MUS_Story_SC_Barque_TrialInView
PASSEUR: Vois-tu ces portes, devant nous ? Dans quelques instants, tu sauras si nous pouvons faire demi-tour, ensemble... #anim:Passeur:show_door #playsound:VOX_Ferryman_voistuporte
PASSEUR: ... ou si c'est ici que nos chemins se sépareront. #anim:Passeur:neutre #playsound:VOX_Ferryman_voistuporte2
    * [Que va t-il se passer ?] PLAYER: Que va t-il se passer ? Parle donc, Passeur... et ne me ménage pas. #anim:Player:stress #playsound:VOX_Player_quevapassemenagepas
        PASSEUR: Cela, je ne puis te le dire, voyageur. Je connais ton passé, mais j'ignore tout de ton destin. #anim:Passeur:neutre #playsound:VOX_Ferryman_jenepuisteledire
    * [Où mènent ces portes ?] PLAYER: Où mènent ces portes, Passeur ? #anim:Player:stress #playsound:VOX_Player_oumeneporte
        PASSEUR: Tu le sauras bientôt, ou ne le saura jamais. Attendons un instant... #anim:Passeur:neutre #playsound:VOX_Ferryman_attendons
    * [(Rester silencieux).]
- PASSEUR: Si les portes s'ouvrent, alors nous seront tenus de passer...  #anim:Passeur:neutre #playsound:VOX_Ferryman_silesportes
    * [Qui nous y oblige ?] PLAYER: Qui nous y contraint, Passeur ? #anim:Player:question  #playsound:VOX_Player_quinousycontraint
        PASSEUR: La Loi. #anim:Passeur:neutre #playsound:VOX_Ferryman_laloi
    * [Faisons demi-tour.] PLAYER: Faisons demi-tour, je t'en prie. #anim:Player:neutre #playsound:VOX_Player_faisonsdemitour
        PASSEUR: Je regrette, ce n'est pas à moi d'en décider. #anim:Passeur:neutre #playsound:VOX_Ferryman_jeregrettepasmadecision
    * [J'ai peur...] PLAYER: j'ai si peur... #anim:Player:stress #playsound:VOX_Player_jaisipeur
        PASSEUR: ... Je comprends. #anim:Passeur:neutre #playsound:VOX_Ferryman_jecomprends
- #anim:open_trial_doors #playsound:Play_MUS_Story_SC_Barque_TrialDoorsOpen
- PASSEUR: Tu vas devoir affronter ton destin. Ainsi en-ont décidé les portes, voyageur... #playsound:Stop_AMB_SC_Barque_Ambiance #playsound:VOX_Ferryman_devoiraffronterdestin #playsound:Stop_AMB_SC_Barque_Ambiance
- -> tribunal_1

= end_scene
-> END