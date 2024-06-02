// TRIBUNAL SCENE 2

// Variables
VAR naida_name = "LA POISCAILLE"
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
#set:forest // En attendant d'avoir le décors trial
// Set the actor's positions
#position:Player:8:2
#position:Judge:0:5
#position:Naïda:4:20

// Start the scene
#open_curtains
#audience:ovation
#judge_bell
#wait:5
#audience:ovation
#wait:4
// Start the scene
- JUGE ERNEST: Silence ! Silence ! #anim:Judge:bell #audience:silent
JUGE ERNEST: Ainsi, vous avez véritablement affronté une créature marine ?
    * [Pour Irène !] PLAYER: Je l'ai fait. Pour nul autre qu'Irène, Votre Honneur. #audience:ovation
        ~ audience_judgement(0.4)
    * [Pour la Couronne !] PLAYER: Je l'ai fait. Pour nul autre que la Coronne, Votre Honneur. #audience:ovation
        ~ audience_judgement(0.3)
    * [Je n'avais pas le choix...] PLAYER: Je l'ai fait. Je n'avais pas le choix, Votre Honneur... C'était elle ou nous. #audience:ovation
        ~ audience_judgement(0.2)
    
- JUGE ERNEST: À la fin de votre histoire, il semblerait pourtant que le Léviathan vous ait avalé...
JUGE ERNEST: Vous, et votre navire...
    * [Avalé tout cru !] PLAYER: Avalé tout entier, Votre Honneur ! #audience:choc
    * [Pourtant, je suis en vie.] PLAYER: En effet. Pourtant, je suis bel et bien vivant... #audience:debate
- JUGE ERNEST: Bien, bien... Si vous le dites...
    -> judge_proceed_to_mention_the_sireine

// The judge proceed to mention the sireine
= judge_proceed_to_mention_the_sireine
JUGE ERNEST: Accusé, il est un sujet que nous n'avons pas encore évoqué lors de ce procès. #audience:debate
JUGE ERNEST: Ce sujet constitue pourtant le cœur de ce qu'il vous est repproché. #audience:debate
JUGE ERNEST: Je veux bien entendu parler... de votre histoire d'amour avec une sireine. #audience:choc
    * [Laisser le silence retomber.]
- JUGE ERNEST: Mesdames et messieurs les jurés, je vous demande de garder votre calme. #audienc:silent
JUGE ERNEST: Vous savez l'importance de la tâche qui vous incombe. Sachez vous en montrer digne.
JUGE ERNEST: J'appelle à la barre... la sireine. #anim:Judge:bell #audience:choc #move(Naida)
JUGE ERNEST: Avant toute chose : je demande à la créature de ne pas prendre la parole.
JUGE ERNEST: Si tant est qu'elle soit capable de s'exprimer... #audience:laughter
JUGE ERNEST: En effet, ce lieu saint ne saurait acceuillir la voix d'une affreuse sireine !
L'AFFREUSE SIREINE: ... #audience:boing
    * [Vous allez regretter ces paroles !] PLAYER: Retirez ces sales paroles, maudit Juge ! Naïda vaut plus que vous tous réunis !
    * [Elle possède un nom.] PLAYER: L'affreuse sireine, comme vous dites, possède un nom. Naïda.
- JUGE ERNEST: Ainsi, la poiscaille possède un nom ?
LA POISCAILLE: ...
    * [(Menaçant) Appelez-la par son nom. {t(STRE, -20)}]
        {sc(STRE, -20): -> convince_name_naida_S | -> convince_name_naida_F}
            ** (convince_name_naida_S) Votre Honneur, si vous ne daignez pas appeler Naïda par son nom, par la Déesse, vous le pairez. #audience:choc
                ~ audience_judgement(0.1)
                JUGE ERNEST: Bon, bon... Je consens à appeler la créature par ce qui lui sert de nom... #audience:applause
                JUGE ERNEST: Tant que celle-ci ne profane pas ces lieux de sa parole impie. #audience:ovation
                ~ naida_name = "NAÏDA"
            ** (convince_name_naida_F) Peuh... Si tu crois me faire peur, Accusé... Ce procès sera l'occasion de rebaptiser ton amie : la poiscaille. #audience:ovation
    * [(Calme) Tout être a le droit à un nom.{t(CHAR, -20)}]
        {sc(CHAR, -20): -> force_name_naida_S | -> force_name_naida_F}
            ** (force_name_naida_S) Votre Honneur, je vous demande de faire preuve d'humanité en appelant Naïda par son nom. #audience:debate
                ~ audience_judgement(0.1)
                JUGE ERNEST: Bon, bon... Je consens à appeler la créature par ce qui lui sert de nom... #audience:applause
                JUGE ERNEST: Tant que celle-ci ne profane pas ces lieux de sa parole impie. #audience:ovation
                ~ naida_name = "NAÏDA"
            ** (force_name_naida_F) Peuh... Si tu crois m'attendrir, Accusé... Ce procès sera l'occasion de rebaptiser ton amie : la poiscaille. #audience:ovation
- SOUFFLEUR: Je sais ce que tu penses, l'ami... 
SOUFFLEUR: La pièce prend des tournures particulièrement sombres...
SOUFFLEUR: Mais ainsi sont fait nos mythes, pas vrai ?
SOUFFLEUR: Le moment risque d'être difficile pour le personnage de Naïda. Elle saura rester digne, ne t'en fais pas !
SOUFFLEUR: Quand à toi, essaye de la défendre du mieux que tu le peux auprès du Juge, mais surtout du public !
SOUFFLEUR: Fais de ton mieux, entendu ? Bon courage, l'ami !
- JUGE ERNEST: Commencez par nous raconter comment vous avez fait la rencontre de {naida_name}, voulez-vous ?
JUGE ERNEST: Où avez-vous fait sa rencontre, Accusé ?
- (player_and_naida_met)
    * [À l'intérieur du Léviathan.] PLAYER: Lorsque le Léviathan nous a avalé, mon équipage et moi-même... Nous nous sommes retrouvés à l'intérieur de son estomac. #audience:choc
        PLAYER: C'est là que j'ai fait la rencontre du peuple des sireines. #audience:debate
    * [Cela ne vous regarde pas.] PLAYER: Notre histoire ne vous regarde pas, Votre Honneur.
        JUGE ERNEST: Allons, allons... Que dirais-tu d'un marché ?
        JUGE ERNEST: Toi, tu témoignes de votre histoire, et moi je concens à appeler ton amie par son nom. 
        ** [Pas question.] PLAYER: Vous avez perdu ma confiance, Votre Honneur. Il n'en est pas question.
            JUGE ERNEST: Si tu ne racontes pas ton histoire, Accusé... vous serez jugés coupables. #audience:booing
            -> player_and_naida_met
        ** [C'est entendu.] PLAYER: Marché conclus, Votre Honneur. #audience:applause
            -> player_and_naida_met
- JUGE ERNEST: Ainsi, tu as découvert le peuple maudit qui fut jadis noyé...
    * [Ils ne sont pas maudits. {t(DEXT, -20)}]
        {sc(DEXT, -20): -> sireine_are_not_cursed_S | -> sireine_are_not_cursed_F}
        ** (sireine_are_not_cursed_S) PLAYER: Votre Honneur, j'ai toutes les raison de penser que le peuple des sireine n'est en rien maudit. #audience:debate
            PLAYER: Ne pensez-vous pas que si la Déesse avait voulu que le Déluge ne les tuent, ils ne seraient pas vivants aujou'd'hui ? #audience:applause
            ~ audience_judgement(0.1)
        ** (sireine_are_not_cursed_F) PLAYER: Sont-ils réellement maudits ? Qui peut le dire ? #audience:debate
            ~ audience_judgement(-0.03)
    * [Vous seul êtes maudit. {t(STRE, -10)}]
        {sc(STRE, -20): -> judge_is_cursed_S | -> judge_is_cursed_F}
        ** (judge_is_cursed_S) PLAYER: Votre Honneur, s'il est un être maudit en ces lieux, c'est bien vous. #audience:debate
            PLAYER: Un siècle à souffrir, accroché à une roue...
            PLAYER: Si la Déesse avait voulu abréger vos souffrance, ne l'aurait-elle pas fait ? #audience:applause
            ~ audience_judgement(0.1)
        ** (judge_is_cursed_F) PLAYER: C'est vous qui êtes maudit, pas eux ! #audience:debate
            ~ audience_judgement(-0.03)
    * [Rester silencieux.] JUGE ERNEST: Tu sembles n'avoir rien à répondre... #audience:debate
        ~ audience_judgement(-0.03)
- JUGE ERNEST: Accusé, il est une question qui est dans tous les esprits...
JUGE ERNEST: Comment avez-vous pu tomber amoureux d'une engeance du Déluge ?
    * [(Convaincre) Elle est plus proche de nous que vous. {t(STRE, -10)}]
        {sc(STRE, -10): -> closer_to_us_S | -> closer_to_us_F}
        ** (closer_to_us_S) PLAYER: Votre Honneur... Les sireines sont plus proches des humains que vous ne l'êtes vous-même... #audience:choc
            PLAYER: Naïda a un cœur qui bat : le votre n'a t-il pas cessé il y a bien longtemps ? #audience:debate
            PLAYER: Lorsqu'elle se blesse, son sang coule : est-ce votre cas ? #audience:debate
            PLAYER: Un jour... Elle mourra. #audience:silent
            PLAYER: ... #anim:Player:sad
            PLAYER: Peut-on en dire autant de vous ? #audience:ovation
            ~ audience_judgement(0.3)
        ** (closer_to_us_F) PLAYER: Votre Honneur... Les sireines sont plus proches des humains que vous ne l'êtes vous-même... #audience:choc
            PLAYER: Naïda a un cœur qui bat : le votre n'a t-il pas cessé il y a bien longtemps ? #audience:debate
            PLAYER: Lorsqu'elle se blesse, son sang coule : est-ce votre cas ? #audience:debate
            PLAYER: Un jour... Elle mourra. #audience:silent
            PLAYER: ... #anim:Player:sad
            PLAYER: Peut-on en dire autant de vous ? #audience:booing
            ~ audience_judgement(-0.03)
    * [(Persuader) J'ai un cœur.{t(CHAR, -10)}]
        {sc(CHAR, -10): -> we_have_a_heart_S | -> we_have_a_heart_F}
        ** (we_have_a_heart_S) PLAYER: Pour la simple raison que j'ai un cœur, Votre Honneur. #audience:debate
            PLAYER: Naïda aussi en possède un. Et vous, est-ce votre cas ? #audience:choc
            PLAYER: Le votre n'a t-il pas cessé de battre il y a des centaines d'années, attaché à votre roue ?
            PLAYER: Par quel droit un être auquel il manque un cœur peut-il procéder au jugement de ceux qui souffrent et souffrent d'en posséder un ? #audience:ovation
                ~ audience_judgement(0.3)
        ** (we_have_a_heart_F) PLAYER: Pour la simple raison que j'ai un cœur, Votre Honneur. #audience:debate
            PLAYER: Naïda aussi en possède un. Et vous, est-ce votre cas ? #audience:choc
            PLAYER: Le votre n'a t-il pas cessé de battre il y a des centaines d'années, attaché à votre roue ?
            PLAYER: Par quel droit un être auquel il manque un cœur peut-il procéder au jugement de ceux qui souffrent et souffrent d'en posséder un ? #audience:booing
                ~ audience_judgement(-0.03)
    * [Rester silencieux.] JUGE ERNEST: Aucune réponse... Le cœur a ses raisons... #audience:debate
        ~ audience_judgement(-0.03)
- JUGE ERNEST: Accusé, ne souffrez-vous d'aucune honte à défendre ce peuple que le Déluge a puni ?
    * [Nos ancêtres sont communs. {t(DEXT, 0)}]
        {sc(DEXT, 0): -> we_have_same_ancesters_S | -> we_have_same_ancesters_F}
        ** (we_have_same_ancesters_S) PLAYER: Votre Honneur, nos ancêtres et ceux des sireines sont les mêmes. #audience:choc
            PLAYER: Lorsque Miraterre sombra, certains de nos ancêtres furent sauvés du Déluge, sauvés par la Déesse... #audience:debate
            PLAYER: D'autres n'eurent pas cette chance... Fort hereusement, ils échappèrent à la noyade, eux aussi...
            PLAYER: Sauvés par le Léviathan. #audience:choc
            PLAYER: Les deux facettes d'une même pièce... Les deux destins d'un même peuple. #audience:ovation
            ~ audience_judgement(0.3)
        ** (we_have_same_ancesters_F)
    * [Nous pourrions nous unir. {t(STRE, 0)}]
        {sc(STRE, 0): -> we_could_unify_S | -> we_could_unify_F}
        ** (we_could_unify_S) PLAYER: 
        ** (we_could_unify_F)
    * [Rester silencieux.] JUGE ERNEST: Vous préférez garder le silence... #audience:debate
        ~ audience_judgement(-0.03)
        -> are_sireine_doomed
- JUGE ERNEST: Insinuez-vous que l'infâme créature... Le Léviathan lui-même, aurait sauvé ces gens ?
    * [Ma présence en est la preuve. {t(CHAR, 0)}]
        {sc(CHAR, 0): -> i_am_the_proof_S | -> i_am_the_proof_F}
        ** (i_am_the_proof_S) PLAYER: Votre Honneur, ma présence en ces lieux devrait répondre à votre interrogation... #audience:debate
            PLAYER: Dois-je vous rappeler que le Léviathan m'a avalé, avec tout mon équipage ? #audience:debate
            PLAYER: Pourtant, je suis ici, devant vous. En chair et en os... #anim:Player:bow #audience:ovation
            ~ audience_judgement(0.3)
        ** (i_am_the_proof_F) PLAYER: Votre Honneur, ma présence en ces lieux devrait répondre à votre interrogation... #audience:debate
            PLAYER: Dois-je vous rappeler que le Léviathan m'a avalé, avec tout mon équipage ? #audience:debate
            PLAYER: Pourtant, je suis ici, devant vous. En chair et en os... #anim:Player:bow #audience:booing
            ~ audience_judgement(-0.04)
    * [Êtes-vous donc idiot ? {t(STRE, 0)}]
        {sc(STRE, 0): -> are_you_dumb_S | -> are_you_dumb_F}
        ** (are_you_dumb_S) PLAYER: Votre Honneur, êtes-vous stupide ? #audience:choc
            PLAYER: N'avez vous donc rien remarqué ? Le Léviathan m'a avalé, et pourtant... #audience:debate
            PLAYER: Je ne suis point un spectre, contrairement à vous ! #audience:laughter
            PLAYER: ... Sauf votre respect, Votre Honneur. #audience:ovation
            ~ audience_judgement(0.3)
        ** (are_you_dumb_F) PLAYER: Votre Honneur, êtes-vous stupide ? #audience:choc
            PLAYER: N'avez vous donc rien remarqué ? Le Léviathan m'a avalé, et pourtant... #audience:debate
            PLAYER: Je ne suis point un spectre, contrairement à vous ! #audience:debate
            PLAYER: ... Sauf votre respect, Votre Honneur. #audience:booing
            ~ audience_judgement(-0.04)
- (are_sireine_doomed) JUGE ERNEST: Ainsi, vous semblez penser que les sireines ne sont pas des créatures damnées ? #audience:debate
    * [Irène était une sireine. {t(CHAR, -30)}]
        {sc(CHAR, -30): -> irene_was_a_sireine_S | -> irene_was_a_sireine_F}
        ** (irene_was_a_sireine_S) PLAYER: Votre Honneur, n'avez-vous donc pas compris ? #audience:debate
            PLAYER: Irène elle-même... Votre propre fille...
            PLAYER: ... était une sireine. #audience:choc
            PLAYER: Elle fut retrouvée, sur un rocher, en pleine tempête. Pour quelle raison se trouvait-elle en pleine mer ? #audience:debate
            PLAYER: Comment expliquer autrement qu'elle ne fut pas noyée ? #audience:applause
            PLAYER: En conspuant Naïda, ainsi que les siens, c'est la Déesse elle-même que vous insultez ! #audience:ovation
            ~ audience_judgement(0.4)
        ** (irene_was_a_sireine_F) PLAYER: Votre Honneur, n'avez-vous donc pas compris ? #audience:debate
            PLAYER: Irène elle-même... Votre propre fille...
            PLAYER: ... était une sireine. #audience:choc
            PLAYER: Elle fut retrouvée, sur un rocher, en pleine tempête. Pour quelle raison se trouvait-elle en pleine mer ? #audience:debate
            PLAYER: Comment expliquer autrement qu'elle ne fut pas noyée ? #audience:debate
            PLAYER: En conspuant Naïda, ainsi que les siens, c'est la Déesse elle-même que vous insultez ! #audience:booing
                ~ audience_judgement(-0.07)
    * [Pas maudites mais bénies. {t(DEXT, -20)}]
        {sc(DEXT, -20): -> sireine_are_blessed_S | -> sireine_are_blessed_F}
        ** (sireine_are_blessed_S) PLAYER: Votre Honneur, si un peuple, avalé par les Eaux lors du Déluge, a pu survivre jusqu'à aujourdhui... #audience:debate
            PLAYER: Ne pensez-vous pas qu'il en va de la volonté de la Déesse elle-même ? #audience:debate
            PLAYER: Le peuple des sireines est bénie ! Béni de la Déesse ! #audience:ovation
            ~ audience_judgement(0.3)
        ** (sireine_are_blessed_F) PLAYER: Votre Honneur, si un peuple, avalé par les Eaux lors du Déluge, a pu survivre jusqu'à aujourdhui... #audience:debate
            PLAYER: Ne pensez-vous pas qu'il en va de la volonté de la Déesse elle-même ? #audience:debate
            PLAYER: Le peuple des sireines est bénie ! Béni de la Déesse ! #audience:booing
            ~ audience_judgement(-0.04)
    * [Rester silencieux.] JUGE ERNEST: Vous préférez garder le silence ? Passons... #audience:debate
        ~ audience_judgement(-0.03)
- JUGE ERNEST: Ces paroles seront vos dernières, Accusé. 
JUGE ERNEST: Ainsi ce procès arrive à sa conclusion...
JUGE ERNEST: Je demande désormais solennellement aux jurés de bien vouloir rendre leur verdict... #audience:ovation
- -> trial_verdict

// Trial verdict
= trial_verdict
{
    - t_audience_judgement >= 0.5:
        ~ verdict_is_innocent = true
        -> player_is_innocent
    - else:
        ~ verdict_is_guilty = true
        -> player_is_guilty
}

// Player is innocent
= player_is_innocent
JUGE ERNEST: Mesdames et messieur les jurés...
JUGE ERNEST: Qui vote « coupable » ? #audience:applause
JUGE ERNEST: Et maintenant... Qui vote... « innocent » ? #audience:ovation #anim:Player:bow
JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le Juge déclare solennellement Messire {p_name} Jehovah Banes, citoyen de plein droit de Miraterre, et descendant du peuple qui fut sauvé...
JUGE ERNEST: INNOCENT !!! #audience:ovation
JUGE ERNEST: Emmenez-le, ainsi que la sireine, retrouver leur liberté. #audience:ovation
- -> naida_speech

// Player is guilty
= player_is_guilty
JUGE ERNEST: Mesdames et messieur les jurés...
JUGE ERNEST: Qui vote « innocent » ? #audience:applause
JUGE ERNEST: Et maintenant... Qui vote... « coupable » ? #audience:ovation
JUGE ERNEST: Ainsi le verdict des jurés est-il prononcé : le Juge déclare solennellement Messire {p_name} Jehovah Banes, citoyen de plein droit de Miraterre, et descendant du peuple qui fut sauvé...
JUGE ERNEST: COUPABLE !!! #audience:ovation
JUGE ERNEST: Emmenez-le, ainsi que la sireine, au fond des océans. #audience:ovation
- -> naida_speech

= naida_speech
NAÏDA: Avant cela, si vous le permettez... #audience:silent
NAÏDA: Je voudrais dire quelques mots. #audience:debate
NAÏDA: Je resterai digne, et ferai montre de respect, car j'ai souffert de ne pas l'avoir obtenu de votre part à tous...
NAÏDA: Que nos ancêtres aient été ou non des semblables, des frères... cela, pour moi, ne change rien.
NAÏDA: Je voudrais simplement dire à quel point il est étrange, pour une créature telle que moi...
NAÏDA: Une pauvre sireine... Une poiscaille...
NAÏDA: Combien il est étrange de constater que vous autres, humains, ayez donné à ce système, le nom de « Justice ». #audience:debate
{
    - verdict_is_innocent: NAÏDA: Aujourd'hui, elle nous est favorable... L'aurait-elle été hier ? #audience:debate
    - verdict_is_guilty: NAÏDA: Aujourd'hui, elle nous est défavorable... L'aurait-elle été demain ? #audience:debate
}
- NAÏDA: Je remercie {p_name} de s'être battu pour qu'on me nomma bien, par mon nom.
NAÏDA: Car les noms, voyez-vous, sont le cœur battant de toute chose. Les noms sont importants.
NAÏDA: Ainsi il m'apparaît, pour conclure notre histoire, qu'en donnant à un système partial et imparfait, le nom même d'une vertue... #audience:silent
NAÏDA: Vous ayez commis une erreur... cruelle. #anim:Naida:bow #audience:ovation
- -> epilogue








