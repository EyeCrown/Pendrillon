// SECRET MEETING SCENE

// VAriables
VAR threat_jester = false
VAR has_fail = false
VAR failed_breaking_jester_crate = false

// Scene
=== secret_meeting ===
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Arle:???:ARLE
#actor:Prompter:SOUFFLEUR
// Start the scene
-> start

// Start of the scene
= start
// On se trouve sur scène, seul.
    * [Attendre son interlocuteur.]
- #sleep:6 #audience:normal_applause
    * [Attendre encore.]
- #sleep:6 #audience:mild_applause
    * [Attendre plus fort.]
- #sleep:6 #audience:discontent
SOUFFLEUR: Le public s'impatiente ! Si ton partenaire de scène ne daigne pas se montrer... tu vas devoir meubler !
    * [(Ironique) Quelle ponctualité...] PLAYER: Espérons que mon mystérieux interlocuteur arrive avant...
        ** [(Humour) Conclure avec légèreté. {t(CHAR, 10)}]
            {sc(CHAR, 0): -> joke_punctuality_S | -> joke_punctuality_F}
            *** (joke_punctuality_S) PLAYER: ...avant les premiers rayons du soleil. Je n'ai pas prévu ma crème solaire.
                SOUFFLEUR: Bien joué l'ami ! Continue de divertir le public pour ne pas qu'il s'ennuie...
                #audience:applause
            *** (joke_punctuality_F) PLAYER: ...euh... avant les premiers rayons du soleil... qui lui-même n'est pourtant... euh... pas très ponctuel ?
                SOUFFLEUR: Tu as fait ce qu'on appelle un four. Un bide. Un coup d'épée dans l'eau... Un flop, en d'autres termes. Mais je ne suis pas là pour te descendre... Ne te laisse pas abattre l'ami, tu auras d'autres occasions !
                #audience:booing
                ~ has_fail = true
        ** [(Menace) Conclure avec panache. {t(STRE, 10)}]
            {sc(CHAR, 0): -> threat_ponctuality_S | -> threat_ponctuality_F}
            ~ threat_jester = true
            *** (threat_ponctuality_S) PLAYER: ...avant que je ne juge bon de punir un tel manque de manière.
                SOUFFLEUR: Certaines situations devraient être gérées avec diplomatie et tact... pas celle-ci ! Une quesion cependant : es-tu en train de menacer le personnage, ou l'actrice ? Quelle que soit la réponse, le public est avec toi, continue comme ça !
                #audience:applause
            *** (threat_ponctuality_F) PLAYER: ...avant que je me mette en colère !!
                SOUFFLEUR: Il y avait de l'idée... Mais tu n'as pas été très convainquant. Ne te laisse pas abattre, tu auras d'autres occasions !
                #audience:booing
                ~ has_fail = true
    * [(Soupirant) Je suis tout à fait seul.] PLAYER: Je me trouve bien seul. Aussi seul...
        ** [(Humour) Conclure avec légèreté. {t(CHAR, 10)}]
            {sc(CHAR, 0): -> joke_wainting_S | -> joke_waiting_F}
            *** (joke_wainting_S) PLAYER: ...aussi seul qu'un poux sur le crâne lustré d'un chauve.
                SOUFFLEUR: Bien joué, l'ami ! Continue de divertir le public pour ne pas qu'il s'ennuie...
                #audience:applause
            *** (joke_waiting_F) PLAYER: ...aussi seul.. euh... que mes dernières... miettes de patience ?
                SOUFFLEUR: Tu as fait ce qu'on appelle un four. Un bide. Un coup d'épée dans l'eau... Un flop, en d'autres termes. Mais je ne suis pas là pour te descendre... Ne te laisse pas abattre, tu auras d'autres occasions !
                #audience:booing
                ~ has_fail = true
        ** [(Menace) Conclure avec poigne. {t(STRE, 10)}]
            {sc(STRE, 0): -> threat_waiting_S | -> threat_waiting_F}
            ~ threat_jester = true
            *** (threat_waiting_S) PLAYER: ...que la dent qui restera dans le bec de qui me fait attendre aussi longtemps !
                SOUFFLEUR: Certaines situations devraient être gérées avec diplomatie et tact... pas celle-ci ! Une quesion cependant : es-tu en train de menacer le personnage, ou l'actrice ? Quelle que soit la réponse, le public est avec toi, continue comme ça !
                #audience:applause
            *** (threat_waiting_F) PLAYER: ...Euh... que mes dernières... onces de patience.
                SOUFFLEUR: Il y avait de l'idée... Mais tu n'as pas été très convainquant. Ne te laisse pas abattre, tu auras d'autres occasions !
                #audience:booing
                ~ has_fail = true
- // La scène continue
    * [(S'adresser à l'actrice) Il est temps.] PLAYER: Je crois VRAIMENT qu'il est temps, désormais.
        ???: ... Laisse moi un peu de temps, veux-tu ?
- #sleep:3 #audience:booing
    * [(À l'actrice, chuchotant) Qui payera mes heures supplémentaires ?] PLAYER: Psssst... Je suis trop mal payé pour que la pièce dure toute la nuit. Dépêche-toi !
    * [(À l'actrice, chuchotant) Es-tu en grève ?] PLAYER: Psssst... Tu es en grève ? Qu'es-ce qu'il te prend, encore ?
- ???: Laissons-les se languir encore un peu... Ça ne rendra mon entrée en scène que plus mémorable !
    * [Se montrer conciliant.] PLAYER: Je n'en doute pas... Je vais faire ce que je peux pour meubler. Je t'en prie, ne tarde pas.
    * [Hausser le ton.] PLAYER: Le public va t'acceuillir avec des applaudissements... et moi avec un coup de pied au derrière !
    * [Ignorer la voix.]
- #sleep:3 #audience:booing
- SOUFFLEUR: Trouve autre chose pour les divertir... N'importe quoi qui te passe par la tête ! Surtout, ne reste pas planté là !
    * [Effectuer une danse. {t(DEXT, -10)}]
        {sc(CHAR, 0): -> dancing_S | -> dancing_F}
        ** (dancing_S) #anim:Player:dancing_success
            SOUFFLEUR: Excellent ! Je ne te connaissais pas un talent de danseur.
            -> success_entertaining_audience
        ** (dancing_F) #anim:Player:dancing_failure
            SOUFFLEUR: L'idée n'était pas mauvaise... Mais un conseil : la prochaine fois, fais appel à un talent que tu possèdes vraiment, l'ami !
            -> failure_entertaining_audience
    * [Faire des pompes. {t(STRE, -10)}]
        {sc(CHAR, 0): -> do_pushups_S | -> do_pushups_F}
        ** (do_pushups_S) #anim:Player:break_crate_success
            {
                - threat_jester == true: SOUFFLEUR: Bien joué ! J'ai l'impression que tu comptes pas mal sur tes muscles... Mais qui suis-je pour juger, hein ? Continue comme ça !
            }
            -> success_entertaining_audience
        ** (do_pushups_F) #anim:Player:break_crate_failure
            SOUFFLEUR: Je comprends l'intention, mais les muscles ne suivent pas. Skill issue, comme on dit. Surtout, garde la tête haute, l'ami !
            -> failure_entertaining_audience
    * [Hypnotiser le public. {t(CHAR, -20)}]
        {sc(CHAR, 0): -> hypnotise_S | -> hypnotise_F}
        ** (hypnotise_S) #anim:Player:hypnotise_success
            SOUFFLEUR: ...
            SOUFFLEUR: Aucune idée de ce qu'il s'est passé, mais ça a fonctionné ! Bien joué, l'ami !
            -> success_entertaining_audience
        ** (hypnotise_F) #anim:Player:hypnotise_failure
            SOUFFLEUR: ...
            SOUFFLEUR: Je ne suis pas sûr que faire appel au... paranormal..? soit une bone idée, l'ami. Bien tenté tout de même !
            -> failure_entertaining_audience
            *** (success_entertaining_audience) ???: Hé ! Ne me vole pas la vedette, compris ?
            *** (failure_entertaining_audience) ???: Merci d'avoir tout loupé, camarade ! Ça me permettra de briller encore plus !
- // On voit un bout du JESTER qui dépasse d'une caisses
    * [(À L'ACTRICE) On te voit, là...] PLAYER: Psssst... Hé ! Tout le monde peut te voir, caché derrière la caisse !
    * [(AU PUBLIC) Je crois que je suis épié !] PLAYER: J'ai la sensation que je ne suis pas aussi seul que je le croyais... Quelqu'un m'épie !
        #audience:applause
- // Le JESTER ne bouge pas, caché derrière sa caisse
    * [Tirer la caisse.]
        #anim:Player:pull_crate
        // Quand le joueur tire la caisse, le JESTER continue de la suivre pour se cacher derrière
    * [Raisonner l'actrice.] PLAYER: Le public n'attend que ton apparition ! C'est maintenant ou jamais.
        ???: J'ai l'impression que tu cherches à me ridiculiser devant mon public adoré.
        ** [C'est de la paranoia.] PLAYER: À ce stade, c'est carrément de la paranoia.
        ** [C'est de bonne guerre.] PLAYER: Peut-être bien, oui... Ça t'apprendra à me laisser seul sur scène !
- // Le joueur compte
    * [Je compte jusqu'à trois...] PLAYER: Je te préviens, je compte jusqu'à trois...
    ** [Un...] Un...
        *** [... deux...] ... deux...
- // Le joueur s'apprête à briser la caisse
    * [Briser la caisse. {t(STRE, -10)}]
        PLAYER: ... trois !!
        {sc(CHAR, 0): -> breaking_crate_S | -> breaking_crate_F}
        ** (breaking_crate_S) #anim:Player:break_crate_success  #audience:ovation
            ~ failed_breaking_jester_crate = true
        ** (breaking_crate_F) #anim:Player:break_crate_failure  #audience:booing
- ???: Mais qui voilà ? N'est-ce pas moi ?  #anim:Arle:charisma #audience:ovation
{
    - failed_breaking_jester_crate == true: ???: Désirant briser cette malheureuse caisse, messire...
        ???: ... vous n'avez abîmé que votre dignité.
        #sleep:2
        ???: Sauf votre respect. #anim:Arle:bow #audience:laughter
}
    * [Que faisais-tu caché ?] PLAYER: Que faisais-tu là, caché tel un rat ?
        ???: On ne connait jamais mieux une personne qu’en l’observant quand celle-ci croit être seule.
        ** [Me connaître ?] PLAYER: Me connaître, moi ?
            ???: Parfaitement, messire.
            *** [Échangeons nos noms.] PLAYER: Faisons un marché, bouffon. Je t'échange mon nom contre le tien. Qu'en dis-tu ? N'est-ce pas là une honnête transaction ?
                ???: J'ai bien peur, messire, de posséder déjà ce que vous proposez de m'offrir...
                ???: {p_name}, si je ne m'abuse ?
                **** [Et à qui {p_name} a t-il l'honneur ?] PLAYER: Et avec qui ai-je le plaisir de m'entretenir ?
                    -> arle_presentation
                **** [Refuses-tu d'annoncer qui tu es ?] PLAYER: Refuses-tu d'annoncer qui tu es...
                    ***** [... vaurien ?] PLAYER: ... vaurien ?
                        #anim:Arle:ashamed
                        -> arle_presentation
                    ***** [... plaisantin ?] PLAYER: ... plaisantin ?
                        #anim:Arle:ashamed
                        -> arle_presentation
                    ***** [... malandrin ?] PLAYER: ... malandrin ?
                        #anim:Arle:ashamed
                        -> arle_presentation
        ** [C'est toi que je veux connaître.] PLAYER: La politesse exige qu'on se présente le premier.
            ???: Me présenter ? Cela, je sais le faire, et fort bien !
            #anim:Arle:charisma
            --- (arle_presentation) ???: Je suis Arle, pour vous servir, messire.
    * [Es-tu l'auteur de la lettre ?] PLAYER: Est-ce donc toi qui a écrit la lettre que j'ai reçue la veille ?
        ???: Je sais faire bien des choses, messire...
        ???: ... Faire la belle...
        #anim:Arle:charisma
        ???: ... Faire le show...
        #anim:Arle:acrobatics
        ???: ... Mais je ne sais point écrire !
        ** [Qui es-tu ?] PLAYER: Sais-tu au moins dire ton nom ?
            -> arle_presentation
        ** [(Se moquer) Un plaisantin. {t(CHAR, 0)}]
            {sc(CHAR, 0): -> mock_jester_S | -> mock_jester_F} 
            *** (mock_jester_S) Un authentique bouffon... #anim:Arle:ashamed #audience:laughter
                ???: Bouffon est l'une de mes profession, mais ce n'est pas mon nom.
                -> arle_presentation
            *** (mock_jester_F) Un authentique bouffon... #anim:Arle:charisma
                ???: Je me plais à inspirer le rire, le bonheur... la fécilicité ! Vous plaisez-vous à inspirer la pitié ? #audience:laugther #anim:Player:ashamed
                -> arle_presentation
- #character_presentation:Arle
    * [Qui t'envoie ?] PLAYER: Je présume que tu es au service de quelqu'un. Qui donc ?
        ARLE: Je suis au service, en cuisine et à la plonge, messire. Là où on me somme d'être. Quant à qui me commande...
            ** [J'attends.] PLAYER: Alors ?
            ** [Qui ?] PLAYER: Qui ?
            -- ARLE: Si je ne puis vous offrir son identité, je me doit tout de même de vous dire qu'il - ou elle - est très riche.
                *** [C'est bon à savoir.] PLAYER: C'est là le principal.
                *** [Mais encore ?] PLAYER: C'est un bon début, mais où cela va t-il nous mener ?
    * [Pourquoi tant de mystère ?] PLAYER: La lettre non signée, le rendez-vous secret... Pourquoi tant de mystères ?
    * [Que me veut-on ?] PLAYER: Ce rendez-vous commence sous de mauvais augures. Énonce-moi prestement ce qu'on attend de moi.
- -> the_mission

= the_mission
- ARLE: J'en viens à la raison de cette convocation. La personne qui m'envoie souhaiterais vous offrir un travail. Disons plutôt : une mission.
    * [Une mission ?]
    * [Continue, plaisantin.]
    * [Quelle mission ?]
- PLAYER: Quelle est donc cette mission ?
ARLE: D'abord dois-je vous demander, messire : quel rapport entretenez-vous avec l'acte de tuer ? #audience:surprise
    * [Hors de question.] PLAYER: Je t'arrête tout de suite, ôter une vie n'est pas dans mes pratiques. Je suis un marin. Tout juste suis-je bon à tuer un poisson...
        ARLE: Il se trouve justement que c'est un poisson que l'on souhaiterait voir mort. Un gros poisson.
        -- (big_fish)
        ** [Un gros poisson ?] PLAYER : Un gros poisson tu dis ? Gros comment ?
            ARLE: Je n'ai pas les bras assez longs, messire. Gros comme le dédommagement que mon maître est prêt à vous offrir pour l'abattre.
        ** [Assez de mystère !] PLAYER: Il suffit ! J'en ai assez de tout ce mystère : parle maintenant ou permet-moi d'aller me recoucher.
            ARLE : Ce poisson est un très gros poisson, messire. Aussi gros que le dédommagement que mon maître est prêt à vous offrir pour l'abattre.
    * [Sans soucis.] PLAYER : Je n'y vois aucun problème. Dis-m'en plus : qui voulez-vous voir périr ?
            ARLE: Un poisson, messire. Un gros poisson.
            -> big_fish
- ARLE: Prenez ceci, voulez-vous ? #anim:Arle:give_map
    * [Qu'est-ce que c'est ?] PLAYER: Qu'est-ce donc ?
- ARLE: Un marin tel que vous ne reconnait-il pas une carte quand il en voit une, messire ?
    * [Quel endroit indique t-elle ?] PLAYER: Quel est l'endroit qu'elle indique ?
        ARLE: En voilà une question intéressante...
    * [Une carte, pourquoi donc ?] PLAYER: Pourquoi aurais-je besoin d'une carte, je te prie ?
        ARLE: Vous le saurez bien assez tôt...
    * [Je sais déjà aller où je veux.] PLAYER: Je n'ai nul besoin de carte. Je puis déjà aller où je le désire...
        ARLE: Prenez-là tout de même, faites-moi confiance...
~ add_to_inventory(i_map_leviathan)
- ARLE: Puis-je vous raconter une petite histoire, messire ?
    * [J'adore les histoires !] PLAYER: Je t'en prie.
    * [Fais vite.] PLAYER: Je n'ai point ton temps, presse-toi.
    * [Hors de question.] PLAYER: 
        ARLE: Si je ne le fais pas pour vous, messire...
        ARLE: Je le ferai pour eux. #anim:Arle:show_audience
- ARLE: Il était une fois... une terrible tempête. #audience:shock
ARLE: Pas n'importe quelle tempête : celle-ci dura près d'un siècle.
ARLE: Les océans se déchaînèrent, l'eau avala tout sur son passage...
ARLE: Et les humains durent survivre à bord d'un grand navire, cent années durant.
- ARLE: Avec la montée des eaux vint d'autres fléaux. L'un d'eux était un poisson...
- #anim_event:arle_rope #anim:Arle:swimming // Arle, accroché à une corde, mime un poisson qui nage
- ARLE: Ce poisson, voyez-vous, était si gros qu'il aurait pu avaler une ville entière. #audience:surprise
    * [Le Léviathan !] PLAYER: Le léviathan ! #audience:shock
        ARLE: Le Léviathan, messire.
    * [Rester silencieux.]
- ARLE: Plus d'une fois, il manqua d'engloutir le navire des Hommes... Fort heureusement, la Déesse était pleine de ressources ! #audience:applause
- ARLE: C'est pourquoi nous jouissons d'être en vie aujourd'hui, n'est-ce pas ? Mais cette petite histoire ne se finit pas si bien...
    * [Pourquoi donc ?] PLAYER: Et pourquoi donc ?
        ARLE: Pour la simple raison que la créature nage toujours dans nos océans à l'heure où nous parlons, messire...
    * [Je sais pourquoi.] PLAYER: J'ai une idée de ce que tu vas dire...
        ARLE: Je vous en prie, messire, concluez.
        ** [Le Léviathan est toujours vivant.] PLAYER: Le Léviathan est toujours en vie.
            ARLE: Précisément. Or, je ne sais pas vous, mais je me sentirais plus en sécurité s'il n'était plus de ce monde...
        ** [Le Léviathan nous menace.] PLAYER: Le Léviathan est toujours une menace.
            ARLE: Son existence, messire, est une menace. Un affront à la Déesse elle-même. Une abomination...
- #audience:surprise
    * [Moi, tuer le Léviathan ?] PLAYER: Suis-je en plein rêve, ou me demandes-tu vraiment d'aller tuer le Léviathan ? #audience:laugther
        ARLE: Il n'y a point matière à rire... Cette entreprise est tout à fait sérieuse.
    * [C'est une plaisanterie ?] PLAYER: Si c'est une plaisanterie, elle est de mauvais goût. #audience:laugther
        #anim:Arle:laugh
        ARLE: Il n'y a point matière à rire... Cette entreprise est tout à fait sérieuse.
    * [Il va falloir me payer grassement.] PLAYER: Si ton maître veut me faire courir un tel risque... Il a interêt à me payer grassement !
- ARLE: Souvenez-vous : celui - ou celle - qui m'envoie est d'une richesse dont vous n'avez pas idée.
    * [Annoncez-moi la somme.] PLAYER: De quelle somme parle t-on ?
    * [Il a interêt...] PLAYER: Au vu de la mission, il ne le sera plus autant après m'avoir payé.
- ARLE: Si vous acceptez de ramener le cœur du terrible Léviathan, mon maître vous offrira le poids de votre navire en or.
    * [Une sacré somme.] PLAYER: Une somme qui n'est pas à prendre à la légère...
    * [(Négocier) Mon navire est léger. {t(CHAR, -20)}]
        {sc(CHAR, -20): -> negociate_S | -> negociate_F} 
            *** (negociate_S) PLAYER: Mon navire est fait d'un bois très léger, voyez-vous...
                ARLE: Vous êtes dur en affaire, messire. Alors disons le double !
            *** (negociate_F) PLAYER: Mon navire, voyez-vous... est au régime. Il pèse de moins en mois et...
                ARLE: Messire, ces simagrées ne vous honorent pas. Notre position est ferme, j'en ai peur.
- ARLE: Qu'en dites-vous, messire ? Ramenez-nous le cœur de l'immonde Léviathan, sinon pour la gloire ou le service rendu à la population, du moins pour la fortune. Affaire conclue ?
- ARLE: Ramenez-nous le cœur de l'immonde Léviathan, sinon pour la gloire, pour l'interêt de la Couronne.
    * [Est-ce la Couronne qui t'envoie ?] PLAYER: Que veux-tu dire ? Est-ce donc la Couronne qui t'envoie ?
        -- (to_the_crown) ARLE: Seriez-vous plus enclin à rendre ce service s'il était au profit de la Couronne elle-même ?
            ** [Je ferai tout pour Elle !] PLAYER: Je braverai tous les dangers pour Elle !
                ~ trial(t_1_respect_the_crown)
            ** [La Reine et sa Couronne m'indiffèrent.] PLAYER: Constance et son inconstance m'inspirent l'indifférence.
                ~ trial(t_1_disrespect_the_crown)
                ARLE: Ces petites rimes, messire, pourraient vous coûter cher.
    * [Pour la Reine Constance ?] PLAYER: Est-ce la Reine elle-même qui demande mon renfort ?
        ARLE: Nulle demande ne saurait provenir de la bouche de la Reine, messire. Seulement des ordres...
        -> to_the_crown
    * [Crache le morceau.] PLAYER: Que veux-tu dire ? Sois franche, s'il t'est seulement possible de l'être.
        ARLE: Aucun de nous deux n'ignore qu'une telle mission exige de grands efforts...
        ARLE: Or, de grands efforts exigent une grande volonté. Une volonté d'aider, messire.
        -> to_the_crown
- ARLE: Puis-je ajouter, messire, que vaincre le Léviathan constituerait une offrande de taille à la Déesse Elle-même.
    * [J'en serais honoré !] PLAYER: Voilà qui éteint mes dernières hésitations.
        ~ trial(t_1_respect_irene)
    * [Je me fiche de la Déesse.] PLAYER: Je me fiche de la Déesse comme de la dernière pluie.
        ARLE: Messire, ces paroles ne vous honorent pas. Peut-être n'aurais-je pas du vous laisser penser, en présentant ma requête, que vous aviez le choix.
        ~ trial(t_1_disrespect_irene)
    * [Seul m'intéresse le profit.] PLAYER: Si j'accepte, ce ne serait ni pour la Reine, ni pour la Déesse, mais pour mon seul profit.
        ~ trial(t_1_disrespect_the_crown)
        ~ trial(t_1_disrespect_irene)
        ~ trial(t_1_gold_digger)
- ARLE: Le jour commence à poindre, messire. Acceptez-vous de ramener le cœur de l'abjecte créature ?
    * [J'en serai honoré.] PLAYER: Cela serait pour moi un véritable honneur.
    * [Je n'ai le choix.] PLAYER: Puisque je n'ai point le loisir de me soustraire à la tâche...
- #audience:ovation
- -> barge.scene_2

// End the scene
= end_scene
-> END