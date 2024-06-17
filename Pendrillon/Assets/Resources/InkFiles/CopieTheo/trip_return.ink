// TRIP RETURN SCENE


// Variables
VAR sireine_is_hidden = false // If the sireine is hidden or not
VAR sireine_hideout = "none" // The sireine hideout
VAR weapon_on_hand = true // If the player's weapon is on hand or not
VAR has_bone = false // Can be found in the back crate
VAR has_coconut = false // Can be found in the front crate
VAR player_is_stinky = false // Player is stinky if he searches through the back crate
VAR player_is_hidden = false // Define if the player is hidden or not
VAR player_won_battle = false // Define if the player won the battle or not

// Scene
=== trip_return ===
-> start

= start
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Naïda:PERSONNAGE MASQUÉ
#actor:Marcello:MARCELLO
#actor:Capucine:CAPUCINE
// Set the location
#set:cale
// Set the actor's positions
#position:Player:11:3
#position:Naïda:11:9
#position:Marcello:3:20
#position:Capucine:5:20
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:2

// Start the scene
#playsound:Play_MUS_Story_SC_SecretMeeting_Intro
- PERSONNAGE MASQUÉ: Ça sent mauvais là-dedans... #playsound:VOX_Naida_sentmauvais
    * [Du poisson plus très frais.] PLAYER: Certaines caisses sont remplies de poisson. Et la pêche ne date pas de la veille...
    * [Ça sent les ennuis...] PLAYER: Ça sent les ennuis !
    * [L'odeur de la liberté !] PLAYER: Le poisson pas frais et le sel marin : l'odeur de la liberté !
- PERSONNAGE MASQUÉ: Que fera-t-on s'ils me trouvent ? #playsound:VOX_Naida_queferaton
    * [Je vous protégerai. {t(STRE, 20)}] // 60%
        {sc(STRE, 20): -> protect_S | -> protect_F}
        ** (protect_S) PLAYER: Je braverai les dangers pour vous protéger ! #playsound:VOX_Player_braveraidangers
            PERSONNAGE MASQUÉ: Espérons que l'on n'en arrive pas là. #playsound:VOX_Naida_esperonsque
        ** (protect_F) PLAYER: Euh.. Je.. Je vous défendrai ? #playsound:VOX_Player_euhjedefendrai
            PERSONNAGE MASQUÉ: Ne le prenez pas mal, mais... vous n'êtes pas très convaincant. #playsound:VOX_Naida_neleprenez
    * [On improvisera.] PLAYER: On improvisera, comme j'en ai l'habitude. #playsound:VOX_Player_onimprovisera
        PERSONNAGE MASQUÉ: Ce n'est pas la première fois que vous avez des ennuis avec la Couronne, n'est-ce pas ? #playsound:VOX_Naida_paspremierefois
        ** [(Mentir) C'est une première. {t(CHAR, -10)}] // 40%
            {sc(CHAR, -10): -> lie_S | -> lie_F}
            *** (lie_S) PLAYER: Je suis ce qu'on appelle un honnête homme.
                PERSONNAGE MASQUÉ: Vous semblez sincère. #playsound:VOX_Naida_semblezsincere
            *** (lie_F) PLAYER: Je suis blanc comme neige au soleil. #trial
                ~ trial()
                ~ t_2_lawless = true
                PERSONNAGE MASQUÉ: Vous mentez très mal, mon ami. #playsound:VOX_Naida_mentezmal
        ** [Certes.] PLAYER: C'est vrai, je l'admets. Mais ne dit-on pas que nul homme n'a à rougir d'une faute avouée ?
            PERSONNAGE MASQUÉ: Je n'ai jamais entendu cela, non. #playsound:VOX_Naida_jamaisentendu
            *** [Oubliez.] PLAYER: J'ai dû l'inventer, alors.
- PERSONNAGE MASQUÉ: Et maintenant, que fait-on ? #playsound:VOX_Naida_etmaintenant
    * [Fouiller la caisse de devant. {t(DEXT, 40)}] #playsound:crate_search // 80%
        {sc(DEXT, 40): -> crate_front_search_S | -> crate_front_search_F}
        ** (crate_front_search_S) PLAYER: Une <b>noix de coco</b>. Ça pourrait être utile, qui sait. #move:Player:7:0 #playsound:VOX_Player_trouvenoixcoco
            ~ has_coconut = true
        ** (crate_front_search_F) PLAYER: Je n'ai rien trouvé. #move:Player:7:0
    * [Fouiller le tonneau. {t(DEXT, 40)}] // 80%
        {sc(DEXT, 40): -> barrel_search_S | -> barrel_search_F}
        ** (barrel_search_S) PLAYER: J'ai trouvé un <b>gros os</b>. Ça pourrait servir. #move:Player:0:-1 #playsound:VOX_Player_trouvegrosos
        ~ has_bone = true
            PERSONNAGE MASQUÉ: Qu'avez-vous en tête ? #playsound:VOX_Naida_quavezvous
            *** [Plaisanter.] PLAYER: Peut-être qu'en l'envoyant, les gardes iront chercher ? #audience:laughter #playsound:VOX_Player_gardesirontchercher
                PERSONNAGE MASQUÉ: Comment pouvez-vous avoir le cœur à rire ? #playsound:VOX_Naida_commentcoeurrire
            *** [Dire la vérité.] PLAYER: Si je n'ai pas d'autres choix, j'assommerai les gardes. #playsound:VOX_Player_pasdautrechoixassomer
                PERSONNAGE MASQUÉ: J'ai si peur... #playsound:VOX_Naida_jaisipeur
        ** (barrel_search_F) PLAYER: Je n'ai rien trouvé. #move:Player:0:-1
    * [Forcer la caisse du fond. {t(STRE, 40)}] #playsound:crate_search // 80%
        {sc(STRE, 40): -> crate_back_search_S | -> crate_back_search_F}
        ** (crate_back_search_S) PLAYER: Du poisson pourri... J'empeste ! Mais j'ai trouvé <b>quelques pièces</b>. #move:Player:3:10 #playsound:gold_coins #playsound:VOX_Player_dupoissonpourrimaispieces
            ~ p_gold += 3
            ~ player_is_stinky = true
        ** (crate_back_search_F) PLAYER: Du poisson pourri... J'empeste ! #move:Player:3:10 #playsound:VOX_Player_dupoissonpourri
            ~ player_is_stinky = true
- PERSONNAGE MASQUÉ: Ne peut-on pas éviter que des gardes ne viennent fourrer leur nez ici ? #playsound:VOX_Naida_nepeutonpas #move:Player:11:3
    * [Je connais certains gardes, mais...] PLAYER: Il est certains gardes que je... connais bien, disons. Pas ceux-là. #playsound:VOX_Player_certainsgardesjeconnais
    * [C'est la Loi.] PLAYER: Tous les navires qui arrivent à <b>Miraterre</b> doivent être fouillés. Par ailleurs... #playsound:VOX_Player_touslesnavires
        PERSONNAGE MASQUÉ: Par ailleurs ? #playsound:VOX_Naida_paraiileurq
        PLAYER: Votre simple présence enfreint une <b>Loi capitale</b>, j'en ai peur. #audience:debate #trial #playsound:VOX_Player_loicapitale
            ~ trial()
            ~ t_2_lawfull = true
- PERSONNAGE MASQUÉ: N'éprouvez-vous jamais aucun regret ? Si la Loi et la Foi l'interdisent... #playsound:VOX_Naida_neprouvezvousaucun
    * [Sans foi ni loi.] PLAYER: Je me fiche de la Loi comme de la Foi. #trial #playsound:VOX_Player_fichedelaloicommefoi
        ~ trial()
        ~ t_2_against_law = true
        ~ t_2_against_crown = true
    * [Pas le temps pour des regrets.] PLAYER: L'heure n'est pas au regret. #trial
        ~ trial()
        ~ t_2_show_no_regrets = true
    * [(Tiraillé) Parfois...] PLAYER: Il est des jours où je crois être le plus vil des hommes... #trial
        ~ trial()
        ~ t_2_show_regrets = true
- PERSONNAGE MASQUÉ: J'entends des bruits. Quelqu'un vient. #playsound:activity_far #playsound:VOX_Naida_jentendsdesbruits
* [Cachez-vous.] PLAYER: Il va falloir vous trouver une cachette, et en vitesse. #playsound:VOX_Player_trouverunecachette
    -- (hide_sireine) PERSONNAGE MASQUÉ: Les bruits se rapprochent ! #playsound:activity_close #playsound:VOX_Naida_lesbruitsserapprochent
        *** [Derrière le tonneau.] PLAYER: Derrière ce tonneau, vite ! #move:Naïda:-2:1 #move:Naïda:-2:-3 #playsound:VOX_Player_cetonneau
            ~ sireine_hideout = "barrel"
            ~ sireine_is_hidden = true
        *** [Dans la caisse du fond.] PLAYER: Cette caisse, au fond ! Vite ! #move:Naïda:-2:7 #move:Naïda:-2:10 #playsound:VOX_Player_cettecaisseaufond
            ~ sireine_hideout = "crate_back"
            ~ sireine_is_hidden = true
* [Attendons.] PLAYER: Pas le temps de se cacher ! #playsound:VOX_Player_pasletempsdecacher
    PERSONNAGE MASQUÉ: Il le faut pourtant ! #playsound:VOX_Naida_illefaut
        -> hide_sireine
- PLAYER: Quant à moi...
    * {has_coconut == true or has_bone == true} [Se cacher. {t(DEXT, 35)}] // 75%
        {sc(DEXT, 35): -> player_hide_S | -> player_hide_F}
        ** (player_hide_S) #move:Player:5:1 #move:Player:5:-3
            ~ player_is_hidden = true
            -> guards_arrive
        ** (player_hide_F) PLAYER: Loupé ! La discrétion n'est pas mon fort ! #anim:Player:fail
            -> guards_arrive
    * [Accueillir les gardes.]
- -> guards_arrive


// The guards arrive
= guards_arrive
#playsound:guards_arrive
- MARCELLO: J'ai entendu du bruit dans la cale. #anim:Marcello:enter_scene #audience:ovation #playsound:VOX_Marcello_jaientendu
CAPUCINE: Tu entends des voix, maintenant ? Peut-être la Déesse en personne qui te cause... #playsound:VOX_Capucine_tuentendsvoixQ #anim:Capucine:enter_scene #audience:laughter
MARCELLO: Vous me croyez fou, cheffe ? #audience:laughter #move:Capucine:9:9 #move:Marcello:11:7 #audience:ovation #playsound:VOX_Marcello_mecroyezfou
CAPUCINE: Que tu sois cinglé ou non... Nous devons <i>fouiller</i> tous les navires qui <i>arrivent au port</i>. #playsound:VOX_Capucine_soiscinglenon #audience:applause
- {player_is_hidden: -> player_hidden | -> player_greet_guards}


//The guards arrive while the player is hidden
= player_hidden
#playsound:guards_arrive
MARCELLO: Il n'y a personne, cheffe. #playsound:VOX_Marcello_yapersonne
* [Rester discret. {t(DEXT, 30)}] // 75%
    {sc(DEXT, 30): -> discretion_1_S | -> discretion_1_F} #anim:Marcello:seek_intruder_near_player
    ** (discretion_1_S) MARCELLO: Je ne vois personne. Et toi ? #playsound:VOX_Marcello_jevoispersonne
        -- {
                - player_is_stinky: CAPUCINE: Je ne vois personne, mais ça pue le poisson mort par ici. 
                    -> player_is_found
                -else:
                    -> player_not_found
            }
    ** (discretion_1_F) MARCELLO: Là ! Derrière cette caisse ! Il y a quelqu'un ! #anim:Player:stop_hiding #playsound:VOX_Marcello_laderriere
        -> player_is_found
* [Sortir de sa cachette]
    -> player_stop_hiding
- (player_not_found) CAPUCINE: Laisse-moi regarder de plus près...
    * {has_bone} [Envoyer l'os sur Marcello. {t(STRE, 35)}] // 80%
        -> attack_marcello_with_bone
    * {has_coconut} [Envoyer la noix de coco sur Marcello. {t(DEXT, 30)}] // 80%
        -> attack_marcello_with_coconut
    * [Sortir de sa cachette]
        -> player_stop_hiding
- (player_is_found) CAPUCINE: Qui es-tu, maraud ? {player_is_stinky: Tu empestes le poisson pourri !} #playsound:VOX_Capucine_quiestu
    {
        - player_is_stinky:
            SOUFFLEUR: SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe3
            SOUFFLEUR: En fouillant la caisse pleine de poisson pourri, l'odeur s'est incrustée à ton costume... #playsound:VOX_Souffleur_enfouillantpoisson
            SOUFFLEUR: Ce doit être pour ça que tu t'es fait repérer. #playsound:VOX_Souffleur_tureperer
            SOUFFLEUR: Interagir avec le décors entraîne parfois des conséquences inattendues, l'ami ! #playsound:VOX_Souffleur_interagir
    }
    -> player_stop_hiding


// The guards arrive while the player is not hidden
= player_not_hidden
- (player_stop_hiding) #move:Player:5:3 #move:Player:11:3
- (player_greet_guards)
* [S'annoncer.] PLAYER: Bien le bonjour, mes braves. #playsound:VOX_Player_bienlebonjourgardes
- CAPUCINE: Décline ton identité, et vite ! #playsound:VOX_Capucine_declineidentite
    * [Je suis le capitaine.] PLAYER: Vous vous trouvez sur mon humble navire. #playsound:VOX_Player_monhumblenavire
        CAPUCINE: C'est toi le capitaine ? #playsound:VOX_Capucine_cesttoicapitaineQ
    * [(Mentir) Un simple moussaillon. {t(CHAR, 30)}] // 70%
        {sc(CHAR, 30): -> lie_about_not_being_capitaine_S | -> lie_about_not_being_capitaine_F}
            ** (lie_about_not_being_capitaine_S) PLAYER: Je suis un simple moussaillon. #playsound:VOX_Player_unsimplemoussaillon
                MARCELLO: Il a l'air de dire vrai, cheffe. #playsound:VOX_Marcello_ilalairvrai
            ** (lie_about_not_being_capitaine_F) PLAYER: Je... euh... Je suis un simple moussaillon. #playsound:VOX_Player_jeeuhsimple
                MARCELLO: Tu mens comme tu respires, pas vrai ? #playsound:VOX_Marcello_tumens
- CAPUCINE: Le fripon a l'air louche... #playsound:VOX_Capucine_friponlouche
    * [Louches vous-mêmes !] PLAYER: C'est vous qui êtes louches, les baveux. #playsound:VOX_Player_cestvouslouches
        MARCELLO: Répète ça pour voir, abruti ! #playsound:VOX_Marcello_repete
        ** [Répéter.] PLAYER: Louches et sourdingues, en plus de ça. #playsound:VOX_Player_louchesetsourdingues
            MARCELLO: Nous allons t'apprendre à insulter des gardes de la Couronne ! #playsound:VOX_Marcello_nouallonstappr
                -> battle
        ** [Calmer le jeu. {t(CHAR, 0)}] // 50%
            {sc(CHAR, 0): -> try_diplomacy_S | -> try_diplomacy_F}
            *** (try_diplomacy_S) -> calm_the_situation
            *** (try_diplomacy_F) PLAYER: Euh... Pardon, j'ai tendance à dire tout haut ce que je pense tout bas... #playsound:VOX_Player_euhpardontendance
        -> calm_the_situation
    * (calm_the_situation) [Amadouer.] PLAYER: Et si nous remontions sur le pont, pour discuter entre amis ? #playsound:VOX_Player_etsiremontionspont
        CAPUCINE: Un garde de la Couronne n'a d'ordre à recevoir de personne. #playsound:VOX_Capucine_gardecouronneordre
        ** [Faire de l'esprit.] PLAYER: Pas même de la reine ? #playsound:VOX_Player_pasmemelareine
            MARCELLO: Il a pas tort, cheffe. #playsound:VOX_Marcello_ilapator
            CAPUCINE: Cet abruti se fiche de nous. Mais il ne va pas rire longtemps... #playsound:VOX_Capucine_abrutifiche
                -> confronted_about_fugitive
        ** [Que faites-vous sur mon navire ?] PLAYER: Puis-je vous demander ce que vous faites ici, mes braves ?
            MARCELLO: Tous les bateaux qui arrivent au port royal doivent être fouillés, c'est la loi. #playsound:VOX_Marcello_laloi
            CAPUCINE: Et nul ne doit ignorer la loi... Caches-tu quelque chose ? #playsound:VOX_Capucine_nulignorerloi
- (confronted_about_fugitive) CAPUCINE: Quelqu'un qui sortait de la cale nous a dit qu'un fugitif se cachait ici. #playsound:VOX_Capucine_quelqunsortait
MARCELLO: Alors, qu'as-tu à répondre, marin d'eau douce ? #playsound:VOX_Marcello_alorsreponds
    * [Baratiner. {t(CHAR, 0)}] // 50%
        {sc(CHAR, 0): -> lie_about_fugitive_S | -> lie_about_fugitive_F}
        ** (lie_about_fugitive_S) PLAYER: Cet individu ment. D'ailleurs, il m'a détroussé de cinq pièces d'or !
            MARCELLO: Il a l'air de dire vrai. T'en penses quoi, cheffe ? #playsound:VOX_Marcello_ilalairvrai2
            CAPUCINE: Flanque-lui en une, dans le doute.
            MARCELLO: Compris, cheffe ! #playsound:VOX_Marcello_comprischeffe
                -> battle
        ** (lie_about_fugitive_F) PLAYER: Le type que vous avez vu sortir d'ici est atteint d'une maladie rare. #playsound:VOX_Player_letypemaladie
            CAPUCINE: Une maladie rare ? #playsound:VOX_Capucine_maladierare
            PLAYER: Absolument. Une maladie qui lui fait voir des fugitifs qui ne sont pas là. #playsound:VOX_Player_maladiefugitifs
            CAPUCINE: ...
            MARCELLO: ...
            CAPUCINE: Il nous prend pour des idiots ou je rêve ? #playsound:VOX_Capucine_idiotsoujereve
            MARCELLO: Je vais t'apprendre à mentir à des gardes de la Couronne ! #playsound:VOX_Marcello_jevaistaprend
                -> battle
    * [Intimider. {t(STRE, -5)}] // 45%
        {sc(STRE, -5): -> intimidate_guards_S | -> intimidate_guards_F}
        ** (intimidate_guards_S) PLAYER: Le marin d'eau douce va te noyer de coups, si tu continues de l'ouvrir.
            MARCELLO: Pardon, m'sieur. #playsound:VOX_Marcello_pardonmsieu
            CAPUCINE: Ne t'excuse pas, abruti. Apprends-lui plutôt ce qu'on obtient en menaçant un garde de la Couronne ! #playsound:VOX_Capucine_netexxcusepas
            MARCELLO: Compris, cheffe ! #playsound:VOX_Marcello_comprischeffe
                -> battle
        ** (intimidate_guards_F) PLAYER: T'as vu mes biscoteaux ? Tu veux les voir de plus près, peut-être ?
            CAPUCINE: ... 
            MARCELLO: ...
            CAPUCINE: Il se croit intimidant, cet idiot ? #playsound:VOX_Capucine_ilsecroitintimidant
            MARCELLO: Je vais t'apprendre à menacer des gardes de la Couronne ! #playsound:VOX_Marcello_jevaistaprend
                -> battle
    * {p_gold > 0} [Soudoyer. {t(DEXT, 25)}] #trial // 75%
        {sc(DEXT, 25): -> bribe_guards_S | -> bribe_guards_F}
        PLAYER: Est-ce que {p_gold} pièces d'or pourraient vous faire quitter mon navire sans faire de vagues ? Si vous me permettez l'expression... #playsound:VOX_Player_estcequepiecesdor
        ~ trial()
        ~ t_2_bribe_guards = true
        ** (bribe_guards_S) CAPUCINE: Laisse-moi te débarrasser de ces pièces...
            *** [Donner les pièces.] PLAYER: Voilà pour toi, mon amie. #playsound:gold_coins
                CAPUCINE: Nous allons maintenant t'apprendre les mérites de respecter la Loi, et les dangers de tenter de soudoyer un garde, quadruple forban. #playsound:VOX_Capucine_quadrupleforbandangerssoudoyer
                MARCELLO: C'est là que je le frappe, cheffe ? #playsound:VOX_Marcello_cestlafrappe
                CAPUCINE: En effet, Marcello. C'est là que tu le frappes. #playsound:VOX_Capucine_eneffetfrappes
                MARCELLO: Compris, cheffe ! #playsound:VOX_Marcello_compris2
                    -> battle
            *** [Assommer Marcello.] -> attack_marcello_S
        ** (bribe_guards_F) CAPUCINE: À qui penses-tu avoir affaire, quadruple forban ? Nous allons t'apprendre les mérites de respecter la Loi, et les dangers de tenter de soudoyer un garde ! #playsound:VOX_Capucine_aquiquadrupleforban
            MARCELLO: C'est là que je le frappe, cheffe ? #playsound:VOX_Marcello_cestlafrappe
            CAPUCINE: En effet, Marcello. C'est là que tu le frappes. #playsound:VOX_Capucine_eneffetfrappes
            MARCELLO: Compris, cheffe ! #playsound:VOX_Marcello_compris2
                -> battle


// Attack Marcello with a bone
= attack_marcello_with_bone
{sc(STRE, 35): -> attack_marcello_bone_S | -> attack_marcello_bone_F}
    ** (attack_marcello_bone_S) MARCELLO: Le navire est vide, cheffe. #playsound:VOX_Marcello_lenavirevide
        MARCELLO: Aïe ! #anim:Player:throw #anim:Marcello:hurt #playsound:VOX_Marcello_aie #audience:laugh #trial
        CAPUCINE: Pas aussi vide que tu ne le pensais, apparemment... #move:Player:5:3 #move:Player:11:3 #playsound:VOX_Capucine_pasaussivide #audience:laugh
        MARCELLO: Cet abruti m'a balancé une entrecôte sur le museau !
        CAPUCINE: Ça m'en a tout l'air, en effet. #playsound:VOX_Capucine_camenatoutlair
        ~ trial()
        ~ t_2_has_attacked_guards = true
    ** (attack_marcello_bone_F) MARCELLO: Le navire est vide, cheffe. #playsound:VOX_Marcello_lenavirevide
        MARCELLO: Hein ? #anim:Player:throw #audience:booing
        CAPUCINE: Pas aussi vide que tu ne le pensais, apparemment... #move:Player:5:3 #move:Player:11:3 #playsound:VOX_Capucine_pasaussivide #audience:laugh
        MARCELLO: Ai-je la berlue ou est-ce qu'un gougnafier vient d'essayer de m'assommer en m'envoyant une entrecôte ? #audience:laugh #trial
        ~ trial()
        ~ t_2_has_attacked_guards = true
- MARCELLO: Prends ça, pour la peine !
    -> battle


// Attack Marcello with a coconut
= attack_marcello_with_coconut
{sc(DEXT, 30): -> attack_marcello_coconut_S | -> attack_marcello_coconut_F}
    ** (attack_marcello_coconut_S) MARCELLO: Le navire est vide, cheffe. #playsound:VOX_Marcello_lenavirevide
        MARCELLO: Aïe ! #anim:Player:throw #anim:Marcello:hurt #audience:laugh #playsound:VOX_Marcello_aie #trial
        CAPUCINE: Pas aussi vide que tu ne le pensais, apparemment... #move:Player:5:3 #move:Player:11:3 #playsound:VOX_Capucine_pasaussivide #audience:laugh
        MARCELLO: Cet abruti m'a envoyé une noix de coco en plein dans les narines ! #playsound:VOX_Marcello_abruticoco
        CAPUCINE: Ça m'en a tout l'air, en effet. #playsound:VOX_Capucine_camenatoutlair
        ~ trial()
        ~ t_2_has_attacked_guards = true
    ** (attack_marcello_coconut_F) MARCELLO: Le navire est vide, cheffe. #playsound:VOX_Marcello_lenavirevide
        MARCELLO: Hein ? #anim:Player:throw #audience:booing
        CAPUCINE: Pas aussi vide que tu ne le pensais, apparemment... #move:Player:5:3 #move:Player:11:3 #playsound:VOX_Capucine_pasaussivide #audience:laugh
        MARCELLO: Ai-je la berlue ou est-ce qu'un gougnafier vient d'essayer de m'envoyer une noix de coco dans la poire ? #audience:laugh #playsound:VOX_Marcello_gougnafiercoco #trial
        ~ trial()
        ~ t_2_has_attacked_guards = true
- MARCELLO: Prends ça, pour la peine ! #playsound:VOX_Marcello_prendsca2
    -> battle


// Battle (acting phase)
= battle
- #move:Marcello:11:5 #look:Marcello:Player #anim:Marcello:punch #anim:Player:hurt #look:Marcello:front 
    * [Attaquer Marcello. {t(STRE, 35)}] #trial // 70%
        {sc(STRE, 35): -> attack_marcello_S | -> attack_marcello_F}
        ** (attack_marcello_S) PLAYER: Prends ça ! #look:Player:Marcello #anim:Player:punch #anim:Marcello:hurt #look:Player:front #trial 
            MARCELLO: Attaquer un garde de la Couronne ! Tu as perdu la tête ! #playsound:VOX_Marcello_attaquerungarde
            ~ trial()
            ~ t_2_has_attacked_guards = true
            -> combat_part_2
        ** (attack_marcello_F) PLAYER: Prends ça ! #look:Player:Marcello #anim:Player:punch #look:Player:front #trial 
            MARCELLO: Héhé... Loupé, minable.
            ~ trial()
            ~ t_2_has_attacked_guards = true
            -> combat_part_2
    * [Attaquer par derrière. {t(DEXT, 40)}] #trial // 80%
        {sc(DEXT, 40): -> sneaky_attack_marcello_S | -> sneaky_attack_marcello_F}
        ** (sneaky_attack_marcello_S) MARCELLO: Je peux le rosser, cheffe ? #look:Marcello:Capucine #trial #playsound:VOX_Marcello_jepeuxrosser
            PLAYER: Prends ça ! #look:Player:Marcello #anim:Player:punch #anim:Marcello:hurt #look:Player:front #playsound:VOX_Player_prendsca
            MARCELLO: M'attaquer alors que j'ai le dos tourné ? Tu es un lâche ! #look:Marcello:front #playsound:VOX_Marcello_mattaquerdostourne
            ~ trial()
            ~ t_2_has_attacked_guards = true
            *** [Et toi un crétin.] PLAYER: C'est toi qui es stupide, à tourner le dos à quelqu'un que tu viens de frapper. #audience:laughter
                -> combat_part_2
            *** [C'est tout moi, en effet.] PLAYER: Je dirai plutôt que je sais saisir une opportunité quand je la vois... #audience:applause
                PLAYER: Surtout quand cette opportunité consiste à cogner un rustre comme toi.
                -> combat_part_2
        ** (sneaky_attack_marcello_F) MARCELLO: Je peux le rosser, cheffe ? #trial #look:Marcello:Capucine #playsound:VOX_Marcello_jepeuxrosser
            PLAYER: Prends ça ! #look:Player:Marcello #anim:Player:punch #look:Marcello:front #look:Player:front
            MARCELLO: Tu te crois discret, abruti ? #look:Marcello:front #playsound:VOX_Marcello_tutecroisdiscret
            ~ trial()
            ~ t_2_has_attacked_guards = true
            -> combat_part_2
    * [Calmer le jeu. {t(CHAR, 0)}] // 50%
        {sc(CHAR, 0): -> calm_marcello_S | -> calm_marcello_F}
        ** (calm_marcello_S) PLAYER: Je vous propose d'en rester là, messires. Je ne suis point homme à rosser un garde de la Couronne. #playsound:VOX_Player_pointhommerosser
            CAPUCINE: En voilà une parole raisonnable. #playsound:VOX_Capucine_envoilaraisonnable
            MARCELLO: Dommage, je n'aurais pas détesté t'en claquer une sur le museau... #audience:laughter #playsound:VOX_Marcello_dommage
            CAPUCINE: Allons, allons, Marcello... Le monsieur est raisonnable, alors soyons-le à notre tour. #playsound:VOX_Capucine_allonsallonsmarecello #audience:applause
            -> arrest
        ** (calm_marcello_F) PLAYER: Je vous propose d'en rester là, messires. Je ne suis point homme à rosser un garde de la Couronne. #playsound:VOX_Player_pointhommerosser
            CAPUCINE: En voilà une parole raisonnable. Mon ami, en revanche, apprécierait de t'en claquer une sur le museau. Pas vrai, Marcello ? #playsound:VOX_Capucine_envoilaenrevanche
            MARCELLO: Je confirme. #audience:laughter #playsound:VOX_Marcello_jeconfirme
            MARCELLO: Tiens, la voilà ! #look:Marcello:Player #anim:Marcello:punch #anim:Player:hurt #look:Marcello:front #playsound:VOX_Marcello_tienlavoila
            -> combat_part_2
- (combat_part_2)
    * [Faire la paix. {t(CHAR, -10)}] // 40%
        {sc(CHAR, -10): -> make_peace_S | -> make_peace_F}
        ** (make_peace_S) PLAYER: Faisons la paix, veux-tu ?
            MARCELLO: La... la paix ? Tu plaisantes ? Toi et moi, c'est la <b>guerre</b>, freluquet !
            PLAYER: Précisément. Cependant, il faut être en guerre pour pouvoir faire la paix.
            MARCELLO: Euh... Il faut être en guerre pour... Hein ?
        ** (make_peace_F) PLAYER: Faisons la paix, veux-tu ?
            MARCELLO: La... la paix ? Tu plaisantes ? Toi et moi, c'est la <b>guerre</b>, freluquet !
    * [Ne rien dire.]
- (arrest) -> arrest_naida


// Naida is arrested
=arrest_naida
#playsound:sounds_inside_the_crate
CAPUCINE: As-tu entendu ? Quelque chose a bougé là-dedans ! #playsound:VOX_Capucine_astuentenduquelquechoeabouge
MARCELLO : Sans doute un rat. Cette tête de pipe prend aussi peu soin de son navire qu'un crapaud de son étang. #audience:laughter #playsound:VOX_Marcello_sansdouterat
- CAPUCINE: Bloque-lui la route tandis que j'y jette un œil. #playsound:VOX_Capucine_bloqueluilaroute #audience:choc #look:Marcello:Player
{
    - sireine_hideout == "barrel": CAPUCINE: Tiens donc... Mais qui voilà ? #move:Capucine:-2:-1 #playsound:VOX_Capucine_tiensdoncmaisquivouila #audience:choc #look:Capucine:Naïda
    - sireine_hideout == "crate_back": CAPUCINE: Tiens donc... Mais qui voilà ? #move:Capucine:-2:8 #playsound:VOX_Capucine_tiensdoncmaisquivouila #audience:choc #look:Capucine:Naïda
}
- PERSONNAGE MASQUÉ: Laissez-moi ! Je vous ai dit de me laisser ! #playsound:VOX_Naida_laissezmoi #look:Naïda:Capucine
CAPUCINE: C'est donc cela que tu cachais... Marcello, embarquons-la. #playsound:VOX_Capucine_cestdonccela
CAPUCINE: Allons-nous-en avec notre trouvaille. #playsound:VOX_Capucine_allonsnousen
CAPUCINE: Si ce maraud se trouve encore sur son navire quand nous reviendrons avec des renforts... #playsound:VOX_Capucine_ilfinira1 #audience:debate
CAPUCINE: Il finira sa triste vie au cachot, comme son amie. #playsound:VOX_Capucine_ilfinira2 #audience:ovation
    -> barge.scene_3

= end_playtest_demo
- SOUFFLEUR: Psssst... Hé, l'ami !
SOUFFLEUR: C'est la fin de la démo de <wiggle>PENDRILLONS</wiggle> !
SOUFFLEUR: Toute l'équipe ainsi que la troupe te remercient d'avoir participé aux playtests du jeu !
SOUFFLEUR: Nous avons encore un peu de travail, alors on te laisse l'ami !
SOUFFLEUR: N'oublie pas de répondre au questionnaire que nous allons te transmettre !
SOUFFLEUR: À la prochaine, l'ami !
-> END
