// SECRET MEETING SCENE

// Variables
VAR threat_arle = false
VAR has_fail = false

// Scene
=== secret_meeting ===
-> start

// Start of the scene
= start
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Arle:VOIX CHUCHOTÉE:BOUFFONNE:ARLE
// Set the location
#set:forest
// Set the actor's positions
#position:Player:8:2
//#position:Arle:10:11
//#position:Arle:3:17
#position:Arle:2:10

// Start the scene
#playsound:Play_MUS_Story_SC_SecretMeeting_Intro
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #anim:Arle:crawling #wait:3

- // On se trouve sur scène, seul.
    * [Attendre son interlocuteur.]
- #audience:applause
    * [Attendre encore.]
- #audience:debate #playsound:Play_MUS_Story_SC_SecretMeeting_Encore
    * [Attendre plus fort.]
- #audience:booing
- SOUFFLEUR: Le public s'impatiente ! Si ta partenaire de scène ne daigne pas se montrer... Tu vas devoir meubler ! #playsound:VOX_Souffleur_partenairedescene
SOUFFLEUR: J'ai une idée, l'ami ! Fais appel à l'un de tes <b>talents</b> !
SOUFFLEUR: Que tu réussisses ou que tu échoues... ça vaut le coup de tenter ta chance !
    * [Effectuer une danse. {t(DEXT, 30)}]
        {sc(DEXT, 30): -> dancing_S | -> dancing_F}
        ** (dancing_S) SOUFFLEUR: Excellent ! Je ne te connaissais pas un talent de danseur ! Tu as le rythme dans la peau, l'ami ! #playsound:Play_MUS_Story_SC_SecretMeeting_Meubler
            -> success_entertaining_audience
        ** (dancing_F) SOUFFLEUR: L'idée n'était pas mauvaise, mais... Je ne crois pas que tu aies le rythme dans la peau, l'ami. #playsound:Play_MUS_Story_SC_SecretMeeting_Meubler
            SOUFFLEUR: Ce n'est pas grave. Parfois, faire appel à ses talents demande un coup de chance !
            -> failure_entertaining_audience
    * [Faire des pompes. {t(STRE, 30)}]
        {sc(STRE, 30): -> do_pushups_S | -> do_pushups_F}
        ** (do_pushups_S) SOUFFLEUR: Bien joué ! Tu ne seras pas allé à la salle pour rien, l'ami ! #playsound:Play_MUS_Story_SC_SecretMeeting_Meubler
            -> success_entertaining_audience
        ** (do_pushups_F) #playsound:Play_MUS_Story_SC_SecretMeeting_Meubler
            SOUFFLEUR: Je comprends l'intention, mais les muscles ne suivent pas. Skill issue, l'ami.
            SOUFFLEUR: Bien tenté quand même ! Parfois, faire appel à ses talents demande un coup de chance !
            -> failure_entertaining_audience
    * [Hypnotiser le public. {t(CHAR, 30)}]
        {sc(CHAR, 30): -> hypnotise_S | -> hypnotise_F}
        ** (hypnotise_S) #playsound:Play_MUS_Story_SC_SecretMeeting_Meubler
            SOUFFLEUR: Wow...
            SOUFFLEUR: Je n'avais encore jamais vu un acteur faire appel au... paranormal... Bien joué, l'ami !
            -> success_entertaining_audience
        ** (hypnotise_F) #playsound:Play_MUS_Story_SC_SecretMeeting_Meubler
            SOUFFLEUR: Euh...
            SOUFFLEUR: Je n'avais encore jamais vu un acteur faire appel au... paranormal...
            SOUFFLEUR: Bien tenté quand même ! Parfois, faire appel à ses talents demande un coup de chance !
            -> failure_entertaining_audience
            *** (success_entertaining_audience) VOIX CHUCHOTÉE: <i>(Psssst... Hé ! Cesse d'amuser la galerie, veux-tu ? Ne me vole pas la vedette !)</i> #playsound:VOX_Arle_nevolepasvedette
            *** (failure_entertaining_audience) VOIX CHUCHOTÉE: <i>(Psssst... Hé ! Merci d'avoir tout loupé, camarade ! Ça me permettra de briller d'autant plus !)</i> #playsound:VOX_Arle_mercitoutloupe
-
    * [(Chuchoter) Qui me parle ?] PLAYER: <i>(Qui me parle, au juste ?)</i> #audience:debate
        VOIX CHUCHOTÉE: <i>(Celle qui va bientôt faire une entrée remarquée ! Héhé !)</i>
    * [Ignorer la voix.] PLAYER: ... #audience:debate
- // La scène continue
    * [(À l'actrice) Il est temps que tu me rejoignes.] PLAYER: <i>(Il serait <b>vraiment</b> temps que tu me rejoignes sur scène.)</i> #audience:booing #playsound:VOX_Player_VRAIMENTtemps
    * [(Au public) Il est temps que l'on me rejoigne.] PLAYER: Je crois <b>vraiment</b> qu'il est temps que mon interlocuteur secret daigne se montrer. #audience:laughter #playsound:VOX_Player_VRAIMENTtemps
- VOIX CHUCHOTÉE: <i>(Laissons-les se languir encore un peu... Ça ne rendra mon entrée en scène que plus mémorable !)</i> #playsound:VOX_Arle_laissonslesselanguir //#anim:Arle:get_up_a_bit
    * [Attendre davantage.] #audience:booing
- // On voit un bout de ARLE qui dépasse d'un buisson
    * [(À l'actrice) Tout le monde t'as vu...] PLAYER: <i>(Psssst... Hé ! Tout le monde t'as repéré, cachée derrière le buisson !)</i> #playsound:VOX_Player_toutlemondepeuttevoir
        VOIX CHUCHOTÉE: <i>(Hé ! Ne me donne pas de leçon sur mon jeu de scène, compris ?)</i>
    * [(Au public) On dirait que je suis épié !] PLAYER: J'ai la sensation que je ne suis pas aussi seul que je le croyais... Quelqu'un m'épie ! Quelqu'un qui n'est pas très discret... #audience:laughter #playsound:VOX_Player_quelquunmepie
        VOIX CHUCHOTÉE: <i>(Hé ! Arrête de me ridiculiser auprès du public, tu veux ?)</i>
- #anim:Arle:get_down
    * [Raisonner l'actrice.] PLAYER: <i>(Le public n'attend que ton apparition ! C'est maintenant ou jamais !)</i> #anim:Player:chuchote #playsound:VOX_Player_lepublicnattend
        VOIX CHUCHOTÉE: <i>(J'ai l'impression que tu cherches à me ridiculiser devant mon public adoré.)</i> #playsound:VOX_Arle_jailimpressionpublic
    * [Examiner le buisson.] PLAYER: Ce buisson me semble... suspect... #anim:Player:examine_bush #audience:laughter
- // Le joueur compte
    * [Tirer le buisson.] #anim:Player:pull_bush #playsound:VOX_Player_jecompte0 #audience:choc
        ARLE: Mais qui voilà ?! N'est-ce pas moi ?  #anim:Arle:get_up #anim:Arle:bow #playsound:VOX_Arle_maisquivoila #audience:ovation
- // Arle fait son apparition
    * [Que faisais-tu cachée ?] PLAYER: Que faisais-tu là, cachée tel un rat ? #anim:Player:question
        BOUFFONNE: J'apprenais à vous connaître, messire. Je vous observais...
        ** [Me connaître ?] PLAYER: Me connaître, moi ? #anim:Player:surprised
            BOUFFONNE: Parfaitement, messire.
            *** [Échangeons nos noms.] PLAYER: Faisons un marché. Je t'échange mon nom contre le tien. Qu'en dis-tu ? N'est-ce pas là une honnête transaction ?
                BOUFFONNE: J'ai bien peur, messire, de posséder déjà ce que vous proposez de m'offrir... #anim:Arle:deception
                BOUFFONNE: {p_name}, si je ne m'abuse ? #anim:Arle:question
                **** [Et à qui {p_name} a-t-il l'honneur ?] PLAYER: Et avec qui ai-je le plaisir de m'entretenir ? #anim:Player:question
                    -> arle_presentation
                **** [Refuses-tu d'annoncer qui tu es ?] PLAYER: Refuses-tu d'annoncer qui tu es...
                    ***** [... plaisantine ?] PLAYER: ... plaisantine ? #anim:Player:question #anim:Arle:sad
                        -> arle_presentation
                    ***** [... malandrine ?] PLAYER: ... malandrine ? #anim:Player:question #anim:Arle:sad
                        -> arle_presentation
        ** [C'est toi que je veux connaître.] PLAYER: La politesse exige qu'on se présente le premier.
            BOUFFONNE: Me présenter ? Cela, je sais le faire, et fort bien ! #anim:Arle:happy
            --- (arle_presentation) BOUFFONNE: Je suis Arle, pour vous servir, messire. #anim:Arle:bow #playsound:VOX_Arle_jesuisarle #audience:ovation
    * [Es-tu l'autrice de la lettre ?] PLAYER: Est-ce donc toi qui as écrit la lettre que j'ai reçue la veille ? #anim:Player:question
        BOUFFONNE: Je sais faire bien des choses, messire... #anim:Arle:happy
        BOUFFONNE: Faire la belle... #anim:Arle:prettypose
        BOUFFONNE: Faire le show... #anim:Arle:acrobatics
        BOUFFONNE: ... Mais je ne sais point écrire ! #anim:Arle:sad #audience:laughter
        ** [Qui es-tu ?] PLAYER: Sais-tu au moins dire ton nom ? #anim:Player:question
            -> arle_presentation
        ** [(Se moquer) En voilà une plaisantine. {t(CHAR, 30)}]
            {sc(CHAR, 30): -> mock_arle_S | -> mock_arle_F}
        *** (mock_arle_S) PLAYER: Tu es une authentique bouffonne... #anim:Arle:sad #audience:laughter
                BOUFFONNE: Bouffonne est l'une de mes professions, mais ce n'est pas mon nom. #anim:Arle:stressed
                -> arle_presentation
            *** (mock_arle_F) PLAYER: Une authentique bouffonne... #anim:Player:stressed #anim:Arle:happy
                BOUFFONNE: Je me plais à inspirer le rire, le bonheur... la félicité ! Vous plaisez-vous à inspirer la pitié ? #anim:Arle:happy #audience:laugther #anim:Player:sad
                -> arle_presentation
- #character_presentation:Arle
    * [Qui t'envoie ?] PLAYER: Je présume que tu es au service de quelqu'un. Qui donc ? #anim:Player:question
        ARLE: Je suis au service, en cuisine et à la plonge, messire. Là où on me somme d'être. Quant à qui me commande... #anim:Arle:Bow
            ** [J'attends.] PLAYER: Alors ? #anim:Player:question
            ** [Qui ?] PLAYER: Qui ? #anim:Player:question
            -- ARLE: Si je ne puis vous offrir son identité, je me dois tout de même de vous dire qu'il - ou elle - est très riche.
                *** [C'est bon à savoir.] PLAYER: C'est là l'essentiel.
                *** [Mais encore ?] PLAYER: C'est un bon début, mais où cela va-t-il nous mener ? #anim:Player:question
    * [Pourquoi tant de mystère ?] PLAYER: La lettre non signée, le rendez-vous secret... Pourquoi tant de mystère ? #anim:Player:question
    * [Que me veut-on ?] PLAYER: Ce rendez-vous commence sous de mauvais augures. Énonce-moi prestement ce qu'on attend de moi. #anim:Player:question
- -> the_mission

= the_mission
- ARLE: La personne qui m'envoie souhaiterait vous offrir un travail. Disons plutôt : une mission. #playsound:VOX_Arle_raisonconvocation
    * [Continue.] -> what_is_the_mission
    * [Je t'écoute.]  -> what_is_the_mission
    * [Dépêche-toi !]  -> what_is_the_mission
- (what_is_the_mission) PLAYER: Quelle est donc cette mission ? #anim:Player:question #playsound:VOX_Player_quelleestcettemission
ARLE: D'abord dois-je vous demander, messire : quel rapport entretenez-vous avec l'acte de tuer ? #anim:Arle:question #playsound:VOX_Arle_quelrapporttuer #anim:Player:surprised #audience:choc
    * [Hors de question.] PLAYER: Ôter une vie n'est pas dans mes pratiques. #audience:ovation #trial
        ~ trial()
        ~ t_1_refuse_to_kill = true
        PLAYER: Je ne suis pas un tueur, mais un marin. Tout juste suis-je capable d'ôter la vie à un poisson... #anim:Player:non
        ARLE: Il se trouve justement que c'est un poisson que l'on souhaiterait voir mort. Un gros poisson. #anim:Arle:happy #audience:debate
        -- (big_fish)
        ** [Un gros poisson ?] PLAYER : Un gros poisson tu dis ? Gros comment ? #anim:Player:question
            ARLE: Je n'ai pas les bras assez longs, messire. Gros comme le dédommagement que mon maître est prêt à vous offrir pour l'abattre. #anim:Arle:groscommeca
        ** [Assez de mystère !] PLAYER: Il suffit ! J'en ai assez de tout ce mystère : parle maintenant ou permets-moi d'aller me recoucher. #anim:Player:angry
            ARLE : Ce poisson est un très gros poisson, messire. Aussi gros que le dédommagement que mon maître est prêt à vous offrir pour l'abattre. #anim:Arle:groscommeca
    * [Sans soucis.] PLAYER : Tuer ne me dérange nullement. #audience:choc #trial
        ~ trial()
        ~ t_1_accept_to_kill = true
        PLAYER: Dis-m'en plus : qui voulez-vous voir périr ? #audience:debate
        ARLE: Un poisson, messire. Un gros poisson. #audience:debate
        -> big_fish
- ARLE: Prenez ceci, voulez-vous ? #anim:Arle:give_map #playsound:VOX_Arle_prenezceci
    * [Qu'est-ce que c'est ?] PLAYER: Qu'est-ce donc ? #anim:Player:question
- ARLE: Un marin tel que vous ne reconnaît-il pas une carte quand il en voit une, messire ? #anim:Arle:bow #audience:laughter
    * [Quel endroit indique t-elle ?] PLAYER: Quel endroit indique-t-elle ? #anim:Player:question
        ARLE: En voilà une question intéressante... #anim:Arle:happy
    * [Une carte, pourquoi donc ?] PLAYER: Pourquoi aurais-je besoin d'une carte ? #anim:Player:question
        ARLE: Vous le saurez bien assez tôt... #anim:Arle:happy
    * [Pas besoin de carte.] PLAYER: Je n'ai nul besoin de carte. Je puis déjà aller où je le désire...
        ARLE: Prenez-là tout de même, faites-moi confiance, messire...
~ add_to_inventory(i_map_leviathan)
- ARLE: Puis-je vous raconter une petite histoire, messire ? #anim:Arle:question
    * [J'adore les histoires !] PLAYER: Je t'en prie !
    * [Fais vite.] PLAYER: Je n'ai point ton temps, presse-toi. #anim:Player:angry
    * [Hors de question.] PLAYER: Non. #anim:Player:non
        ARLE: Si je ne le fais pas pour vous, messire...
        ARLE: Je le ferai pour eux. #anim:Arle:point_audience #audience:applause
- ARLE: Il était une fois... une terrible tempête. #audience:choc
ARLE: Pas n'importe quelle tempête : celle-ci dura près d'un siècle. #audience:debate
ARLE: Pour survivre, les Hommes durent bâtir un immense navire... #audsience:ovation
ARLE: Avec la montée des eaux vint d'autres fléaux. L'un d'eux était un poisson...
- #anim:Arle:swimming #audience:laughter // Arle, accroché à une corde, mime un poisson qui nage
- ARLE: Ce poisson, voyez-vous, était si gros qu'il aurait pu avaler une ville entière. #audience:choc
    * [Le Léviathan !] PLAYER: Le léviathan ! #anim:Player:surprised #audience:choc
        ARLE: Le Léviathan, messire.
    * [Rester silencieux.]
- ARLE: Plus d'une fois, il manqua d'engloutir les Hommes... Fort heureusement, la <b>Déesse Irène</b> nous sauva tous ! #audience:applause
- ARLE: C'est pourquoi nous jouissons d'être en vie aujourd'hui, n'est-ce pas ?
ARLE: Malheureusement, il n'y a pas que les Hommes qui survécurent au Déluge... La créature, elle aussi, est en vie aujourd'hui. #audience:debate
    * [Moi, tuer le Léviathan ?] PLAYER: Suis-je en plein rêve, ou me demandes-tu vraiment d'aller tuer le Léviathan ? #anim:Player:question #audience:laugther
        ARLE: Il n'y a point matière à rire... Cette entreprise est tout à fait sérieuse. #audience:choc
    * [C'est une plaisanterie ?] PLAYER: Si c'est une plaisanterie, elle est de mauvais goût. #audience:laughter #anim:Player:laugh
        ARLE: Il n'y a point matière à rire... Cette entreprise est tout à fait sérieuse. #audience:choc
    * [Il va falloir me payer grassement.] PLAYER: Si ton maître veut me faire courir un tel risque... Il a intérêt à me payer grassement ! #audience:laughter
- ARLE: Si vous acceptez de ramener le cœur du terrible Léviathan, mon maître vous offrira le poids de votre navire en or.
    * [Une sacrée somme.] PLAYER: Une somme qui n'est pas à prendre à la légère... #anim:Player:joy
    * [(Négocier) Mon navire est léger. {t(CHAR, -10)}]
        {sc(CHAR, -10): -> negociate_S | -> negociate_F} 
            *** (negociate_S) PLAYER: Mon navire est fait d'un bois très léger, voyez-vous...
                ARLE: Vous êtes dur en affaire, messire. Alors disons le double ! #anim:Arle:angry
            *** (negociate_F) PLAYER: Mon navire, euh... est au régime. Il a perdu du poids, et... #anim:Player:stressed
                ARLE: Messire, ces simagrées ne vous honorent pas. Notre position est ferme, j'en ai peur. #anim:Arle:deception
- ARLE: Ramenez-nous le cœur de l'immonde Léviathan, sinon pour la gloire, pour l'intérêt de la Couronne.
    * [Est-ce la Couronne qui t'envoie ?] PLAYER: Que veux-tu dire ? Est-ce donc la Couronne qui t'envoie ? #anim:Player:question
        -- (to_the_crown) ARLE: Seriez-vous plus enclin à rendre ce service s'il était au profit de la Couronne elle-même ? #anim:Arle:happy
            ** [Je ferai tout pour Elle !] PLAYER: Je braverai tous les dangers pour notre bonne reine ! #trial
                ~ trial()
                ~ t_1_respect_the_crown = true
            ** [La reine et sa Couronne m'indiffèrent.] PLAYER: Constance et son inconstance m'inspirent l'indifférence. #audience:laughter #trial
                ~ trial()
                ~ t_1_disrespect_the_crown = true
                ARLE: Ces petites rimes, messire, pourraient vous coûter cher. #anim:Arle:deception
    * [Pour la reine Constance ?] PLAYER: Est-ce la reine elle-même qui demande mon renfort ? #anim:Player:question
        ARLE: Nulle demande ne saurait provenir de la bouche de la reine, messire. Seulement des ordres...
        -> to_the_crown
- ARLE: Puis-je ajouter, messire, que vaincre le Léviathan constituerait une offrande de taille à la <b>Déesse</b> Elle-même.
    * [Pour la Déesse !] PLAYER: J'honorerai la <b>Déesse</b>, j'en fais le serment ! #audience:ovation #trial
        ~ trial()
        ~ t_1_respect_irene = true
    * [Je me fiche de la Déesse.] PLAYER: Je me fiche de la <b>Déesse Irène</b> comme du dernier crachin ! #anim:Player:disappointed#audience:booing #trial
        ~ trial()
        ~ t_1_disrespect_irene = true
        ARLE: Messire, ces paroles ne vous honorent pas. Peut-être n'aurais-je pas du vous laisser penser, en présentant ma requête, que vous aviez le choix. #anim:Arle:deception
    * [Seul m'intéresse le profit.] PLAYER: Si j'accepte, ce ne serait ni pour la reine, ni pour la <b>Déesse</b>, mais pour mon seul profit.
        ~ trial()
        ~ t_1_gold_digger = true
- ARLE: Le jour commence à poindre, messire. Acceptez-vous de ramener le cœur de l'abjecte créature ? #anim:Arle:question #playsound:VOX_Arle_lejourcommence
    * [J'en serai honoré.] PLAYER: Cela serait pour moi un véritable honneur de ramener le cœur du Léviathan. #playsound:VOX_Player_celaseraitunhonneur
        ~ t_1_accept_mission_with_positivity = true
    * [Je n'ai le choix.] PLAYER: Puisque je n'ai point le loisir de me soustraire à la tâche... J'accepte de ramener le cœur du Léviathan. #playsound:VOX_Player_pointleloisirsoustraire
        ~ t_1_accept_mission_with_negativity = true
- #audience:ovation Stop_AMB_SC_Cale_Ambiance
- -> barge.scene_2