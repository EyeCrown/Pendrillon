// CHURCH NIGHT SCENE


// Variables
VAR claim_to_be_free = false
VAR irene_torch_is_on = false

// Scene
=== church_night ===
-> start

= start
// Define the actors
#actor:Player:PLAYER
#actor:Agathe:UNE VOIX:PRÊTRESSE AGATHE:AGATHE
// Set the location
#set:church_night
// Set the actor's positions
#position:Player:7:3
#position:Agathe:7:5
// Audience reaction
//#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3
// - #wait:1
// - #map:down 
// - #wait:2
// - #map:departure
// - #wait:10
// - #map:arrival
#wait:10
#anim_event:light_on_irene_lamp
- PLAYER: J'ai ramené de <b>mon voyage</b>... #playsound:VOX_Player_jairamenevoyage
- PLAYER: ... un <b>trésor</b> qui m'était <shake a=0.5><b>interdit</b></shake>. #playsound:VOX_Player_untresorinterdit


//- #anim:Agathe:pray #anim:Player:pray
//#playsound:Play_MUS_Story_SC_Eglise_Intro
// Player arrive dans l'Église puis avance jusqu'à la statue.
// Après un moment.
//- PLAYER: J'ai ramené de mon voyage... #playsound:VOX_Player_jairamenevoyage
//- PLAYER: ... un trésor qui m'était interdit. #playsound:VOX_Player_untresorinterdit
- UNE VOIX: <b>Irène</b> accueille en sa demeure tous ceux qui ont besoin d'un toit... #wait:100
// La voix vient d'hors-champ. Après un moment, une femme âgée arrive par la droite de la scène et entre dans le champ.
- PRÊTRESSE AGATHE: ... quel qu'ils soient. #character_presentation:Agathe
    * [Bénie soit-elle.] PLAYER: Bénie soit-elle.
        Agathe: Bénie entre toutes. Depuis le premier jour de sa vie, et jusqu'à ce que plus une seule d'entre nous ne la serve.
        ** [ « Nous » ? Les prêtresses ?] PLAYER: Vous faites référence aux prêtresses d'<b>Irène</b> ? 
            -> priestess
    * [Quelle hospitalité !] PLAYER: Vous savez faire preuve d'hospitalité. Merci.
        AGATHE: Diriez-vous d'un servant qu'il est hospitalier en vous accueillant dans la maison de son maître ?
        ** [N'êtes-vous pas chez vous ?] PLAYER: N'êtes-vous pas chez vous en ces lieux ?
            AGATHE: « Invitée en son foyer, vaisseau en ce monde. ».
            AGATHE: Nous sommes toutes de simples servantes, en ce lieu comme dans cette vie.
            *** [Nous ?] PLAYER: Les prêtresses d'<b>Irène</b> ?
                ---- (priestess) AGATHE: Nous autres prêtresses d'<b>Irène</b> vouons notre vie à la Pupille des eaux.
                **** [Une noble cause.] PLAYER: La plus noble des causes...
                **** [Vous n'êtes pas libres.] PLAYER: Ne préfèreriez-vous pas être libre, comme moi ?
                    ~ claim_to_be_free = true
                    AGATHE: Vous êtes libre, et je suis assujettie. Pourtant, votre liberté vous a conduit au même endroit que moi, sous ce même toit par cette même nuit.
                    AGATHE: Vous êtes ici parce que des gardes vous poursuivaient, je suis là parce que la <b>Déesse</b> m'a parlé. Qui de nous deux est réellement le plus libre ?
                    ***** [Touché.] PLAYER: J'imagine que vous avez raison...
                    ***** [Elle vous a parlé ?] PLAYER: <b>Irène</b> vous a parlé, à vous ?
                        AGATHE: Parfaitement. Elle me parle en cet instant.
                        ****** [Que vous dit-elle ?] PLAYER: Et que vous murmure-t-elle ?
                            AGATHE: Rien que vous ne sauriez entendre, mon enfant.
                        ****** [Elle ne me parle pas.] PLAYER: Elle ne m'a jamais parlé, à moi...
                            AGATHE: Peut-être n'avez-vous pas su écouter...
                    ***** [Je peux m'en aller...] PLAYER: Je suis libre. Libre de m'en aller...
            *** [Acquiescer.]
        ** [Certes, non.] PLAYER: Probablement pas...
            AGATHE: Il en va de même pour nous autres prêtresses...
            *** [Les prêtresses d'Irène...] PLAYER: Les prêtresses d'<b>Irène</b>... 
                -> priestess
        ** [Bien entendu.]
            AGATHE: Ne confondez pas le Foyer et la braise.
            *** [Le foyer et la braise ?] PLAYER: Le Foyer et la braise ?
                AGATHE: Représentez-vous un feu. À chaque instant, une braise cesse d'être, consumée jusqu'à son extinction pour attiser les flammes.
                **** [Les prêtresses...] PLAYER: La braise, ce sont les prêtresses ? Et le Foyer... -> priestess
            *** [Vous avez raison.] PLAYER: Vos paroles sont sages.
            *** [Je ne confonds personne.] PLAYER: Je sais ce que je dis.
                AGATHE: J'en ai bien peur, en effet...
    * [Rester silencieux.]
// Bruits de gardes à l'extérieur
- AGATHE: Rassurez-vous, vous êtes au seul endroit que les gardes de la Couronne ne viendront pas fouiller... #playsound:Play_SFX_Story_SC_Eglise_GuardsSearchingFar #playsound:Play_MUS_Story_SC_Eglise_GuardsSearching
- AGATHE: Seule <b>Irène</b> est en droit de juger vos actes en ces lieux. #playsound:Play_MUS_Story_SC_Eglise_ImploreStatue #light:irene_statue
// PLAYER se tourne vers la statue
    * [(Avec intensité) Implorer la statue. {t(CHAR, -10)}]
        {sc(CHAR, -10): -> implore_irene_S | -> implore_irene_F}
        ** (implore_irene_S) PLAYER: Ô divine apparition. Sachez me venir en aide, victime que je suis...
            ~ trial()
            ~ t_3_implore_irene = true
            *** [...de la folie des Hommes.] PLAYER: ...des Hommes et de leur folie ! #audience:ovation
                AGATHE: <b>Irène</b> a eu à souffrir elle aussi de leurs aliénations.
            *** [...de ma propre convoitise.] PLAYER: ...de mes propres désirs ! #audience:debate
                AGATHE: Au moins avez-vous le courage de reconnaître vos fautes.
            *** [...du plus funeste destin.] PLAYER: ...d'un destin des plus tragiques ! #audience:choc
                AGATHE: Soyez reconnaissant des épreuves que la <b>Déesse</b> dresse sur votre chemin, car dans ces adversités se cachent des trésors de sagesse.
        ** (implore_irene_F) PLAYER: C'est de votre faute à vous, là-haut !
            ~ trial()
            ~ t_3_blame_irene = true
            AGATHE: {claim_to_be_free: N'était-ce pas vous qui, un instant plus tôt, prétendiez être libre, dans vos pensées comme dans vos actes ? | Blâmer notre Sauveuse pour vos malheurs est insensé et cruel.}
    * [Elle ressemble à la proue d'un navire.] PLAYER: Elle est pareille à la figure de proue d'un navire.
        AGATHE: Cette statue représente <b>Irène</b> guidant l'humanité vers la terre promise. Après des nuits entières à veiller sur le pont du bateau...
        AGATHE: ... <b>Irène</b> fut découverte un matin, transfigurée en figure de proue.
    * [Parlez-moi d'elle.] PLAYER: Parlez-moi d'<b>Irène</b>. Qu'aurait-elle fait à ma place ?
        AGATHE: Plutôt que de me demander à moi... Peut-être pourriez-vous vous adresser à Elle ?
- AGATHE: Voyez-vous la lampe qui se tient dans sa main ? Faites-en briller la flamme, si vous souhaitez prier la <b>Déesse</b>.
    * [Allumer la lampe d'Irène.] #playsound:Play_SFX_Story_SC_Eglise_LightIreneLamp #playsound:Play_MUS_Story_SC_Eglise_LightOn #anim_event:light_on_irene_lamp
        ~ trial()
        ~ t_3_light_on_irene_torch = true
        AGATHE: Désormais que sa flamme berce ces lieux, n'hésitez plus : parlez-lui.
        ** [Se confesser.] PLAYER: J'ai ramené de mon voyage...
            ~ irene_torch_is_on = true
            *** [...un trésor interdit.] PLAYER: ...un trésor qui m'était interdit.
            *** [...un bagage de trop.] PLAYER: ...un bagage de plus. Un bagage de trop. Un poids sur ma conscience.
            *** [...un tas de problèmes.] PLAYER: ...tout un lot d'embêtements.
            --- PLAYER: <b>Irène</b>, trouvez en votre bonne âme la force de me pardonner, et d'alléger par la même le poids de mes supplices !
        ** [Lui demander de l'aide.] PLAYER: <b>Irène</b>, je vous en conjure, venez-moi en aide. Ô, allégez le poids de mes supplices !
            ~ trial()
            ~ t_3_light_on_irene_torch = true
            ~ irene_torch_is_on = true
        ** [Éteindre la lampe.] PLAYER: J'ai changé d'avis. La lampe restera éteinte, j'en ai peur.
            ~ trial()
            ~ t_3_no_light_on_irene_torch = true
            -> lamp_off
        -- AGATHE: <b>Irène</b> saura entendre vos prières, mon enfant. Sachez, à votre tour, entendre son récit.
    * [Laisser la lampe éteinte.] PLAYER: Elle restera éteinte, j'en ai peur.
        ~ trial()
        ~ t_3_no_light_on_irene_torch = true
        -- (lamp_off) AGATHE: Savez-vous seulement ce que symbolise cette torche, mon, enfant ?
- AGATHE: Cette église, voyez-vous, n'a pas pour seule vocation de prier la <b>Déesse</b>. Elle fut aussi dressée pour témoigner de son histoire. -> stained_glass


// Ask about the different stained glass illustrations
= stained_glass
#light:stained_glass #playsound:Play_MUS_Story_SC_Eglise_StainedGlassMentionned
* {t_3_stained_glass_1_talk == false} [À propos du vitrail du bébé au milieu de la tempête.] PLAYER: Ce bébé, au milieu de la tempête... c'est Elle ?
    ~ t_3_stained_glass_1_talk = true
    -> baby_in_the_middle_of_a_tempest
* {t_3_stained_glass_2_talk == false} [À propos du  vitrail d'Irène regardant l'océan.] PLAYER: <b>Irène</b>, près du phare, contemplant l'océan. Je me demande quelles pensées la traversaient.
    ~ t_3_stained_glass_2_talk = true
    -> irene_next_to_the_lighthouse
* {t_3_stained_glass_3_talk == false} [À propos du  vitrail de l'homme écartelé sur sa roue.] PLAYER: L'homme attaché à la roue... c'est Lui n'est-ce pas ?
    ~ t_3_stained_glass_3_talk = true
    -> man_tied_to_a_wheel
+ {t_3_stained_glass_1_talk or t_3_stained_glass_2_talk or t_3_stained_glass_3_talk} [(Conclure) Passer la nuit.] PLAYER: J'aimerais me reposer, prêtresse.
    {
        - t_3_stained_glass_1_talk == true && t_3_stained_glass_2_talk == true && t_3_stained_glass_3_talk == true:
            #anim:Player:go_to_sleep_on_bench
            -> barge.scene_4
        - else:
            AGATHE: Êtes-vous certain de ne pas vouloir poursuivre notre discussion, mon enfant ?
                + [J'ai changé d'avis.] PLAYER: Sans doute ne souffrirais-je pas d'entendre encore un peu parler votre sagesse...
                    -> stained_glass
                + [Je souhaite me reposer...] PLAYER: Veuillez me pardonner, prêtresse. Le sommeil m'emporte déjà...
                    #anim:Player:go_to_sleep_on_bench #playsound:Play_MUS_Story_SC_Eglise_Goodnight
                    -> barge.scene_4
    }

// Stained glass of Irene as a baby, in the middle of a tempest
= baby_in_the_middle_of_a_tempest
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassBaby
- AGATHE: Une nuit où l'océan déchaînait ses passions... Un bateau de pêcheurs fut pris dans ses entrailles.
AGATHE: En plein affrontement avec les vagues furieuses... Ils entendirent des pleurs.
    * [Des pleurs ?] PLAYER: Des pleurs ? Les pleurs de qui ?
        AGATHE: Quelle autre voix que la Sienne saurait étouffer les vents les plus impétueux ?
    * [J'en doute.] PLAYER: En pleine tempête ? Croyez un marin lorsqu'il vous dit ceci : c'est impossible...
            ~ trial()
            ~ t_3_doubt_about_irene_cryings = true
        AGATHE: Les vents les plus impétueux ne sauraient étouffer la voix de la <b>Déesse</b>.
- AGATHE: Ils hésitèrent à envoyer un canot chercher la source des pleurs...
    * [Cela les honorerait.] PLAYER: Des pleurs, au milieu de la houle ? Ma curiosité - sinon mon honneur - l'aurait emporté sur ma prudence !
        ~ trial()
        ~ t_3_is_with_irene_saviors = true
        AGATHE: Bénit soyez-vous, mon enfant.
    * [Un signe de leur inconscience.] PLAYER: Par ce temps ? Mieux vaut une âme en pleurs que dix épouses en deuil. J'aurai écouté ma prudence et fait taire ma curiosité.
        ~ trial()
        ~ t_3_is_against_irene_saviors = true
        AGATHE: Fort heureusement, ces marins furent mieux conseillés par leur conscience...
    * [Écouter en silence.]
- (a_navigator_save_baby) AGATHE: L'un d'eux, n'écoutant que son courage...
- AGATHE: Affréta un canot et suivit le son des pleurs au cœur de la tempête.
- AGATHE: Au milieu des vagues, il découvrit sur un rocher, allongé, un bébé.
    * [La vision du vitrail !] PLAYER: C'est cette scène que le vitrail représente, n'est-ce pas ?
        AGATHE: Celle-là même.
    * [(Avec emphase) Quelle vision émouvante ! {t(CHAR, 10)}]
        {sc(CHAR, -30): -> moved_by_the_baby_S | -> moved_by_the_baby_F}
        ** (moved_by_the_baby_S) PLAYER: Imaginer cet enfant - la <b>Déesse</b> ! - pleurant au milieu de la tempête... Quelle vision poignante ! #anim:Player:emotionnal
                ~ trial()
                ~ t_3_moved_by_baby_irene = true
        ** (moved_by_the_baby_F) PLAYER: Ô quelle magnifique - que dis-je - suprême vision !
            ~ trial()
            ~ t_3_fake_about_feeling_for_the_baby = true
            AGATHE: Vous en faites trop, mon enfant...
    * [Ça n'a ni queue ni tête...] PLAYER: Balivernes. Des mythes pour tirer une larme aux culs bénis. #audience:choc
        AGATHE: Mon enfant, soyez sûr qu'<b>Irène</b> entend tout. Les chants les plus clairs comme les paroles les plus sinistres.
            ~ trial()
            ~ t_3_religion_is_to_make_naive_cry = true
- AGATHE: Le marin garda l'enfant contre sa poitrine, et le ramena au reste de l'équipage.
- AGATHE: Mais, la tempête n'en avait pas fini avec eux. Perdus au milieu de la houle... Les pêcheurs n'apercevaient plus un espoir de terre ferme.
AGATHE: Jamais ils n'auraient eu la moindre chance, sans l'aide d'un homme du nom de...
- (ernest)
    * [... Eugène, sans nul doute.] PLAYER: Vous parlez sans l'ombre d'un doute du célèbre Eugène.
        AGATHE: Je n'ai aucune idée de qui donc est cet Eugène. L'homme que je mentionne n'est autre qu'Ernest.
    * [... Ernest, cela va sans dire.] PLAYER: Vous faites sans doute allusion au pieu Ernest.
        AGATHE: La <b>Déesse</b> le bénisse, entre tous les hommes.
    * [(Avec certitude) Je connais son nom. {t(STRE, -20)}]
        {sc(STRE, -20): -> player_knows_ernest_S | -> player_knows_ernest_F}
        ** (player_knows_ernest_S) PLAYER: Vous faites sans doute allusion au pieu Ernest.
            AGATHE: Absolument
        ** (player_knows_ernest_F) PLAYER: Vous parlez sans l'ombre d'un doute du célèbre Edgar.
            AGATHE: Edgar, vous dites ?
            *** [Edgar le Traquenard.] PLAYER: Edgar le Traquenard, bien sûr ! On raconte qu'il est capable de détrousser mille hommes par nuit !
                ~ trial()
                ~ t_3_rant_about_edgar_the_traquenard = true
            --- AGATHE: Je vous demande pardon, mon enfant ?
                PLAYER: Nul ne devrait tourner au croisement d'une ruelle sans retenir un frisson de terreur pour <shake>Edgar le Traquenard</shake>.
                AGATHE: ...
                PLAYER: (Les yeux fous) Il nous attend peut-être de l'autre côté d'une ruelle, prêt à nous suriner !
                AGATHE: ... Euh...
                AGATHE: L'homme auquel je faisais en réalité allusion est Ernest, la <b>Déesse</b> le bénisse.
- AGATHE: Ernest, le gardien du phare.
    * [Qu'a-t-il donc fait ?] PLAYER: Qu'a-t-il fait pour les aider ?
        AGATHE: Cette nuit-là, Ernest dormait dans son phare, usé par une journée de labeur.
        AGATHE: Cependant, au plus profond de son sommeil, il entendit une voix...
    * [Qui est-il ?] PLAYER: Nul n'ignore le nom d'Ernest, mais qui est-il vraiment ?
        AGATHE: Un brave homme, vivant à l'écart des siens, dans son phare.
        -- AGATHE: Cette nuit-là, au plus profond de son sommeil, il entendit une voix.
    * [Écouter la suite.]
        AGATHE: Cette nuit-là, Ernest dormait dans son phare, usé par une journée de labeur. 
        AGATHE: Cependant, au plus profond de son sommeil, il entendit une voix...
- AGATHE: Les pleurs d'un enfant.
- AGATHE: Il gravit l'échelle qui menait au phare, et éclaira la nuit de sa divine lueur.
    * [Les pêcheurs purent la voir ?] PLAYER: Ainsi, les pêcheurs purent regagner le rivage ?
    * [(Avec emphase) Louée soit la lumière !] PLAYER: Louée soit la lumière qui sauva les pêcheurs et l'enfant d'une mort certaine !
- AGATHE: Après des efforts considérables, les braves hommes purent regagner la terre ferme sains et saufs.
    * [(Avec émotion) Magnifique.] PLAYER: S'il est des histoires qui émeuvent un marin, c'est bien celle d'un équipage qui regagne les siens.
        ~ trial()
        ~ t_3_believe_in_lighthouse_sacred_light = true
    * [Difficile à croire.] PLAYER: Toute cette histoire me semble tenir davantage du mythe que de la réalité, chère prêtresse.
        ~ trial()
        ~ t_3_does_not_believe_in_lighthouse_sacred_light = true
        AGATHE: Cher enfant, vous semblez confondre le tonnage d'un mortel et l'étoffe d'une Sainte.
- AGATHE: Savez-vous seulement ce que les pêcheurs firent pour remercier Ernest ?
    * [Ils s'en prirent à lui.] PLAYER: Je connais les Hommes, et leur cœur impur. Ils s'en prirent à leur sauveur, n'est-ce pas ?
        AGATHE: Ces pêcheurs risquèrent leur vie pour sauver une pauvre âme de la noyade. Ils ne firent rien de cela, et confièrent plutôt l'enfant sacré à leur sauveur.
    * [Ils lui offrirent l'enfant.] PLAYER: Ils lui confièrent la garde de l'enfant sacré.
        -- (know_fishermen_gift)
        AGATHE: Précisément.
    * [Seul un idiot l'ignorerait. {t(STRE, 20)}]
        {sc(STRE, 0): -> know_fishermen_gift_S | -> know_fishermen_gift_F}
        ** (know_fishermen_gift_S) PLAYER: Ils lui confièrent la garde de l'enfant sacré.
            -> know_fishermen_gift
        ** (know_fishermen_gift_F) PLAYER: Ils lui firent offrande de la pêche du jour ?
            AGATHE: Ils surent mieux mesurer l'ampleur de leur dette. Les pêcheurs lui confièrent la garde de l'enfant sacré, pour sûr.
- AGATHE: Et c'est ainsi que, sauvée des eaux, <b>Irène</b> fut élevée comme sa fille par le gardien du phare...
- AGATHE: Cet acte scella le destin de nos ancêtres, qui purent survivre au <b>Déluge</b> à venir.
- -> stained_glass

// Stained glass of Irene next ton the lighthouse
= irene_next_to_the_lighthouse
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassLookingOcean
- AGATHE: Savez-vous ce que disait l'homme qui éleva la <b>Déesse</b> comme sa fille ?
    * [Qui pourrait le prétendre ?] PLAYER: J'aimerais bien connaître celui qui le prétend.
        AGATHE: Les Écrits nous renseignent à ce sujet, mon enfant.
        ** [Que disent les Écrits ?] PLAYER: Et que disent-ils à ce sujet, prêtresse ?
            --- (irene_obsessed_with_ocean) AGATHE: Que la <b>Déesse Irène</b> passait ses journées à observer l'océan, comme fascinée par le mouvement des vagues. Ensorcelée.
        ** [Encore faut-il y croire...] PLAYER: Ces Écrits soit-disant sacrés sont des mythes...
            ~trial()
            ~ t_3_does_not_believe_the_sacred_writings = true
            AGATHE: Mon enfant, il est des récits qui doivent être entendus avec le cœur, non avec la raison.
            AGATHE: La <b>Déesse Irène</b> passait ses journées à observer l'océan, comme fascinée par le mouvement des vagues. Ensorcelée.
    * [Je l'ignore.] PLAYER: Je dois avouer mon ignorance. Que disait-il ?
        -> irene_obsessed_with_ocean
- AGATHE: Cela effrayait son père.
    * [Pourquoi donc ?] PLAYER: Pour quelle raison ?
        -- (afraid_irene_swim_back) AGATHE: Il avait peur que sa fille adoptive, venue des Eaux y retourne.
    * [Un froussard.] PLAYER: Certains bravent des tempêtes... quand d'autres s'émeuvent de la houle.
        AGATHE: Vous faites fausse route. Ce n'est pas de l'océan dont le brave homme avait peur.
            -> afraid_irene_swim_back
    * [Écouter en silence.] -> afraid_irene_swim_back
- AGATHE: Comprenez-vous son trouble, mon enfant ?
    * [Un père a peur de perdre sa fille.] PLAYER: Un père effrayé à l'idée de voir sa fille disparaître. Rien de plus naturel.
    * [Certains disent qu'Irène y est née.] PLAYER: Certains prétendent que l'océan était son berceau...
        AGATHE: Ce à quoi vous faites référence, en réalité, est un abominable blasphème.
        AGATHE: Quiconque prétend qu'<b>Irène</b> est de cette engeance, périront noyés par le <b>Juste</b>.
        ** [Que l'océan les avale.] PLAYER: Que l'océan soit leur tombeau ! #audience:ovation
        ** [Ont-ils vraiment tort ?] PLAYER: Pourtant, cela expliquerait certains détails des Écrits, ne pensez-vous pas ? #audience:debate
            ~ trial()
            ~ t_3_question_if_irene_is_a_sireine = true
            AGATHE: Il est des prêtresses qui étudient les Écrits leur vie durant pour tenter d'en percer ses mystères... 
            AGATHE: Préférez laisser ces zones d'ombres intactes...
            AGATHE: ... à l'idée de les éclairer d'une lumière impie.
- AGATHE: Observez davantage le vitrail, mon enfant. Qu'y voyez-vous d'autre ?
    * [Irène semble... inquiète.] PLAYER: Elle a l'air préoccupée...
        AGATHE: Ne le seriez-vous pas, si vous saviez que le <b>Déluge</b> arrivait ? Ne le seriez-vous pas, si nul ne vous croyait ?
    * [Une tempête se prépare.] PLAYER: Je sais reconnaître une tempête qui arrive...
        AGATHE: Une tempête, vous dites ? Le <b>Déluge</b>, mon enfant.
    * [La lune est pleine.] PLAYER: La pleine lune...
        AGATHE: Une lune incandescente, annonçant le <b>Déluge</b>.
- AGATHE: Connaissez-vous la comptine, mon enfant ?
- AGATHE: « Quand le ciel fût sombre, et la lune fût levée... <b>Irène</b>, Fille des eaux...
    * [... ouït le Déluge gronder.] PLAYER: ... ouït le <b>Déluge</b> gronder. ». 
    * [... vit le monde sombrer.] PLAYER: ... vit le monde sombrer. ».
    * [... sentit la Vie cesser.] PLAYER: ... sentit la Vie cesser. ».
- AGATHE: « Près du phare, cette nuit, l'océan lui parla... Puis elle n'eut qu'une seule cause...
    * [... sauver qui elle pourra.] PLAYER: ... sauver qui le pourra. ».
    * [... instruire qui la croira.] PLAYER: ... instruire qui la croira. ».
    * [... bénir qui l'aidera.] PLAYER: ... bénir qui l'aidera. ».
- AGATHE: « Elle monta à la ville, et cria sous chaque toit. Annonçant le péril...
    * [... on la fit hors-la-loi.] PLAYER: ... on la fit hors-la-loi. ».
    * [... de folle on la traita.] PLAYER: ... de folle on la traita. ».
    * [... de vice on l'accusa.] PLAYER: ... de vice on l'accusa. ».
- AGATHE: « Seul son père la crut, acquis à sa pureté. Ce qu'il vit en elle fut...
    * [... une Sauveuse née.] PLAYER: ... une Sauveuse née. ».
    * [... une Sainteté.] PLAYER: ... une Sainteté.». 
    * [... une âme Sacrée.] PLAYER: ... une âme Sacrée.». 
- AGATHE: « <b>Irène</b> lui jura que pour dompter les eaux... Ils devaient s'atteler...
    * [... à construire un bateau.] PLAYER: ... à construire un bateau. ».
    * [... à bâtir un paquebot.] PLAYER: ... à bâtir un paquebot. ».
    * [... à créer un vaisseau.] PLAYER: ... à créer un vaisseau. ».
- AGATHE: « L'édifice prenant forme, ceux-là qui l'accusaient... Voyant qu'elle disait vrai...
    * [... proposèrent de l'aider.] PLAYER: ... proposèrent de l'aider. ».
    * [... firent preuve de piété.] PLAYER: ... firent preuve de piété. ».
    * [... se montrèrent dévoués.] PLAYER: ... se montrèrent dévoués. ».
- AGATHE: « Quand la Couronne eut vent qu'un Messie existait. Elle envoya des gardes...
    * [... le faire exécuter.] PLAYER: ... le faire exécuter. ».
    * [... afin de le châtier.] PLAYER: ... afin de le châtier. ».
    * [... en faire un prisonnier.] PLAYER: ... en faire un prisonnier. ».
- AGATHE: « Mais le père dévoué à sa fille bien-aimée, n'écoutant que son cœur...
    * [... pour le Messie, se fit passer.] PLAYER: ... pour le Messie, se fit passer. ».
    * [... se sacrifia pour la sauver.] PLAYER: ... se sacrifia pour la sauver. ».
    * [... à sa place, fut enfermé.] PLAYER: ... à sa place, fut enfermé. ».
- AGATHE: « Son supplice, désormais, nulle âme ne l'ignore. Enchaîné à une roue...
    * [... on le laissa pour mort.] PLAYER: ... on le laissa pour mort. ».
    * [... on y scella son sort.] PLAYER: ... on y scella son sort. ».
    * [... on déforma son corps.] PLAYER: ... on déforma son corps. ».
- AGATHE: « Et par son sacrifice, il permit à sa fille, et à ceux qu'elle choisit...
    * [... d'entamer leur exil.] PLAYER: ... d'entamer leur exil. ».
    * [... d'éviter leur péril.] PLAYER: ... d'éviter leur péril. ».
    * [... de fuire ces terres hostiles.] PLAYER: ... de fuire ces terres hostiles. ».
- AGATHE: Ce que cet homme a fait pour sa fille... pour notre peuple tout entier...
    * [Louons son sacrifice.] PLAYER: Nous ne pouvons, nous autres mortels, que louer son sacrifice.
        ~ trial()
        ~ t_3_show_judge_respect = true
        AGATHE: La tâche que nos aïeux lui ont confiée lorsqu'il fût libéré est à la hauteur de notre respect à son égard... #playsound:Play_SFX_Story_JudgeBellFar #wait:0.5 #audience:choc
    * [Ce qu'il est devenu après...] PLAYER: Certains disent qu'il aurait dû être sanctifié, plutôt que...
        AGATHE: ... plutôt que voué à une tâche si grave ? #playsound:Play_SFX_Story_JudgeBellFar #wait:0.5 #audience:choc
        ** [Peut-être...] PLAYER: J'ose le dire, en effet. Son sacrifice fut salvateur pour nos ancêtres, mais au lieu de lui faire atteindre la béatitude, cela l'a... consumé... 
            ~ trial()
            ~ t_3_question_judge_position = true
        ** [Oubliez.] PLAYER: Ce n'est pas ce que je voulais dire. Disons que la tâche qui lui incombe est... épuisante. #playsound:Play_SFX_Story_JudgeBellFar #wait:0.5 #audience:choc
            ~ trial()
            ~ t_3_show_judge_respect = true
// Return to the stained glass conversation
- -> stained_glass

// Stained glass of a man tied to a wheel, about to be sentenced to death
= man_tied_to_a_wheel
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassHim
AGATHE: C'est <b>Lui</b>, en effet. L'homme a souffert pour sauver sa fille, et notre peuple tout entier.
AGATHE: Quand les gardes de la Couronne vinrent arrêter le Messie, c'est lui qu'ils emmenèrent.
    * [Nous lui devons tant.] PLAYER: Notre dette à son égard est immense.
        ~ trial()
        ~ t_3_show_judge_respect = true
    * [Irène l'a-t-elle su ?] PLAYER: Sait-on si <b>Irène</b> a su quel sacrifice son père avait fait ?
        AGATHE: Elle l'apprit le soir même, mais il était trop tard. Les gardes s'en étaient allé depuis longtemps déjà.
    * [Devrions-nous le craindre ?] PLAYER: Serait-on avisé de le craindre, désormais ? Ou bien pensez-vous que la cloche ne sonne pas pour le juste ? #audience:debate
        AGATHE: À tort ou à raison, tous les habitants de Miraterre le craignent...
- AGATHE: Lorsque nos ancêtres revinrent à Miraterre, ils le trouvèrent enchaîné à sa roue. Vivant. Intact.
AGATHE: Durant un siècle entier, il avait souffert sans jamais mourir.
AGATHE: Pourquoi donc, d'après vous ?
    * [Le savez-vous vous-même ?] PLAYER: Le savez-vous vous-même, prêtresse ?
        AGATHE: Je crois que quelque chose l'a empêché de mourir. Quelque chose de l'ordre du Divin, mon enfant...
    * [Qui peut le dire ?] PLAYER: On ne peut que supputer...
        AGATHE: Assurément. Je crois que quelque chose l'a empêché de mourir. Quelque chose de l'ordre du Divin, mon enfant...
    * [Pourquoi cette question ?] PLAYER: Pourquoi cette question, prêtresse ?
        AGATHE: Je crois que quelque chose l'a empêché de mourir. Quelque chose de l'ordre du Divin, mon enfant...
- AGATHE: Prenez le temps d'observer à nouveau le vitrail... Voyez ses détails...
    * [Regarder de plus près. {t(STRE, 0)}]
        {sc(STRE, 0): -> watch_judge_closer_S | -> watch_judge_closer_F}
        ** (watch_judge_closer_S) AGATHE: Voyez comme l'Homme a souffert. Quand on le retrouva, son corps avait été si déformé par les années, qu'Il avait acquis une taille inhumaine.
            *** [Il n'a rien d'humain.] PLAYER: Il n'y a rien, chez lui, qui soit encore humain.
                ~ trial()
                ~ t_3_say_judge_is_not_human = true
                AGATHE: Vous fait-il peur, mon enfant ?
                    **** [Je n'ai peur de personne.] PLAYER: Je n'en ai pas peur. Pas le moindre du monde...
                    **** [C'est tout naturel.] PLAYER: Tout est fait, chez <b>Lui</b>, pour inspirer la peur. La peur et le respect.
                        -> you_are_right_to_be_afraid
                    **** [Je n'y pense jamais.] PLAYER: J'évite d'y penser.
                        -> you_are_right_to_be_afraid
            *** [Se taire.]
        ** (watch_judge_closer_F) -> not_watch_judge
    * [Détourner le regard.]
        -- (not_watch_judge) AGATHE: Vous détournez votre regard, mon enfant...
            ~ trial()
            ~ t_3_look_away_judge_stained_glass = true
            ** [Suis-je un couard ?] PLAYER: Cela fait-il de moi un couard ?
                --- (you_are_right_to_be_afraid) AGATHE: J'ai vu tant de fois ce vitrail. Je crois y être devenue presque insensible. Au fond, c'est sans doute vous qui avez raison...
            ** [Ne rien dire.] -> you_are_right_to_be_afraid
// Return to the stained glass conversation
- AGATHE: <b>Irène</b> nous observe avec bonté... Son père, <b>Lui</b>, nous juge pour nos péchés. #playsound:Play_SFX_Story_JudgeBellFar
- -> stained_glass
        
// Return to the stained glass conversation
- -> stained_glass