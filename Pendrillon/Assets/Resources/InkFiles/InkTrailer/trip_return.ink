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
#position:Player:10:4
#position:Naïda:10:20
#position:Marcello:10:8
#position:Capucine:9:10
// Audience reaction
//#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:4
#wait:5
- #look:Player:right
- #look:Marcello:PLAYER
- #look:Capucine:PLAYER
- #wait:5
- MARCELLO: Tous les <b>bateaux</b> qui arrivent au <b>port royal</b> doivent être <b>fouillés</b>, c'est la <shake a=0.5><b>Loi</b></shake>. #playsound:VOX_Marcello_laloi

// Start the scene
//#playsound:Play_MUS_Story_SC_SecretMeeting_Intro
- rien #wait:1400
- MARCELLO: Tiens, la voilà ! #look:Player:right #look:Marcello:Player #anim:Player:punch #anim:Marcello:hurt #look:Marcello:front #wait:120
- MARCELLO: Alors, qu'as-tu à répondre, marin d'eau douce ? #playsound:VOX_Marcello_alorsreponds
    * [Baratiner. {t(CHAR, -10)}]
        {sc(CHAR, -10): -> lie_about_fugitive_S | -> lie_about_fugitive_F}
    * [Intimider. {t(STRE, -20)}]
        {sc(STRE, -20): -> intimidate_guards_S | -> intimidate_guards_F}
    * [Soudoyer. {t(DEXT, -10)}]
        ~ trial()
        ~ t_2_bribe_guards = true
        {sc(DEXT, -10): -> bribe_guards_S | -> bribe_guards_F}


- PERSONNAGE MASQUÉ: Ça sent mauvais là-dedans... #wait:3
- PERSONNAGE MASQUÉ: Que fera-t-on s'ils me trouvent ? #playsound:VOX_Naida_queferaton #wait:10
-> church_night
    * [Du poisson plus très frais.] PLAYER: Certaines caisses sont remplies de poisson. Et la pêche ne date pas de la veille...
    * [Ça sent les ennuis...] PLAYER: Ça sent les ennuis !
    * [L'odeur de la liberté !] PLAYER: Le poisson pas frais et le sel marin : l'odeur de la liberté !
- PERSONNAGE MASQUÉ: Que fera-t-on s'ils me trouvent ?
    * [Je vous protégerai. {t(CHAR, 0)}]
        {sc(CHAR, 0): -> protect_S | -> protect_F}
        ** (protect_S) PLAYER: Je braverai les dangers pour vous protéger !
            PERSONNAGE MASQUÉ: Espérons que l'on n'en arrive pas là.
        ** (protect_F) PLAYER: Euh.. Je.. Je vous défendrai ?
            PERSONNAGE MASQUÉ: Ne le prenez pas mal, mais... vous n'êtes pas très convaincant.
    * [On improvisera.] PLAYER: On improvisera, comme j'en ai l'habitude.
        PERSONNAGE MASQUÉ: Ce n'est pas la première fois que vous avez des ennuis avec la Couronne, n'est-ce pas ?
        ** [(Mentir) C'est une première. {t(CHAR, -10)}]
            {sc(CHAR, -10): -> lie_S | -> lie_F}
            *** (lie_S) PLAYER: Je suis ce qu'on appelle un honnête homme.
                PERSONNAGE MASQUÉ: Vous semblez sincère.
            *** (lie_F) PLAYER: Je suis blanc comme neige au soleil.
                ~ trial()
                ~ t_2_lawless = true
                PERSONNAGE MASQUÉ: Vous mentez très mal, mon ami.
        ** [Certes.] PLAYER: C'est vrai, je l'admets. Mais ne dit-on pas que nul homme n'a à rougir d'une faute avouée ?
            PERSONNAGE MASQUÉ: Je n'ai jamais entendu cela, non.
            *** [Oubliez.] PLAYER: J'ai dû l'inventer, alors.
- PERSONNAGE MASQUÉ: Et maintenant, que fait-on ?
    * [Forcer la caisse du fond. {t(STRE, 0)}] #playsound:crate_search
        {sc(STRE, 0): -> crate_back_search_S | -> crate_back_search_F}
        ** (crate_back_search_S) PLAYER: Du poisson pourri... J'empeste ! Mais j'ai trouvé <b>quelques pièces</b>. #playsound:gold_coins
            ~ p_gold += 3
            ~ player_is_stinky = true
        ** (crate_back_search_F) PLAYER: Du poisson pourri... J'empeste !
            ~ player_is_stinky = true
    * [Fouiller le tonneau. {t(DEXT, 10)}]
        {sc(DEXT, 10): -> barrel_search_S | -> barrel_search_F}
        ** (barrel_search_S) PLAYER: J'ai trouvé un <b>gros os</b>. Ça pourrait servir. #playsound:inventory
        ~ has_bone = true
            PERSONNAGE MASQUÉ: Qu'avez-vous en tête ?
            *** [Plaisanter.] PLAYER: Peut-être qu'en l'envoyant, les gardes iront chercher ? #audience:laughter
                PERSONNAGE MASQUÉ: Comment pouvez-vous avoir le cœur à rire ?
            *** [Dire la vérité.] PLAYER: Si je n'ai pas d'autres choix, j'assommerai les gardes.
                PERSONNAGE MASQUÉ: J'ai si peur...
        ** (barrel_search_F) PLAYER: Je n'ai rien trouvé.
    * [Fouiller la caisse de devant. {t(DEXT, -10)}] #playsound:crate_search
        {sc(DEXT, -10): -> crate_front_search_S | -> crate_front_search_F}
        ** (crate_front_search_S) PLAYER: Une <b>noix de coco</b>. Ça pourrait être utile, qui sait. #playsound:inventory
            ~ has_coconut = true
        ** (crate_front_search_F) PLAYER: Je n'ai rien trouvé.
- PERSONNAGE MASQUÉ: Ne peut-on pas éviter que des gardes ne viennent fourrer leur nez ici ?
    * [Je connais certains gardes...] PLAYER: Il est certains gardes que je... connais bien, disons. Pas ceux-là.
    * [C'est la Loi.] PLAYER: Tous les navires qui arrivent à Miraterre doivent être fouillés. Par ailleurs...
        PERSONNAGE MASQUÉ: Par ailleurs ?
        PLAYER: Votre simple présence enfreint une <b>Loi capitale</b>, j'en ai peur. #audience:debate
            ~ trial()
            ~ t_2_lawfull = true
- PERSONNAGE MASQUÉ: N'éprouvez-vous jamais aucun regret ? Si la Loi et la Foi l'interdisent...
    * [Sans foi ni loi.] PLAYER: Je me fiche de la Loi comme de la Foi. #trial
        ~ trial()
        ~ t_2_against_law = true
        ~ trial()
        ~ t_2_against_crown = true
    * [Pas le temps pour des regrets.] PLAYER: L'heure n'est pas au regret.
        ~ trial()
        ~ t_2_show_no_regrets = true
    * [(Tiraillé) Parfois...] PLAYER: Il est des jours où je crois être le plus vil des hommes... #trial
        ~ trial()
        ~ t_2_show_regrets = true
- PERSONNAGE MASQUÉ: J'entends des bruits. Quelqu'un vient. #playsound:activity_far
* [Cachez-vous.] PLAYER: Il va falloir vous trouver une cachette, et en vitesse.
    -- (hide_sireine) PERSONNAGE MASQUÉ: Les bruits se rapprochent ! #playsound:activity_close
        *** [Dans la caisse du fond.] PLAYER: Cette caisse, au fond ! Vite ! #move:Naïda:-2:10
            ~ sireine_hideout = "crate_back"
            ~ sireine_is_hidden = true
        *** [Derrière le tonneau.] PLAYER: Derrière ce tonneau, vite ! #move:Naïda:-3:-1
            ~ sireine_hideout = "barrel"
            ~ sireine_is_hidden = true
        *** [Derrière la caisse de devant.] PLAYER: Derrière cette caisse, vite ! #move:Naïda:4:2
            ~ sireine_hideout = "crate_front"
            ~ sireine_is_hidden = true
* [Attendons.] PLAYER: Pas le temps de se cacher !
    PERSONNAGE MASQUÉ: Il le faut pourtant !
        -> hide_sireine
- PLAYER: Quant à moi...
    * {has_coconut == true or has_bone == true} [Se cacher. {t(DEXT, 10)}]
        {sc(DEXT, 10): -> player_hide_S | -> player_hide_F}
        ** (player_hide_S) #move:Player:3:-3
            ~ player_is_hidden = true
            -> guards_arrive
        ** (player_hide_F) PLAYER: Loupé ! La discrétion n'est pas mon fort !
            -> guards_arrive
    * [Accueillir les gardes.]
- -> guards_arrive


// The guards arrive
= guards_arrive
#playsound:guards_arrive
- MARCELLO: J'ai entendu du bruit dans la cale. #anim:Marcello:enter_scene #audience:ovation
CAPUCINE: Tu entends des voix, maintenant ? Peut-être la Déesse en personne qui te cause... #playsound:VOX_Capucine_tuentendsvoixQ #anim:Capucine:enter_scene #audience:laughter
MARCELLO: Vous me croyez fou, cheffe ? #audience:laughter #move:Capucine:11:9 #move:Marcello:9:11 #audience:ovation
CAPUCINE: Que tu sois cinglé ou non... Nous devons <b>fouiller</b> tous les navires qui <b>arrivent au port</b>. #playsound:VOX_Capucine_soiscinglenon #audience:applause
- {player_is_hidden: -> player_hidden | -> player_not_hidden}


//The guards arrive while the player is hidden
= player_hidden
#playsound:guards_arrive
MARCELLO: Il n'y a personne, cheffe.
* [Rester discret. {t(DEXT, -10)}]
    {sc(DEXT, -10): -> discretion_1_S | -> discretion_1_F} #anim:Marcello:seek_intruder_near_player
    ** (discretion_1_S) MARCELLO: Je ne vois personne. Et toi ?
        -- {
                - player_is_stinky: CAPUCINE: Je ne vois personne, mais ça pue le poisson mort par ici. 
                    -> player_is_found
                -else:
                    -> player_not_found
            }
    ** (discretion_1_F) MARCELLO: Là ! Derrière cette caisse ! Il y a quelqu'un ! #anim:Player:stop_hiding
        -> player_is_found
* [Sortir de sa cachette] #anim:Player:stop_hiding
    -> player_not_hidden
- (player_not_found) CAPUCINE: Laisse-moi regarder de plus près... 
    * {has_bone} [Assommer Marcello avec l'os. {t(STRE, 0)}]
        -> attack_marcello_with_bone
    * {has_coconut} [Envoyer la noix de coco. {t(DEXT, -10)}]
        -> attack_marcello_with_coconut
    * [Sortir de sa cachette] #anim:Player:stop_hiding
        -> player_not_hidden
- (player_is_found) CAPUCINE: Qui es-tu, maraud ? {player_is_stinky: Tu empestes le poisson pourri !} #playsound:VOX_Capucine_quiestu
    SOUFFLEUR: SOUFFLEUR: Psssst... Hé, l'ami !
    SOUFFLEUR: En fouillant la caisse pleine de poisson pourri, l'odeur s'est incrustée à ton costume...
    SOUFFLEUR: Ce doit être pour ça que tu t'es fait repéré.
    SOUFFLEUR: Interagir avec le décors entraîne parfois des conséquences inattendues, l'ami !
    -> player_not_hidden


// The guards arrive while the player is not hidden
= player_not_hidden
#playsound:guards_arrive
* [S'annoncer.] PLAYER: Bien le bonjour, mes braves. #move:Player:11:2
- CAPUCINE: Décline ton identité, et vite ! #playsound:VOX_Capucine_declineidentite
    * [Je suis le capitaine.] PLAYER: Vous vous trouvez sur mon humble navire.
        CAPUCINE: C'est toi le capitaine ? #playsound:VOX_Capucine_cesttoicapitaineQ
    * [(Mentir) Un simple moussaillon. {t(CHAR, 10)}]
        {sc(CHAR, 10): -> lie_about_not_being_capitaine_S | -> lie_about_not_being_capitaine_F}
            ** (lie_about_not_being_capitaine_S) PLAYER: Je suis un simple moussaillon.
                MARCELLO: Il a l'air de dire vrai, cheffe.
            ** (lie_about_not_being_capitaine_F) PLAYER: Je... euh... Je suis un simple moussaillon.
                MARCELLO: Tu mens comme tu respires, pas vrai ?
- CAPUCINE: Le fripon a l'air louche... #playsound:VOX_Capucine_friponlouche
    * [Louches vous-mêmes !] PLAYER: C'est vous qui êtes louches, les baveux.
        MARCELLO: Répète ça pour voir, abruti !
        ** [Répéter.] PLAYER: Louches et sourdingues, en plus de ça.
            MARCELLO: Nous allons t'apprendre à insulter des gardes de la Couronne ! #anim:Marcello:attack #anim:Player:hurt
                -> battle
        ** [Calmer le jeu. {t(CHAR, 10)}]
            {sc(CHAR, 10): -> try_diplomacy_S | -> try_diplomacy_F}
            *** (try_diplomacy_S) -> calm_the_situation
            *** (try_diplomacy_F) PLAYER: Euh... Pardon, j'ai tendance à dire tout haut ce que je pense tout bas...
        -> calm_the_situation
    * (calm_the_situation) [Amadouer.] PLAYER: Et si nous remontions sur le pont, pour discuter entre amis ?
        CAPUCINE: Un garde de la Couronne n'a d'ordre à recevoir de personne. #playsound:VOX_Capucine_gardecouronneordre
        ** [Faire de l'esprit.] PLAYER: Pas même de la reine ?
            MARCELLO: Il a pas tort, cheffe.
            CAPUCINE: Cet abruti se fiche de nous. Mais il ne va pas rire longtemps... #playsound:VOX_Capucine_abrutifiche
                -> confronted_about_fugitive
        ** [Que faites-vous sur mon navire ?] PLAYER: Puis-je vous demander ce que vous faites ici, mes braves ?
            MARCELLO: Tous les bateaux qui arrivent au port royal doivent être fouillés, c'est la loi. #playsound:VOX_Marcello_laloi
            CAPUCINE: Et nul ne doit ignorer la loi... Caches-tu quelque chose ? #playsound:VOX_Capucine_nulignorerloi
- (confronted_about_fugitive) CAPUCINE: Quelqu'un qui sortait de la cale nous a dit qu'un fugitif se cachait ici. #playsound:VOX_Capucine_quelqunsortait
MARCELLO: Alors, qu'as-tu à répondre, marin d'eau douce ?
    * [Baratiner. {t(CHAR, -10)}]
        {sc(CHAR, -10): -> lie_about_fugitive_S | -> lie_about_fugitive_F}
        ** (lie_about_fugitive_S) PLAYER: Cet individu ment. D'ailleurs, il m'a détroussé de cinq pièces d'or !
            MARCELLO: Il a l'air de dire vrai. T'en penses quoi, cheffe ?
            CAPUCINE: J'en pense que je vais fouiller le navire dans le doute. Garde un œil sur lui. #playsound:VOX_Capucine_fouillernaviredoute #anim:Capucine:seek_intruder_near_sireine
                -> battle
        ** (lie_about_fugitive_F) PLAYER: Le type que vous avez vu sortir d'ici est atteint d'une maladie rare.
            CAPUCINE: Une maladie rare ? #playsound:VOX_Capucine_maladierare
            PLAYER: Absolument. Une maladie qui lui fait voir des fugitifs qui ne sont pas là.
            CAPUCINE: ...
            MARCELLO: ...
            CAPUCINE: Il nous prend pour des idiots ou je rêve ? #playsound:VOX_Capucine_idiotsoujereve
            MARCELLO: Je vais t'apprendre à mentir à des gardes de la Couronne ! #anim:Marcello:attack #anim:Player:hurt
                -> battle
    * [Intimider. {t(STRE, -20)}]
        {sc(STRE, -20): -> intimidate_guards_S | -> intimidate_guards_F}
        ** (intimidate_guards_S) PLAYER: Le marin d'eau douce va te noyer de coups, si tu continues de l'ouvrir.
            MARCELLO: Pardon, m'sieur.
            CAPUCINE: Ne t'excuse pas, abruti. Apprends-lui plutôt ce qu'on obtient en menaçant un garde de la Couronne ! #playsound:VOX_Capucine_netexxcusepas
            MARCELLO: Compris, cheffe ! #anim:Marcello:attack #anim:Player:hurt
                -> battle
        ** (intimidate_guards_F) PLAYER: T'as vu mes biscoteaux ? Tu veux les voir de plus près, peut-être ?
            CAPUCINE: ... 
            MARCELLO: ...
            CAPUCINE: Il se croit intimidant, cet idiot ? #playsound:VOX_Capucine_ilsecroitintimidant
            MARCELLO: Je vais t'apprendre à menacer des gardes de la Couronne ! #anim:Marcello:attack #anim:Player:hurt
                -> battle
    * {p_gold > 0} [Soudoyer. {t(DEXT, -10)}]
        ~ trial()
        ~ t_2_bribe_guards = true
        {sc(DEXT, -10): -> bribe_guards_S | -> bribe_guards_F}
    PLAYER: Est-ce que {p_gold} pièces d'or pourraient vous faire quitter mon navire sans faire de vagues ? Si vous me permettez l'expression...
        ** (bribe_guards_S) CAPUCINE: Laisse-moi te débarrasser de ces pièces...
            *** [Donner les pièces.] PLAYER: Voilà pour toi, mon amie. #playsound:gold_coins
                CAPUCINE: Nous allons maintenant t'apprendre les mérites de respecter la Loi, et les dangers de tenter de soudoyer un garde, quadruple forban. #playsound:VOX_Capucine_quadrupleforbandangerssoudoyer
                MARCELLO: C'est là que je le frappe, cheffe ?
                CAPUCINE: En effet, Marcello. C'est là que tu le frappes. #playsound:VOX_Capucine_eneffetfrappes
                MARCELLO: Compris, cheffe ! #anim:Marcello:attack #anim:Player:hurt
                    -> battle
            *** [Assommer Marcello.] -> attack_marcello_S
        ** (bribe_guards_F) CAPUCINE: À qui penses-tu avoir affaire, quadruple forban ? Nous allons t'apprendre les mérites de respecter la Loi, et les dangers de tenter de soudoyer un garde ! #playsound:VOX_Capucine_aquiquadrupleforban
            MARCELLO: C'est là que je le frappe, cheffe ?
            CAPUCINE: En effet, Marcello. C'est là que tu le frappes. #playsound:VOX_Capucine_eneffetfrappes
            MARCELLO: Compris, cheffe ! #anim:Marcello:attack #anim:Player:hurt
                -> battle

// Attack Marcello with a bone
= attack_marcello_with_bone
{sc(STRE, 0): -> attack_marcello_bone_S | -> attack_marcello_bone_F} #anim:Marcello:seek_intruder_near_player
    ** (attack_marcello_bone_S) MARCELLO: Le navire est vide, cheffe. #anim:Player:attack #anim:Marcello:hurt #audience:choc
        MARCELLO: Aïe !
        CAPUCINE: Pas aussi vide que tu ne le pensais, apparemment... #playsound:VOX_Capucine_pasaussivide #audience:laugh
        MARCELLO: Cet abruti m'a frappé !
        CAPUCINE: Ça m'en a tout l'air, en effet. #playsound:VOX_Capucine_camenatoutlair
    ** (attack_marcello_bone_F) MARCELLO: Le navire est vide, cheffe. #anim:Player:attack #anim:Marcello:dodge
        MARCELLO: Ai-je la berlue ou est-ce qu'un gougnafier vient d'essayer de m'assommer avec une entrecôte ? #audience:laugh
- MARCELLO: Prends ça, pour la peine ! #anim:Marcello:attack #anim:Player:hurt audience:applause
- -> battle

// Attack Marcello with a coconut
= attack_marcello_with_coconut
{sc(DEXT, -10): -> attack_marcello_coconut_S | -> attack_marcello_coconut_F}
    ** (attack_marcello_coconut_S) MARCELLO: Le navire est vide, cheffe. #anim:Player:throw_coconut_success
        MARCELLO: Aïe !
        CAPUCINE: Pas aussi vide que tu ne le pensais, apparemment... #playsound:VOX_Capucine_pasaussivide #audience:laugh
        MARCELLO: Cet abruti m'a envoyé une noix de coco en plein dans les narines !
        CAPUCINE: Ça m'en a tout l'air, en effet. #playsound:VOX_Capucine_camenatoutlair
    ** (attack_marcello_coconut_F) MARCELLO: Le navire est vide, cheffe. #anim:Player:throw_coconut_fail
        MARCELLO: Ai-je la berlue ou est-ce qu'un gougnafier vient d'essayer de m'envoyer une noix de coco dans la poire ? #audience:laugh
- MARCELLO: Prends ça, pour la peine ! #anim:Marcello:attack #anim:Player:hurt audience:applause
- -> battle

// Battle (acting phase)
= battle
    * [Attaquer Marcello. {t(STRE, -10)}]
        ~ trial()
        ~ t_2_attack_guards = true
        {sc(STRE, -10): -> attack_marcello_S | -> attack_marcello_F}
        ** (attack_marcello_S) PLAYER: Prends ça ! #anim:Player:attack #anim:Marcello:hurt #audience:choc
            MARCELLO: Attaquer un garde de la Couronne ! Tu as perdu la tête !
        ** (attack_marcello_F) PLAYER: Prends ça ! #anim:Player:attack #anim:Marcello:dodge
            MARCELLO: Héhé... Trop lent, minable.
    * [Attaquer par derrière. {t(DEXT, -10)}]
        ~ trial()
        ~ t_2_attack_guards = true
        {sc(DEXT, -10): -> sneaky_attack_marcello_S | -> sneaky_attack_marcello_F}
        ** (sneaky_attack_marcello_S) MARCELLO: Je peux le rosser, cheffe ? #look:Marcello:Capucine
            PLAYER: Prends ça ! #anim:Player:sneaky_attack #anim:Marcello:hurt #audience:choc
            MARCELLO: M'attaquer alors que j'ai le dos tourné ? Tu es un lâche !
            *** [Et toi un crétin.] PLAYER: C'est toi qui es stupide, à tourner le dos à quelqu'un que tu viens de frapper. #audience:laughter
            *** [C'est tout moi, en effet.] PLAYER: Je dirai plutôt que je sais saisir une opportunité quand je la vois... #audience:applause
                PLAYER: Surtout quand cette opportunité consiste à cogner un rustre comme toi.
        ** (sneaky_attack_marcello_F) MARCELLO: Je peux le rosser, cheffe ? #look:Marcello:Capucine
            PLAYER: Prends ça ! #anim:Player:sneaky_attack #anim:Marcello:dodge
            MARCELLO: Tu te crois discret, abruti ?
    * [Calmer le jeu. {t(CHAR, -10)}]
        {sc(CHAR, -10): -> calm_marcello_S | -> calm_marcello_F}
        ** (calm_marcello_S) PLAYER: Je vous propose d'en rester là, messires. Je ne suis point homme à rosser un garde de la Couronne.
            CAPUCINE: En voilà une parole raisonnable. #playsound:VOX_Capucine_envoilaraisonnable
            MARCELLO: Dommage, je n'aurais pas détesté t'en claquer une sur le museau... #audience:laughter
            CAPUCINE: Allons, allons, Marcello... Le monsieur est raisonnable, alors soyons-le à notre tour. #playsound:VOX_Capucine_allonsallonsmarecello #audience:applause
        ** (calm_marcello_F) PLAYER: Je vous propose d'en rester là, messires. Je ne suis point homme à rosser un garde de la Couronne.
            CAPUCINE: En voilà une parole raisonnable. Mon ami, en revanche, apprécierait de t'en claquer une sur le museau. Pas vrai, Marcello ? #playsound:VOX_Capucine_envoilaenrevanche
            MARCELLO: Je confirme. #audience:laughter
            MARCELLO: Tiens, la voilà ! #anim:Marcello:attack #anim:Player:hurt
- -> arrest_naida

// After the battle
= after_battle
{
    - player_won_battle:
        MARCELLO: Je crois qu'on lui a donné une bonne leçon, cheffe.
        CAPUCINE: Pas du tout, abruti. Cette truandaille nous a rossés. Les gardes de la Couronne vont encore passer pour des moins-que-rien. #playsound:VOX_Capucine_pasdutoutabruti
        MARCELLO: Vraiment ? Vengeons-nous en lui brisant les côtelettes, cheffe !
        CAPUCINE: C'est précisémment ce que nous venons d'échouer à faire, triple baveux. #playsound:VOX_Capucine_cesprecisement #anim:Marcello:ashamed
    - else:
        CAPUCINE: Voilà qui t'enseignera les mérites de ne pas manquer de respect aux gardes de la Couronne, vulgaire truandaille. #playsound:VOX_Capucine_voilaquitenseignera
        MARCELLO: Bien dit, cheffe ! J'ajouterai une petite insulte afin de marquer le coup.
        CAPUCINE: Je viens précisément de le faire, triple baveux. #playsound:VOX_Capucine_jeviensprecisement #anim:Marcello:ashamed
}
- -> arrest_naida

// Naida is arrested
=arrest_naida
#playsound:sounds_inside_the_crate
CAPUCINE: As-tu entendu ? Quelque chose a bougé là-dedans ! #playsound:VOX_Capucine_astuentenduquelquechoeabouge
MARCELLO : Sans doute un rat. Cette tête de pipe prend aussi peu soin de son navire qu'un crapaud de son étang. #audience:laughter
CAPUCINE: Bloque-lui la route tandis que j'y jette un œil. #playsound:VOX_Capucine_bloqueluilaroute #audience:choc #anim:Marcello:block_the_way
{
    - sireine_hideout == "crate_back":
        #move(Capucine)
        #anim:Capucine:search_crate
    - sireine_hideout == "crate_front":
        #move(Capucine)
        #anim:Capucine:search_crate
    - sireine_hideout == "barrel":
        #move(Capucine)
        #anim:Capucine:search_barrel
}
- CAPUCINE: Tiens donc... Mais qui voilà ? #playsound:VOX_Capucine_tiensdoncmaisquivouila #audience:choc #move:Naïda:10:9
PERSONNAGE MASQUÉ: Laissez-moi ! Je vous ai dit de me laisser !
CAPUCINE: C'est donc cela que tu cachais... Marcello, embarquons-la. #playsound:VOX_Capucine_cestdonccela
#anim:Player:attack
#anim:Marcello:dodge
#anim:Marcello:attack
#anim:Player:hurt
CAPUCINE: Allons-nous-en avec notre trouvaille. #playsound:VOX_Capucine_allonsnousen
CAPUCINE: Si ce maraud se trouve encore sur son navire quand nous reviendrons avec des renforts... #playsound:VOX_Capucine_ilfinira1 #audience:debate
CAPUCINE: Il finira sa triste vie au cachot, comme son amie. #playsound:VOX_Capucine_ilfinira2 #audience:ovation
- -> barge.scene_3
