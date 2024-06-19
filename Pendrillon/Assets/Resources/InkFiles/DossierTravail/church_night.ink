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
#actor:Agathe:UNE VOIX:PRÊTRESSE AGATHE:AGATHE:PRÊTRESSE
// Set the location
#set:church_night
// Set the actor's positions
#position:Player:8:25
#position:Agathe:4:5
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3
#playsound:Play_MUS_Story_SC_Church_Agathe

// Player arrive dans l'Église puis avance jusqu'à la statue.
// Après un moment.
- UNE VOIX: <b>Irène</b> accueille en sa demeure tous ceux qui ont besoin d'un toit...  #look:Agathe:Player #move:player:8:9 #look:Player:Agathe #look:Agathe:Player #audience:ovation #wait:1 #box #playsound:VOX_Agathe_ireneaccueille #wait:6
// La voix vient d'hors-champ. Après un moment, une femme âgée arrive par la droite de la scène et entre dans le champ.
- PRÊTRESSE: ... quel qu'ils soient. #look:Agathe:front #playsound:VOX_Agathe_quelsquils #look:Player:front #audience:applause
    * [Bénie soit-elle.] PLAYER: Bénie soit-elle. #playsound:VOX_Player_beniesoitelle #audience:applause
        Agathe: Bénie entre toutes. Depuis le premier jour de sa vie, et jusqu'à ce que plus une seule d'entre nous ne la serve. #playsound:VOX_Agathe_benieentretoutes #audience:ovation
        ** [ « Nous » ? Les prêtresses ?] PLAYER: Vous faites référence aux <b>prêtresses d'Irène</b> ?
            -> priestess
    * [Quelle hospitalité !] PLAYER: Vous savez faire preuve d'hospitalité. Merci. #playsound:VOX_Player_voussavezhospitalite #audience:applause
        AGATHE: Diriez-vous d'un servant qu'il est hospitalier en vous accueillant dans la maison de son maître ? #playsound:VOX_Agathe_diriezservant
        ** [N'êtes-vous pas chez vous ?] PLAYER: N'êtes-vous pas chez vous en ces lieux ?
            AGATHE: « Invitée en son foyer, vaisseau en ce monde. ». #playsound:VOX_Agathe_vaisseauencemonde
            AGATHE: Nous sommes toutes de simples servantes, en ce lieu comme dans cette vie. #playsound:VOX_Agathe_sommessimplesservantes #audience:applause
            *** [Nous ?] PLAYER: Les <b>prêtresses d'Irène</b> ?
                ---- (priestess) AGATHE: Nous autres <b>prêtresses d'Irène</b> vouons notre vie à la Pupille des eaux. #playsound:VOX_Agathe_pupilledeseaux #audience:applause
                **** [Une noble cause.] PLAYER: La plus noble des causes... #audience:applause
                **** [Vous n'êtes pas libres.] PLAYER: Ne préfèreriez-vous pas être libre, comme moi ? #audience:debate
                    ~ claim_to_be_free = true
                    AGATHE: Vous êtes libre, et je suis assujettie. Pourtant, votre liberté vous a conduit au même endroit que moi, sous ce même toit par cette même nuit. #playsound:VOX_Agathe_vouseteslibreironie #audience:hush
                    AGATHE: Vous êtes ici parce que des gardes vous poursuivaient, je suis là parce que la <b>Déesse</b> m'a parlé. Qui de nous deux est réellement le plus libre ? #playsound:VOX_Agathe_lesgardesvouspoursuivaient #audience:applause
                    ***** [Touché.] PLAYER: J'imagine que vous avez raison...
                    ***** [Elle vous a parlé ?] PLAYER: <b>Irène</b> vous a parlé, à vous ?
                        AGATHE: Parfaitement. Elle me parle en cet instant. #playsound:VOX_Agathe_parfaitement #audience:ovation
                        ****** [Que vous dit-elle ?] PLAYER: Et que vous murmure-t-elle ?
                            AGATHE: Rien que vous ne sauriez entendre, mon enfant. #playsound:VOX_Agathe_rienquevousnesaurier
                        ****** [Elle ne me parle pas.] PLAYER: Elle ne m'a jamais parlé, à moi...
                            AGATHE: Peut-être n'avez-vous pas su écouter... #playsound:VOX_Agathe_peutetrepasecoute #audience:applause
                    ***** [Je peux m'en aller...] PLAYER: Je suis libre. Libre de m'en aller...
            *** [Acquiescer.]
        ** [Certes, non.] PLAYER: Probablement pas...
            AGATHE: Il en va de même pour nous autres prêtresses... #playsound:VOX_Agathe_demempournous
            *** [Les prêtresses d'Irène...] PLAYER: Les prêtresses d'<b>Irène</b>... 
                -> priestess
        ** [Bien entendu.]
            AGATHE: Ne confondez pas le Foyer et la braise. #playsound:VOX_Agathe_foyerbraise #audience:applause
            *** [Le foyer et la braise ?] PLAYER: Le Foyer et la braise ?
                AGATHE: Représentez-vous un feu. À chaque instant, une braise cesse d'être, consumée jusqu'à son extinction pour attiser les flammes. #playsound:VOX_Agathe_unfeu
                **** [Les prêtresses...] PLAYER: La braise, ce sont les prêtresses ? Et le Foyer... -> priestess
            *** [Vous avez raison.] PLAYER: Vos paroles sont sages.
            *** [Je ne confonds personne.] PLAYER: Je sais ce que je dis.
                AGATHE: J'en ai bien peur, en effet... #playsound:VOX_Agathe_bienpeureneffet
    * [Rester silencieux.]
// Bruits de gardes à l'extérieur
- AGATHE: Rassurez-vous, vous êtes au seul endroit que les gardes de la <b>Couronne</b> ne viendront pas fouiller... #playsound:Play_SFX_Story_SC_Eglise_GuardsSearchingFar #playsound:Play_MUS_Story_SC_Eglise_GuardsSearching #playsound:VOX_Agathe_lesgardesneviendront
- AGATHE: Seule <b>Irène</b> est en droit de juger vos actes en ces lieux. #playsound:Play_MUS_Story_SC_Eglise_ImploreStatue #light:irene_statue #playsound:VOX_Agathe_seuleirene #audience:applause
// PLAYER se tourne vers la statue
    * [(Avec intensité) Implorer la statue. {t(CHAR, 25)}] // 75%
        {sc(CHAR, 25): -> implore_irene_S | -> implore_irene_F}
        ** (implore_irene_S) PLAYER: Ô divine apparition. Sachez me venir en aide, victime que je suis... #anim:Player:pray #playsound:VOX_Player_osachezmevenirenaide #trial
            ~ trial()
            ~ t_3_implore_irene = true
            *** [...de la folie des Hommes.] PLAYER: ...des Hommes et de leur folie ! #trial #playsound:VOX_Player_deshommesetfolie #audience:ovation
                AGATHE: <b>Irène</b> a eu à souffrir elle aussi de leurs aliénations. #playsound:VOX_Agathe_elleaussialienations
            *** [...de ma propre convoitise.] PLAYER: ...de mes propres désirs ! #trial #playsound:VOX_Player_mespropresdesirs #audience:debate
                AGATHE: Au moins avez-vous le courage de reconnaître vos fautes. #playsound:VOX_Agathe_aucouragefaute
            *** [...du plus funeste destin.] PLAYER: ...d'un destin des plus tragiques ! #trial #playsound:VOX_Player_destintragique #audience:choc
                AGATHE: Soyez reconnaissant des épreuves que la <b>Déesse</b> dresse sur votre chemin, car dans ces adversités se cachent des trésors de sagesse. #playsound:VOX_Agathe_lesepreuvesdeesse
        ** (implore_irene_F) PLAYER: C'est de votre faute à vous, là-haut ! #anim:Player:angry #playsound:VOX_Player_votrefautelahaut #trial #audience:booing
            ~ trial()
            ~ t_3_blame_irene = true
            {
                - claim_to_be_free == true :
                    AGATHE: N'était-ce pas vous qui, un instant plus tôt, prétendiez être libre, dans vos pensées comme dans vos actes ? #playsound:VOX_Agathe_vousquipretendiez #audience:applause
                - claim_to_be_free == false :
                    AGATHE: Blâmer notre Sauveuse pour vos malheurs est insensé et cruel. #playsound:VOX_Agathe_blamernotresauveuse #audience:applause
            }
    * [Elle ressemble à la proue d'un navire.] PLAYER: Elle est pareille à la figure de proue d'un navire. #audience:applause
        AGATHE: Cette statue représente <b>Irène</b> guidant l'humanité vers la terre promise. Après des nuits entières à veiller sur le pont du bateau... #playsound:VOX_Agathe_cettestatuereprésente
        AGATHE: ... <b>Irène</b> fut découverte un matin, transfigurée en figure de proue. #playsound:VOX_Agathe_irenefutdecouverte
    * [Parlez-moi d'elle.] PLAYER: Parlez-moi d'<b>Irène</b>. Qu'aurait-elle fait à ma place ?
        AGATHE: Plutôt que de me demander à moi... Peut-être pourriez-vous vous adresser à <b>Elle</b> ? #playsound:VOX_Agathe_plutotquedemanderamoi
- AGATHE: Voyez-vous la lampe qui se tient dans sa main ? Faites-en briller la flamme, si vous souhaitez prier la <b>Déesse</b>. #playsound:VOX_Agathe_lalampequitientdanssamain #audience:applause
    * [Allumer la lampe d'Irène.]
        AGATHE: Désormais que sa flamme berce ces lieux, n'hésitez plus : parlez-lui. #move:Player:8:3 #look:player:left #playsound:Play_SFX_Story_SC_Eglise_LightIreneLamp #playsound:Play_MUS_Story_SC_Eglise_LightOn #anim_event:light_on_irene_lamp #trial #audience:ovation #playsound:VOX_Agathe_saflamebercesesyeux
        ~ trial()
        ~ t_3_light_on_irene_torch = true
        ~ irene_torch_is_on = true
        ** [Se confesser.] PLAYER: J'ai ramené de mon voyage... #playsound:VOX_Player_jairamenevoyage
            ~ irene_torch_is_on = true
            *** [...un trésor interdit.] PLAYER: ...un trésor qui m'était interdit. #playsound:VOX_Player_untresorinterdit
            *** [...un bagage de trop.] PLAYER: ...un bagage de plus. Un bagage de trop. Un poids sur ma conscience. #playsound:VOX_Player_unbagagedetrop
            *** [...un tas de problèmes.] PLAYER: ...tout un lot d'embêtements. #playsound:VOX_Player_toutunlot
            --- PLAYER: <b>Irène</b>, trouvez en votre bonne âme la force de me pardonner, et d'alléger par la même le poids de mes supplices !
        ** [Lui demander de l'aide.] PLAYER: <b>Irène</b>, je vous en conjure, venez-moi en aide. Ô, allégez le poids de mes supplices ! #playsound:VOX_Player_irenevenezmoienaide #trial
            ~ trial()
            ~ t_3_light_on_irene_torch = true
            ~ irene_torch_is_on = true
        ** [Éteindre la lampe.] PLAYER: J'ai changé d'avis. La lampe restera éteinte, j'en ai peur. #playsound:VOX_Player_jaichangedavis #trial #audience:debate
            ~ trial()
            ~ t_3_no_light_on_irene_torch = true
            -> lamp_off
        -- AGATHE: <b>Irène</b> saura entendre vos prières, mon enfant. Sachez, à votre tour, entendre son récit. #look:Player:front #playsound:VOX_Agathe_ireneentendrapriere
    * [Laisser la lampe éteinte.] PLAYER: Elle restera éteinte, j'en ai peur. #playsound:VOX_Player_elleresteraeteinte #trial #audience:booing
        ~ trial()
        ~ t_3_no_light_on_irene_torch = true
        -- (lamp_off) AGATHE: Savez-vous seulement ce que symbolise cette torche, mon, enfant ? #playsound:VOX_Agathe_savezvoussymbole
- AGATHE: Cette église, voyez-vous, n'a pas pour seule vocation de prier la <b>Déesse</b>. Elle fut aussi dressée pour témoigner de son histoire. #playsound:VOX_Agathe_cetteeglisevitraux
-> stained_glass


// Ask about the different stained glass illustrations
= stained_glass
#light:stained_glass #playsound:Play_MUS_Story_SC_Eglise_StainedGlassMentionned #look:Agathe:front
* {t_3_stained_glass_1_talk == false} [À propos du vitrail du bébé au milieu de la tempête.] PLAYER: Ce bébé, au milieu de la tempête... c'est Elle ? #move:player:8:4 #look:Player:back #playsound:VOX_Player_cebebecestelle #audience:empathy
    ~ t_3_stained_glass_1_talk = true
    -> baby_in_the_middle_of_a_tempest
* {t_3_stained_glass_2_talk == false} [À propos du vitrail d'Irène regardant l'océan.] PLAYER: <b>Irène</b>, près du phare, contemplant l'océan. Je me demande quelles pensées la traversaient. #move:player:8:9 #look:Player:back #playsound:VOX_Player_irenepresduphare
    ~ t_3_stained_glass_2_talk = true
    -> irene_next_to_the_lighthouse
* {t_3_stained_glass_3_talk == false} [À propos du vitrail de l'homme écartelé sur sa roue.] PLAYER: L'homme attaché à la roue... c'est <fade a=0.5><shake a=0.5><b>Lui</b></shake></fade> n'est-ce pas ? #move:player:8:13 #look:Player:back #playsound:VOX_Player_lhommeattachealaroue
    ~ t_3_stained_glass_3_talk = true
    -> man_tied_to_a_wheel
+ {t_3_stained_glass_1_talk or t_3_stained_glass_2_talk or t_3_stained_glass_3_talk} [(Conclure) Passer la nuit.] PLAYER: J'aimerais me reposer, prêtresse. #playsound:VOX_Player_jaimeraismereposer
    {
        - t_3_stained_glass_1_talk == true && t_3_stained_glass_2_talk == true && t_3_stained_glass_3_talk == true:
            #anim:Player:go_to_sleep_on_bench
            -> barge.scene_4
        - else:
            AGATHE: Êtes-vous certain de ne pas vouloir poursuivre notre discussion, mon enfant ? #playsound:VOX_Agathe_certainpascontinuer
                + [J'ai changé d'avis.] PLAYER: Sans doute ne souffrirais-je pas d'entendre encore un peu parler votre sagesse...
                    -> stained_glass
                + [Je souhaite me reposer...] PLAYER: Veuillez me pardonner, prêtresse. Le sommeil m'emporte déjà... #playsound:VOX_Player_veuillezpardonner
                    #anim:Player:go_to_sleep_on_bench #playsound:Play_MUS_Story_SC_Eglise_Goodnight
                    -> barge.scene_4
    }

// Stained glass of Irene as a baby, in the middle of a tempest
= baby_in_the_middle_of_a_tempest
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassBaby
- AGATHE: Une nuit où l'océan déchaînait ses passions... Un bateau de pêcheurs fut pris dans ses entrailles. #look:Player:front
AGATHE: En plein affrontement avec les vagues furieuses... Ils entendirent des pleurs. #audience:empathy
    * [Des pleurs ?] PLAYER: Des pleurs ? Les pleurs de qui ?
        AGATHE: Quelle autre voix que la <b>Sienne</b> saurait étouffer les vents les plus impétueux ? #audience:ovation
    * [J'en doute.] PLAYER: En pleine tempête ? Croyez un marin lorsqu'il vous dit ceci : c'est impossible... #trial
            ~ trial()
            ~ t_3_doubt_about_irene_cryings = true
        AGATHE: Les vents les plus impétueux ne sauraient étouffer la voix de la <b>Déesse</b>. #audience:ovation
- AGATHE: Ils hésitèrent à envoyer un canot chercher la source des pleurs... #audience:empathy
    * [Cela les honorerait.] PLAYER: Des pleurs, au milieu de la houle ? Ma curiosité - sinon mon honneur - l'aurait emporté sur ma prudence ! #trial #audience:ovation
        ~ trial()
        ~ t_3_is_with_irene_saviors = true
        AGATHE: Bénit soyez-vous, mon enfant.
    * [Un signe de leur inconscience.] PLAYER: Par ce temps ? Mieux vaut une âme en pleurs que dix épouses en deuil. J'aurai écouté ma prudence et fait taire ma curiosité. #trial #audience:booing
        ~ trial()
        ~ t_3_is_against_irene_saviors = true
        AGATHE: Fort heureusement, ces marins furent mieux conseillés par leur conscience... #audience:applause
    * [Écouter en silence.]
- (a_navigator_save_baby) AGATHE: L'un d'eux, n'écoutant que son courage...
- AGATHE: Affréta un canot et suivit le son des pleurs au cœur de la tempête. #audience:applause
- AGATHE: Au milieu des vagues, il découvrit sur un rocher, allongé, un bébé. #audience:empathy
    * [La vision du vitrail !] PLAYER: C'est cette scène que le vitrail représente, n'est-ce pas ?
        AGATHE: Celle-là même.
    * [(Avec emphase) Quelle vision émouvante ! {t(CHAR, 15)}]
        {sc(CHAR, 15): -> moved_by_the_baby_S | -> moved_by_the_baby_F}
        ** (moved_by_the_baby_S) PLAYER: Imaginer cet enfant - la <b>Déesse</b> ! - pleurant au milieu de la tempête... Quelle vision poignante ! #anim:Player:happy #playsound:VOX_Player_imaginerenfantdeesse #trial #audience:ovation
                ~ trial()
                ~ t_3_moved_by_baby_irene = true
        ** (moved_by_the_baby_F) PLAYER: Ô quelle magnifique - que dis-je - suprême vision ! #anim:Player:pray #playsound:VOX_Player_oquellemagnifiquesupreme #trial #audience:booing
            ~ trial()
            ~ t_3_fake_about_feeling_for_the_baby = true
            AGATHE: Vous en faites trop, mon enfant...
    * [Ça n'a ni queue ni tête...] PLAYER: Balivernes. Des mythes pour tirer une larme aux culs bénis. #playsound:VOX_Player_balivernesculbenis #audience:choc
        AGATHE: Mon enfant, soyez sûr qu'<b>Irène</b> entend tout. Les chants les plus clairs comme les paroles les plus sinistres. #trial #audience:booing
            ~ trial()
            ~ t_3_religion_is_to_make_naive_cry = true
- AGATHE: Le marin garda l'enfant contre sa poitrine, et le ramena au reste de l'équipage. #audience:applause
- AGATHE: Mais, la tempête n'en avait pas fini avec eux. Perdus au milieu de la houle... Les pêcheurs n'apercevaient plus un espoir de terre ferme. #audience:choc
AGATHE: Jamais ils n'auraient eu la moindre chance, sans l'aide d'un homme du nom de... #audience:hush
- (ernest)
    * [... Eugène, sans nul doute.] PLAYER: Vous parlez sans l'ombre d'un doute du célèbre Eugène. #audience:silent
        AGATHE: Je n'ai aucune idée de qui donc est cet Eugène. L'homme que je mentionne n'est autre qu'<b>Ernest</b>. #audience:applause
    * [... Ernest, cela va sans dire.] PLAYER: Vous faites sans doute allusion au pieu <b>Ernest</b>. #audience:applause
        AGATHE: La <b>Déesse</b> le bénisse, entre tous les hommes. #audience:ovation
    * [(Avec certitude) Je connais son nom. {t(CHAR, -20)}] // 30%
        {sc(CHAR, -20): -> player_knows_ernest_S | -> player_knows_ernest_F}
        ** (player_knows_ernest_S) PLAYER: Vous faites sans doute allusion au pieu <b>Ernest</b>. #audience:applause
            AGATHE: Absolument
        ** (player_knows_ernest_F) PLAYER: Vous parlez sans l'ombre d'un doute du célèbre <b>Edgar</b>. #audience:debate
            AGATHE: <b>Edgar</b>, vous dites ? #audience:hush
            *** [Edgar le Traquenard.] PLAYER: <b><wiggle a=0.1>Edgar le Traquenard</wiggle></b>, bien sûr ! On raconte qu'il est capable de détrousser mille hommes par nuit ! #trial #audience:hush
                ~ trial()
                ~ t_3_rant_about_edgar_the_traquenard = true
            --- AGATHE: Je vous demande pardon, mon enfant ?
                PLAYER: Nul ne devrait tourner au croisement d'une ruelle sans retenir un frisson de terreur pour <b><wiggle a=0.1>Edgar le Traquenard</wiggle></b>. #anim:Player:stressed #audience:laughter
                AGATHE: ... #audience:debate
                PLAYER: <wiggle a=0.1>(Les yeux fous)</wiggle> Il nous attend peut-être, <fade a=0.5>caché</fade> de l'autre côté d'une ruelle, prêt à nous suriner ! #audience:choc
                AGATHE: ... Euh...
                AGATHE: L'homme auquel je faisais en réalité allusion est <b>Ernest</b>, la <b>Déesse</b> le bénisse. #audience:applause
- AGATHE: <b>Ernest</b>, le gardien du phare. #audience:ovation
    * [Qu'a-t-il donc fait ?] PLAYER: Qu'a-t-il fait pour les aider ?
        AGATHE: Cette nuit-là, <b>Ernest</b> dormait dans son phare, usé par une journée de labeur.
        AGATHE: Cependant, au plus profond de son sommeil, il entendit une <wiggle a=0.1>voix</wiggle>... #audience:hush
    * [Qui est-il ?] PLAYER: Nul n'ignore le nom d'<b>Ernest</b>, mais qui est-il vraiment ?
        AGATHE: Un brave homme, vivant à l'écart des siens, dans son phare.
        -- AGATHE: Cette nuit-là, au plus profond de son sommeil, il entendit une <wiggle a=0.1>voix</wiggle>. #audience:hush
    * [Écouter la suite.]
        AGATHE: Cette nuit-là, <b>Ernest</b> dormait dans son phare, usé par une journée de labeur. 
        AGATHE: Cependant, au plus profond de son sommeil, il entendit une <wiggle a=0.1>voix</wiggle>... #audience:hush
- AGATHE: Les pleurs d'un enfant. #audience:empathy
- AGATHE: Il gravit l'échelle qui menait au phare, et éclaira la nuit de sa divine lueur. #audience:ovation
    * [Les pêcheurs purent la voir ?] PLAYER: Ainsi, les pêcheurs purent regagner le rivage ?
    * [(Avec emphase) Louée soit la lumière !] PLAYER: <b>Louée soit la lumière</b> qui sauva les pêcheurs et l'enfant d'une mort certaine ! #anim:Player:pray #audience:ovation
- AGATHE: Après des efforts considérables, les braves hommes purent regagner la terre ferme sains et saufs.
    * [(Avec émotion) Magnifique.] PLAYER: S'il est des histoires qui émeuvent un marin, c'est bien celle d'un équipage qui regagne les siens. #trial #anim:Player:happy #audience:ovation
        ~ trial()
        ~ t_3_believe_in_lighthouse_sacred_light = true
    * [Difficile à croire.] PLAYER: Toute cette histoire me semble tenir davantage du mythe que de la réalité, chère prêtresse. #trial #audience:booing
        ~ trial()
        ~ t_3_does_not_believe_in_lighthouse_sacred_light = true
        AGATHE: Cher enfant, vous semblez confondre le tonnage d'un mortel et l'étoffe d'une Sainte. #audience:applause
- AGATHE: Savez-vous seulement ce que les pêcheurs firent pour remercier <b>Ernest</b> ?
    * [Ils s'en prirent à lui.] PLAYER: Je connais les Hommes, et leur cœur impur. Ils s'en prirent à leur sauveur, n'est-ce pas ? #audience:hush
        AGATHE: Ces pêcheurs risquèrent leur vie pour sauver une pauvre âme de la noyade. Ils ne firent rien de cela, et confièrent plutôt l'enfant sacré à leur sauveur. #audience:applause
    * [Ils lui offrirent l'enfant.] PLAYER: Ils lui confièrent la garde de l'enfant sacré. #audience:applause
        -- (know_fishermen_gift)
        AGATHE: Précisément. #audience:ovation
    * [Seul un idiot l'ignorerait. {t(STRE, 20)}] // 70%
        {sc(STRE, 20): -> know_fishermen_gift_S | -> know_fishermen_gift_F}
        ** (know_fishermen_gift_S) PLAYER: Ils lui confièrent la garde de l'enfant sacré. #audience:applause
            -> know_fishermen_gift
        ** (know_fishermen_gift_F) PLAYER: Ils lui firent offrande de la pêche du jour ? #audience:booing
            AGATHE: Ils surent mieux mesurer l'ampleur de leur dette. Les pêcheurs lui confièrent la garde de l'enfant sacré, pour sûr. #audience:applause
- AGATHE: Et c'est ainsi que, sauvée des eaux, <b>Irène</b> fut élevée comme sa fille par le gardien du phare... #audience:ovation
- AGATHE: Cet acte scella le destin de nos ancêtres, qui purent survivre au <b>Déluge</b> à venir. #audience:choc
- -> stained_glass

// Stained glass of Irene next ton the lighthouse
= irene_next_to_the_lighthouse
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassLookingOcean
- AGATHE: Savez-vous ce que disait l'homme qui éleva la <b>Déesse</b> comme sa fille ? #look:Player:front #audience:debate
    * [Qui pourrait le prétendre ?] PLAYER: J'aimerais bien connaître celui qui le prétend.
        AGATHE: Les <b>Écrits</b> nous renseignent à ce sujet, mon enfant. #audience:applause
        ** [Que disent les Écrits ?] PLAYER: Et que disent-ils à ce sujet, prêtresse ?
            --- (irene_obsessed_with_ocean) AGATHE: Que la <b>Déesse Irène</b> passait ses journées à observer l'océan, comme fascinée par le mouvement des vagues. Ensorcelée. #audience:hush
        ** [Encore faut-il y croire...] PLAYER: Ces <b>Écrits</b> soi-disant sacrés sont des mythes... #trial #audience:booing
            ~trial()
            ~ t_3_does_not_believe_the_sacred_writings = true
            AGATHE: Mon enfant, il est des récits qui doivent être entendus avec le cœur, non avec la raison. #audience:applause
            AGATHE: La <b>Déesse Irène</b> passait ses journées à observer l'océan, comme fascinée par le mouvement des vagues. Ensorcelée. #audience:hush
    * [Je l'ignore.] PLAYER: Je dois avouer mon ignorance. Que disait-il ? #audience:debate
        -> irene_obsessed_with_ocean
- AGATHE: Cela effrayait son père. #audience:hush
    * [Pourquoi donc ?] PLAYER: Pour quelle raison ?
        -- (afraid_irene_swim_back) AGATHE: Il avait peur que sa fille adoptive, venue des <b>Eaux</b> y retourne. #audience:debate
    * [Un froussard.] PLAYER: Certains bravent des tempêtes... quand d'autres s'émeuvent de la houle. #audience:booing
        AGATHE: Vous faites fausse route. Ce n'est pas de l'océan dont le brave homme avait peur.
            -> afraid_irene_swim_back
    * [Écouter en silence.] -> afraid_irene_swim_back
- AGATHE: Comprenez-vous son trouble, mon enfant ?
    * [Un père a peur de perdre sa fille.] PLAYER: Un père effrayé à l'idée de voir sa fille disparaître. Rien de plus naturel. #audience:applause
    * [Certains disent qu'Irène y est née.] PLAYER: Certains prétendent que l'océan était son berceau... #audience:choc
        AGATHE: Ce à quoi vous faites référence, en réalité, est un <shake a=0.5><b>abominable blasphème</b></shake>. #audience:debate
        AGATHE: Quiconque prétend qu'<b>Irène</b> est de cette engeance, périront noyés par le <fade a=0.5><shake a=0.5><b>Juste</b></shake></fade>. #audience:ovation
        ** [Que l'océan les avale.] PLAYER: Que l'océan soit leur tombeau ! #audience:ovation
        ** [Ont-ils vraiment tort ?] PLAYER: Pourtant, cela expliquerait certains détails des <b>Écrits</b>, ne pensez-vous pas ? #trial #audience:debate
            ~ trial()
            ~ t_3_question_if_irene_is_a_sireine = true
            AGATHE: Il est des prêtresses qui étudient les <b>Écrits</b> leur vie durant pour tenter d'en percer ses mystères... 
            AGATHE: Préférez laisser ces zones d'ombres intactes...
            AGATHE: ... à l'idée de les éclairer d'une lumière impie. #audience:applause
- AGATHE: Observez davantage le vitrail, mon enfant. Qu'y voyez-vous d'autre ?
    * [Irène semble... inquiète.] PLAYER: Elle a l'air préoccupée... #audience:debate
        AGATHE: Ne le seriez-vous pas, si vous saviez que le <b>Déluge</b> arrivait ? Ne le seriez-vous pas, si nul ne vous croyait ? #audience:choc
    * [Une tempête se prépare.] PLAYER: Je sais reconnaître une tempête qui arrive...
        AGATHE: Une tempête, vous dites ? Le <b>Déluge</b>, mon enfant. #audience:choc
    * [La lune est pleine.] PLAYER: La pleine lune...
        AGATHE: Une lune incandescente, annonçant le <b>Déluge</b>. #audience:choc
- AGATHE: Connaissez-vous la <b>comptine</b>, mon enfant ? #audience:hush
- AGATHE: « Quand le ciel fut sombre, et la lune fut levée... <b>Irène</b>, Fille des eaux... #playsound:VOX_Agathe_comptine1
    * [... ouït le Déluge gronder.] PLAYER: ... ouït le <b>Déluge</b> gronder. ». #audience:choc
    * [... vit le monde sombrer.] PLAYER: ... vit le monde sombrer. ». #audience:choc
    * [... sentit la Vie cesser.] PLAYER: ... sentit la Vie cesser. ». #audience:choc
- AGATHE: « Près du phare, cette nuit, l'océan lui parla... Puis elle n'eut qu'une seule cause... #playsound:VOX_Agathe_comptine2
    * [... sauver qui elle pourra.] PLAYER: ... sauver qui le pourra. ». #audience:applause
    * [... instruire qui la croira.] PLAYER: ... instruire qui la croira. ». #audience:applause
    * [... bénir qui l'aidera.] PLAYER: ... bénir qui l'aidera. ». #audience:applause
- AGATHE: « Elle monta à la ville, et cria sous chaque toit. Annonçant le péril... #playsound:VOX_Agathe_comptine3
    * [... on la fit hors-la-loi.] PLAYER: ... on la fit hors-la-loi. ». #audience:booing
    * [... de folle on la traita.] PLAYER: ... de folle on la traita. ». #audience:booing
    * [... de vice on l'accusa.] PLAYER: ... de vice on l'accusa. ». #audience:booing
- AGATHE: « Seul son père la crut, acquis à sa pureté. Ce qu'il vit en elle fut... #playsound:VOX_Agathe_comptine4
    * [... une Sauveuse née.] PLAYER: ... une Sauveuse née. ». #audience:ovation
    * [... une Sainteté.] PLAYER: ... une Sainteté. ». #audience:ovation
    * [... une âme Sacrée.] PLAYER: ... une âme Sacrée. ». #audience:ovation
- AGATHE: « <b>Irène</b> lui jura que pour dompter les eaux... Ils devaient s'atteler... #playsound:VOX_Agathe_comptine5
    * [... à construire un bateau.] PLAYER: ... à construire un bateau. ». #audience:applause
    * [... à bâtir un paquebot.] PLAYER: ... à bâtir un paquebot. ». #audience:applause
    * [... à créer un vaisseau.] PLAYER: ... à créer un vaisseau. ». #audience:applause
- AGATHE: « L'édifice prenant forme, ceux-là qui l'accusaient... Voyant qu'elle disait vrai... #playsound:VOX_Agathe_comptine6
    * [... proposèrent de l'aider.] PLAYER: ... proposèrent de l'aider. ». #audience:empathy
    * [... firent preuve de piété.] PLAYER: ... firent preuve de piété. ». #audience:empathy
    * [... se montrèrent dévoués.] PLAYER: ... se montrèrent dévoués. ». #audience:empathy
- AGATHE: « Quand la <b>Couronne</b> eut vent qu'un Messie existait. Elle envoya des gardes... #playsound:VOX_Agathe_comptine7
    * [... le faire exécuter.] PLAYER: ... le faire exécuter. ». #audience:choc
    * [... afin de le châtier.] PLAYER: ... afin de le châtier. ». #audience:choc
    * [... en faire un prisonnier.] PLAYER: ... en faire un prisonnier. ». #audience:choc
- AGATHE: « Mais le père dévoué à sa fille bien-aimée, n'écoutant que son cœur... #playsound:VOX_Agathe_comptine8
    * [... pour le Messie, se fit passer.] PLAYER: ... pour le Messie, se fit passer. ». #audience:hush
    * [... se sacrifia pour la sauver.] PLAYER: ... se sacrifia pour la sauver. ». #audience:hush
    * [... à sa place, fut enfermé.] PLAYER: ... à sa place, fut enfermé. ». #audience:hush
- AGATHE: « Son supplice, désormais, nulle âme ne l'ignore. Enchaîné à une roue... #playsound:VOX_Agathe_comptine9
    * [... on le laissa pour mort.] PLAYER: ... on le laissa pour mort. ». #audience:empathy
    * [... on y scella son sort.] PLAYER: ... on y scella son sort. ». #audience:empathy
    * [... on déforma son corps.] PLAYER: ... on déforma son corps. ». #audience:empathy
- AGATHE: « Et par son sacrifice, il permit à sa fille, et à ceux qu'elle choisit... #playsound:VOX_Agathe_comptine10
    * [... d'entamer leur exil.] PLAYER: ... d'entamer leur exil. ». #audience:ovation
    * [... d'éviter leur péril.] PLAYER: ... d'éviter leur péril. ». #audience:ovation
    * [... de fuire ces terres hostiles.] PLAYER: ... de fuire ces terres hostiles. ». #audience:ovation
- AGATHE: Ce que cet homme a fait pour sa fille... pour notre peuple tout entier... #audience:ovation
    * [Louons son sacrifice.] PLAYER: Nous ne pouvons, nous autres mortels, que louer son sacrifice. #trial #audience:applause
        ~ trial()
        ~ t_3_show_judge_respect = true
        AGATHE: La tâche que nos aïeux lui ont confiée lorsqu'il fut libéré est à la hauteur de notre respect à son égard... #playsound:Play_SFX_Story_JudgeBellFar #wait:0.5
    * [Ce qu'il est devenu après...] PLAYER: Certains disent qu'il aurait dû être sanctifié, plutôt que... #audience:choc
        AGATHE: ... plutôt que voué à une tâche si grave ? #playsound:Play_SFX_Story_JudgeBellFar #wait:0.5 #audience:choc
        ** [Peut-être...] PLAYER: J'ose le dire, en effet. Son sacrifice fut salvateur pour nos ancêtres, mais au lieu de lui faire atteindre la béatitude, cela l'a... consumé... #trial #audience:debate
            ~ trial()
            ~ t_3_question_judge_position = true
        ** [Oubliez.] PLAYER: Ce n'est pas ce que je voulais dire. Disons que la tâche qui lui incombe est... épuisante. #trial #audience:hush
            ~ trial()
            ~ t_3_show_judge_respect = true
// Return to the stained glass conversation
- -> stained_glass

// Stained glass of a man tied to a wheel, about to be sentenced to death
= man_tied_to_a_wheel
#playsound:Play_MUS_Story_SC_Eglise_StainedGlassHim
AGATHE: C'est <fade a=0.5><shake a=0.5><b>Lui</b></shake></fade>, en effet. L'homme a souffert pour sauver sa fille, et notre peuple tout entier. #look:Player:front #audience:hush
AGATHE: Quand les gardes de la <b>Couronne</b> vinrent arrêter le Messie, c'est lui qu'ils emmenèrent. #audience:hush
    * [Nous lui devons tant.] PLAYER: Notre dette à son égard est immense. #trial #audience:debate
        ~ trial()
        ~ t_3_show_judge_respect = true
    * [Irène l'a-t-elle su ?] PLAYER: Sait-on si <b>Irène</b> a su quel sacrifice son père avait fait ? #audience:debate
        AGATHE: Elle l'apprit le soir même, mais il était trop tard. Les gardes s'en étaient allé depuis longtemps déjà. #audience:empathy
    * [Devrions-nous le craindre ?] PLAYER: Serait-on avisé de le craindre, désormais ? Ou bien pensez-vous que la cloche ne sonne pas pour le juste ? #audience:debate
        AGATHE: À tort ou à raison, tous les habitants de <b>Miraterre</b> le craignent... #audience:hush
- AGATHE: Lorsque nos ancêtres revinrent à <b>Miraterre</b>, ils le trouvèrent enchaîné à sa roue. Vivant. Intact. #audience:choc
AGATHE: Durant un siècle entier, il avait souffert sans jamais mourir. #audience:empathy
AGATHE: Pourquoi donc, d'après vous ? #audience:debate
    * [Le savez-vous vous-même ?] PLAYER: Le savez-vous vous-même, prêtresse ?
        AGATHE: Je crois que quelque chose l'a empêché de mourir. Quelque chose de l'ordre du Divin, mon enfant... #audience:hush
    * [Qui peut le dire ?] PLAYER: On ne peut que supputer...
        AGATHE: Assurément. Je crois que quelque chose l'a empêché de mourir. Quelque chose de l'ordre du Divin, mon enfant... #audience:hush
    * [Pourquoi cette question ?] PLAYER: Pourquoi cette question, prêtresse ?
        AGATHE: Je crois que quelque chose l'a empêché de mourir. Quelque chose de l'ordre du Divin, mon enfant... #audience:hush
- AGATHE: Prenez le temps d'observer à nouveau le vitrail... Voyez ses détails...
    * [Regarder de plus près. {t(STRE, 10)}] // 50
        {sc(STRE, 10): -> watch_judge_closer_S | -> watch_judge_closer_F}
        ** (watch_judge_closer_S) AGATHE: Voyez comme l'Homme a souffert. Quand on le retrouva, son corps avait été si déformé par les années, qu'Il avait acquis une taille inhumaine. #look:Player:back
            *** [Il n'a rien d'humain.] PLAYER: Il n'y a rien, chez lui, qui soit encore humain. #playsound:VOX_Player_rienchezluiencorehumain #trial
                ~ trial()
                ~ t_3_say_judge_is_not_human = true
                AGATHE: Vous fait-il peur, mon enfant ? #look:Player:front
                    **** [Je n'ai peur de personne.] PLAYER: Je n'en ai pas peur. Pas le moindre du monde...
                    **** [C'est tout naturel.] PLAYER: Tout est fait, chez <b>Lui</b>, pour inspirer la peur. La peur et le respect. #playsound:VOX_Player_toutestfaitinspirerpeur
                        -> you_are_right_to_be_afraid
                    **** [Je n'y pense jamais.] PLAYER: J'évite d'y penser. #playsound:VOX_Player_jevitedypenser
                        -> you_are_right_to_be_afraid
            *** [Se taire.]
        ** (watch_judge_closer_F) -> not_watch_judge
    * [Détourner le regard.]
        -- (not_watch_judge) AGATHE: Vous détournez votre regard, mon enfant... #look:Player:back #wait:1 #look:Player:front #anim:Player:stressed #trial
            ~ trial()
            ~ t_3_look_away_judge_stained_glass = true
            ** [Suis-je un couard ?] PLAYER: Cela fait-il de moi un couard ? #look:Player:front #anim:Player:sad
                --- (you_are_right_to_be_afraid) AGATHE: J'ai vu tant de fois ce vitrail. Je crois y être devenue presque insensible. Au fond, c'est sans doute vous qui avez raison...
            ** [Ne rien dire.] -> you_are_right_to_be_afraid
// Return to the stained glass conversation
- AGATHE: <b>Irène</b> nous observe avec bonté... Son père, <b>Lui</b>, nous juge pour nos péchés. #look:Player:front #playsound:Play_SFX_Story_JudgeBellFar
- -> stained_glass
        
// Return to the stained glass conversation
- -> stained_glass