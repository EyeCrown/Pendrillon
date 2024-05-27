// CHURCH NIGHT SCENE


// Variables
VAR claim_to_be_free = false
VAR stained_glass_1_talk = false
VAR stained_glass_2_talk = false
VAR stained_glass_3_talk = false
VAR stained_glass_4_talk = false
VAR irene_torch_is_on = false
VAR irene_was_a_sireine = true

// Scene
=== church_night ===
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Agathe:???:PRÊTRESSE AGATHE:AGATHE
-> start

= start
#playsound:Play_MUS_Story_SC_Eglise_Intro
// Player arrive dans l'Église puis avance jusqu'à la statue.
// Après un moment.
- ???: Irène acceuille en sa demeure tous ceux qui ont besoin d'un toit...
// La voix vient d'hors-champ. Après un moment, une femme âgée arrive par la droite de la scène et entre dans le champ.
- PRÊTRESSE AGATHE: ... quel qu'ils soient. #character_presentation:Agathe
    * [Bénie soit-elle.] PLAYER: Bénie soit-elle.
        Agathe: Bénie entre toutes. Depuis le premier jour de sa vie, et jusqu'à ce que plus une seule d'entre nous ne la serve.
        ** [Nous ?] PLAYER: Les prêtresse d'Irène ? 
            -> priestess
    * [Quelle hospitalité !] PLAYER: Vous savez faire preuve d'hospitalité. Merci.
        AGATHE: Diriez-vous d'un servant qu'il est hospitalier en vous acceuillant dans la maison de son maître ?
        ** [N'êtes-vous pas chez vous ?] PLAYER: N'êtes-vous pas chez vous en ces lieux ?
            AGATHE: « Invitée en son foyer, vaisseau en ce monde. ».
            AGATHE: Nous sommes toutes de simples servantes, en ce lieu comme dans cette vie.
            *** [Nous ?] PLAYER: Les prêtresse d'Irène ?
                ---- (priestess) AGATHE: Nous autres prêtresses d'Irène vouons notre vie à la Pupille des eaux.
                **** [Une noble cause.] PLAYER: La plus noble des causes...
                **** [Vous n'êtes pas libres.] PLAYER: Ne préfèreriez-vous pas être libre, comme moi ?
                    ~ claim_to_be_free = true
                    AGATHE: Vous êtes libre, et je suis assujettie. Pourtant, votre liberté vous a conduit au même endroit que moi, sous ce même toit par cette même nuit.
                    AGATHE: Vous êtes ici parce que des gardes vous poursuivaient, je suis là parce que la Déesse m'a parlé. Qui de nous deux est réellement le plus libre ?
                    ***** [Touché.] PLAYER: J'imagine que vous avez raison...
                    ***** [Elle vous a parlé ?] PLAYER: Irène vous a parlé, à vous ?
                        AGATHE: Parfaitement. Elle me parle en cet instant.
                        ****** [Que vous dit-elle ?] PLAYER: Et que vous murmure t-elle ?
                            AGATHE: Rien que vous ne sauriez entendre, mon enfant.
                        ****** [Elle ne me parle pas.] PLAYER: Elle ne m'a jamais parlé, à moi...
                            AGATHE: Peut-être n'avez-vous pas sû écouter...
                    ***** [Je peux m'en aller...] PLAYER: Je suis libre. Libre de m'en aller...
            *** [Acquiescer.]
        ** [Certes, non.] PLAYER: Probablement pas...
            AGATHE: Il en va de même pour nous autres prêtresses...
            *** [Les prêtresse.] PLAYER: Les prêtresse d'Irène... -> priestess
        ** [Bien entendu.]
            AGATHE: Ne confondez pas le Foyer et la braise.
            *** [Le foyer et la braise ?] PLAYER: Le Foyer et la braise ?
                AGATHE: Représentez-vous un feu. À chaque instant, une braise cesse d'être, consummée jusqu'à son exctinction pour attiser les flammes.
                **** [Les prêtresses...] PLAYER: La braise, ce sont les prêtresses ? Et le Foyer... -> priestess
            *** [Vous avez raison.] PLAYER: Vos paroles sont sages.
            *** [Je ne confonds personne.] PLAYER: Je sais ce que je dis.
                AGATHE: J'en ai bien peur, en effet...
    * [Rester silencieux.]
// Bruits de gardes à l'extérieur
- AGATHE: ... #playsound:Play_SFX_Story_SC_Eglise_GuardsSearchingFar #playsound:Play_MUS_Story_SC_Eglise_GuardsSearching
- AGATHE: Rassurez-vous, vous êtes au seul endroit que les gardes de la Couronne ne viendront pas fouiller...
    * [(Mentir) Personne ne me recherche. {t(CHAR, -40)}]
        {sc(CHAR, -30): -> lie_about_being_chased_S | -> lie_about_being_chased_F}
        ** (lie_about_being_chased_S) PLAYER: Nul n'est à mes trousses... Les gardes sont peut-être simplement en train de courir un marathon ?
            AGATHE: Peut-être en ont-ils après quelqu'un d'autre que vous.
        ** (lie_about_being_chased_F) PLAYER: Je... Je ne vois pas de quoi vous parlez.
    * [Allez-vous me dénoncer ?] PLAYER: Ne répondez-vous pas à la Loi ? N'êtes-vous pas supposée prévenir les gardes ?
        AGATHE: Si je devais prévenir les gardes à chaque fois qu'un malendrin ayant volé une miche de pain entrait ici...
        AGATHE: ... plus personne ne me rendrait visite.
- AGATHE: Quoique vous ayez fait... En éprouvez-vous des remords ?
    * [Rien à me reprocher.] PLAYER: Je n'ai rien fait qui mérite que j'implore le pardon de qui que ce soit.
            ~ trial(t_2_show_no_regrets)
        AGATHE: En êtes-vous certain ? Il est davantage de mortels trop cléments avec eux-mêmes, que vierge de tout péché.
    * [Quelque fois...] PLAYER: Parfois... Lorsque la nuit vient et que la lune éclaire mes actes d'une lumière nouvelle...
        AGATHE: On dit parfois que la nuit porte conseil. Elle porte davantage encore le poids de nos fautes...
            ~ trial(t_3_show_some_regrets)
    * [Chaque jour.] PLAYER: Pas un seul jour ne passe sans que j'implore la Déesse pour son pardon.
            ~ trial(t_3_show_plenty_regrets)
        AGATHE: Peut-être ne vous êtes-vous pas contenté de voler une miche de pain...
- AGATHE: Quoi qu'il en soit, seule Irène est en droit de juger vos actes en ces lieux. #playsound:Play_MUS_Story_SC_Eglise_ImploreStatue #light:irene_statue
// PLAYER se tourne vers la statue
    * [(Avec intensité) Implorer la statue. {t(CHAR, -10)}]
        {sc(CHAR, -10): -> implore_irene_S | -> implore_irene_F}
        ** (implore_irene_S) PLAYER: Ô divine apparition. Sachez me venir en aide, victime que je suis...
            ~ trial(t_3_implore_irene)
            *** [...de la folie des Hommes.] PLAYER: ...des Hommes et de leur folie !
                AGATHE: Irène a eu a souffir elle aussi de leurs aliéantions.
            *** [...de ma propre convoitise.] PLAYER: ...de mes propres désirs !
                AGATHE: Au moins avez-vous le courage de reconnaître vos fautes.
            *** [...du plus funeste destin.] PLAYER: ...d'un destin des plus tragiques !
                AGATHE: Soyez reconnaissant des épreuves que la Déesse dresse sur votre chemin, car dans ces adversités se cachent des trésors de sagesse.
        ** (implore_irene_F) PLAYER: C'est de votre faute à vous, là-haut !
            ~ trial(t_3_blame_irene)
            AGATHE: {claim_to_be_free: N'était-ce pas vous qui, un instant plus tôt, prétendiez être libre, dans vos pensées comme dans vos actes ? | Blâmer notre Sauveuse pour vos malheurs est insensé et cruel.}
    * [Elle ressemble à la proue d'un navire.] PLAYER: Elle est pareille à la figure de proue d'un navire.
        AGATHE: Cette statue représente Irène guidant l'humanité vers la terre promise. Après des jours et des nuits passés à veiller sur le pont du Vaisseau...
        AGATHE: ... Irène fut découverte un matin, transfigurée en figure de proue du navire.
    * [Parlez-moi d'elle.] PLAYER: Parlez-moi d'Irène. Qu'aurait-elle fait à ma place ?
        AGATHE: En voilà un sage questionnement. Je ne puis vous apporter une réponse...
        AGATHE: Plutôt que de me demander à moi... Peut-être pourriez-vous vous adresser à elle directement ?
- AGATHE: Voyez-vous la lampe qui se tient dans sa main ? Faites-en briller la flamme, si vous souhaitez prier la Déesse.
    * [Allumer la lampe d'Irène.] #anim_event:light_on_irene_lamp #playsound:Play_SFX_Story_SC_Eglise_LightIreneLamp #playsound:Play_MUS_Story_SC_Eglise_LightOn
        AGATHE: Désormais que sa flamme berce ces lieux, n'hésitez plus : parlez-lui.
        ** [Se confesser.] PLAYER: J'ai ramené de mon voyage...
            ~ trial(t_3_light_on_irene_torch)
            ~ irene_torch_is_on = true
            *** [...un trésor interdit.] PLAYER: ...un trésor qui m'était interdit.
            *** [...un bagage de trop.] PLAYER: ...un bagage de plus. Un bagage de trop. Un poids sur ma conscience.
            *** [...un tas problèmes.] PLAYER: ...tout un lot d'embêtements.
            --- PLAYER: Irène, trouvez en votre bonne âme la force de me pardonner, et d'alléger par la même le poids de mes supplices !
        ** [Lui demander de l'aide.] PLAYER: Irène, je vous en congure, venez-moi en aide. Ô, allégez le poids de mes supplices !
            ~ trial(t_3_light_on_irene_torch)
            ~ irene_torch_is_on = true
        ** [Éteindre la lampe.] PLAYER: J'ai changé d'avis. La lampe restera éteinte, j'en ai peur.
            -> lamp_off
        -- AGATHE: Irène saura entendre vos prières, mon enfant. Sachez, à votre tour, entendre son récit.
    * [Laisser la lampe éteinte.] PLAYER: Elle restera éteinte, j'en ai peur.
        ~ trial(t_3_no_light_on_irene_torch)
        -- (lamp_off) AGATHE: ... Et votre cœur, quant à lui, ne connaîtra la lumière de la rédemption.
        ** [Mon cœur va très bien.] PLAYER: Mon cœur, comme vous dites, se porte bien ainsi.
        ** [Je ne suis pas croyant.] PLAYER: Veuillez me pardonner, mais... Je n'ai jamais cru à tout cela...
        -- AGATHE: J'aime à croire que votre dédain pour Irène est davantage signe d'ignorance que de méchanceté. Savez-vous seulement qui était Irène ?
- AGATHE: Cette église, voyez-vous, n'a pas pour seule vocation de prier la Déesse. Elle a aussi été dressée pour témoigner de son histoire. -> stained_glass


// Ask about the different stained glass illustrations
= stained_glass
#light:stained_glass #playsound:Play_MUS_Story_SC_Eglise_StainedGlassMentionned
* {stained_glass_1_talk == false} [Le bébé au milieu de la tempête.] PLAYER: Ce bébé, au milieu de la tempête... c'est Elle ?
    ~ stained_glass_1_talk = true
    -> baby_in_the_middle_of_a_tempest
* {stained_glass_2_talk == false} [Irène regardant l'océan.] PLAYER: Irène, près du phare, contemplant l'océan. Je me demande quelles pensées la traversaient.
    ~ stained_glass_2_talk = true
    -> irene_next_to_the_lighthouse
* {stained_glass_3_talk == false} [L'homme écartelé sur la roue.] L'homme attaché à la roue... c'est Lui n'est-ce pas ?
    ~ stained_glass_3_talk = true
    -> man_tied_to_a_wheel
* {stained_glass_4_talk == false} [Le vitrail brisé.] Le dernier vitrail est brisé...
    ~ stained_glass_4_talk = true
    -> ship_reaching_land
+ {stained_glass_1_talk or stained_glass_2_talk or stained_glass_3_talk or stained_glass_4_talk} [(Conclure) Passer la nuit.]
    {
        - stained_glass_1_talk == true && stained_glass_2_talk == true && stained_glass_3_talk == true && stained_glass_4_talk == true:
            #anim:Player:go_to_sleep_on_bench
            -> barge.scene_4
        - else:
            AGATHE: Êtes vous certain de ne pas vouloir ?
                * [J'ai changé d'avis.] PLAYER: Sans doute ne souffrirais-je pas d'entendre encore un peu parler votre sagesse...
                    -> stained_glass
                * [Je souhaite me reposer...] PLAYER: Veuillez me pardonnez, prêtresse. Le sommeil m'emporte déjà...
                    #anim:Player:go_to_sleep_on_bench
                    -> barge.scene_4
    }
    -> barge.scene_4

// Stained glass of Irene as a baby, in the middle of a tempest
= baby_in_the_middle_of_a_tempest
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassBaby
AGATHE: Une nuit où l'océan déchaînait ses passions... Un bateau de pêcheurs fut pris dans ses entrailles.
    * [Et ensuite ?] PLAYER: Et puis ? Que leur est-il arrivé ?
    * [S'en sont-ils sorti ?] PLAYER: Ont-il pû regager la terre ferme ?
- AGATHE: En plein affrontement avec les vagues furieuse... Ils entendirent des pleurs.
    * [Quels pleurs ?] PLAYER: Des pleurs ? Les pleurs de qui ?
        AGATHE: Quelle autre voix que la Sienne sauraient étouffer les vents les plus impétueux ?
            -> irene_voice
    * [J'en doute.] PLAYER: Par ce temps ? Croyez un marin lorsqu'il vous dit ceci : c'est parfaitement impossible...
            ~ trial(t_3_doubt_about_irene_cryings)
        AGATHE: Les vents les plus impétueux ne sauraient étouffer la voix de la Déesse.
        -- (irene_voice)
        ** [La Déesse ?] PLAYER: Irène ? C'était sa voix que les pêcheurs entendaient ?
            AGATHE: Vous le saurez bien assez tôt. -> should_i_proceed
        ** [(Avec dédain) Toujours elle...] PLAYER: Encore Elle ? La dent d'un indigeant tombe à l'autre bout du pays, et on se tourne vers Elle plutôt que vers la pomme dans laquelle il a croqué !
                ~ trial(t_3_insult_interest_about_irene)
            AGATHE: Vous auriez été de ceux qui la traitaient de folle quand vint le moment d'annoncer le Déluge...
            *** [Le Déluge ?] PLAYER: Le Déluge ? Je n'y voit aucun rapport.
                AGATHE: J'y viendrais. -> should_i_proceed
                ---- (should_i_proceed) Puis-je poursuivre ?
                **** [Je vous en prie.] PLAYER: Je vous en prie, faites donc.
                **** [Si vous y tenez...] PLAYER: Puisque vous y tenez tant...
                ---- -> continue_about_the_crying
            *** [Peut-être.] PLAYER: Peut-être. Quel sôt pourrait prétendre qu'il aurait, en un autre temps et une autre vie, fait le bon choix plutôt que le mauvais ?
                    ~ trial(t_3_not_believing_irene_predictions)
                AGATHE: En cela, vous avez raison. -> should_i_proceed
- (continue_about_the_crying) AGATHE: Tout occupés qu'ils étaient à affronter l'écume, ils hésitèrent à envoyer un canot chercher la source des pleurs...
    * [Cela les honorerait.] PLAYER: Des pleurs ? Au milieu de la houle ? Ma curiosité - sinon mon honneur - l'aurait emporté sur ma prudence.
        AGATHE: Bénit soyez-vous, mon enfant.
    * [Un signe de leur inconscience.] PLAYER: Par ce temps ? Mieux vaut une âme en pleurs que dix épouses en deuil. J'aurai écouté ma prudence et fait taire ma curiosité.
        AGATHE: Fort heuresement, ces marin furent mieux conseillés par leur conscience...
    * [Écouter en silence.]
- AGATHE: L'un d'eux, n'écoutant que son courage...
    * [... ou sa bêtise.] PLAYER: ...ou sa stupidité...
        ~ trial(t_3_insult_irene_savior)
    * [Rester silencieux.]
- AGATHE: L'un d'eux, dis-je, affreta un canot et suivit le son des pleurs au cœur de la tempête.
- AGATHE: Après une bataille livrée à la houle et gagnée de justesse, il découvrit sur un rocher, allongé, un bébé.
    * [La vision du vitrail !] PLAYER: C'est cette scène que le vitrail représente, n'est-ce pas ?
        AGATHE: Celle-là même.
    * [(Avec emphase) Quelle vision émouvante ! {t(CHAR, 10)}]
        {sc(CHAR, -30): -> moved_by_the_baby_S | -> moved_by_the_baby_F}
        ** (moved_by_the_baby_S) PLAYER: Imaginer cet enfant - la Déesse ! - pleurant au milieu de la tempête... Quelle vision poignante ! #anim:Player:emotionnal
            AGATHE: L'innocence du nouveau-né résistant à la cruauté de l'océan. Il n'est de plus belles images à garder en son cœur.
                ~ trial(t_3_moved_by_baby_irene)
        ** (moved_by_the_baby_F) PLAYER: Ô quelle magnifique, suprême - que dis-je - apothéotique vision !
            ~ trial(t_3_fake_about_feeling_for_the_baby)
            AGATHE: Vous en faites trop... Il est des occasions où le sage sait rester sobre mais sincère.
    * [Ça n'a ni queue ni tête...] PLAYER: Balivernes. Des mythes pour tirer la larme des culs bénis.
        AGATHE: Mon enfant, soyez sûr qu'Irène entend tout. Les chants les plus clairs comme les paroles les plus sinistres.
            ~ trial(t_3_religion_is_to_make_naive_cry)
- AGATHE: Le marin garda l'enfant contre sa poitrine, et manqua de couler en le ramenant au reste de l'équipage. Fort heureusement, tous deux survécurent...
- AGATHE: Mais, la tempête n'en avait pas fini avec eux. Perdus au milieu de la houle, l'océan à perte de vue... Les pêcheurs n'apercevaient plus un espoir de terre ferme.
    * [Ils vont s'en sortir.] PLAYER: Je garde espoir pour ces braves gens : ils s'en sortiront !
        AGATHE: Vous avez bon cœur, mon enfant. Les pêcheurs auraient sans doute fini au fond de la mer, sans l'aide du personnage que je m'apprête à introduire, un homme du nom de...
    * [Ils vont périr...] PLAYER: Jamais ils ne parviendront à regagner la côte. Jamais.
        AGATHE: C'était sans compter sur une belle âme du nom de...
    * [Continuer d'écouter.]
        AGATHE: Jamais les braves pêcheurs ainsi que l'enfant n'auraient eu la moindre chance, sans l'aide du personnage que je m'apprête à introduire, un homme du nom de...
- (ernest)
    * [...Eugène, sans nul doute.] PLAYER: Vous parlez sans l'ombre d'un doute du célèbre Eugène.
        ~ trial(t_3_does_not_know_ernest)
        AGATHE: Je n'ai aucune idée de qui donc est cet Eugène. L'homme que je mentionne n'est autre qu'Ernest.
    * [...Edmond, évidemment.] PLAYER: Vous parlez sans l'ombre d'un doute du fameux Edmond.
        ~ trial(t_3_does_not_know_ernest)
    * [...Ernest, cela va sans dire.] PLAYER: Vous faites sans doute allusion au pieu Ernest.
        ~ trial(t_3_know_ernest)
        AGATHE: La Déesse le bénisse, entre tous les hommes.
    * [(Avec certitude) Je sais qui. {t(LUCK, -20)}]
        {sc(CHAR, -30): -> player_knows_ernest_S | -> player_knows_ernest_F}
        ** (player_knows_ernest_S) PLAYER: Vous faites sans doute allusion au pieu Ernest.
            ~ trial(t_3_know_ernest)
            AGATHE: Absolument
        ** (player_knows_ernest_F) PLAYER: Vous parlez sans l'ombre d'un doute du célèbre Edgar.
            AGATHE: Edgar, vous dites ?
            *** [Edgar le Traquenard.] PLAYER: Edgar le Traquenard, bien sûr ! On raconte qu'il est capable de détrousser mille hommes en une seule nuit de travail.
            --- AGATHE: (Consternée) Je vous demande pardon ?
                PLAYER: Nul ne devrait tourner au croisement d'une ruelle sans retenir un frisson de terreur pour Edgar le Traquenard.
                AGATHE: ...
                PLAYER: (Les yeux fous) Il vous attend peut-être de l'autre coté, prêt à vous suriner.
                AGATHE: ...
                AGATHE: L'homme auquel je faisais en réalité allusion est Ernest, la Déesse le bénisse.
                ~ trial(t_3_rant_about_edgar_the_traquenard)
                ~ trial(t_3_does_not_know_ernest)
- AGATHE: Ernest, le gardien du phare.
    * [Qu'a t-il donc fait ?] PLAYER: Qu'a t-il fait pour les aider ?
        AGATHE: Cette nuit-là, Ernest dormait dans son phare, usé par une journée de labeur. Pourtant, au plus profond de son sommeil, il entendit une voix...
    * [Qui est il ?] PLAYER: Nul n'ignore le nom d'Ernest, mais qui est-il vraiment ?
        AGATHE: Un brave homme, vivant à l'écart des siens, dans son phare. Un homme taiseux, solitaire.
        ** [Un misanthrope ?] PLAYER: Fuyait-il les hommes car il les dédaignait ?
            AGATHE: Nullement. Il ne les fuyait pas, mais préférait la compagnie de l'océan. N'êtes-vous pas dans le même cas, mon enfant ?
            *** [Certainement.] PLAYER: Il est vrai. J'aime mieux prendre le large, que de rester au contact des hommes...
            *** [Au contraire.] PLAYER: C'eût été vrai d'un homme quittant seul la terre ferme. Mais mon équipage me préserve de la solitude !
                AGATHE: Edgar, lui, aimait être seul.
            --- AGATHE: Il pouvait passer des semaines sans entendre la voix d'un autre.
            --- AGATHE: Cette nuit-là, au plus profond de son sommeil, il entendit pourtant une voix.
    * [Écouter la suite.]
        AGATHE: Cette nuit-là, Ernest dormait dans son phare, usé par une journée de labeur. Pourtant, au plus profond de son sommeil, il entendit une voix...
- AGATHE: Les pleurs d'un enfant.
    * [Lui aussi entendit Irène ?] PLAYER: La voix d'Irène atteint son cœur comme il avait atteint celui des pêcheurs...
        AGATHE: Voilà qui est joliment dit.
    * [Rester silencieux.]
- AGATHE: Le son était presque imperceptible. Il aurait pu l'ignorer, mais ce n'est pas ce qu'il fit.
- AGATHE: À la place, il escalada l'échelle qui menait au phare, et éclaira la nuit de sa divine lueur.
    * [Une lumière bénie.] PLAYER: Une lumière que certains prient encore de nos jours.
    * {irene_torch_is_on} [Une lueur telle cette torche.] PLAYER: Une lueur semblable à celle que porte cette statue.
- AGATHE: Une lumière capable de percer la plus sombre des tempêtes.
    * [Les pêcheurs purent la voir ?] PLAYER: Ainsi, les pêcheurs purent regagner le rivage ?
    * [Louée soit la lumière !] PLAYER: Louée soit la lumière qui sauva les pêcheurs et l'enfant d'une mort certaine.
- AGATHE: En effet. Après des efforts considérables, les braves hommes purent regagner la terre ferme sains et saufs.
    * [(Avec émotion) Magnifique.] PLAYER: S'il est des histoires qui émeuvent un marin, c'est bien celle d'un équipage qui regagne les siens.
        ~ trial(t_3_believe_in_lighthouse_sacred_light)
    * [Difficile à croire.] PLAYER: Toute cette histoire me semble tenir davantage du mythe que de la réalité, chère prêtresse.
        ~ trial(t_3_does_not_believe_in_lighthouse_sacred_light)
        AGATHE: Cher enfant, vous sembles confondre le tonnage d'un mortel et l'étoffe d'une Sainte. Cessez ces doutes impies...
- AGATHE: Savez-vous seulement ce que les pêcheurs firent pour remercier Ernest ?
    * [Ils lui offrèrent l'enfant.] PLAYER: Ils lui confièrent la garde de l'enfant sacré.
        -- (know_fishermen_gift) ~ trial(t_3_know_fishermen_holy_gift)
        AGATHE: Précisément.
    * [Ils s'en prirent à lui.] PLAYER: Je connais les Hommes, et leur cœur impur. Ils s'en prirent à leur sauveur, n'est-ce pas ?
        ~ trial(t_3_does_not_know_fishermen_holy_gift)
        AGATHE: Ces pêcheurs risquèrent leur vie pour sauver une pauvre âme de la noyade. Ils ne firent rien de cela, et confièrent plutôt l'enfant sacré à leur sauveur.
    * [Seul un idiot l'ignorerais. {t(LUCK, 20)}]
        {sc(LUCK, 0): -> know_fishermen_gift_S | -> know_fishermen_gift_F}
        ** (know_fishermen_gift_S) PLAYER: Ils lui confièrent la garde de l'enfant sacré.
            -> know_fishermen_gift
        ** (know_fishermen_gift_F) PLAYER: Ils lui firent offrande de la pêche du jour ?
            AGATHE: Ils sûrent mieux mesurer l'ampleur de leur dette. Les pêcheurs lui confièrent la garde de l'enfant sacré, pour sûr.
- AGATHE: Et c'est ainsi que, sauvée des eaux, Irène fut élevée comme sa fille par le gardien du phare...
- AGATHE: ... Et, guidés par leur bonté ou bien par le Destin, en confiant à Ernest l'enfant sacré, les pêcheurs permirent sans le savoir à nos ancêtres de survivre au Déluge à venir.
// Return to the stained glass conversation
- -> stained_glass

// Stained glass of Irene next ton the lighthouse
= irene_next_to_the_lighthouse
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassLookingOcean
- AGATHE: Savez-vous ce que disait l'homme qui l'éleva comme sa fille ?
    * [Qui pourrait le prétendre ?] PLAYER: J'aimerais bien connaître celui qui le prétend.
        AGATHE: Les Écrits nous renseignent à ce sujet, mon enfant.
        ** [Que disent les écrits ?] PLAYER: Et que disent-ils à ce sujet, prêtresse ?
            --- (irene_obsessed_with_ocean) AGATHE: Irène passait ses journée à observer l'océan, comme fascinée par le mouvement des vagues. Encorcellée.
            *** [N'est-ce pas un blasphème ?] PLAYER: Parler ainsi d'Irène, notre Sauveuse... Ne pourrait-on y voir là un blasphème ?
                AGATHE: Prononcé par quelque autre, sans doute. Mais un père peut-il seulement blasphémer sa fille adorée ?
            *** [L'océan l'obsédait ?] PLAYER: L'océan exercait sur elle une fascination.
                AGATHE: C'est ainsi qu'il parlait d'elle, en effet.
        ** [Encore faut-il y croire...] PLAYER: Pour cela, il eût fallu qu'ils ne racontent autre chose que des mythes...
            ~trial(t_3_does_not_believe_the_sacred_writings)
            AGATHE: Mon enfant, il est des récits qui doivent être entendus avec le cœur, non avec la raison.
                -> irene_obsessed_with_ocean
    * [Je l'ignore.] PLAYER: Je dois avouer mon ignorance. Que disait-il donc ?
        -> irene_obsessed_with_ocean
- AGATHE: Il disait encore que cela l'effrayait.
    * [Pourquoi donc ?] PLAYER: Pour quelle raison ?
        -- (effraid_irene_swim_back) AGATHE: Il avait peur que sa fille adoptive, venue des Eaux y retourne.
    * [Un froussard.] PLAYER: Certains bravent des tempêtes... quand d'autres s'émeuvent de la houle.
        AGATHE: Vous faites fausse route. Ce n'est pas de l'océan dont le brave homme avait peur.
            -> effraid_irene_swim_back
    * [Écouter en silence.] -> effraid_irene_swim_back
- AGATHE: Comprenez-vous son trouble, mon enfant ?
    * [Un père a peur de perdre sa fille.] PLAYER: Un père effrayé à l'idée de voir sa fille disparaître. Rien de plus naturel.
        AGATHE: C'est juste. Il était un père aimant, et un homme admirable...
    * [Certains disent qu'elle y est née.] PLAYER: Certains prétendent que l'océan était son berceau...
        AGATHE: Ce à quoi vous faites référence, en réalité, est un abominable blasphème.
        AGATHE: Quiquonque prétend qu'Irène, la Pupille des eaux, est de cette engeance, périront noyés par le Juste.
        ** [Que l'océan les avale.] PLAYER: Que l'océan soit leur tombeau.
        ** [Ont-ils vraiement tort ?] PLAYER: Pourtant, cela expliquerait certains détails des Écrits, ne pensez-vous pas ?
            ~ trial(t_3_question_if_irene_is_a_sireine)
            ~ irene_was_a_sireine = true
            AGATHE: Mon enfant, vous jouez à un jeu dangereux. Il est des prêtresses qui étudient les Écrits leur vie durant pour tenter d'en percer ses mystères... Préferez laisser ces zones d'ombres intactes...
            AGATHE: ... au fait de les éclairer d'une lumière impie.
- AGATHE: Observez davantage le vitrail, mon enfant. Qu'y voyez-vous d'autre ?
    * [Elle semble... inquiète.] PLAYER: Elle a l'air préoccupée...
        AGATHE: Ne le seriez-vous pas, si vous saviez que le Déluge arrivait ? Ne le seriez-vous pas, si nul ne vous croyait ?
    * [Une tempête se prépare.] PLAYER: Je sais reconnaître une tempête qui arrive...
        AGATHE: Une tempête, vous dites ? Le Déluge, mon enfant.
    * [La lune est pleine.] PLAYER: La pleine lune...
        AGATHE: Une lune incandescente.
- AGATHE: Connaissez-vous la comptine, mon enfant ?
- AGATHE: « Quand le ciel fût sombre, et la lune fût levée... Irène, Fille des eaux...
    * [...ouït le Déluge gronder.] PLAYER: ...ouït le Déluge gronder. ». 
    * [...vit le monde sombrer.] PLAYER: ...vit le monde sombrer. ».
    * [...sentit la Vie cesser.] PLAYER: ...sentit la Vie cesser. ».
- AGATHE: « Prés du phare, cette nuit, l'océan lui parla... Puis elle n'êut qu'une seule cause...
    * [...sauver qui elle pourra.] PLAYER: ...sauver qui le pourra. ».
    * [...instruire qui la croira.] PLAYER: ...instruire qui la croira. ».
    * [...bénir qui l'aidera.] PLAYER: ...bénir qui l'aidera. ».
- AGATHE: « Elle monta à la ville, et cria sous chaque toit. Annnonçant le péril...
    * [...on la fit hors-la-loi.] PLAYER: ...on la fit hors-la-loi. ».
    * [...de folle on la traita.] PLAYER: ...de folle on la traita. ».
    * [...de vice on l'accusa.] PLAYER: ...de vice on l'accusa. ».
- AGATHE: « Seul son père la crut, acquis à sa pureté. Ce qu'il vit en elle fut...
    * [...une Sauveuse née.] PLAYER: ...une Sauveuse née. ».
    * [...une Sainteté.] PLAYER: ...une Sainteté.». 
    * [...une âme Sacrée.] PLAYER: ...une âme Sacrée.». 
- AGATHE: « Irène lui jura que pour dompter les eaux... Ils devaient s'atteler...
    * [...à construire un bateau.] PLAYER: ...à construire un bateau. ».
    * [...à bâtir un paquebot.] PLAYER: ...à bâtir un paquebot. ».
    * [...à créer un vaisseau.] PLAYER: ...à créer un vaisseau. ».
- AGATHE: « L'édifice prenant forme, ceux-là qui l'accusaient... Voyant qu'elle disait vrai...
    * [...proposèrent de l'aider.] PLAYER: ...proposèrent de l'aider. ».
    * [...firent preuve de piété.] PLAYER: ...firent preuve de piété. ».
    * [...se montrèrent dévoués.] PLAYER: ...se montrèrent dévoués. ».
- AGATHE: « Quand la Couronne eut vent qu'un Messie existait. Elle envoya des gardes...
    * [...le faire exécuter.] PLAYER: ...le faire exécuter. ».
    * [...afin de le châtier.] PLAYER: ...afin de le châtier. ».
    * [...en faire un prisonnier.] PLAYER: ...en faire un prisonnier. ».
- AGATHE: « Mais le père dévoué à sa fille bien-aimée, n'écoutant que son cœur...
    * [...pour le Messie, se fit passer.] PLAYER: ...pour le Messie, se fit passer. ».
    * [...se sacrifia pour la sauver.] PLAYER: ...se sacrifia pour la sauver. ».
    * [...à sa place, fut enfermé.] PLAYER: ...à sa place, fut enfermé. ».
- AGATHE: « Son supplice fut à la hauteur de son âme. Enchaîné à une roue...
    * [...on le laissa pour mort.] PLAYER: ...on le laissa pour mort. ».
    * [...on y scella son sort.] PLAYER: ...on y scella son sort. ».
    * [...on déforma son corps.] PLAYER: ...on déforma son corps. ».
- AGATHE: « Et par son sacrifice, il permit à sa fille, et à ceux qu'elle choisit...
    * [...d'entamer leur exil.] PLAYER: ...d'entamer leur exil. ».
    * [...d'éviter leur péril.] PLAYER: ...d'éviter leur péril. ».
    * [...de fuire ces terres hostiles.] PLAYER: ...de fuire ces terres hostiles. ».
- AGATHE: Ce que cet homme a fait pour sa fille... pour notre peuple tout entier...
    * [Louons son sacrifice.] PLAYER: Nous ne pouvons, nous autres mortels, que louer son sacrifice.
        ~ trial(t_3_show_judge_respect)
        AGATHE: La tâche que nos aïeux lui ont confié lorsqu'il fût libéré est à la hauteur de notre respect à son égard, ne pensez-vous pas ?
        ** [Sans nul doute.] PLAYER: Qui d'autre que cet être héroïque aurait pu la mener à bien ? J'y suis tout entier favorable.
            ~ trial(t_3_validate_judge_position)
                AGATHE: Chacun doit l'être.
        ** [C'était peut-être une erreur...] PLAYER: Loin de moi l'idée d'entamer sa légende... Mais je pense que cette tâche fût pour lui un fardeau.
            ~ trial(t_3_question_judge_position)
            -> close_judge_discussion
    * [Ce qu'il est devenu après...] PLAYER: Certains disent qu'il aurait dû être sanctifié, plutôt que...
        AGATHE: ... plutôt que ce qu'il est devenu ?
        ** [Peut-être...] PLAYER: J'ôse le dire, en effet. Son sacrifice fut salvateur pour nos ancêtres, mais au lieu de lui faire atteindre la béatitude, cela l'a... consumé... #audience:choc
            ~ trial(t_3_question_judge_position)
            -> close_judge_discussion
        ** [Oubliez.] PLAYER: Ce n'est pas ce que je voulais dire. Disons que la tâche qui lui incombe est épuisante.
            AGATHE: Qu'auraient dû faire nos aïeux, selon vous ?
                *** [Ils ont bien fait.] PLAYER: Leur décision était bonne. Qui d'autre que cet être héroïque aurait pu la mener à bien ?
                    ~ trial(t_3_validate_judge_position)
                    -> close_judge_discussion
                *** [Abréger ses souffrances.] PLAYER: Prêter au pauvre homme un tel labeur... Peut-être aurait-il mieux valu le laisser partir.
                        ~ trial(t_3_question_judge_position)
                    ---- (close_judge_discussion) AGATHE: Nul ne doit jamais se prononcer sur ce sujet. Restons-en là, je vous en conjure. 
// Return to the stained glass conversation
- -> stained_glass

// Stained glass of a man tied to a wheel, about to be sentenced to death
= man_tied_to_a_wheel
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassHim
AGATHE: C'est Lui, en effet. L'homme a souffert pour sauver sa fille, et notre peuple tout entier.
    * [Nous lui devons tant.] PLAYER: Notre dette à son égard est immense. Sans lui, le Déluge nous aurait emporté.
        AGATHE: Sans lui, nous aurions été avalés par les eaux, comme les impies.
        ** [La Déesse nous en préserve.] PLAYER: Bienheureux sommes-nous de vivre à la surface...
            AGATHE: ... plutôt qu'en-dessous, la Déesse nous en préserve.
            *** [Vous pensez que les sireines existent ?] PLAYER: Vous croyez que les sireines existent bel et bien, alors ?
                -> believing_in_the_sireine
            *** [Changer de sujet.] PLAYER: Revenons à notre discussion au sujet de l'homme enchaîné à sa roue.
        ** [Est-ce si mal ?] PLAYER: Cela aurait-il été une si mauvaise chose ?
            AGATHE: Que voulez-vous dire, mon enfant ?
            *** [Si l'on en croit les légendes...] PLAYER: Si l'on en croit ce que racontent nos mythes... Ne croyez-vous pas que les sireines existent ?
                ---- (believing_in_the_sireine) AGATHE: Si le le crois ? Je le sais. Ces êtres sont bel et bien une réalité, la Déesse nous en protège.
                **** [Pourquoi tant de haine ?] PLAYER: Pourquoi tant de méfiance ? Pourquoi ces êtres seraient-ils nécessairement mauvais ?
                    ~ trial(t_3_defend_sireine)
                    AGATHE: Le Déluge les a emporté, pas nous. Cette punition divine n'est-elle pas un signe suffisant ?
                    ***** [Peut-être.] PLAYER: Peut-être bien, en effet. Revenons à notre discussion au sujet de l'homme enchaîné à sa roue.
                            -> continue_about_the_judge
                    ***** [Et si c'était le hasard ?] PLAYER: Peut-être était-ce le hasard ? Et si le navire d'Irène n'était simplement pas assez grand pour acceuillir tout le monde ?
                        AGATHE: Pensez-vous que la Déesse aurait cru bon faire preuve d'une telle partialité ?
                            ****** [Une question de survie.] PLAYER: N'était-ce pas une question de vie ou de mort ? Aurait-il été préférable que nous pérîmes tous ?
                                AGATHE: Le cœur d'un mortel est trop impur pour abriter de telles nécessités. Seul un être touché par le divin est en mesure d'y répondre.
                                    ******* [Et si Irène était une mortelle ?] PLAYER: N'avez-vous jamais pensé qu'Irène aurait pu être une simple mortelle, comme vous et moi ?
                                        AGATHE: Blasphème, mon enfant. Irène, une simple humaine ?
                                        ******** [Elle serait davantage héroïque.] PLAYER: Elle n'en serait pas moins une figure héroïque. Peut-être même le serait-elle davantage encore !
                                            AGATHE: Insinuer qu'Irène n'avait rien de divin... Changeons de sujet, il vaut mieux.
                                        ******** [Mortelle ne veut pas dire humaine.] PLAYER: Humaine, non, mais mortelle ?
                                            AGATHE: Insinuez-vous{irene_was_a_sireine: encore } qu'Irène était une sireine ?
                                                ********* [Nullement.]
                                                ********* [Est-ce un crime ?] PLAYER: Et bien ! Est-ce un crime ?
                                                    AGATHE: Crime, blasphème, baliverne... Je ne porte point la cloche, mais suis douée d'un cœur... Changeons de sujet, voulez-vous ?
                                                        -> continue_about_the_judge
                            ****** [J'en aurais fait autant.] PLAYER: Sauver quelques uns, ou condamner tout le monde... Est-ce absurde de pense qu'elle ait pu faire ce choix en qualité de mortelle ?
                                AGATHE: Les paroles d'un fou, ou d'un sot... Changeons de sujet, je vous en prie.
                            ****** [Sans doute pas.] PLAYER: Vous avez raison. Sa Mejesté elle-même ne pourrait se saisir d'une décision si difficile...
                                AGATHE: Je suis du même avis. Mais changeons de sujet, voulez-vous ?
                **** [Nous en... protège ?] PLAYER: Pourquoi devrait-on être protégé des sireines ?
                    AGATHE: « Frappés par le Déluges, condamnés par les Eaux; demeurant sous les flots. ». Un sinistre sujet de discussion. Changeons-en, voulez-vous ?
                **** [Je ne les hais point.] PLAYER: La haine que certains portent à leur égard est une folie... Si leur existence est une réalité, que nous ont-il fait qui mérite tant d'animosité ?
                    AGATHE : La bienveillance est un poison latent lorsqu'elle est dirigée à l'endroit du malin. Changeons de sujet, voulez-vous ?
            *** [Oubliez ça.] PLAYER: Oubliez ça, tout cela n'a pas la moindre importance. Revenons à notre discussion au sujet de l'homme enchaîné à sa roue.
    * [Irène l'a t-elle sû ?] PLAYER: Sait-on si Irène a su quel sacrifice son père avait fait ?
        AGATHE: Elle l'apprit le soir même, mais il était trop tard. Les gardes s'en étaient allé depuis longtemps déjà.
            ** [Pauvre homme...] PLAYER: Quel funeste destin que celui que la Couronne réserva au pauvre homme.
                AGATHE: Les membres de la couronne connurent le même destin que les plus indigeants. Leur royal sang ne les empêcha pas de couler comme les autres...
                *** [On ne les regrette pas.] PLAYER: Ce n'est pas moi qui les regretterai.
                    AGATHE: Je n'en pense pas moins, mon enfant.
                *** [Nous sommes tous égaux.] PLAYER: J'y vois-là une morale : toutes et tous sommes égaux devant la mort. Peut-être devrions-nous l'être dans nos instants de vie...
                    AGATHE: Est-ce là les paroles d'un marin épris de liberté, ou celles d'un factieux ?
                    **** [J'aime seulement la liberté.] PLAYER: Je chéris ma liberté, rien de plus, rien de moins...
                    **** [Nous pourrions être égaux.] PLAYER: Nous pourrions être égaux, ne pensez-vous pas ? Ne sauriez-vous pas quoi faire de cette liberté ?
                        AGATHE: Une prêtresse se consacre toute entière à la Déesse. Vous souhaitez un royaume, quand je me contente d'un jardin...
                *** [Ne pas se prononcer.] PLAYER: Qui sait...
            ** [C'est Irène que je plains.] PLAYER: C'est la Déesse que je plaint le plus. Sait-on comment elle réagit à la nouvelle ?
                AGATHE: Elle ne dévia point de ses aspirations.
                *** [Quelle rigueur !] PLAYER: Sa rigueur est à louer. Sans elle, nous aurions peut-être été condamnés au péril...
                    AGATHE: Il est un débat chez les femmes de mon office : certaines prêtresses considèrent qu'Irène fut Déesse du jour de sa naissance jusqu'à sa transfiguration, et pour l'éternité...
                    AGATHE: ... quand d'autres croient qu'elle fut autre avant d'être Déesse. Pas mortelle, mais pas tout à fait Déesse.
                    **** [Elle était Déesse.] PLAYER: Je crois qu'elle était Déesse, dès le premier instant.
                    **** [Elle était autre.] PLAYER: J'ai l'intime conviction qu'elle fut autre, autrefois...
                    **** [Qu'en pensez-vous ?] PLAYER: Quel est votre avis ?
                        AGATHE: Imagine t-on un lion être un jour un agneaux ?
                        ***** [Jamais.] PLAYER: D'aucune manière.
                        ***** [Un lionceau, alors ?] PLAYER: Un lionceau, peut-être ?
                *** [Quelle froideur...] PLAYER: On pourrait y voir une certaine... froideur...
                        ~ trial(t_3_criticise_irene_coldness)
                    AGATHE: Le jugement d'un homme sur une émanation du Divin.
            ** [A t-elle tenté de le sauver ?] PLAYER: A t-elle essayé de lui venir en aide ?
                AGATHE: Jamais Irène ne dérogea de son devoir. On dit qu'elle versa une unique larme. Mais elle savait que même lors des pièces tragiques, chacun doit jouer son rôle...
    * [Devrions-nous le craindre ?] PLAYER: Serait-on avisé de le craindre ? Ou bien pensez-vous que la cloche ne sonne pas pour le juste ?
        AGATHE: Je crois à l'impartialité de la Loi, autant qu'à l'imperfection des Hommes...
        ** [Que voulez-vous dire] PLAYER: Qu'entendez-vous par là, prêtresse ?
            AGATHE: Que la justice ne devrait repprocher à un Homme l'impureté de son cœur, car là est ce qui le sépare de la Déesse elle-même.
            *** [De sages paroles.] PLAYER: Un discours auquel j'adhère sans détours.
                ~ trial(t_3_law_can_be_lax)
            *** [Du laxisme.] PLAYER: Laxisme ! La Loi n'est rien si elle ne peut repprocher à un Homme ses fautes, fussent-elles les conséquences de son humanité.
                ~ trial(t_3_law_should_not_be_lax)
- (continue_about_the_judge) AGATHE: Puis-je vous poser une question, mon enfant ?
    * [Je vous en prie.] PLAYER: Je vous écoute, prêtresse.
    * [Si vous insistez...] PLAYER: Si vous y tenez...
- AGATHE: Comment se fait-il, selon vous, qu'Il ne fut pas mort ? Lorsque nos ancêtres revinrent à Miraterre, ils le trouvèrent enchaîné à sa roue. Vivant. Intact. Durant un siècle entier, il avait souffert sans mourir. Pourquoi donc ?
    * [Le savez-vous ?] PLAYER: Le savez-vous vous-même, prêtresse ?
        AGATHE: Oh, je ne sais que peu de choses. Mais je m'interroge, car comprendre me rapproche d'Elle.
            ** [Poursuivez.] PLAYER: Je vous en prie, poursuivez...
                AGATHE: Je crois que quelque chose l'a empêché de mourir. Quelque chose de l'ordre du Divin, mon enfant...
                *** [Sans doute.] PLAYER: Nul doute qu'il en fut ainsi.
                *** [Divin ? Encore ?] PLAYER: Tout est divin, si l'on en croit vos paroles...
    * [Qui peut le dire ?] PLAYER: On ne peut que supputer...
        AGATHE: Assurément. Je crois que quelque chose l'a empêché de mourir. Quelque chose de l'ordre du Divin, mon enfant...
                *** [Sans doute.] PLAYER: Nul doute qu'il en fut ainsi. 
    * [Pourquoi cette question ?] PLAYER: Pourquoi cette question, prêtresse ?
        AGATHE: Car de son immortalité découle notre condition toute entière.
- AGATHE: Prenez le temps d'observer à nouveau le vitrail... Voyez ses détails...
    * [Regarder de plus près. {t(STRE, 0)}]
        {sc(STRE, 0): -> watch_judge_closer_S | -> watch_judge_closer_F}
        ** (watch_judge_closer_S) AGATHE: Voyez comme l'Homme a souffert. Quand on le retrouva, son corps avait été si déformé par les années, qu'Il avait acquis une taille inhumaine.
            *** [Il n'a rien d'humain.] PLAYER: Il n'y a rien, chez lui, qui soit encore humain.
                AGATHE: Vous fait-il peur, mon enfant ?
                    **** [Je n'ai peur de personne.] PLAYER: Je n'en ai pas peur. Pas le moindre du monde...
                    **** [C'est tout naturel.] PLAYER: Tout est fait, chez Lui, pour inspirer la peur. La peur et le respect.
                        -> you_are_right_to_be_afraid
                    **** [Je n'y pense jamais.] PLAYER: J'évite d'y penser.
                        -> you_are_right_to_be_afraid
            *** [Ne rien dire.]
        ** (watch_judge_closer_F) -> not_watch_judge
    * [Détourner le regard.] 
        -- (not_watch_judge) AGATHE: Vous détournez votre regard, mon enfant...
            ** [Suis-je un couard ?] PLAYER: Cela fait-il de moi un couard ?
                --- (you_are_right_to_be_afraid) AGATHE: J'ai vu tant de fois ce vitrail, j'y suis devenue presque insensible. Au fond, c'est sans doute vous qui avez raison...
            ** [Ne rien dire.] -> you_are_right_to_be_afraid
// Return to the stained glass conversation
- -> stained_glass

// Stained glass of a ship reaching land (broken)
= ship_reaching_land
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassBroken
- Le destin fait bien les choses, mon enfant. Il représente le retour du navire d'Irène à Miraterre, après un siècle de voyage... Or, c'est un temps dont nous ne savons rien.
    * [Que voulez-vous dire ?] PLAYER: Que voulez-vous dire par là ? Ne sait-on pas que le navire a vogué durant un siècle ? Ne sait-on pas qu'Irène fut transfigurée en figure de proue ?
        AGATHE: Nous savons cela. Mais nous ignorons tout le reste...
    * [Qu'ignore t-on ?] Que n' sait-on pas ?
        AGATHE: Tout, ou presque. Nous savons que le navire a vogué durant un siècle, nous savons qu'Irène fut transfigurée, devenue figure de proue...
- AGATHE: Les Écrits ne nous renseignent pas sur comment les gens vivaient sur le navire d'Irène... Ils ne nous renseignent que sur l'après ou l'avant...
    * [Est-ce si important ?] PLAYER: Est-il nécessaire d'en savoir davantage ? J'ai ouïe des histoires de marins à faire trembler...
        AGATHE: Sur cela, vous en savez davantage que moi.
    * [Vous avez raison.] PLAYER: C'est très juste. Peut-être était-il préférable que les descendants que nous sommes ne sachent rien de ces temps-là...
        AGATHE: Peut-être, en effet.
- AGATHE: Pouvez-vous imaginer ce que nos ancêtres ont ressenti en voyant la terre ferme pondre à l'horizon ?
    * [La délivrance !] PLAYER: Ce dut être une délivrance à la hauteur de leurs inconvénients ! Sublime conclusion à leur voyage centenaire.
    * [Je ne le peux que trop bien.] PLAYER: Je m'en fais une idée assez précise, prêtresse. La vision d'un phare, après des semaines en mer... une sensation incomparable.
- AGATHE: Quelle ironie, au fond...
    * [Quoi donc ?] PLAYER: Quoi donc, prêtresse ?
        -- (irony) AGATHE: Je parle du vitrail, bien sûr. Le seul qui illustre un moment de félicité... brisé...
            *** [Ironique, en effet.] PLAYER: Ironique, il est vrai...
            *** [C'est triste.] PLAYER: Je trouve cela triste, pour ma part...
            AGATHE: Peut-être, peut-être...
    * [Ironique, vous dites ?] PLAYER: Ironique, vous dites ? En quoi ?
        -> irony
        
// Return to the stained glass conversation
- -> stained_glass

// End of scene
= end_scene
-> END