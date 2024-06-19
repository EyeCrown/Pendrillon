// TRIBUNAL SCENE 2

// Variables
VAR naida_name = "LA POISCAILLE"
VAR naida_name_on_text = "Naïda"
VAR verdict_is_innocent = false
VAR verdict_is_guilty = false

// Scene
=== tribunal_2 ===
-> start

= start
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Judge:JUGE ERNEST
#actor:Naïda:???:NAÏDA:L'AFFREUSE SIREINE:LA POISCAILLE
// Set the location
#set:trial
// Set the actor's positions
#position:Player:10:1
#position:Naïda:4:20

// Start the scene
#audience:ovation
#playsound:Play_MUS_Story_SC_Trial_Intro2
#judge_bell
#wait:5
#audience:ovation
#wait:3
#audience:ovation
#wait:1
// Start the scene
- JUGE ERNEST: Silence ! Silence ! #playsound:VOX_Judge_silencesilence #anim:Judge:bell #audience:silent
JUGE ERNEST: Ainsi, vous avez véritablement affronté une créature marine ? #playsound:VOX_Judge_ainsiavezvousveritablecreature
    * [Pour Irène !] PLAYER: Je l'ai fait. Pour nul autre qu'<b>Irène</b>, <b>Votre Honneur</b>. #audience:ovation #playsound:VOX_Player_jelaifaitirene
        ~ audience_judgement(20)
    * [Pour la Couronne !] PLAYER: Je l'ai fait. Pour nul autre que la <b>Couronne</b>, <b>Votre Honneur</b>. #audience:ovation #playsound:VOX_Player_jelaifaitcouronne
        ~ audience_judgement(10)
    * [Je n'avais pas le choix...] PLAYER: Je l'ai fait. Je n'avais pas le choix, <b>Votre Honneur</b>... C'était elle ou nous. #audience:ovation #playsound:VOX_Player_jelaifaitoblige
        ~ audience_judgement(10)
-
{
    - b_player_won == true:
        JUGE ERNEST: Et vous avez triomphé de la bête. #audience:ovation #screenshake
        ~ audience_judgement(40)
    - else:
        JUGE ERNEST: Et vous avez été vaincu. #audience:booing
        ~ audience_judgement(-30)
}
- JUGE ERNEST: À la fin de votre histoire, il semblerait pourtant que le <shake a=0.5><b>Léviathan</b></shake> vous ait avalé... #playsound:VOX_Judge_finhistoireleviathanavale
JUGE ERNEST: Vous, et votre navire... #playsound:VOX_Judge_vousetvotrenavire
    * [Avalé tout cru !] PLAYER: Avalés tout entier, <b>Votre Honneur</b> ! #audience:choc #playsound:VOX_Player_avalestoutentier
    * [Pourtant, je suis en vie.] PLAYER: En effet. Pourtant, je suis bel et bien vivant... #audience:debate #playsound:VOX_Player_eneffetpourtantvivant
- JUGE ERNEST: Bien, bien... Si vous le dites... #playsound:VOX_Judge_bienbiensivousledites
    -> judge_proceed_to_mention_the_sireine

// The judge proceed to mention the Sireine
= judge_proceed_to_mention_the_sireine
JUGE ERNEST: <b>Accusé</b>, il est un sujet que nous n'avons pas encore évoqué lors de ce procès. #playsound:VOX_Judge_accuseilestsujetsireine #audience:debate
JUGE ERNEST: Ce sujet constitue pourtant le cœur de ce qu'il vous est reproché. #playsound:VOX_Judge_constituecoeur #audience:debate
JUGE ERNEST: Je veux bien entendu parler... de votre histoire d'amour avec une <b>Sireine</b>. #playsound:VOX_Judge_bienentenduhistoireamour #audience:choc
    ~ audience_judgement(-30)
    * [Laisser le silence retomber.]
- JUGE ERNEST: Mesdames et messieurs les jurés, je vous demande de garder votre calme. #playsound:VOX_Judge_gardezcalmejures #audienc:silent
JUGE ERNEST: Vous savez l'importance de la tâche qui vous incombe. Sachez vous en montrer digne. #playsound:VOX_Judge_savezimportancetache
JUGE ERNEST: J'appelle à la barre... la <b>Sireine</b>. #box #playsound:VOX_Judge_appellesireinebarre #position:Naïda:8:10 #wait:4 #anim:Judge:bell #audience:choc #audience:booing
JUGE ERNEST: Avant toute chose : je demande à la créature de ne pas prendre la parole. #playsound:VOX_Judge_creaturepasparole #audience:booing
JUGE ERNEST: Si tant est qu'elle soit capable de s'exprimer... #playsound:VOX_Judge_sitantestexprimer #audience:laughter
JUGE ERNEST: En effet, ce lieu saint ne saurait accueillir la voix d'une affreuse <b>Sireine</b> ! #playsound:VOX_Judge_eneffetlieusacre #audience:booing
L'AFFREUSE SIREINE: ... #audience:boing
    * [Vous allez regretter ces paroles !] PLAYER: Retirez ces sales paroles, maudit <b>Juge</b> ! <b>Naïda</b> vaut plus que vous tous réunis ! #playsound:VOX_Player_retirezsalesparoles #audience:choc
        ~ audience_judgement(-20)
    * [Elle possède un nom.] PLAYER: L'affreuse <b>Sireine</b>, comme vous dites, possède un nom. <b>Naïda</b>. #playsound:VOX_Player_affreusesireine
        ~ audience_judgement(5)
- JUGE ERNEST: Ainsi, <b>la poiscaille</b> possède un nom ? #playsound:VOX_Judge_poiscalleaunnomq #audience:debate
LA POISCAILLE: ... #audience:booing
    * [(Menaçant) Appelez-la par son nom. {t(STRE, -30)}] // 30%
        {sc(STRE, -30): -> convince_name_naida_S | -> convince_name_naida_F}
            ** (convince_name_naida_S) PLAYER: <b>Votre Honneur</b>, si vous ne daignez pas appeler <b>Naïda</b> par son nom, par la <b>Déesse</b>, vous le paierez. #audience:choc #playsound:VOX_Player_menacerlejuge
                ~ audience_judgement(10)
                JUGE ERNEST: Bon, bon... Je consens à appeler la créature par ce qui lui sert de nom... #playsound:VOX_Judge_bonbonjeconsens #audience:applause
                JUGE ERNEST: Tant que celle-ci ne profane pas ces lieux de sa parole impie. #playsound:VOX_Judge_tantqueprofanepas #audience:ovation
                ~ naida_name = "NAÏDA"
                ~ naida_name_on_text = "Naïda"
            ** (convince_name_naida_F) PLAYER: <b>Votre Honneur</b>, si vous ne daignez pas appeler <b>Naïda</b> par son nom, par la <b>Déesse</b>, vous le paierez. #audience:choc #playsound:VOX_Player_menacerlejuge
                JUGE ERNEST: Peuh... Si vous croyez me faire peur, <b>Accusé</b>... Ce procès sera l'occasion de rebaptiser votre amie : <b>la poiscaille</b>. #playsound:VOX_Judge_peuhfairepeur #audience:ovation
                ~ naida_name_on_text = "la poiscaille"
                ~ audience_judgement(-10)
    * [(Calme) Tout être a droit à un nom.{t(CHAR, -10)}] // 60%
        {sc(CHAR, -10): -> force_name_naida_S | -> force_name_naida_F}
            ** (force_name_naida_S) PLAYER: <b>Votre Honneur</b>, je vous demande de faire preuve d'humanité en appelant <b>Naïda</b> par son nom. #audience:debate #playsound:VOX_Player_attendrirlejuge
                ~ audience_judgement(10)
                JUGE ERNEST: Bon, bon... Je consens à appeler la créature par ce qui lui sert de nom... #playsound:VOX_Judge_bonbonjeconsens #audience:applause
                JUGE ERNEST: Tant que celle-ci ne profane pas ces lieux de sa parole impie. #playsound:VOX_Judge_tantqueprofanepas #audience:ovation
                ~ naida_name = "NAÏDA"
                ~ naida_name_on_text = "Naïda"
            ** (force_name_naida_F) PLAYER: <b>Votre Honneur</b>, je vous demande de faire preuve d'humanité en appelant <b>Naïda</b> par son nom. #audience:debate #playsound:VOX_Player_attendrirlejuge
                JUGE ERNEST: Peuh... Si vous croyez m'attendrir, <b>Accusé</b>... Ce procès sera l'occasion de rebaptiser votre amie : <b>la poiscaille</b>. #playsound:VOX_Judge_peuhattendriraccuse #audience:ovation
                ~ naida_name_on_text = "la poiscaille"
                ~ audience_judgement(-10)
- SOUFFLEUR: Je sais ce que tu penses, l'ami... #playsound:VOX_Souffleur_jesaiscequetupenses
SOUFFLEUR: La pièce prend des tournures <b>particulièrement sombres</b>... #playsound:VOX_Souffleur_lapieceprendtournuresombre
SOUFFLEUR: Mais ainsi sont fait nos mythes, pas vrai ? #playsound:VOX_Souffleur_mythes
SOUFFLEUR: Le moment risque d'être difficile pour le personnage de <b>Naïda</b>. Elle saura rester digne, ne t'en fais pas ! #playsound:VOX_Souffleur_difficilenaida
SOUFFLEUR: Quand à toi, essaye de la défendre du mieux que tu le peux auprès du <b>Juge</b>, mais surtout du public ! #playsound:VOX_Souffleur_essaiededefendre
SOUFFLEUR: Fais de ton mieux, entendu ? Bon courage, l'ami ! #playsound:VOX_Souffleur_faisdetonmieux
{
    - naida_name_on_text == "la poiscaille":
        JUGE ERNEST: Commencez par nous raconter comment vous avez fait la rencontre de <b>{naida_name_on_text}</b>, voulez-vous ? #playsound:VOX_Judge_commencerrencontrepoiscaille
    - naida_name_on_text == "Naïda":
        JUGE ERNEST: Commencez par nous raconter comment vous avez fait la rencontre de <b>{naida_name_on_text}</b>, voulez-vous ? #playsound:VOX_Judge_commencerencontrenaida
    - else:
        JUGE ERNEST: Commencez par nous raconter comment vous avez fait la rencontre de <b>{naida_name_on_text}</b>, voulez-vous ? #playsound:VOX_Judge_commencerencontrenaida
}
- (player_and_naida_met)
    * [À l'intérieur du Léviathan.] PLAYER: Lorsque le <shake a=0.5><b>Léviathan</b></shake> nous a avalé, mon équipage et moi-même... Nous nous sommes retrouvés à l'intérieur de son estomac. #audience:choc
        PLAYER: C'est là que j'ai fait la rencontre du peuple des <b>Sireines</b>. #audience:debate
        PLAYER: Durant près d'une année, j'ai appris à les connaître.
        PLAYER: À apprécier vivre à leurs côtés... #audience:debate
    * [Cela ne vous regarde pas.] PLAYER: Notre histoire ne vous regarde en rien, <b>Votre Honneur</b>.
        JUGE ERNEST: Allons, allons... Que diriez-vous d'un marché, <b>Accusé</b> ? #playsound:VOX_Judge_allonsallonsmarche
        JUGE ERNEST: Vous témoignez de votre histoire, et je consens à appeler votre amie par son nom.  #playsound:VOX_Judge_temoignezhistoire
        ** [Pas question.] PLAYER: Vous avez perdu ma confiance, <b>Votre Honneur</b>. Il n'en est pas question.
            JUGE ERNEST: Si vous ne témoignez pas de votre histoire, <b>Accusé</b>... vous serez jugés coupables, tous les deux. #playsound:VOX_Judge_temoignezpascoupable #audience:booing
            -> player_and_naida_met
        ** [C'est entendu.] PLAYER: Entendu, <b>Votre Honneur</b>. #audience:applause
            -> player_and_naida_met
- JUGE ERNEST: Ainsi, vous avez découvert le peuple maudit qui fut jadis noyé, avalé par le <shake a=0.5><b>Léviathan</b></shake>... #playsound:VOX_Judge_ainsipeuplejadis
    * [Ils ne sont pas maudits. {t(CHAR, -10)}] // 60%
        {sc(CHAR, -10): -> sireine_are_not_cursed_S | -> sireine_are_not_cursed_F}
        ** (sireine_are_not_cursed_S) PLAYER: <b>Votre Honneur</b>, j'ai toutes les raisons de penser que le peuple des <b>Sireines</b> n'est en rien maudit. #audience:debate
            PLAYER: Ne pensez-vous pas que si la <b>Déesse</b> avait voulu que le <b>Déluge</b> ne les tue, ils ne seraient pas vivants aujourd'hui ? #audience:applause
            ~ audience_judgement(10)
        ** (sireine_are_not_cursed_F) PLAYER: Sont-ils réellement maudits ? Qui peut le dire ? #audience:debate
            ~ audience_judgement(-10)
    * [Vous seul êtes maudit. {t(STRE, -10)}] // 60%
        {sc(STRE, -10): -> judge_is_cursed_S | -> judge_is_cursed_F}
        ** (judge_is_cursed_S) PLAYER: <b>Votre Honneur</b>, s'il est un être maudit en ces lieux, c'est bien vous. #audience:debate
            PLAYER: Un siècle à souffrir, accroché à une roue...
            PLAYER: Si la <b>Déesse</b> avait voulu abréger vos souffrances, ne l'aurait-elle pas fait ? #audience:applause
            ~ audience_judgement(10)
        ** (judge_is_cursed_F) PLAYER: C'est vous qui êtes maudit, pas eux ! #audience:debate
            ~ audience_judgement(-10)
    * [Rester silencieux.] JUGE ERNEST: Vous semblez n'avoir rien à répondre... #playsound:VOX_Judge_semblezavoirrienrepondre #audience:debate
        ~ audience_judgement(-10)
- JUGE ERNEST: <b>Accusé</b>, il est une question qui est dans tous les esprits... #playsound:VOX_Judge_accusequestionesprits
JUGE ERNEST: Comment avez-vous pu tomber amoureux d'une engeance du <b>Déluge</b> ? #playsound:VOX_Judge_commentamoureuxdeluge
    * [(Convaincre) Elle est plus proche de nous que vous. {t(DEXT, -5)}] // 65%
        {sc(DEXT, -5): -> closer_to_us_S | -> closer_to_us_F}
        ** (closer_to_us_S) PLAYER: <b>Votre Honneur</b>... Les <b>Sireines</b> sont plus proches des humains que vous ne l'êtes vous-même... #audience:choc #playsound:VOX_Player_sireineplusprocheshumains
            PLAYER: <b>Naïda</b> a un cœur qui bat : le vôtre n'a-t-il pas cessé il y a bien longtemps ? #audience:debate #playsound:VOX_Player_naidaauncoeur
            PLAYER: Lorsqu'elle se blesse, son sang coule : est-ce votre cas ? #audience:debate #playsound:VOX_Player_sonsangcoule
            PLAYER: Un jour... Elle mourra. #audience:silent #playsound:VOX_Player_unjourellemourra
            PLAYER: Peut-on en dire autant de vous ? #audience:ovation #playsound:VOX_Player_peutonendireautant
            ~ audience_judgement(20)
        ** (closer_to_us_F) PLAYER: <b>Votre Honneur</b>... Les <b>Sireines</b> sont plus proches des humains que vous ne l'êtes vous-même... #audience:choc #playsound:VOX_Player_sireineplusprocheshumains
            PLAYER: <b>Naïda</b> a un cœur qui bat : le vôtre n'a-t-il pas cessé il y a bien longtemps ? #audience:debate #playsound:VOX_Player_naidaauncoeur
            PLAYER: Lorsqu'elle se blesse, son sang coule : est-ce votre cas ? #audience:debate #playsound:VOX_Player_sonsangcoule
            PLAYER: Un jour... Elle mourra. #audience:silent #playsound:VOX_Player_unjourellemourra
            PLAYER: Peut-on en dire autant de vous ? #audience:booing #playsound:VOX_Player_peutonendireautant
            ~ audience_judgement(-10)
    * [(Persuader) J'ai un cœur.{t(CHAR, 0)}] // 70%
        {sc(CHAR, 0): -> we_have_a_heart_S | -> we_have_a_heart_F}
        ** (we_have_a_heart_S) PLAYER: Pour la simple raison que j'ai un cœur, <b>Votre Honneur</b>. #audience:debate #playsound:VOX_Player_jaiuncoeurvotrehonneur
            PLAYER: <b>Naïda</b> aussi en possède un. Et vous, est-ce votre cas ? #audience:choc #playsound:VOX_Player_naidaaussi
            PLAYER: Le vôtre n'a-t-il pas cessé de battre il y a des centaines d'années, attaché à votre roue ? #playsound:VOX_Player_levotreestmort
            PLAYER: Par quel droit un être auquel il manque le cœur peut-il procéder au jugement de ceux qui jouissent et souffrent d'en posséder un ? #audience:ovation #playsound:VOX_Player_commentjugersanscoeur
                ~ audience_judgement(30)
        ** (we_have_a_heart_F) PLAYER: Pour la simple raison que j'ai un cœur, <b>Votre Honneur</b>. #audience:debate #playsound:VOX_Player_jaiuncoeurvotrehonneur
            PLAYER: <b>Naïda</b> aussi en possède un. Et vous, est-ce votre cas ? #audience:choc #playsound:VOX_Player_naidaaussi
            PLAYER: Le vôtre n'a-t-il pas cessé de battre il y a des centaines d'années, attaché à votre roue ? #playsound:VOX_Player_levotreestmort
            PLAYER: Par quel droit un être auquel il manque un cœur peut-il procéder au jugement de ceux qui jouissent et souffrent d'en posséder un ? #audience:booing #playsound:VOX_Player_commentjugersanscoeur
                ~ audience_judgement(-10)
    * [Rester silencieux.] JUGE ERNEST: Aucune réponse... Le cœur a ses raisons... #playsound:VOX_Judge_lecoeurasesraisons #audience:debate
        ~ audience_judgement(-10)
- JUGE ERNEST: <b>Accusé</b>, ne souffrez-vous d'aucune honte à défendre ce peuple que le <b>Déluge</b> a puni ? //#playsound:VOX_Judge_accuseaucunehonte
    * [Nos ancêtres sont communs. {t(DEXT, 5)}] // 75%
        {sc(DEXT, 5): -> we_have_same_ancesters_S | -> we_have_same_ancesters_F}
        ** (we_have_same_ancesters_S) PLAYER: <b>Votre Honneur</b>, nos ancêtres et ceux des <b>Sireines</b> sont les mêmes. #audience:choc #playsound:VOX_Player_memesancetres
            PLAYER: Lorsque <b>Miraterre</b> sombra, certains de nos ancêtres furent sauvés du <b>Déluge</b>, sauvés par la <b>Déesse</b>... #audience:debate #playsound:VOX_Player_miraterresombra
            PLAYER: D'autres n'eurent pas cette chance... Fort heureusement, ils échappèrent à la noyade, eux aussi... #audience:debate #playsound:VOX_Player_dautrespascettechance
            PLAYER: Sauvés par le <shake a=0.5><b>Léviathan</b></shake>. #audience:choc #playsound:VOX_Player_sauvesparleleviathan
            PLAYER: Les deux facettes d'une même pièce... Les deux destins d'un <b>même peuple</b>. #audience:ovation #playsound:VOX_Player_deuxfacettesmemepiece
            ~ audience_judgement(20)
        ** (we_have_same_ancesters_F) PLAYER: <b>Votre Honneur</b>, nos ancêtres et ceux des <b>Sireines</b> sont les mêmes. #audience:choc #playsound:VOX_Player_memesancetres
            PLAYER: Lorsque <b>Miraterre</b> sombra, certains de nos ancêtres furent sauvés du <b>Déluge</b>, sauvés par la <b>Déesse</b>... #audience:debate #playsound:VOX_Player_miraterresombra
            PLAYER: D'autres n'eurent pas cette chance... Fort heureusement, ils échappèrent à la noyade, eux aussi... #audience:debate #playsound:VOX_Player_dautrespascettechance
            PLAYER: Sauvés par le <shake a=0.5><b>Léviathan</b></shake>. #audience:choc #playsound:VOX_Player_sauvesparleleviathan
            PLAYER: Les deux facettes d'une même pièce... Les deux destins d'un <b>même peuple</b>. #audience:booing #playsound:VOX_Player_deuxfacettesmemepiece
            ~ audience_judgement(-10)
    * [Nous pourrions nous unir. {t(CHAR, 0)}] // 70%
        {sc(CHAR, 0): -> we_could_unify_S | -> we_could_unify_F}
        ** (we_could_unify_S) PLAYER: Nos deux peuples pourraient s'unir, <b>Votre Honneur</b>. Faire la paix, du moins. #audience:debate #playsound:VOX_Player_uniondespeuples
            PLAYER: Avant le <b>Déluge</b>, nous ne formions qu'une seule et même communauté... #audience:debate #playsound:VOX_Player_memecommunaute
            PLAYER: Il serait temps d'abandonner notre haine, et de leur montrer... à eux, nos frères et nos sœurs... le respect qu'ils méritent. #audience:ovation #playsound:VOX_Player_abandonnerlahaine
            ~ audience_judgement(20)
        ** (we_could_unify_F) PLAYER: Nos deux peuples pourraient s'unir, <b>Votre Honneur</b>. Faire la paix, du moins. #audience:debate #playsound:VOX_Player_uniondespeuples
            PLAYER: Avant le <b>Déluge</b>, nous ne formions qu'une seule et même communauté... #audience:debate #playsound:VOX_Player_memecommunaute
            PLAYER: Il serait temps d'abandonner notre haine, et de leur montrer... à eux, nos frères et nos sœurs... le respect qu'ils méritent. #audience:booing #playsound:VOX_Player_abandonnerlahaine
            ~ audience_judgement(-10)
    * [Rester silencieux.] JUGE ERNEST: Vous préférez garder le silence... #playsound:VOX_Judge_preferezgardersilencepointpointp #audience:debate
        ~ audience_judgement(-10)
        -> are_sireine_doomed
- JUGE ERNEST: Insinuez-vous que l'infâme créature... Le <shake a=0.5><b>Léviathan</b></shake> lui-même, aurait <b>sauvé</b> ces gens ? #playsound:VOX_Judge_insinuezcreatureinfame
    * [Ma présence en est la preuve. {t(CHAR, 10)}] // 80%
        {sc(CHAR, 10): -> i_am_the_proof_S | -> i_am_the_proof_F}
        ** (i_am_the_proof_S) PLAYER: <b>Votre Honneur</b>, ma présence en ces lieux devrait répondre à votre interrogation... #audience:debate #playsound:VOX_Player_mapresencerepond
            PLAYER: Dois-je vous rappeler que le <shake a=0.5><b>Léviathan</b></shake> m'a avalé, avec tout mon équipage ? #audience:debate #playsound:VOX_Player_doisjerappeler
            PLAYER: Pourtant, je suis ici, devant vous. En chair et en os... #anim:Player:bow #audience:ovation #playsound:VOX_Player_pourtantjesuisici
            ~ audience_judgement(10)
        ** (i_am_the_proof_F) PLAYER: <b>Votre Honneur</b>, ma présence en ces lieux devrait répondre à votre interrogation... #audience:debate #playsound:VOX_Player_mapresencerepond
            PLAYER: Dois-je vous rappeler que le <shake a=0.5><b>Léviathan</b></shake> m'a avalé, avec tout mon équipage ? #audience:debate #playsound:VOX_Player_doisjerappeler
            PLAYER: Pourtant, je suis ici, devant vous. En chair et en os... #anim:Player:bow #audience:booing #playsound:VOX_Player_pourtantjesuisici
            ~ audience_judgement(-10)
    * [Êtes-vous donc idiot ? {t(STRE, 0)}] // 70%
        {sc(STRE, 0): -> are_you_dumb_S | -> are_you_dumb_F}
        ** (are_you_dumb_S) PLAYER: <b>Votre Honneur</b>, êtes-vous stupide ? #audience:choc #playsound:VOX_Player_etesvousstupide
            PLAYER: N'avez-vous donc rien remarqué ? Le <shake a=0.5><b>Léviathan</b></shake> m'a avalé, et pourtant... #audience:debate #playsound:VOX_Player_rienremarquelevi
            PLAYER: Je ne suis point un spectre, contrairement à vous ! #audience:laughter #playsound:VOX_Player_pasunspectre
            PLAYER: ... Sauf votre respect, <b>Votre Honneur</b>. #audience:ovation #playsound:VOX_Player_saufvotrerespecthonneur
            ~ audience_judgement(20)
        ** (are_you_dumb_F) PLAYER: <b>Votre Honneur</b>, êtes-vous stupide ? #audience:choc #playsound:VOX_Player_etesvousstupide
            PLAYER: N'avez-vous donc rien remarqué ? Le <shake a=0.5><b>Léviathan</b></shake> m'a avalé, et pourtant... #audience:debate #playsound:VOX_Player_rienremarquelevi
            PLAYER: Je ne suis point un spectre, contrairement à vous ! #audience:debate #playsound:VOX_Player_pasunspectre
            PLAYER: ... Sauf votre respect, <b>Votre Honneur</b>. #audience:booing #playsound:VOX_Player_saufvotrerespecthonneur
            ~ audience_judgement(-10)
- (are_sireine_doomed) JUGE ERNEST: Ainsi, vous semblez penser que les <b>Sireines</b> ne sont pas des créatures damnées ? #playsound:VOX_Judge_sireinespasdamnesq #audience:debate
    * [Irène était une Sireine. {t(CHAR, -20)}] // 50%
        {sc(CHAR, -20): -> irene_was_a_sireine_S | -> irene_was_a_sireine_F}
        ** (irene_was_a_sireine_S) PLAYER: <b>Votre Honneur</b>, n'avez-vous donc pas compris ? #audience:debate #playsound:VOX_Player_honneurpascompris
            PLAYER: <b>Irène</b> elle-même... Votre propre fille... #playsound:VOX_Player_irenevotrefille
            PLAYER: ... était une <b>Sireine</b>. #audience:choc #playsound:VOX_Player_cestunesireneomg
            PLAYER: Elle fut retrouvée, sur un rocher, en pleine tempête. Pour quelle raison se trouvait-elle en pleine mer ? #audience:debate
            PLAYER: Comment expliquer autrement qu'elle ne fut pas noyée ? #audience:applause
            PLAYER: En conspuant Naïda, ainsi que les siens, c'est la <b>Déesse</b> elle-même que vous insultez ! #audience:ovation
            ~ audience_judgement(30)
        ** (irene_was_a_sireine_F) PLAYER: <b>Votre Honneur</b>, n'avez-vous donc pas compris ? #audience:debate #playsound:VOX_Player_honneurpascompris
            PLAYER: <b>Irène</b> elle-même... Votre propre fille... #playsound:VOX_Player_irenevotrefille
            PLAYER: ... était une <b>Sireine</b>. #audience:choc #playsound:VOX_Player_cestunesireneomg
            PLAYER: Elle fut retrouvée, sur un rocher, en pleine tempête. Pour quelle raison se trouvait-elle en pleine mer ? #audience:debate
            PLAYER: Comment expliquer autrement qu'elle ne fut pas noyée ? #audience:debate
            PLAYER: En conspuant <b>Naïda</b>, ainsi que les siens, c'est la <b>Déesse</b> elle-même que vous insultez ! #audience:booing
                ~ audience_judgement(-10)
    * [Pas maudites mais bénies. {t(DEXT, -10)}] // 60%
        {sc(DEXT, -10): -> sireine_are_blessed_S | -> sireine_are_blessed_F}
        ** (sireine_are_blessed_S) PLAYER: <b>Votre Honneur</b>, si un peuple, avalé par les Eaux lors du <b>Déluge</b>, a pu survivre jusqu'à aujourd'hui... #audience:debate #playsound:VOX_Player_lepeupleasurvecu
            PLAYER: Ne pensez-vous pas qu'il en va de la volonté de la <b>Déesse</b> elle-même ? #audience:debate #playsound:VOX_Player_cestladeesequilavoulu
            PLAYER: Le peuple des <b>Sireines</b> est béni ! Béni de la <b>Déesse</b> ! #audience:ovation #playsound:VOX_Player_bravoladeesse
            ~ audience_judgement(20)
        ** (sireine_are_blessed_F) PLAYER: <b>Votre Honneur</b>, si un peuple, avalé par les Eaux lors du <b>Déluge</b>, a pu survivre jusqu'à aujourd'hui... #audience:debate #playsound:VOX_Player_lepeupleasurvecu
            PLAYER: Ne pensez-vous pas qu'il en va de la volonté de la <b>Déesse</b> elle-même ? #audience:debate #playsound:VOX_Player_cestladeesequilavoulu
            PLAYER: Le peuple des <b>Sireines</b> est béni ! Béni de la <b>Déesse</b> ! #audience:booing #playsound:VOX_Player_bravoladeesse
            ~ audience_judgement(-10)
    * [Rester silencieux.] JUGE ERNEST: Vous préférez garder le silence ? Passons... #playsound:VOX_Judge_preferezgardersilence2 #audience:debate
        ~ audience_judgement(-10)
- JUGE ERNEST: Ces paroles seront vos dernières, <b>Accusé</b>. #playsound:VOX_Judge_parolesdernieresaccuse
JUGE ERNEST: Ainsi ce procès arrive à sa <b>conclusion</b>... #playsound:VOX_Judge_procesconclusiono
JUGE ERNEST: Je demande désormais solennellement aux jurés de bien vouloir rendre leur <b>verdict</b>... #playsound:VOX_Judge_demandejuresverdict #audience:ovation
- -> trial_verdict

// Trial verdict
= trial_verdict
{
    - t_audience_judgement >= 50:
        ~ verdict_is_innocent = true
        -> player_is_innocent
    - else:
        ~ verdict_is_guilty = true
        -> player_is_guilty
}

// Player is innocent
= player_is_innocent
JUGE ERNEST: Mesdames et messieurs les jurés... #playsound:VOX_Judge_mesdamesmessieursjures
JUGE ERNEST: Qui vote... <shake a=0.5><b>coupable</b></shake> ? #playsound:VOX_Judge_quicoupable #box #wait:1 #audience:applause
JUGE ERNEST: Et maintenant... #playsound:VOX_Judge_etmaintenant #audience:debate
JUGE ERNEST: Qui vote... <shake a=0.5><b>innocent</b></shake> ? #playsound:VOX_Judge_quiinnocent #box #wait:1.4 #audience:ovation #anim:Player:bow
~ audience_judgement(100) // La balance penche complètement si innocent
{
    - p_name == "Merlin":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisMerlin #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - p_name == "Ambroise":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisAmbroise #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - p_name == "Octave":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisOctave #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - else:
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisMerlin #playsound:Play_MUS_Story_SC_Trial_ResultRoll
}
JUGE ERNEST: <shake a=0.5><b>INNOCENT</b></shake> !!! #playsound:Play_MUS_Story_SC_Trial_Innocent #playsound:VOX_Judge_INNOCENT #audience:ovation #anim:Judge:bell
JUGE ERNEST: L'<b>Accusé</b>, ainsi que <b>Naïda la Sireine</b>, peuvent retrouver leur liberté. #playsound:VOX_Judge_accuseetnaidelibres #audience:ovation #anim:Judge:bell
- -> naida_speech

// Player is guilty
= player_is_guilty
JUGE ERNEST: Mesdames et messieurs les jurés... #playsound:VOX_Judge_mesdamesmauvais
JUGE ERNEST: Qui vote... <shake a=0.5><b>innocent</b></shake> ? #playsound:VOX_Judge_quivotemauvaisinnocent #box #wait:1 #audience:applause
JUGE ERNEST: Et maintenant... #playsound:VOX_Judge_etmaintenantmauvais #audience:debate
JUGE ERNEST: Qui vote... <shake a=0.5><b>coupable</b></shake> ? #playsound:VOX_Judge_quicoupablemauvais #box #wait:1.4 #audience:ovation #anim:Player:bow
{
    - p_name == "Merlin":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisMerlin #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - p_name == "Ambroise":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisAmbroise #playsound:Play_MUS_Story_SC_Trial_ResultRoll
    - p_name == "Octave":
        JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le <b>Juge</b> déclare solennellement Messire <b>{p_name} Jehovah Banes</b>, citoyen de plein droit de <b>Miraterre</b>, et descendant du peuple qui fut sauvé... #playsound:VOX_Judge_ainsiverdictmauvaisOctave #playsound:Play_MUS_Story_SC_Trial_ResultRoll
}
- JUGE ERNEST: <shake a=0.5><b>COUPABLE</b></shake> !!! #playsound:Play_MUS_Story_SC_Trial_Coupable #playsound:VOX_Judge_COUPABLE #audience:ovation #anim:Judge:bell
~ audience_judgement(-100) // La balance penche complètement si coupable
JUGE ERNEST: Coulez-le, ainsi que <b>l'affreuse Sireine</b>, où la <b>Déesse</b> ne saurait le trouver... #playsound:VOX_Judge_coulezle #audience:ovation 
JUGE ERNEST: ... Au fond des océans ! #playsound:VOX_Judge_aufonddesoceans #audience:ovation #anim:Judge:bell
- -> naida_speech

= naida_speech
NAÏDA: Avant cela, si vous le permettez... #audience:choc #playsound:VOX_Naida_avantcelasi #playsound:Play_MUS_Story_SC_Trial_NaidaSpeech
NAÏDA: Je voudrais dire quelques mots. #audience:debate #playsound:VOX_Naida_jevoudraisdiremo
NAÏDA: Je resterai digne, et ferai montre de respect, car j'ai souffert de ne pas l'avoir obtenu de votre part à tous... #audience:silent #playsound:VOX_Naida_resteraidigne #audience:empathy
NAÏDA: Que nos ancêtres aient été ou non des semblables, des frères... cela, pour moi, ne change rien. #audience:applause #playsound:VOX_Naida_quenos
NAÏDA: Je voudrais simplement dire à quel point il est étrange, pour une créature telle que moi... #playsound:VOX_Naida_jevoudraissimplement
NAÏDA: Une pauvre <b>Sireine</b>... Une poiscaille... #playsound:VOX_Naida_unepauvresireine #audience:empathy
NAÏDA: Combien il est étrange de constater que vous autres, humains, ayez donné à ce système, le nom de « Justice ». #audience:debate #playsound:VOX_Naida_combienilestetrange
{
    - verdict_is_innocent: NAÏDA: Aujourd'hui, elle nous est favorable...  L'aurait-elle été hier ? #audience:debate #playsound:VOX_Naida_aujourdhuifavorable
    - verdict_is_guilty: NAÏDA: Aujourd'hui, elle nous est défavorable... L'aurait-elle été demain ? #audience:debate #playsound:VOX_Naida_aujourdhuidefavo
}
{
    - p_name == "Merlin":
        NAÏDA: Je remercie <b>Merlin</b> de s'être battu pour qu'on me nomma bien, par <b>mon nom</b>. #audience:applause #playsound:VOX_Naida_remercieMerlin
    - p_name == "Ambroise":
        NAÏDA: Je remercie <b>Ambroise</b> de s'être battu pour qu'on me nomma bien, par <b>mon nom</b>. #audience:applause #playsound:VOX_Naida_remercieAmbroise
    - p_name == "Octave":
        NAÏDA: Je remercie <b>Octave</b> de s'être battu pour qu'on me nomma bien, par <b>mon nom</b>. #audience:applause #playsound:VOX_Naida_remercieOctave
    - else:
        NAÏDA: Je remercie <b>Merlin</b> de s'être battu pour qu'on me nomma bien, par <b>mon nom</b>. #audience:applause #playsound:VOX_Naida_remercieMerlin
}
- NAÏDA: Car <b>les noms</b>, voyez-vous, sont le <b>cœur battant</b> de toute chose. Les noms sont <b>importants</b>. #audience:applause #playsound:VOX_Naida_carlesnoms
NAÏDA: Ainsi il m'apparaît, pour conclure notre histoire, qu'en donnant à un système partial et imparfait, le nom même d'une <b>vertu</b>... #audience:silent #playsound:VOX_Naida_ainsiilmapparait
NAÏDA: En lui donnant le nom de <b>« Justice »</b>... #audience:debate #playsound:VOX_Naida_enluidonnantjustice
NAÏDA: Vous autres humains ayez commis une erreur... <shake a=0.5><b>cruelle</b></shake>. #anim:Naida:bow #box #audience:ovation #playsound:VOX_Naida_vousautreshumains #curtains:close #wait:10 #audience:ovation
- -> cast_salutation