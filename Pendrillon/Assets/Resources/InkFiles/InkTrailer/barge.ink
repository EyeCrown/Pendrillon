// BARGE SCENE


// Variables

// Scene
=== barge ===
-> scene_1

// Scène 1
= scene_1
// Define the actors of the scene
#actor:Player:PLAYER:VOYAGEUR
#actor:Passeur:PASSEUR
// Set the location
#set:barge
// Set the actor's positions
#position:Player:4:1
#position:Passeur:4:3

// Audience reaction
//#playsound:Play_AMB_SC_Theater_CrowdChatter
//#playsound:Play_MUS_Story_SC_Barque_Intro
//#anim:Player:kneeling
//#look:Player:Passeur
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:5
//- #playsound:Play_SFX_Story_JudgeBellFarTrial #screenshake #audience:choc

// Start the scene
- #wait:10
- rien #wait:1000
- SOUFFLEUR: Je sais ce que tu penses, l'ami... 
SOUFFLEUR: <b>La pièce</b> prend des tournures particulièrement <shake a=0.5><b>sombres</b></shake>... #playsound:VOX_Souffleur_lapieceprendtournuresombre
SOUFFLEUR: Mais ainsi sont fait nos mythes, pas vrai ? #playsound:VOX_Souffleur_mythes
SOUFFLEUR: Le moment risque d'être difficile pour le personnage de Naïda. Elle saura rester digne, ne t'en fais pas ! #playsound:VOX_Souffleur_difficilenaida
SOUFFLEUR: Quand à toi, essaye de la défendre du mieux que tu le peux auprès du Juge, mais surtout du public ! #playsound:VOX_Souffleur_essaiededefendre
SOUFFLEUR: Fais de ton mieux, entendu ? Bon courage, l'ami ! #playsound:VOX_Souffleur_faisdetonmieux
- SOUFFLEUR: Psssst... Hé ! #playsound:VOX_Souffleur_pssthe
SOUFFLEUR: La pièce prend des tournures particulièrement sombres... #anim:Souffleur:wavehand #playsound:VOX_Souffleur_parici
SOUFFLEUR: Je ne sais pas si c'est le trac qui te paralyse, mais... c'est à ton tour de donner la réplique ! #playsound:VOX_Souffleur_tracparalyse
- SOUFFLEUR: Hé, qu'est-ce que tu fabriques ? Tu as oublié ton texte, c'est ça ? #playsound:VOX_Souffleur_oublietexete 
- PASSEUR:  
- SOUFFLEUR: Hé, qu'est-ce que tu fabriques ? Tu as oublié ton texte, c'est ça ? #playsound:VOX_Souffleur_oublietexete 
- PASSEUR: Eh, bien... #playsound:VOX_Ferryman_ehbien
PASSEUR: J'ai connu des passagers plus loquaces... #playsound:VOX_Ferryman_passagersloquaces #box #audience:applause
    * [(Rester silencieux)]
- PASSEUR: *Hum hum* #anim:Passeur:clear_voice #playsound:VOX_Ferryman_humhum
- PASSEUR: J'ai dit : « J'ai connu des passagers plus loquaces... ». #box #audience:debate #playsound:VOX_Ferryman_jaidit
- SOUFFLEUR: Psssst... Hé ! #playsound:VOX_Souffleur_pssthe
SOUFFLEUR: Par ici, l'ami. #anim:Souffleur:wavehand #playsound:VOX_Souffleur_parici
SOUFFLEUR: Je ne sais pas si c'est le trac qui te paralyse, mais... c'est à ton tour de donner la réplique ! #playsound:VOX_Souffleur_tracparalyse
    * [(Rester silencieux)]
- #sleep:1 #audience:booing
- SOUFFLEUR: Hé, qu'est-ce que tu fabriques ? Tu as oublié ton texte, c'est ça ? #wait:2 #playsound:VOX_Souffleur_oublietexeteQ
SOUFFLEUR: Permets-moi de te rafraîchir la mémoire, l'ami. #playsound:VOX_NPC_Souffleur_rafraichirmemoire
SOUFFLEUR: « Ma mère m'a toujours dit... ».
    * [Ma mère m'a toujours dit...] PLAYER: Ma mère m'a toujours dit... #anim:Player:talk #playsound:VOX_Player_meretoujoursdit #playsound:Play_MUS_Story_SC_Barque_BadViolin1 #audience:applause
- SOUFFLEUR: « ... qu'enfant, déjà, je n'étais pas très bavard. ». #playsound:VOX_Souffleur_pasbavard
    * [... qu'enfant, déjà, je n'étais pas très bavard.] PLAYER: ... qu'enfant, déjà, je n'étais pas très bavard. #playsound:VOX_Player_pasbavard #playsound:Play_MUS_Story_SC_Barque_BadViolin2 #audience:applause
PASSEUR: Vraiment ? J'ai pourtant ouï-dire qu'en matière de baratin, tu n'étais pas le dernier... #playsound:VOX_Ferryman_baratinpasdernier #audience:applause
SOUFFLEUR: Psssst... Hé, l'ami ! #anim:Souffleur:angry #playsound:VOX_Souffleur_pssthecolere
SOUFFLEUR: Quand je te souffle le texte, je n'y mets pas le ton...
SOUFFLEUR: Ce n'est pas mon métier, tu piges ?
SOUFFLEUR: Mais toi, tu es acteur, pas vrai ?
SOUFFLEUR: Alors mets-y de l'émotion, l'ami !
- SOUFFLEUR: Reprenons : « Il est vrai que j'ai ce talent-là, mais... ». #anim:Souffleur:deception
    * [Il est vrai que j'ai ce talent-là, mais...] PLAYER: Il est vrai que j'ai ce talent-là, mais... #playsound:VOX_Player_ilestvraitalent
- SOUFFLEUR: N'oublie pas d'incarner ton personnage, l'ami ! Souviens-toi : l'é-mo-tion ! #anim:Souffleur:angry
- SOUFFLEUR: « Un talent est une ressource précieuse, aussi, je l'utilise à bon escient. ».
    * [(Avec intensité) Un talent est une ressource précieuse...] PLAYER: Un talent est une ressource précieuse, aussi je l'utilise à bon escient. #wait:1 #audience:ovation #playsound:Play_MUS_Story_SC_Barque_AGoodActor
- PASSEUR: Héhé, je vois, je vois... #anim:Passeur:laugh #playsound:VOX_Ferryman_hahajevois
- PASSEUR: Tu sais, voyageur, ce n'est pas auprès de moi qu'il faudra se montrer éloquent. #playsound:VOX_Ferryman_detoutefacon #audience:ovation
- SOUFFLEUR: C'est exaltant, pas vrai ? #anim:Souffleur:happy
SOUFFLEUR: Le public réagit à tes répliques, mais aussi à ton jeu de scène ! Tu brûles littéralement les planches, l'ami ! #anim:Souffleur:happy #playsound:VOX_Souffleur_publicreagit
SOUFFLEUR: Poursuivons : « Je ne suis pas un homme de mauvaise compagnie. ».
    * [Je ne suis pas un homme de mauvaise compagnie.] PLAYER: Je ne suis pas un homme de mauvaise compagnie. #playsound:VOX_Player_pasmauvaisecompagnie
- SOUFFLEUR: « De quoi souhaites-tu que l'on parle, Passeur ? ».
    * [De quoi souhaites-tu que l'on parle, Passeur ?] PLAYER: De quoi souhaites-tu que l'on parle, Passeur ? #anim:Player:question
- PASSEUR: Commence par te présenter : qui es-tu ? #anim:Passeur:question #playsound:VOX_Ferryman_commencepresenter
#audience:debate
- SOUFFLEUR: Aïe ! C'est là qu'on va avoir un petit problème, l'ami.
SOUFFLEUR: Le metteur en scène de cette pièce, le célèbre Jean Ornicar... son nom te dit sans doute quelque chose...
SOUFFLEUR: Le respectable Ornicar a quitté la troupe. En assez mauvais termes, vois-tu.
SOUFFLEUR: Là où le bât blesse... c'est qu'il n'a jamais terminé d'écrire tes répliques.
SOUFFLEUR: On aurait dû te prévenir avant, navré l'ami...
SOUFFLEUR: À partir de maintenant... tu vas devoir improviser ! Bonne chance, l'ami ! #anim:Player:stressed
#audience:booing
- PASSEUR: Peut-être ne m'as-tu pas entendu. Je disais : qui es-tu ? #playsound:VOX_Ferryman_quiestu
    * [Je suis Merlin...] PLAYER: Je réponds au doux nom de Merlin... #anim:Player:bow #playsound:VOX_Player_Merlin #playsound:Play_MUS_Story_SC_Barque_ANewName
        ~ p_name = "Merlin"
    * [Mon nom est Ambroise...] PLAYER: Je réponds au doux nom d'Ambroise... #anim:Player:bow #playsound:VOX_Player_Ambroise #playsound:Play_MUS_Story_SC_Barque_ANewName
        ~ p_name = "Ambroise"
    * [On m'appelle Octave...] PLAYER: Je réponds au doux nom d'Octave... #anim:Player:bow #playsound:VOX_Player_Octave #playsound:Play_MUS_Story_SC_Barque_ANewName
        ~ p_name = "Octave"
- #audience:ovation
SOUFFLEUR: Sacré talent d'improvisation l'ami ! Tu es sur la bonne voie ! <i>Show must go on!</i>
{
    - p_name == "Merlin":
        PASSEUR: Désormais que je sais qui tu es, dis-moi : comment t'es-tu retrouvé ici, {p_name} ? #anim:Passeur:question #playsound:VOX_Ferryman_commentretrouveiciMerlin
    - p_name == "Ambroise":
        PASSEUR: Désormais que je sais qui tu es, dis-moi : comment t'es-tu retrouvé ici, {p_name} ? #anim:Passeur:question #playsound:VOX_Ferryman_commentretrouveiciAmbroise
    - p_name == "Octave":
        PASSEUR: Désormais que je sais qui tu es, dis-moi : comment t'es-tu retrouvé ici, {p_name} ? #anim:Passeur:question #playsound:VOX_Ferryman_commentretrouveiciOctave
}
- PLAYER: Un jour où je me trouvais...
    * [À l'auberge...] PLAYER: Un jour où je me trouvais à l'auberge des Deux Frères, je reçus la missive d'un expéditeur inconnu.
    * [Sur mon navire...] PLAYER: Un jour où je me trouvais sur mon navire, je reçus la missive d'un expéditeur inconnu.
    * [À la taverne...] PLAYER: Un jour où je me trouvais à la taverne du Rat Bouilli, je reçus la missive d'un expéditeur inconnu.
- PLAYER: Habituellement, une lettre de cette nature aurait fini au feu, mais un détail attira mon attention... #playsound:VOX_Player_unjour #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter1
    * [L'écriture.] PLAYER: La lettre était dotée d’une impeccable calligraphie. Ce détail ne pouvait signifier qu’une chose : notre expéditeur était du genre fortuné. #playsound:VOX_Player_lalettreecriture #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter2
    * [Le destinataire.] PLAYER: La lettre était destinée à un certain {p_name} Jehovah Banes. Or, la seule personne à m’appeler ainsi est ma mère, qui est absolument et irrémédiablement illettrée... #playsound:VOX_Player_lalettredestinataire{p_name} #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter2
    * [L'odeur.] PLAYER: J’ai reçu bien des lettres dans ma vie, certaines avaient l’odeur du sel marin ou des impôts impayés, mais jamais une odeur si... délicate. L'odeur d'un expéditeur fortuné. #playsound:VOX_Player_lalettreodeur
- PLAYER: La lettre me donnait rendez-vous pour une cause « de la plus haute importance ».
PLAYER: Curieux, je décidais de me rendre à minuit au lieu du mystérieux rendez-vous... #playsound:VOX_Player_transitionsecretmeeting  
    * [Le Bois aux Noyés.] PLAYER:    
PLAYER:... #wait:60
- -> secret_meeting

// Scène 2
= scene_2
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Passeur:PASSEUR
// Set the location
#set:barge
// Set the actor's positions
#position:Player:4:1
#position:Passeur:4:3
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3

// Start the scene
- PASSEUR: ...
PASSEUR: Dis-moi, voyageur : pourquoi avoir accepté une mission si périlleuse ? #anim:Passeur:question #playsound:VOX_Ferryman_pourquoimission
    * [Pour la fortune !] PLAYER: Pour la fortune, évidemment ! #anim:Player:gloire #playsound:VOX_Player_pourlafortune #light:Player #playsound:Play_MUS_Story_SC_Barque_AFairReward
    * [Pour la gloire !] PLAYER: Pour la gloire, cela va sans dire ! #anim:Player:gloire #playsound:VOX_Player_pourlagloire #light:Player #playsound:Play_MUS_Story_SC_Barque_AFairReward
    * [Pour l'aventure !] PLAYER: Pour l'aventure bien entendu ! #anim:Player:gloire #playsound:VOX_Player_pourlaventure #light:Player #playsound:Play_MUS_Story_SC_Barque_AFairReward
- #audience:applause
- PASSEUR: Tout de même... Te confronter à une créature mythique telle que le Léviathan... #playsound:VOX_Ferryman_toutdememe
PLAYER: À dire vrai...
    * [Je ne crois pas au Léviathan.] PLAYER: Je ne crois pas à ces histoires à dormir debout... 
        PLAYER: Je prévoyais de faire le voyage, prétendre avoir tué le monstre et retourner à bon port. #audience:laughter
        PASSEUR: Tu as pourtant promis de ramener le cœur de la bête. #playsound:VOX_Ferryman_coeurbete
            ** [J'avais un plan.] PLAYER: Personne n'a jamais vu le Léviathan de près : un cœur de baleine aurait suffi à faire illusion... #audience:laughter
            ** [Je n'avais pas pensé à ça.] PLAYER: Je suis un homme de l'improvisation. J'aurai trouvé quelque chose... #audience:applause
    * [Je rêvais de le voir.] PLAYER: Je rêve de l'apercevoir, depuis petit. Ma mère me racontait des récits de marins l'ayant aperçu, au loin.
        PASSEUR: N'étais-tu pas effrayé ? #anim:Passeur:question #playsound:VOX_Ferryman_paseffrayeq
            ** [Si, mais tout de même...] PLAYER: Seul un idiot ne le serait pas. Mais ce sont ces histoires de créatures mythiques qui ont fait de moi le marin que je suis, alors... #anim:Player:stressed
            ** [Pas le moins du monde.] PLAYER: Ce sont ces histoires de créatures mythiques qui ont fait de moi le marin que je suis. J'étais prêt à prendre tous les risques...
- PASSEUR: As-tu trouvé le monstre à l'endroit indiqué par la carte ? #playsound:VOX_Ferryman_etqueensuite
    * [(Mentir) J'ai tué le monstre.] PLAYER: J'ai trouvé le monstre à l'endroit indiqué par la carte, et je l'ai tué, avec l'aide de mon équipage. Quelle bataille avons-nous livrée ! #anim:Player:happy
    * [(Éluder la question) Rien...] PLAYER: Je me suis rendu sur place, je n'ai trouvé aucune créature, bien entendu... et je suis rentré. Fin de l'histoire.
- PASSEUR: Pourquoi ne pas me dire ce qu'il s'est réellement passé ? Ton âme s'en verra peut-être allégée... #playsound:VOX_Ferryman_pourquoidireverite
PLAYER: Bien, bien... Si tu insistes, Passeur.
PLAYER: Notre voyage dura...
    * [Près d'une année.] PLAYER: ... près d'une année, en tout. #map:departure
    * [Bien trop longtemps.] PLAYER: ... beaucoup trop longtemps pour être raconté. #map:Travel:departure
- PLAYER: Je garderai <b>secret</b> ce qu'il se passa lorsque nous atteignîmes le répère du Léviathan.
PLAYER: Après moult péripéties, nous revînmes à Miraterre... #playsound:VOX_Player_voyagedure1an #map:arrival
    * [Plus chargés que prévu.] PLAYER: ... plus chargés que prévu, disons. #playsound:VOX_Player_pluscharges #playsound:Play_MUS_Story_SC_Barque_ANewFriend
    * [Plus nombreux qu'à l'aller] PLAYER: ... plus nombreux qu'à l'aller, pour ainsi dire. #playsound:VOX_Player_plusnombreux playsound:Stop_AMB_SC_Barque_Ambiance #playsound:Play_MUS_Story_SC_Barque_ANewFriend
- PASSEUR: Ainsi, c'est à votre retour à Miraterre que les problèmes ont commencé ? #playsound:VOX_Ferryman_retourmiraterre
- PLAYER: En effet. Un dénouement...
    * [Ironique.] PLAYER: ... des plus <i>ironiques</i>.
        PASSEUR: Ironique, tu dis ? #playsound:VOX_Ferryman_ironique
    * [Tragi-comique.] PLAYER: ... qu'on pourrait qualifier de <i>tragi-comique</i>.
        PASSEUR: Tragi-comique, tu dis ? #playsound:VOX_Ferryman_tragicomique
    * [Inattendu.] PLAYER: ... des plus <i>inattendus</i>.
        PASSEUR: Inattendu, tu dis ? #playsound:VOX_Ferryman_innatendu
- PLAYER: Constatez par vous-même : nous avons bravé une tempête, affronté un monstre marin...
PLAYER: ... Et c'est au port de Miraterre, de retour de notre voyage, que notre heure sonna...
- #playsound:Play_SFX_Story_JudgeBellFarTrial #screenshake #wait:1
- -> trip_return 

// Scène 3
= scene_3
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Passeur:PASSEUR
// Set the location
#set:barge
// Set the actor's positions
#position:Player:4:1
#position:Passeur:4:3
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3

// Start the scene
- PASSEUR: Ainsi, ton ami s'est fait arrêter par les gardes... #playsound:VOX_Ferryman_ainsitonami
    * [Je la retrouverai.] PLAYER: Je la retrouverai. Par tous les moyens, la Déesse m'en soit témoin ! #audience:ovation
        PASSEUR: Ainsi, ton ami est <i>une</i> amie. Je vois... #playsound:VOX_Ferryman_tonamie
    * [Rester silencieux.]
- PASSEUR: Dis-moi plutôt : où t'es-tu rendu, après cela ? #playsound:VOX_Ferryman_outurendu
    * [Tous les gardes en avaient après moi...] PLAYER: Tous les gardes de la ville étaient à mes trousses.
        PLAYER: Mais il est un lieu où ils ne pénètrent jamais... #playsound:VOX_Player_touslesgardes #playsound:Play_MUS_Story_SC_Barque_ToChurch
    * [J'ai trouvé un refuge...] PLAYER: J'ai trouvé un endroit pour passer la nuit. 
        PLAYER: Un endroit où les gardes n'auraient pas idée de me chercher... #playsound:VOX_Player_trouveunendroit #playsound:Play_MUS_Story_SC_Barque_ToChurch
- -> church_night

// Scène 4
= scene_4
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Passeur:PASSEUR
// Set the location
#set:barge
// Set the actor's positions
#position:Player:4:1
#position:Passeur:4:3
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3

// Start the scene
- PASSEUR: Cette prêtresse fit honneur à l'hospitalité de la Déesse... #playsound:VOX_Ferryman_pretressehonneur
    * [Tout à fait, mais...] PLAYER: Jamais n'a-t-on vu âme plus accueillante. Cependant... #playsound:VOX_Player_jamaisame
    * [En un sens...] PLAYER: D'une certaine manière, j'en conviens... Mais... #playsound:VOX_Player_certainemaniere
    * [C'est ce que je pensais.] PLAYER: La même pensée me traversait l'esprit, alors que je m'endormais... Toutefois... #playsound:VOX_Player_penseetraverseesprit
- #audience:debate
- PASSEUR: Parle, je t'en prie. #playsound:VOX_Ferryman_parlejetenprie
- PLAYER: À mon réveil... #playsound:VOX_Player_amonreveil
    * [Une mauvaise surprise m'attendait.] PLAYER: ... une surprise des plus désagréables m'attendait... #playsound:VOX_Player_unemauvaisesurprise
    * [Je m'apprêtais à en découdre.] PLAYER: ... j'allais devoir livrer bataille... #playsound:VOX_Player_devoirlivrerbataille
    * [Je fus trahi.] PLAYER: ... je fus malheureux de constater qu'on m'avait trahi... #playsound:VOX_Player_amonreveil 
- -> church_day

// Scène 5
= scene_5
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Passeur:PASSEUR
// Set the location
#set:barge
// Set the actor's positions
#position:Player:4:1
#position:Passeur:4:3
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3

// Start the scene
- PASSEUR: En fin de compte... Notre voyage fut des plus captivants. #playsound:VOX_Ferryman_voyagecaptivant
PASSEUR: Toutefois... #audience:ovation #playsound:VOX_Ferryman_toutefois
PASSEUR: ... Il arrive déjà à son terme, j'en ai peur. #anim:Passeur:show_door #playsound:VOX_Ferryman_voyagecaptivant2 #playsound:Play_MUS_Story_SC_Barque_TrialInView #audience:debate
    * [Que va t-il se passer ?] PLAYER: Que va-t-il se passer ? Parle donc, Passeur... et ne me ménage pas. #anim:Player:stressed #playsound:VOX_Player_quevapassemenagepas #audience:debate
        PASSEUR: Cela, je ne puis te le dire, voyageur. Je connais ton passé, mais j'ignore tout de ton avenir. #playsound:VOX_Ferryman_jenepuisteledire #audience:applause
    * [Où mène ce chemin ?] PLAYER: Où mène ce chemin, Passeur ? #anim:Player:stressed #playsound:VOX_Player_oumeneporte #audience:debate
        PASSEUR: Il te mène à Lui, voyageur. #audience:choc #playsound:VOX_Ferryman_menealui
    * [(Rester silencieux).]
- PASSEUR: Attendons un instant. #playsound:VOX_Ferryman_attendonsuninstant
PASSEUR: Si la <shake>Cloche du Destin</shake> sonne, alors nous serons tenus de passer... #playsound:VOX_Ferryman_silacloche #audience:debate
PASSEUR: ...
PLAYER: ...
    * [Faire face à son destin.]
- #playsound:Play_SFX_Story_JudgeBellFarTrial #screenshake #audience:choc
PASSEUR: Tu vas devoir affronter ton destin, désormais. #audience:ovation #playsound:VOX_Ferryman_affrontetondestin
    * [Qui m'y oblige ?] PLAYER: Qui m'y contraint, Passeur ? #anim:Player:question  #playsound:VOX_Player_quinousycontraint #audience:debate
        PASSEUR: La Loi. #playsound:VOX_Ferryman_laloi #audience:choc
    * [Faisons demi-tour.] PLAYER: Faisons demi-tour, je t'en prie. #playsound:VOX_Player_faisonsdemitour #audience:booing
        PASSEUR: Je regrette, ce n'est pas à moi d'en décider. #playsound:VOX_Ferryman_jeregrettepasmadecision #audience:debate
    * [J'ai peur...] PLAYER: J'ai si peur... #anim:Player:stressed #playsound:VOX_Player_jaisipeur #audience:debate
        PASSEUR: ... Je comprends. #playsound:VOX_Ferryman_jecomprends #audience:applause
- #anim:open_trial_doors #playsound:Play_MUS_Story_SC_Barque_TrialDoorsOpen
PASSEUR: C'est ici que nos chemins se séparent, voyageur... #playsound:VOX_Ferryman_voistuporte2 #audience:choc
PASSEUR: Ainsi en a décidé la <shake>Cloche du Destin</shake>.  #playsound:VOX_Ferryman_ainsienadecide #audience:ovation
- -> tribunal_1