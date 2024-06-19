// SECRET MEETING SCENE

// Variables
VAR threat_arle = false
VAR has_fail = false
VAR player_is_close_to_bush = false
VAR bush_moved = false

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
#position:Arle:4:10

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
- SOUFFLEUR: Le public s'impatiente ! Si ta partenaire de scène ne daigne pas se montrer... Tu vas devoir <b>meubler</b>. #playsound:VOX_Souffleur_lepublicsimpatiente
SOUFFLEUR: J'ai une idée, l'ami ! Fais appel à l'un de tes <b>talents</b> ! #playsound:VOX_Souffleur_jaiuneidee
SOUFFLEUR: Que tu réussisses ou que tu échoues... ça vaut le coup de tenter ta chance ! #playsound:VOX_Souffleur_quetureussissesou
    * [Effectuer une danse. {t(DEXT, 40)}] // 80%
        {sc(DEXT, 40): -> dancing_S | -> dancing_F}
        ** (dancing_S) SOUFFLEUR: Excellent ! Je ne te connaissais pas un talent de danseur ! Tu as le rythme dans la peau, l'ami ! #playsound:VOX_Souffleur_excellent #anim:Player:dance #audience:ovation 
            -> success_entertaining_audience
        ** (dancing_F) SOUFFLEUR: L'idée n'était pas mauvaise, mais... Je ne crois pas que tu aies le rythme dans la peau, l'ami. #playsound:VOX_Souffleur_pasmauvaisidee #anim:Player:fail #audience:booing
            SOUFFLEUR: Ce n'est pas grave. Parfois, faire appel à ses talents demande un <b>coup de chance</b> ! #playsound:VOX_Souffleur_pasgrave
            -> failure_entertaining_audience
    * [Faire des pompes. {t(STRE, 40)}] // 80%
        {sc(STRE, 40): -> do_pushups_S | -> do_pushups_F}
        ** (do_pushups_S) SOUFFLEUR: Bien joué ! Tu ne seras pas allé à la salle pour rien, l'ami ! #playsound:VOX_Souffleur_bienjouetunesalle #anim:Player:pushup #audience:ovation
            -> success_entertaining_audience
        ** (do_pushups_F) #playsound:Play_MUS_Story_SC_SecretMeeting_Meubler #anim:Player:fail #audience:booing
            SOUFFLEUR: Je comprends l'intention, mais les muscles ne suivent pas. Skill issue, l'ami. #playsound:VOX_Souffleur_comprensmaispasmuscles
            SOUFFLEUR: Bien tenté quand même ! Parfois, faire appel à ses talents demande un coup de chance ! #playsound:VOX_Souffleur_biententequandmeme
            -> failure_entertaining_audience
    * [Hypnotiser le public. {t(CHAR, 40)}] // 80%
        {sc(CHAR, 40): -> hypnotise_S | -> hypnotise_F}
        ** (hypnotise_S) #playsound:Play_MUS_Story_SC_SecretMeeting_Meubler #anim:Player:hypnose #audience:ovation
            SOUFFLEUR: Wow... #playsound:VOX_Souffleur_wowimpress
            SOUFFLEUR: Je n'avais encore jamais vu un acteur faire appel au... paranormal... Bien joué, l'ami ! #playsound:VOX_Souffleur_paranormalgg
            -> success_entertaining_audience
        ** (hypnotise_F) #playsound:Play_MUS_Story_SC_SecretMeeting_Meubler #anim:Player:hypnose #audience:booing
            SOUFFLEUR: Euh... #playsound:VOX_Souffleur_euhpasimpress
            SOUFFLEUR: Je n'avais encore jamais vu un acteur faire appel au... paranormal... #playsound:VOX_Souffleur_paranormalff
            SOUFFLEUR: Bien tenté quand même ! Parfois, faire appel à ses talents demande un coup de chance ! #playsound:VOX_Souffleur_biententetalentschance
            -> failure_entertaining_audience
            *** (success_entertaining_audience) VOIX CHUCHOTÉE: <i>(Psssst... Hé ! Cesse d'amuser la galerie, veux-tu ? Ne me vole pas la vedette !)</i> #playsound:VOX_Arle_pssthecesse
            *** (failure_entertaining_audience) VOIX CHUCHOTÉE: <i>(Psssst... Hé ! Merci d'avoir loupé, camarade ! Ça me permettra de briller d'autant plus !)</i> #playsound:VOX_Arle_pssthemerci
-
    * [(Chuchoter) Qui me parle ?] PLAYER: <i>(Qui me parle, au juste ?)</i> #audience:debate #playsound:VOX_Player_quimeparle
        VOIX CHUCHOTÉE: <i>(Celle qui va bientôt faire une entrée remarquée ! Héhé !)</i> #playsound:VOX_Arle_cellequiva
    * [Ignorer la voix.] PLAYER: ... #audience:debate
- // La scène continue
    * [(À l'actrice) Il est temps que tu me rejoignes.] PLAYER: <i>(Il serait <b>vraiment</b> temps que tu me rejoignes sur scène.)</i> #audience:booing #playsound:VOX_Player_VRAIMENTtemps
    * [(Au public) Il est temps que l'on me rejoigne.] PLAYER: Je crois <b>vraiment</b> qu'il est temps que mon interlocuteur secret daigne se montrer. #audience:laughter #playsound:VOX_Player_VRAIMENTtempspublic
- VOIX CHUCHOTÉE: <i>(Laissons-les se languir encore un peu... Ça ne rendra mon entrée en scène que plus mémorable !)</i> #playsound:VOX_Arle_lessleslanguir //#anim:Arle:get_up_a_bit
    * [Attendre davantage.] #audience:booing
- // On voit un bout de ARLE qui dépasse d'un buisson
    * [(À l'actrice) Tout le monde t'a vu...] PLAYER: <i>(Psssst... Hé ! Tout le monde t'a repéré, cachée derrière le buisson !)</i> #playsound:VOX_Player_toutlemondepeuttevoir
        VOIX CHUCHOTÉE: <i>(Hé ! Ne me donne pas de leçon sur mon jeu de scène, compris ?)</i> #playsound:VOX_Arle_henemedonnepas
    * [(Au public) On dirait que je suis épié !] PLAYER: J'ai la sensation que je ne suis pas aussi seul que je le croyais... Quelqu'un m'épie ! Quelqu'un qui n'est pas très <i>discret</i>... #playsound:VOX_Player_quelquunmepie #audience:laughter
        VOIX CHUCHOTÉE: <i>(Hé ! Arrête de me ridiculiser auprès du public, tu veux ?)</i> #playsound:VOX_Arle_hearrete #audience:debate
- #anim:Arle:get_down
    * [Raisonner l'actrice.] PLAYER: <i>(Le public n'attend que ton apparition ! C'est maintenant ou jamais !)</i> #anim:Player:chuchote #playsound:VOX_Player_lepublicattendapparition #audience:booing
        VOIX CHUCHOTÉE: <i>(J'ai l'impression que tu cherches à me ridiculiser devant mon public adoré.)</i> #playsound:VOX_Arle_jailimpression
        PLAYER: <i>(Puisque tu refuses de coopérer...)</i> #audience:debate
        ** [Aller voir de plus près.] -> move_to_bush
    * [Examiner le buisson.] PLAYER: Ce buisson me semble... suspect... #audience:laughter #playsound:VOX_Player_buissonsuspect #move:Player:8:7
        -> pull_bush
        ~ player_is_close_to_bush = true
- {player_is_close_to_bush == false: -> move_to_bush | -> pull_bush}
    * (move_to_bush) PLAYER: Ce buisson me semble... suspect... #audience:laughter #playsound:VOX_Player_buissonsuspect #move:Player:8:7
- (pull_bush)
    * [Tirer le buisson.] 
        ARLE: Mais qui voilà ?! N'est-ce pas <bounce a=0.05>moi</bounce> ? #look:Player:right #audience:choc #anim:Arle:get_up #audience:ovation #playsound:VOX_Arle_maisquivoila #playsound:Play_MUS_Story_SC_SecretMeeting_ArleFirstEncounter #move:Player:8:2
        ~ bush_moved = true
-
    * [Que faisais-tu cachée ?] PLAYER: Que faisais-tu là, cachée tel un rat ? #anim:Player:question #playsound:VOX_Player_cacheerat
        BOUFFONNE: J'apprenais à vous connaître, messire. Je vous observais... #playsound:VOX_Arle_japprenais
        ** [Me connaître ?] PLAYER: Me connaître, moi ?
            BOUFFONNE: Parfaitement, messire. #playsound:VOX_Arle_pargaitement
            *** [Échangeons nos noms.] PLAYER: Faisons un marché. Je t'échange mon nom contre le tien. Qu'en dis-tu ? N'est-ce pas là une honnête transaction ?
                BOUFFONNE: J'ai bien peur, messire, de posséder déjà ce que vous proposez de m'offrir... #anim:Arle:deception #playsound:VOX_Arle_jaibienpeur
                    {
                        - p_name == "Merlin":
                            BOUFFONNE: Merlin, si je ne m'abuse ? #anim:Arle:question #playsound:VOX_Arle_merlin
                        - p_name == "Ambroise":
                            BOUFFONNE: Ambroise, si je ne m'abuse ? #anim:Arle:question #playsound:VOX_Arle_ambroise
                        - p_name == "Octave":
                            BOUFFONNE: Octave, si je ne m'abuse ? #anim:Arle:question #playsound:VOX_Arle_octave
                    }
                **** [Et à qui {p_name} a-t-il l'honneur ?] PLAYER: Et avec qui ai-je le plaisir de m'entretenir ? #anim:Player:question
                    -> arle_presentation
                **** [Refuses-tu d'annoncer qui tu es ?] PLAYER: Refuses-tu d'annoncer qui tu es...
                    ***** [... plaisantine ?] PLAYER: ... plaisantine ? #anim:Player:question #anim:Arle:sad
                        -> arle_presentation
                    ***** [... malandrine ?] PLAYER: ... malandrine ? #anim:Player:question #anim:Arle:sad
                        -> arle_presentation
        ** [C'est toi que je veux connaître.] PLAYER: La politesse exige qu'on se présente le premier.
            BOUFFONNE: Me présenter ? Cela, je sais le faire, et fort bien ! #anim:Arle:happy #playsound:VOX_Arle_mepresenter
            --- (arle_presentation) BOUFFONNE: Je suis <b>Arle</b>, pour vous servir, messire. #anim:Arle:bow #playsound:VOX_Arle_jesuisarle #audience:ovation #playsound:Play_MUS_Story_SC_SecretMeeting_ArleGivesName
    * [Es-tu l'autrice de la lettre ?] PLAYER: Est-ce donc toi qui as écrit la lettre que j'ai reçue la veille ? #anim:Player:question #playsound:VOX_Player_toiecritlettre
        BOUFFONNE: Je sais faire bien des choses, messire... #anim:Arle:happy #playsound:VOX_Arle_jesaisfaire
        BOUFFONNE: Faire la belle... #playsound:VOX_Arle_fairelabelle
        BOUFFONNE: Faire le show... #playsound:VOX_Arle_lewhow
        BOUFFONNE: ... Mais je ne sais point écrire ! #anim:Arle:sad #audience:laughter #playsound:VOX_Arle_maispointecrir #playsound:Play_MUS_Story_SC_SecretMeeting_ArleJoke
        ** [Qui es-tu ?] PLAYER: Sais-tu au moins dire ton nom ? #anim:Player:question #playsound:VOX_Player_saisdirenom
            -> arle_presentation
        ** [(Se moquer) En voilà une plaisantine. {t(CHAR, 30)}] // 70%
            {sc(CHAR, 30): -> mock_arle_S | -> mock_arle_F}
        *** (mock_arle_S) PLAYER: Tu es une authentique <bounce a=0.05>bouffonne</bounce>... #anim:Arle:sad #audience:laughter #playsound:VOX_Player_tuesbouffonne
                BOUFFONNE: <bounce a=0.05>Bouffonne</bounce> est l'une de mes professions, mais ce n'est pas mon nom. #anim:Arle:stressed #playsound:VOX_Arle_boufonne
                -> arle_presentation
            *** (mock_arle_F) PLAYER: Une authentique <bounce a=0.05>bouffonne</bounce>... #anim:Player:stressed #anim:Arle:happy #playsound:VOX_Player_authentiquebouffonne
                BOUFFONNE: Je me plais à inspirer le rire, le bonheur... la félicité ! Vous plaisez-vous à inspirer la pitié ? #anim:Arle:happy #playsound:VOX_Arle_jinspirelerire #audience:laugther
                -> arle_presentation
-
    * [Qui t'envoie ?] PLAYER: Je présume que tu es au service de quelqu'un. Qui donc ? #anim:Player:question #playsound:VOX_Player_auservice
        ARLE: Je suis au service, en cuisine et à la plonge, messire. Là où on me somme d'être. Quant à qui me commande... #anim:Arle:Bow #playsound:VOX_Arle_alaplonge
            ** [J'attends.] PLAYER: Alors ? #anim:Player:question #playsound:VOX_Player_alors
            ** [Qui ?] PLAYER: Qui ? #anim:Player:question #playsound:VOX_Player_qui
            -- ARLE: Si je ne puis vous offrir son identité, je me dois tout de même de vous dire qu'il - ou elle - est très riche. #playsound:VOX_Arle_puisoffrirident
                *** [C'est bon à savoir.] PLAYER: C'est là l'essentiel.
                *** [Mais encore ?] PLAYER: C'est un bon début, mais où cela va-t-il nous mener ? #anim:Player:question
    * [Pourquoi tant de mystère ?] PLAYER: La lettre non signée, le rendez-vous secret... Pourquoi tant de mystère ? #anim:Player:question #playsound:VOX_Player_lettrenonsignee
    * [Que me veut-on ?] PLAYER: Ce rendez-vous commence sous de mauvais augures. Énonce-moi prestement ce qu'on attend de moi. #anim:Player:question #playsound:VOX_Player_mauvaisaugures
- -> the_mission

= the_mission
- ARLE: La personne qui m'envoie souhaiterait vous offrir un travail. Disons plutôt : une mission. #playsound:VOX_Arle_lapersonnetravail #playsound:Play_MUS_Story_SC_SecretMeeting_TheMission
    * [Continue.] -> what_is_the_mission
    * [Je t'écoute.]  -> what_is_the_mission
    * [Dépêche-toi !]  -> what_is_the_mission
- (what_is_the_mission) PLAYER: Quelle est donc cette mission ? #anim:Player:question #playsound:VOX_Player_quelleestcettemission
ARLE: D'abord dois-je vous demander, messire : quel rapport entretenez-vous avec l'acte de tuer ? #playsound:VOX_Arle_demandermessire #audience:choc
    * [Hors de question.] PLAYER: Ôter une vie n'est pas dans mes pratiques. #audience:ovation #trial #playsound:VOX_Player_oterviepratique #playsound:Play_MUS_Story_SC_SecretMeeting_Kill
        ~ trial()
        ~ t_1_refuse_to_kill = true
        PLAYER: Je ne suis pas un tueur, mais un marin. Tout juste suis-je capable d'ôter la vie à un poisson... #anim:Player:non
        ARLE: Il se trouve justement que c'est un poisson que l'on souhaiterait voir mort. Un <b>gros poisson</b>. #anim:Arle:happy #audience:debate #playsound:VOX_Arle_ilsetrouve
        -- (big_fish)
        ** [Un gros poisson ?] PLAYER : Un gros poisson tu dis ? Gros comment ? #anim:Player:question
            ARLE: Je n'ai pas les bras assez longs, messire. Gros comme le dédommagement que mon maître est prêt à vous offrir pour l'abattre. #anim:Arle:groscommeca #playsound:VOX_Arle_pasbrasassez
        ** [Assez de mystère !] PLAYER: Il suffit ! J'en ai assez de tout ce mystère : parle maintenant ou permets-moi d'aller me recoucher. #anim:Player:angry
            ARLE : Ce poisson est un <b>très gros poisson</b>, messire. Aussi gros que le dédommagement que mon maître est prêt à vous offrir pour l'abattre. #anim:Arle:groscommeca #playsound:VOX_Arle_cepoisson
    * [Sans soucis.] PLAYER : Tuer ne me dérange nullement. #audience:choc #trial #playsound:VOX_Player_tuerderangenullement #playsound:Play_MUS_Story_SC_SecretMeeting_Kill
        ~ trial()
        ~ t_1_accept_to_kill = true
        PLAYER: Dis-m'en plus : qui voulez-vous voir périr ? #audience:debate
        ARLE: Un poisson, messire. Un gros poisson. #audience:debate #playsound:VOX_Arle_unpoisson
        -> big_fish
- ARLE: Puis-je vous raconter une petite histoire, messire ? #anim:Arle:question #playsound:VOX_Arle_puisjehistroire
    * [J'adore les histoires !] PLAYER: Je t'en prie ! #playsound:VOX_Player_jetenprie
    * [Fais vite.] PLAYER: Je n'ai point ton temps, presse-toi. #anim:Player:angry #playsound:VOX_Player_pointtontemps
    * [Hors de question.] PLAYER: Non. #anim:Player:non #playsound:VOX_Player_non
        ARLE: Si je ne le fais pas pour vous, messire... #playsound:VOX_Arle_paspourvous
        ARLE: Je le ferai pour eux. #anim:Arle:point_audience #audience:applause #playsound:VOX_Arle_poureux
- ARLE: Il était une fois... une <shake a=0.5>terrible tempête</shake>. #move:Arle:8:7 #audience:choc #playsound:VOX_Arle_iletaitunefois
ARLE: Pas n'importe quelle tempête : celle-ci dura <b>près d'un siècle</b>. #audience:debate #playsound:VOX_Arle_pasnimportequelle
ARLE: Avec la montée des eaux vint d'autres fléaux. L'un d'eux était un poisson... #playsound:VOX_Arle_avecmonteeeaux #anim:Arle:monster #audience:choc
    * [Le Léviathan !] PLAYER: Le <shake a=0.5><b>Léviathan</b></shake> ! #anim:Player:surprised #audience:choc #playsound:VOX_Player_leleviathan
        ARLE: Le <shake a=0.5><b>Léviathan</b></shake>, messire. #playsound:VOX_Arle_levimessire
    * [Rester silencieux.]
- ARLE: Plus d'une fois, il manqua d'engloutir les Hommes... Fort heureusement, la <b>Déesse Irène</b> nous sauva tous ! #audience:applause #playsound:VOX_Arle_plusdunefoisengloutir
ARLE: Malheureusement, il n'y a pas que les Hommes qui survécurent au <b>Déluge</b>... La créature, elle aussi, est en vie aujourd'hui. #audience:debate #playsound:VOX_Arle_malheureusement
    * [Moi, tuer le Léviathan ?] PLAYER: Suis-je en plein rêve, ou me demandes-tu vraiment d'aller tuer le <shake a=0.5><b>Léviathan</b></shake> ? #anim:Player:question #audience:laugther #playsound:VOX_Player_enpleinreve
        ARLE: Il n'y a point matière à rire... Cette entreprise est tout à fait sérieuse. #audience:choc #playsound:VOX_Arle_pointmatiere
    * [C'est une plaisanterie ?] PLAYER: Si c'est une plaisanterie, elle est de mauvais goût. #audience:laughter #anim:Player:laugh #playsound:VOX_Player_cestplaisanterie
        ARLE: Il n'y a point matière à rire... Cette entreprise est tout à fait sérieuse. #audience:choc #playsound:VOX_Arle_pointmatiere2
    * [Il va falloir me payer grassement.] PLAYER: Si ton maître veut me faire courir un tel risque... Il a intérêt à me payer grassement ! #audience:laughter #playsound:VOX_Player_tonmaitredanger
- ARLE: Si vous acceptez de ramener le cœur du terrible <shake a=0.5><b>Léviathan</b></shake>, mon maître vous offrira le poids de votre navire en or. #playsound:VOX_Arle_sivousacceptez #audience:debate
    * [Une sacrée somme.] PLAYER: Une somme qui n'est pas à prendre à la légère... #anim:Player:joy
    * [(Négocier) Mon navire est léger. {t(CHAR, 10)}] // 50%
        {sc(CHAR, 10): -> negociate_S | -> negociate_F} 
            *** (negociate_S) PLAYER: Mon navire est fait d'un bois très léger, voyez-vous... #playsound:VOX_Player_boistresleger
                ARLE: Vous êtes dur en affaire, messire. Alors disons <b>le double</b> ! #anim:Arle:angry #playsound:VOX_Arle_vousetesdur
            *** (negociate_F) PLAYER: Mon navire, euh... est au régime. Il a perdu du poids, et... #anim:Player:stressed #playsound:VOX_Player_navireregime
                ARLE: Messire, ces simagrées ne vous honorent pas. Notre position est ferme, j'en ai peur. #anim:Arle:deception #playsound:VOX_Arle_messireces
- ARLE: Ramenez-nous le cœur de l'immonde <shake a=0.5><b>Léviathan</b></shake>, sinon pour la gloire, pour l'intérêt de la <b>Couronne</b>. #playsound:VOX_Arle_ramenezlecoeur
    * [Est-ce la Couronne qui t'envoie ?] PLAYER: Que veux-tu dire ? Est-ce donc la <b>Couronne</b> qui t'envoie ? #anim:Player:question
        -- (to_the_crown) ARLE: Seriez-vous plus enclin à rendre ce service s'il était au profit de la <b>Couronne</b> elle-même ? #anim:Arle:happy #playsound:VOX_Arle_seriezvousenclin
            ** [Je ferai tout pour Elle !] PLAYER: Je braverai tous les dangers pour notre bonne reine ! #trial #playsound:VOX_Player_braveraidangersreine
                ~ trial()
                ~ t_1_respect_the_crown = true
            ** [La reine et sa Couronne m'indiffèrent.] PLAYER: <b>Constance</b> et son inconstance m'inspirent l'indifférence. #audience:laughter #trial #playsound:VOX_Player_constanceinconstance
                ~ trial()
                ~ t_1_disrespect_the_crown = true
                ARLE: Ces petites rimes, messire, pourraient vous coûter cher. #anim:Arle:deception #playsound:VOX_Arle_cespetitesrimes
    * [Pour la reine Constance ?] PLAYER: Est-ce la reine elle-même qui demande mon renfort ? #anim:Player:question
        ARLE: Nulle demande ne saurait provenir de la bouche de la reine, messire. Seulement des ordres... #playsound:VOX_Arle_nulledemande
        -> to_the_crown
- ARLE: Puis-je ajouter, messire, que vaincre le <shake a=0.5><b>Léviathan</b></shake> constituerait une offrande de taille à la <b>Déesse</b> Elle-même. #playsound:VOX_Arle_puisjevaincrelevi
    * [Pour la Déesse !] PLAYER: J'honorerai la <b>Déesse</b>, j'en fais le serment ! #audience:ovation #trial #playsound:VOX_Player_honoreraideesse
        ~ trial()
        ~ t_1_respect_irene = true
    * [Je me fiche de la Déesse.] PLAYER: Je me fiche de la <b>Déesse Irène</b> comme du dernier crachin ! #anim:Player:disappointed#audience:booing #playsound:VOX_Player_fichedeesse #trial
        ~ trial()
        ~ t_1_disrespect_irene = true
        ARLE: Messire, ces paroles ne vous honorent pas. Peut-être n'aurais-je pas du vous laisser penser, en présentant ma requête, que vous aviez le choix. #anim:Arle:deception #playsound:VOX_Arle_messiceparoleshon
    * [Seul m'intéresse le profit.] PLAYER: Si j'accepte, ce ne serait ni pour la reine, ni pour la <b>Déesse</b>, mais pour mon seul profit. #playsound:VOX_Player_nidieunimaitre
        ~ trial()
        ~ t_1_gold_digger = true
- ARLE: Le jour commence à poindre, messire. Acceptez-vous de ramener le cœur de l'abjecte créature ? #anim:Arle:question #playsound:VOX_Arle_lejourcommence #playsound:Play_MUS_Story_SC_SecretMeeting_PlayerAccepts
    * [J'en serai honoré.] PLAYER: Cela serait pour moi un véritable honneur de ramener le cœur du <shake a=0.5><b>Léviathan</b></shake>. #playsound:VOX_Player_celaseraitunhonneur
        ~ t_1_accept_mission_with_positivity = true
    * [Je n'ai le choix.] PLAYER: Puisque je n'ai point le loisir de me soustraire à la tâche... J'accepte de ramener le <b>cœur du <shake a=0.5>Léviathan</shake></b>. #playsound:VOX_Player_pointleloisirsoustraire
        ~ t_1_accept_mission_with_negativity = true
- #audience:ovation
- -> barge.scene_2