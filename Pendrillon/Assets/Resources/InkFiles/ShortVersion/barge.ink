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
#curtains:open
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
- PASSEUR: Eh, bien... #playsound:VOX_Ferryman_ehbien
PASSEUR: J'ai connu des passagers plus loquaces... #playsound:VOX_Ferryman_passagersloquaces #box #audience:applause
    * [(Rester silencieux)]
- PASSEUR: *Hum hum* #anim:Passeur:clear_voice #playsound:VOX_Ferryman_humhum
- PASSEUR: J'ai dit : « J'ai connu des passagers plus loquaces... ». #box #audience:debate #playsound:VOX_Ferryman_jaidit
- SOUFFLEUR: Psssst... Hé ! #playsound:VOX_Souffleur_pssthe1
SOUFFLEUR: Par ici, l'ami. #anim:Souffleur:wavehand #playsound:VOX_Souffleur_parici
SOUFFLEUR: Je ne sais pas si c'est le trac qui te paralyse, mais... c'est à ton tour de donner la réplique ! #playsound:VOX_Souffleur_jenesaispas
    * [(Rester silencieux)]
- #sleep:1 #audience:booing
- SOUFFLEUR: Hé, qu'est-ce que tu fabriques ? Tu as oublié ton texte, c'est ça ? #wait:2 #playsound:VOX_Souffleur_hequestceque
SOUFFLEUR: Permets-moi de te rafraîchir la mémoire, l'ami. #playsound:VOX_Souffleur_permetsmoi
SOUFFLEUR: « Ma mère m'a toujours dit... ». #playsound:VOX_Souffleur_mameretoujou
    * [Ma mère m'a toujours dit...] PLAYER: Ma mère m'a toujours dit... #anim:Player:talk #playsound:VOX_Player_meretoujoursdit #playsound:Play_MUS_Story_SC_Barque_BadViolin1 #audience:applause
- SOUFFLEUR: « ... qu'enfant, déjà, je n'étais pas très bavard. ». #playsound:VOX_Souffleur_enfantdeja
    * [... qu'enfant, déjà, je n'étais pas très bavard.] PLAYER: ... qu'enfant, déjà, je n'étais pas très bavard. #playsound:VOX_Player_pasbavard #playsound:Play_MUS_Story_SC_Barque_BadViolin2 #audience:applause
PASSEUR: Vraiment ? J'ai pourtant ouï-dire qu'en matière de baratin, tu n'étais pas le dernier... #playsound:VOX_Ferryman_baratinpasdernier #audience:applause
SOUFFLEUR: Psssst... Hé, l'ami ! #anim:Souffleur:angry #playsound:VOX_Souffleur_pssthe2
SOUFFLEUR: Quand je te souffle le texte, je n'y mets pas le ton... #playsound:VOX_Souffleur_quandjesouffle
SOUFFLEUR: Ce n'est pas mon métier, tu piges ? #playsound:VOX_Souffleur_pasmonmetier
SOUFFLEUR: Mais toi, tu es acteur, pas vrai ? #playsound:VOX_Souffleur_moitoiacteur
SOUFFLEUR: Alors mets-y de l'émotion, l'ami ! #playsound:VOX_Souffleur_metsyemotion
- SOUFFLEUR: Reprenons : « Il est vrai que j'ai ce talent-là, mais... ». #anim:Souffleur:deception #playsound:VOX_Souffleur_reprenons
    * [Il est vrai que j'ai ce talent-là, mais...] PLAYER: Il est vrai que j'ai ce talent-là, mais... #playsound:VOX_Player_ilestvraitalent
- SOUFFLEUR: N'oublie pas d'incarner ton personnage, l'ami ! Souviens-toi : l'é-mo-tion ! #anim:Souffleur:angry #playsound:VOX_Souffleur_noubliepasincarner
- SOUFFLEUR: « Un talent est une ressource précieuse, aussi, je l'utilise à bon escient. ». #playsound:VOX_Souffleur_untalentressource
    * [(Avec intensité) Un talent est une ressource précieuse...] PLAYER: Un talent est une ressource précieuse, aussi je l'utilise à bon escient. #wait:1 #audience:ovation #playsound:Play_MUS_Story_SC_Barque_AGoodActor #playsound:VOX_Player_talentressourceprecieuse
- SOUFFLEUR: C'est exaltant, pas vrai ? #anim:Souffleur:happy #playsound:VOX_Souffleur_exaltant
SOUFFLEUR: Le public réagit à tes répliques, mais aussi à ton jeu de scène ! Tu brûles littéralement les planches, l'ami ! #anim:Souffleur:happy #playsound:VOX_Souffleur_publicreagi
SOUFFLEUR: Poursuivons : « Je ne suis pas un homme de mauvaise compagnie. ». #playsound:VOX_Souffleur_poursuivonsjene
    * [Je ne suis pas un homme de mauvaise compagnie.] PLAYER: Je ne suis pas un homme de mauvaise compagnie. #playsound:VOX_Player_pasmauvaisecompagnie
- SOUFFLEUR: « De quoi souhaites-tu que l'on parle, Passeur ? ». #playsound:VOX_Souffleur_dequoisouhai
    * [De quoi souhaites-tu que l'on parle, Passeur ?] PLAYER: De quoi souhaites-tu que l'on parle, Passeur ? #anim:Player:question #playsound:VOX_Player_quoisouhaiteparle
- PASSEUR: Commence par te présenter : qui es-tu ? #anim:Passeur:question #playsound:VOX_Ferryman_commencepresenter
#audience:debate
- SOUFFLEUR: Aïe ! C'est là qu'on va avoir un petit problème, l'ami. #playsound:VOX_Souffleur_aie
SOUFFLEUR: Le metteur en scène de cette pièce, le célèbre Jean Ornicar... son nom te dit sans doute quelque chose... #playsound:VOX_Souffleur_ornicar
SOUFFLEUR: Le respectable Ornicar a quitté la troupe. En assez mauvais termes, vois-tu. #playsound:VOX_Souffleur_quittelatroupe
SOUFFLEUR: Là où le bât blesse... c'est qu'il n'a jamais terminé d'écrire tes répliques. #playsound:VOX_Souffleur_lebatblesse
SOUFFLEUR: On aurait dû te prévenir avant, navré l'ami... #playsound:VOX_Souffleur_navrelami
SOUFFLEUR: À partir de maintenant... tu vas devoir improviser ! Bonne chance, l'ami ! #anim:Player:stressed #playsound:VOX_Souffleur_bonnechance
#audience:booing
- PASSEUR: Peut-être ne m'as-tu pas entendu. Je disais : qui es-tu ? #playsound:VOX_Ferryman_quiestu
    * [Je suis Merlin...] PLAYER: Je réponds au doux nom de Merlin... #anim:Player:bow #playsound:VOX_Player_Merlin #playsound:Play_MUS_Story_SC_Barque_ANewName
        ~ p_name = "Merlin"
    * [Mon nom est Ambroise...] PLAYER: Je réponds au doux nom d'Ambroise... #anim:Player:bow #playsound:VOX_Player_Ambroise #playsound:Play_MUS_Story_SC_Barque_ANewName
        ~ p_name = "Ambroise"
    * [On m'appelle Octave...] PLAYER: Je réponds au doux nom d'Octave... #anim:Player:bow #playsound:VOX_Player_Octave #playsound:Play_MUS_Story_SC_Barque_ANewName
        ~ p_name = "Octave"
- #audience:ovation
SOUFFLEUR: Sacré talent d'improvisation l'ami ! Tu es sur la bonne voie ! <i>Show must go on!</i> #playsound:VOX_Souffleur_sacretalent
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
    * [Le destinataire.] PLAYER: La lettre était destinée à un certain {p_name} Jehovah Banes. Or, la seule personne à m’appeler ainsi est ma mère, qui est absolument et irrémédiablement illettrée... #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter2
    * [L'odeur.] PLAYER: J’ai reçu bien des lettres dans ma vie, certaines avaient l’odeur du sel marin ou des impôts impayés, mais jamais une odeur si... délicate. L'odeur d'un expéditeur fortuné. #playsound:VOX_Player_lalettreodeur #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter2
- PLAYER: La lettre me donnait rendez-vous pour une cause « de la plus haute importance ». #playsound:VOX_Player_lettreplushauteimportance
PLAYER: Curieux, je décidais de me rendre à minuit au lieu du mystérieux rendez-vous... #playsound:VOX_Player_transitionsecretmeeting  #playsound:Play_MUS_Story_SC_Barque_MysteriousLetter3
    * [Le Bois aux Noyés.] PLAYER: Le Bois aux Noyés. #audience:choc #playsound:VOX_Player_leboisnoyes
- -> secret_meeting

= scene_before_tempest
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
- PASSEUR: ... #playsound:Play_MUS_Story_SC_Barque_AfterMeeting
PASSEUR: Dis-moi, voyageur : pourquoi avoir accepté une mission si périlleuse ? #anim:Passeur:question #playsound:VOX_Ferryman_pourquoimission
    * [Pour la fortune !] PLAYER: Pour la fortune, évidemment ! #anim:Player:gloire #playsound:VOX_Player_pourlafortune #light:Player #playsound:Play_MUS_Story_SC_Barque_AFairReward
    * [Pour la gloire !] PLAYER: Pour la gloire, cela va sans dire ! #anim:Player:gloire #playsound:VOX_Player_pourlagloire #light:Player #playsound:Play_MUS_Story_SC_Barque_AFairReward
    * [Pour l'aventure !] PLAYER: Pour l'aventure bien entendu ! #anim:Player:gloire #playsound:VOX_Player_pourlaventure #light:Player #playsound:Play_MUS_Story_SC_Barque_AFairReward
- #audience:applause
- PASSEUR: Tout de même... Te confronter à une créature mythique telle que le <b>Léviathan</b>... #playsound:VOX_Ferryman_toutdememe
- PASSEUR: As-tu trouvé le monstre à l'endroit indiqué par la carte ? #playsound:VOX_Ferryman_etqueensuite
    * [Je l'ai trouvé, en effet.] PLAYER: Je l'ai trouvé, là où il était supposé être... Au cœur de l'océan. #audience:ovation
    * [Mieux que ça : je l'ai affronté !] PLAYER: Je l'ai même affronté, Passeur... Au cœur de l'océan. #audience:ovation
- -> tempest


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
    * [Que va t-il se passer ?] PLAYER: Que va-t-il se passer ? Parle donc, Passeur... et ne me ménage pas. #anim:Player:stressed #playsound:VOX_Player_quevapasserparlepasseur #audience:debate
        PASSEUR: Cela, je ne puis te le dire, voyageur. Je connais ton passé, mais j'ignore tout de ton avenir. #playsound:VOX_Ferryman_jenepuisteledire #audience:applause
    * [Où mène ce chemin ?] PLAYER: Où mène ce chemin, Passeur ? #anim:Player:stressed #playsound:VOX_Player_oumenecheminpasseur #audience:debate
        PASSEUR: Il te mène à Lui, voyageur. #audience:choc #playsound:VOX_Ferryman_menealui
    * [(Rester silencieux).]
- PASSEUR: Tu sais pourquoi tu es là, n'est-ce pas ?
PLAYER: Je le sais. J'ai ramené de mon voyage quelqu'un qui n'avait <b>aucun droit</b> d'être à <b>Miraterre</b>.
PASSEUR: Et pour cela, tu seras peut-être <b>jugé</b>, voyageur.
- PASSEUR: Attendons un instant. #playsound:VOX_Ferryman_attendonsuninstant
PASSEUR: Si la <shake>Cloche du Destin</shake> sonne, alors nous serons tenus de passer... #playsound:VOX_Ferryman_silacloche #audience:debate
PASSEUR: ...
PLAYER: ...
    * [Faire face à son destin.]
- #playsound:Play_SFX_Story_JudgeBellFarTrial #screenshake #audience:choc
PASSEUR: Tu vas devoir affronter ton destin, désormais. #audience:ovation #playsound:VOX_Ferryman_affrontetondestin #playsound:Play_MUS_Story_SC_Barque_TrialDoorsOpen
    * [Qui m'y oblige ?] PLAYER: Qui m'y contraint, Passeur ? #anim:Player:question  #playsound:VOX_Player_quimycontraint #audience:debate
        PASSEUR: La <b>Loi</b>. #playsound:VOX_Ferryman_laloi #audience:choc
    * [Faisons demi-tour.] PLAYER: Faisons demi-tour, je t'en prie. #playsound:VOX_Player_faisonsdemitour #audience:booing
        PASSEUR: Je regrette, ce n'est pas à moi d'en décider. #playsound:VOX_Ferryman_jeregrettepasmadecision #audience:debate
    * [J'ai peur...] PLAYER: J'ai si peur... #anim:Player:stressed #playsound:VOX_Player_jaisipeur #audience:debate
        PASSEUR: ... Je comprends. #playsound:VOX_Ferryman_jecomprends #audience:applause
- #anim:open_trial_doors #playsound:Play_MUS_Story_SC_Barque_TrialDoorsOpen
PASSEUR: C'est ici que nos chemins se séparent, voyageur... #playsound:VOX_Ferryman_voistuporte2 #audience:choc 
PASSEUR: Ainsi en a décidé la <shake>Cloche du Destin</shake>.  #box #playsound:VOX_Ferryman_ainsienadecide #audience:ovation #curtains:close #wait:4
- -> tribunal_1