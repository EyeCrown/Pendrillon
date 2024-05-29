// TRIP RETURN SCENE


// Variables
VAR sireine_is_hidden = false // If the sireine is hidden or not
VAR sireine_hideout = "none" // The sireine hideout
VAR weapon_on_hand = true // If the player's weapon is on hand or not
VAR has_bone = false // Can be found in the back crate
VAR has_coconut = false // Can be found in the front crate
VAR player_is_stinky = false // Player is stinky if he searches through the back crate
VAR sireine_is_stinky = false // Sireine is stinky if she hides in the back crate
VAR jester_fled = false // Define if the jester fled or not
VAR player_is_hidden = false // Define if the player is hidden or not
VAR player_won_battle = false // Define if the player won the battle or not

// Scene
=== trip_return ===
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Naïda:???
#actor:Arle:ÉPIEUR
#actor:Marcello:MARCELLO
#actor:Capucine:CAPUCINE
// Start the scene
-> start

= start
- ???: (Écœurée) Ça sent mauvais là-dedans...
    * [Du poisson plus très frais.] PLAYER: Certaines caisses sont remplies de poisson. Et la pêche ne date pas de la veille...
        ** [Désolé pour l'odeur...] PLAYER: Les marins ne sont pas dérangés par ce genre d'odeur. Mais ce n'est pas du goût de tout le monde...
        ** [Ça peut nous être profitable !] PLAYER: Avec un peu de chance, l'odeur fera passer aux gardes l'envie de trop s'attarder.
        ** [Impossible d'aérer.] PLAYER: C'est le problème d'une cale de bâteau : difficile d'aérer un navire plongé dans l'eau.
    * [Ça sent les ennuis...] PLAYER: Ça sent les emmerdes.
    * [L'odeur de la liberté !] PLAYER: Le poisson pas frais et le sel marin : l'odeur de la liberté !
- ???: ...
- ???: Que fera t-on s'ils me trouvent ?
    * [Je vous protégerai. {t(CHAR, 0)}]
        {sc(CHAR, 0): -> protect_S | -> protect_F}
        ** (protect_S) PLAYER: Je braverai les dangers pour vous protéger !
            ???: (Inquiète) Espérons qu'on n'en arrive pas là.
        ** (protect_F) PLAYER: Euh.. Je.. Je vous défendrai ?
            ???: (Se retient de rire) Ne le prenez pas mal, mais... vous n'êtes pas très convainquant.
    * [On improvisera.] PLAYER: On improvisera, comme j'en ai l'habitude.
        ???: Ce n'est pas la première fois que vous avez des ennuis avec la Couronne, n'est-ce pas ?
        ** [(Mentir) C'est une première. {t(CHAR, -20)}]
            {sc(CHAR, -20): -> lie_S | -> lie_F}
            *** (lie_S) PLAYER: Je suis ce qu'on appelle un honnête homme.
                ???: Vous semblez sincère.
            *** (lie_F) PLAYER: Je suis blanc comme neige au soleil.
                ~ trial(t_2_lawless)
                ???: Vous mentez très mal, mon ami.
        ** [Certes.] C'est vrai, je l'admet. Mais ne dit-on pas que nul homme n'a à rougir d'une faute avouée ?
            ???: Je n'ai jamais entendu cela, non.
            *** [...] PLAYER: J'ai dû l'inventer, alors.
- ???: Et maintenant ? Qu'avez-vous en tête ?
    * [Fouiller la caisse du fond. {t(LUCK, 0)}] #playsound:crate_search
        {sc(LUCK, 0): -> crate_back_search_S | -> crate_back_search_F}
        ** (crate_back_search_S) PLAYER: Du poisson pourri... J'empeste ! Mais j'ai trouvé quelques pièces. #playsound:gold_coins
            ~ p_gold += 3
            ~ player_is_stinky = true
        ** (crate_back_search_F) PLAYER: Du poisson pourri... J'empeste !
            ~ player_is_stinky = true
    * [Fouiller le tonneau. {t(LUCK, 0)}]
        {sc(LUCK, 0): -> barrel_search_S | -> barrel_search_F}
        ** (barrel_search_S) PLAYER: J'ai trouvé un gros os. Ça pourrait servir. #playsound:inventory
        ~ has_bone = true
            ???: Qu'avez-vous en tête ?
            *** [Plaisanter.] PLAYER: Peut-être qu'en l'envoyant, les gardes iront chercher ?
                ???: Comment pouvez-vous avoir le cœur à rire ?
            *** [Dire la vérité.] PLAYER: Si je n'ai pas d'autres choix, j'assommerai les gardes.
                ???: J'ai si peur...
        ** (barrel_search_F) PLAYER: Je n'ai rien trouvé.
    * [Fouiller la caisse de devant. {t(LUCK, 0)}] #playsound:crate_search
        {sc(LUCK, 0): -> crate_front_search_S | -> crate_front_search_F}
        ** (crate_front_search_S) PLAYER: Une noix de coco. Ça pourrait être utile, qui sait. #playsound:inventory
            ~ has_coconut = true
        ** (crate_front_search_F) PLAYER: Je n'ai rien trouvé.
- ???: Ne peut-on pas éviter que des gardes ne viennent fourrer leur nez ici ?
    * [Je connais certains gardes...] PLAYER: Il est certains gardes que je... connais bien, disons. D'autres sont étrangers.
        ~ trial(t_2_have_bribed_guards)
        ???: Quoi donc ?
        PLAYER: Il est plus difficile de convaincre des gardes de fermes les yeux par ici.
        ???: Pourquoi est-ce différent à Miraterre ?
        PLAYER: Disons que, dans cette ville, la Loi a des yeux partout. #playsound:judge_bell
    * [C'est la Loi.] PLAYER: Certaines lois sont sujettes à interpretations, mais...
        ???: ...mais ?
        PLAYER: ...mais pas celle que nous avons bravée, j'en ai peur. #playsound:judge_bell
            ~ trial(t_2_lawfull)
- ???: ...
- ???: N'éprouvez-vous jamais aucun regret ? Si la Loi et la Foi l'interdisent...
    * [Sans foi ni loi.] PLAYER: Je me fiche de la Loi comme de la Foi. #trial
        ~ trial(t_2_against_law)
        ~ trial(t_2_against_crown)
    * [Pas le temps pour des regrets.] PLAYER: L'heure n'est pas au regret.
        ~ trial(t_2_show_no_regrets)
    * [(Tiraillé) Parfois...] PLAYER: Il est des jours où je crois être le plus vil des hommes... #trial
        ~ trial(t_2_show_regrets)
- ???: J'entends des bruits. Quelqu'un vient. #playsound:activity_far
* [Cachez-vous.] PLAYER: Il va falloir vous trouver une cachette, et en vitesse.
    -- (hide_sireine) ???: Les bruits se rapprochent ! #playsound:activity_close
        #anim:Arle:enter_scene #anim:Arle:hide
        *** [Dans la caisse du fond.] Cette caisse, au fond ! Vite ! #anim:Sireine:hide
            ~ sireine_hideout = "crate_back"
            ~ sireine_is_hidden = true
            ~ sireine_is_stinky = true
        *** [Derrière le tonneau.] Derrière ce tonneau, vite ! #anim:Sireine:hide
            ~ sireine_hideout = "barrel"
            ~ sireine_is_hidden = true
        *** [Derrière la caisse de devant.] Derrière cette caisse, vite ! #anim:Sireine:hide
            ~ sireine_hideout = "crate_front"
            ~ sireine_is_hidden = true
* [Attendons.] PLAYER: Pas le temps de se cacher !
    ???: En êtes-vous certain ? Les pas sont bientôt là... #playsound:activity_close
    ** [Ne faites rien.] PLAYER: Faites-moi confiance... Restez-ici !
    ** [Cachez-vous.] PLAYER: Il va falloir vous trouver une cachette, et en vitesse.
        -> hide_sireine
- #playsound:jester_hiding_make_noise // Le bouffon fait un peu de bruit, caché sur le coté de la scène
* [Tendre l'oreille. {t(COMP, -10)}] PLAYER: J'ai cru entendre quelque chose. Mais les bruits de pas se rapprochent... ##playsound:activity_close
    {sc(COMP, 0): -> listen_hidden_jester_S | -> listen_hidden_jester_F}
        ** (listen_hidden_jester_S) PLAYER: (Chuchotte) Quelqu'un nous épie.
            *** [Confronter l'épieur.] PLAYER: Sort de ta cachette, rat des campagnes !
                ÉPIEUR: Vous avez l'ouïe fine, messire. #anim:Arle:stop_hiding
                **** [Qui êtes vous ?] PLAYER: Qui va là ?!
                    ÉPIEUR: Un simple passant égaré. #anim:Arle:bow 
                    ***** [Foutaises.] PLAYER: Balivernes ! Dis-moi qui tu es ou je te coupe en dés de jambon !
                        ÉPIEUR: Je ne suis que moi-même, messire. Indigne d'être nommé. Je m'en vais déjà...
                        ****** [Attaquer. {t(STRE, -10)}]
                            {sc(STRE, -10): -> attack_jester_S | -> attack_jester_F}
                            ******* (attack_jester_S) ÉPIEUR: (Hurlant) À moi ! Au secours ! #anim:Player:attack
                                ~ trial(t_2_jester_attacked)
                                -> guards_are_called
                            ******* (attack_jester_F) ÉPIEUR: Trop lent !
                                -> jester_flee
                        ****** [Faire fuire.] PLAYER: Va t-en, avant que je te tranche le lard !
                            -> jester_flee
                    ***** (jester_flee) [Déguerpissez.] ÉPIEUR: À la revoyure ! #anim:Arle:flee
                            ~ jester_fled = true 
            *** [Se cacher. {t(DEXT, 15)}] PLAYER: Pas le temps d'investiguer.
                -> hide_player
        ** (listen_hidden_jester_F) PLAYER: Ce doit être mon imagination... J'entends les gardes qui arrivent.
* (hide_player) [Se cacher. {t(DEXT, 15)}] PLAYER: Je devrai me cacher moi aussi ! #anim:Player:hide
    {sc(DEXT, 0): -> player_hide_S | -> player_hide_F}
    ** (player_hide_S) PLAYER: Ici, vite !
        ~ player_is_hidden = true
        -> guards_arrive
    ** (player_hide_F) PLAYER: Loupé ! La discretion n'est pas mon fort ! #playsound:player_hide_and_make_noise
        -> guards_arrive
- -> guards_arrive


// The guards arrive
= guards_arrive
#playsound:guards_arrive
MARCELLO: J'ai entendu du bruit dans la cale. #anim:Marcello:enter_scene
CAPUCINE: (Ironique) Tu entends des voix, maintenant ? Peut-être la Déesse en personne qui te cause... #anim:Capucine:enter_scene
MARCELLO: Vous me croyez fou, cheffe ?
CAPUCINE: Que tu sois cinglé ou non... Nous devons fouiller tous les navires qui arrivent au port.
- {player_is_hidden: -> player_hidden | -> player_not_hidden}


//The guards arrive while the player is hidden
= player_hidden
#playsound:guards_arrive
MARCELLO: Il n'y a personne, cheffe.
* [Rester discret. {t(DEXT, -10)}]
    {sc(DEXT, -10): -> discretion_1_S | -> discretion_1_F} #anim:Marcello:seek_intruder_near_player
    ** (discretion_1_S) MARCELLO: Je ne vois personne. Et toi ?
        -- {player_is_stinky: CAPUCINE: Je ne vois personne, mais ça pue le poisson mort par ici. -> player_is_found | -> player_not_found}
    ** (discretion_1_F) MARCELLO: Là ! Derrière cette caisse ! Il y a quelqu'un ! #anim:Player:stop_hiding
        -> player_is_found
* [Sortir de sa cachette] #anim:Player:stop_hiding
    -> player_not_hidden
- (player_not_found) CAPUCINE: Laisse-moi regarder de plus près...
    * {has_bone} [Assommer Marcello avec l'os. {t(STRE, 20)}]
        -> attack_marcello_with_bone
    * {has_coconut} [Envoyer la noix de coco. {t(DEXT, 20)}]
        -> attack_marcello_with_coconut
    * [Sortir de sa cachette] #anim:Player:stop_hiding
        -> player_not_hidden
- (player_is_found) CAPUCINE: Qui es-tu, maraud ? {player_is_stinky: Tu empestes le poisson pourri !}
    -> player_not_hidden


// The guards arrive while the player is not hidden
= player_not_hidden
#playsound:guards_arrive
* [S'annoncer.] PLAYER: Bien le bonjour.
- CAPUCINE: Décline ton identité, et vite !
    * [Je suis le capitaine.] PLAYER: Vous vous trouvez sur mon humble navire.
        CAPUCINE: C'est toi le capitaine ?
    * [(Mentir) Un simple moussaillon. {t(CHAR, 10)}] PLAYER: Je suis un simple moussaillon.
        {sc(CHAR, 10): -> lie_about_not_being_capitaine_S | -> lie_about_not_being_capitaine_F}
            ** (lie_about_not_being_capitaine_S) MARCELLO: Il a l'air de dire vrai, cheffe.
            ** (lie_about_not_being_capitaine_F) MARCELLO: Tu mens comme tu respires, pas vrai ?
- CAPUCINE: Le fripon a l'air louche...
    * [Vous-mêmes.] PLAYER: C'est vous qui êtes louche, les morpions.
        MARCELLO: Répète ça pour voir, abruti !
        ** [Répéter.] PLAYER: Louches et sourdingues, en plus de ça.
            MARCELLO: Nous allons t'apprendre à insulter des gardes de la Couronne ! #anim:Marcello:attack #anim:Player:hurt
                -> battle
        ** [Calmer le jeu. {t(CHAR, 10)}]
            {sc(CHAR, 10): -> try_diplomacy_S | -> try_diplomacy_F}
            *** (try_diplomacy_S) -> calm_the_situation
            *** (try_diplomacy_F) PLAYER: Euh... Pardon, j'ai tendance à dire tout haut ce que je pense tout bas... -> calm_the_situation
    * (calm_the_situation) [Amadouer.] PLAYER: Et si nous remontions sur le pont, pour discuter entre amis ?
        CAPUCINE: Un garde de la Couronne n'a d'ordre à recevoir de personne.
        ** [Faire de l'esprit.] PLAYER: Pas même de la Reine ?
            CAPUCINE: Que baragouines-tu encore ?
            MARCELLO: Il a pas tort, cheffe.
            CAPUCINE: Cet abruti se fiche de nous. Mais il ne va pas rire longtemps...
                -> confronted_about_fugitive
        ** [Que faites-vous sur mon navire ?] PLAYER: Puis-je vous demander ce que vous faites ici, mes braves ?
            MARCELLO: Tous les bâteaux qui arrivent au port royal doivent être fouiller, c'est la loi.
            CAPUCINE: Et nul ne doit ignorer la loi... Caches-tu quelque chose ?
- (confronted_about_fugitive) CAPUCINE: Quelqu'un qui sortait de la cale nous a dit qu'un fugitif se cachait ici.
MARCELLO: Alors, qu'as-tu à répondre, marin d'eau douce ?
    * [Baratiner. {t(CHAR, -20)}]
        {sc(CHAR, -20): -> lie_about_fugitive_S | -> lie_about_fugitive_F}
        ** (lie_about_fugitive_S) PLAYER: Cet individu ment. D'ailleurs, il m'a détroussé de cinq pièces d'or !
            MARCELLO: Il a l'air de dire vrai. T'en penses quoi, Marcello ?
            CAPUCINE: J'en pense que je vais fouiller le navire dans le doute. Garde un œil sur lui. #anim:Capucine:seek_intruder_near_sireine
                -> battle
        ** (lie_about_fugitive_F) PLAYER: Le type que vous avez vu sortir d'ici est atteint d'une maladie rare.
            CAPUCINE: Une maladie rare ?
            PLAYER: Absolument. Une maladie qui lui fait voir des fugitifs qui ne sont pas là.
            CAPUCINE: ...
            MARCELLO: ...
            CAPUCINE: Il nous prend pour des idiots ou je rêve ?
            MARCELLO: Je vais t'apprendre à mentir à des gardes de la Couronne ! #anim:Marcello:attack #anim:Player:hurt
                -> battle
    * [Intimider. {t(CHAR, -30)}]
        {sc(CHAR, -30): -> intimidate_guards_S | -> intimidate_guards_F}
        ** (intimidate_guards_S) PLAYER: Le marin d'eau douce va te noyer de coups, si tu continues de l'ouvrir.
            MARCELLO: Pardon, m'sieur.
            CAPUCINE: Ne t'excuse pas, abruti. Apprend-lui plutôt ce qu'on obtient en menaçant un garde de la Couronne !
            MARCELLO: Compris, cheffe ! #anim:Marcello:attack #anim:Player:hurt
                -> battle
        ** (intimidate_guards_F) PLAYER: T'as vu mes biscoteaux ? Tu veux les voir de plus près, peut-être ?
            CAPUCINE: ...
            MARCELLO: ...
            CAPUCINE: Il se croit intimidant, cet idiot ?
            MARCELLO: Je vais t'apprendre à menacer des gardes de la Couronne ! #anim:Marcello:attack #anim:Player:hurt
                -> battle
    * {p_gold > 0} [Soudoyer. {t(CHAR, -10)}]
        ~ trial(t_2_bribe_guards)
        {sc(CHAR, -10): -> bribe_guards_S | -> bribe_guards_F}
    PLAYER: Est-ce que {p_gold} pièces d'or pourraient vous faire quitter mon navire sans faire de vagues ? Si vous me permettez l'expression...
        ** (bribe_guards_S) CAPUCINE: Laisse-moi te débarasser de ces pièces...
            ~ trial(t_2_try_and_succeed_bribing_guards)
            *** [Donner les pièces.] PLAYER: Voilà pour toi, mon amie. #playsound:gold_coins
                CAPUCINE: Nous allons maintenant t'apprendre les mérites de respecter la Loi, et les dangers de tenter de soudoyer un garde, quadruple forban.
                MARCELLO: C'est là que je le frappe, cheffe ?
                CAPUCINE: En effet, Marcello. C'est là que tu le frappe. 
                MARCELLO: Compris, cheffe ! #anim:Marcello:attack #anim:Player:hurt
                    -> battle
            *** [Assommer Marcello.] -> attack_marcello_S
        ** (bribe_guards_F) CAPUCINE: À qui penses-tu avoir affaire, quadruple forban ? Nous allons t'apprendre les mérites de respecter la Loi, et les dangers de tenter de soudoyer un garde !
            ~ trial(t_2_try_but_fail_bribing_guards)
            MARCELLO: C'est là que je le frappe, cheffe ?
            CAPUCINE: En effet, Marcello. C'est là que je le frappe.
            CAPUCINE: En effet, Marcello. C'est là que tu le frappe. 
            MARCELLO: Compris, cheffe ! #anim:Marcello:attack #anim:Player:hurt
                -> battle
// The guards are called by the Jester
= guards_are_called
#playsound:guards_arrive
MARCELLO: J'ai entendu quelqu'un hurler. #anim:Marcello:enter_scene
ÉPIEUR: Mes braves ! Cet homme cache une fugitive ! Il est armé, méfiez-vous !
MARCELLO: Il ne fera pas long feu !
MARCELLO: Prends ça ! #anim:Marcello:attack #anim:Player:hurt
- -> battle

// Attack Marcello with a bone
= attack_marcello_with_bone
{sc(DEXT, -10): -> attack_marcello_bone_S | -> attack_marcello_bone_F} #anim:Marcello:seek_intruder_near_player
    ** (attack_marcello_bone_S) MARCELLO: Le navire est vide, cheffe. #anim:Player:attack #anim:Marcello:hurt #audience:choc
        MARCELLO: Aie !
        CAPUCINE: Pas aussi vide que tu ne le pensais, apparemment... #audience:laugh
        MARCELLO: Cet abruti m'a frappé !
        CAPUCINE: Ça m'en a tout l'air, en effet.
    ** (attack_marcello_bone_F) MARCELLO: Le navire est vide, cheffe. #anim:Player:attack #anim:Marcello:dodge
        MARCELLO: Ai-je la berlue ou est-ce qu'un gougnafier vient d'essayer de m'assomer avec une entrecôte ? #audience:laugh
- MARCELLO: Prends ça, pour la peine ! #anim:Marcello:attack #anim:Player:hurt audience:applause
- -> battle

// Attack Marcello with a coconut
= attack_marcello_with_coconut
{sc(DEXT, 20): -> attack_marcello_coconut_S | -> attack_marcello_coconut_F}
    ** (attack_marcello_coconut_S) MARCELLO: Le navire est vide, cheffe. #anim:Player:throw_coconut #anim:Marcello:hurt
    ** (attack_marcello_coconut_F) MARCELLO: Le navire est vide, cheffe. #anim:Player:throw_coconut_fail
        MARCELLO: Aie !
        CAPUCINE: Pas aussi vide que tu ne le pensais, apparemment... #audience:laugh
        MARCELLO: Cet abruti m'a envoyé une noix de coco en plein dans les narines !
        CAPUCINE: Ça m'en a tout l'air, en effet.
- MARCELLO: Prends ça, pour la peine ! #anim:Marcello:attack #anim:Player:hurt audience:applause
- -> battle

// Battle (acting phase)
= battle
    * [Attaquer Marcello. {t(STRE, -10)}]
        {sc(STRE, -10): -> attack_marcello_S | -> attack_marcello_F}
        ** (attack_marcello_S) PLAYER: Prends ça ! #anim:Player:attack #anim:Marcello:hurt
            MARCELLO: Attaquer un garde de la Couronne ! Tu as perdu la tête !
        ** (attack_marcello_F) PLAYER: Prends ça ! #anim:Player:attack #anim:Marcello:dodge
            MARCELLO: Héhé... Trop lent, minable.
    * [Attaquer par derrière. {t(DEXT, -10)}]
        {sc(DEXT, -10): -> sneaky_attack_marcello_S | -> sneaky_attack_marcello_F}
        ** (sneaky_attack_marcello_S) MARCELLO: Je peux le rosser, cheffe ? #look:Marcello:Capucine
            PLAYER: Prends ça ! #anim:Player:sneaky_attack #anim:Marcello:hurt
            MARCELLO: M'attaquer alors que j'ai le dos tourné ? Tu es un lâche !
            *** [Et toi un crétin.] PLAYER: C'est toi qui est stupide, à tourner le dos à quelqu'un que tu viens de frapper.
            *** [C'est tout moi, en effet.] PLAYER: Je dirai plutôt que je sais saisir une opportunité quand je la vois...
                PLAYER: Surtout quand cette opportunité consiste à cogner un rustre comme toi.
        ** (sneaky_attack_marcello_F) MARCELLO: Je peux le rosser, cheffe ? #look:Marcello:Capucine
            PLAYER: Prends ça ! #anim:Player:sneaky_attack #anim:Marcello:dodge
            MARCELLO: Tu te crois discret, abruti ?
    * [Calmer le jeu. {t(CHAR, -10)}]
        {sc(CHAR, -10): -> calm_marcello_S | -> calm_marcello_F}
        ** (calm_marcello_S) PLAYER: Je vous propose d'en rester là, messires. Je ne suis point homme à rosser un garde de la Couronne.
            CAPUCINE: En voilà une parole raisonnable.
            MARCELLO: Dommage, je n'aurais pas détesté t'en claquer une dernière sur le museau...
            CAPUCINE: Allons, allons, Marcello... Le monsieur est raisonnable, alors soyons-le à notre tour.
        ** (calm_marcello_F) PLAYER: Je vous propose d'en rester là, messires. Je ne suis point homme à rosser un garde de la Couronne.
            CAPUCINE: En voilà une parole raisonnable. Mon ami, en revanche, apprécierait de t'en claquer une dernière sur le museau. Pas vrai, Marcello ?
            MARCELLO: Je confirme.
            MARCELLO: Tiens, la voilà ! #anim:Marcello:attack #anim:Player:hurt
- -> arrest_naida

// Battle against two guards
= battle_marcello_capucine_full_life
Combat contre les deux gardes.
- -> after_battle


// Battle against Marcello with Capucine hurt
= battle_marcello_with_capucine_hurt
Combat contre Marcello et Capucine, où Capucine est blessée.
- -> after_battle

// Battle against Capucine with Marcello hurt
= battle_capucine_with_marcello_hurt
Combat contre Capucine et Marcello, où Marcello est blessé.
- -> after_battle

// After the battle
= after_battle
{
    - player_won_battle:
        MARCELLO: Je crois qu'on lui a donné une bonne lesson, cheffe.
        CAPUCINE: Pas du tout, abruti. Cette truandaille nous a rossé. Les gardes de la Couronne vont encore passer pour des moins-que-rien.
        MARCELLO: Vraiment ? Vengons-nous en lui brisant les côtelettes, cheffe !
        CAPUCINE: C'est précisemment ce que nous venons d'échouer à faire, triple baveux. #anim:Marcello:ashamed
    - else:
        CAPUCINE: Voilà qui t'enseignera les mérites de ne pas manquer de respect aux gardes de la Couronne, vulgaire truandaille.
        MARCELLO: Bien dit, cheffe ! J'ajouterai une petite insulte afin de marquer le coup.
        CAPUCINE: Je viens précisément de le faire, triple baveux. #anim:Marcello:ashamed
}
- -> arrest_naida

// Naida is arrested
=arrest_naida
#playsound:sounds_inside_the_crate
CAPUCINE: As-tu entendu ? Quelque chose a bougé là-dedans !
MARCELLO : Sans doute un rat. Cette tête de pipe prend aussi peu soin de son navire qu'un crapaud de son étang.
CAPUCINE: Bloque-lui la route tandis que j'y jette un œil.
#anim:Marcello:block_the_way
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
CAPUCINE: Tiens-donc... Mais qui voilà ?
#anim:Sireine:out_of_hideout
PLAYER: Laissez-là, bande de gougnafiers !
CAPUCINE: C'est donc cela que tu cachais... Marcello, embarquons-la.
#anim:Player:attack
#anim:Marcello:dodge
#anim:Marcello:attack
#anim:Player:hurt
CAPUCINE: Allons-nous-en avec notre trouvaille. Si ce maraud se trouve encore sur son navire quand nous reviendrons avec des renforts...
CAPUCINE: Il finira sa triste vie au cachot, comme son ami.
#move(Capucine)
// Marcello remet un coup gratuit au Player
#anim:Marcello:attack
#anim:Player:hurt
#move(Marcello)
-> barge.scene_3

// End the scene
= end_scene
Fin de la scène.
    -> END