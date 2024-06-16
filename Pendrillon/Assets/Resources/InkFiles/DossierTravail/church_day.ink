// CHURCH DAY SCENE

// Variables
VAR CAPUCINE = ""
VAR MARCELLO = ""
VAR capucine_surname = "la larbine"
VAR marcello_surname = "Marcellogre"

// Scene
=== church_day ===
-> start

= start
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Agathe:AGATHE
#actor:Capucine:CAPUCINE:CAPUCINE LA LARBINE:CAPUCINE LA MARCASSINE:CAPUCINE LA TARTINE
#actor:Marcello:MARCELLO:MARCELLOGRE:MARCELLOTARIE:MARCELLOCROUPIE
// Set the location
#set:church_day
// Set the actor's positions
#position:Player:4:2
#position:Agathe:4:13
#position:Marcello:2:11
#position:Capucine:3:6
// Audience reaction
#wait:0.5 #audience:applause #wait:4 #audience:ovation #wait:3

// Start the scene
#anim:Player:sleep
MARCELLO: Et si on le réveillait avec une tape sur le museau, cheffe ?
CAPUCINE: Cet abruti dort comme un nourrisson... #playsound:VOX_Capucine_cetabrutidort
#anim:Player:wake_up
PLAYER: Vous, ici ?! #playsound:VOX_Player_vousiciQQ #playsound:Play_MUS_Story_SC_Eglise_6oclockWakeUp
CAPUCINE: Heureuse de constater que tu nous reconnais... #playsound:VOX_Capucine_heureusedeconstaterquetunousreconnais
CAPUCINE: Remets-tu des noms sur nos visages, vermisseau ? #playsound:VOX_Capucine_remetstudesnoms
SOUFFLEUR: Psssst... Hé, l'ami ! #playsound:VOX_Souffleur_pssthe4
SOUFFLEUR: Avec ces deux-là, pas besoin d'y aller mollo pour faire rire le public ! #playsound:VOX_Souffleur_ces2la
SOUFFLEUR: Ils ont beau se disputer sur scène, sache qu'en dehors des planches, ils sont mari et femme ! #playsound:VOX_Souffleur_marietfemme
SOUFFLEUR: Je sais qu'ils ont l'air méchants, mais ils adorent être ridiculisés ! #playsound:VOX_Souffleur_pasmechants
- PLAYER: J'ai bien peur de vous reconnaître, en effet... vous êtes... #playsound:VOX_Player_bienpeurconnaitre
    * [Capucine la larbine...] PLAYER: Capucine la larbine... #audience:laughter #playsound:VOX_Player_lalarbine #anim:Capucine:shameful #playsound:Play_MUS_Story_SC_Eglise_ChildishNickname1 #trial
        ~ trial()
        ~ t_4_give_guards_surname = true
        ~ CAPUCINE = "CAPUCINE LA LARBINE"
        ~ capucine_surname = "la larbine"
    * [Capucine la marcassine...] PLAYER: Capucine la marcassine... #audience:laughter #playsound:VOX_Player_lamarcassine #anim:Capucine:shameful #playsound:Play_MUS_Story_SC_Eglise_ChildishNickname1 #trial
        ~ trial()
        ~ t_4_give_guards_surname = true
        ~ CAPUCINE = "CAPUCINE LA MARCASSINE"
        ~ capucine_surname = "la marcassine"
    * [Capucine la tartine...] PLAYER: Capucine la tartine... #audience:laughter #playsound:VOX_Player_latartine #anim:Capucine:shameful #playsound:Play_MUS_Story_SC_Eglise_ChildishNickname1 #trial
        ~ trial()
        ~ t_4_give_guards_surname = true
        ~ CAPUCINE = "CAPUCINE LA TARTINE"
        ~ capucine_surname = "la tartine"
- PLAYER: ... accompagnée de son affreux sbire... #playsound:VOX_Player_sonaffreuxsbire
    * [Marcellogre...] PLAYER: ... Marcellogre ! #audience:laughter #playsound:VOX_Player_marcellogre #anim:Capucine:applause #anim:Marcello:shameful #playsound:Play_MUS_Story_SC_Eglise_ChildishNickname2 #trial
        ~ trial()
        ~ t_4_give_guards_surname = true
        ~ MARCELLO = "MARCELLOGRE"
        ~ marcello_surname = "Marcellogre"
    * [Marcellotarie...] PLAYER: ... Marcellotarie ! #audience:laughter #playsound:VOX_Player_marcellotarie #anim:Capucine:applause #anim:Marcello:shameful #playsound:Play_MUS_Story_SC_Eglise_ChildishNickname2 #trial
        ~ trial()
        ~ t_4_give_guards_surname = true
        ~ MARCELLO = "MARCELLOTARIE"
        ~ marcello_surname = "Marcellotarie"
    * [Marcellocroupie...] PLAYER: ... Marcellocroupie ! #audience:laughter #playsound:VOX_Player_marcellocroupie #anim:Capucine:applause #anim:Marcello:shameful #playsound:Play_MUS_Story_SC_Eglise_ChildishNickname2 #trial
        ~ trial()
        ~ t_4_give_guards_surname = true
        ~ MARCELLO = "MARCELLOCROUPIE"
        ~ marcello_surname = "Marcellocroupie"
- #anim:Marcello:shameful
- {CAPUCINE}: Tu... Tu te crois malin, abruti ? #playsound:VOX_Capucine_tututecrois
- {MARCELLO}: Il se prend pour notre mère, à nous donner des sobriquets pareils ?
    * [Mais vous n'êtes pas seuls...] PLAYER: Vous êtes déjà de trop, cependant ai-je la tristesse de constater que vous n'êtes point seuls... #playsound:VOX_Player_dejadetrop
    * [Si vous êtes ici, c'est que...] PLAYER: Si vous êtes ici, écourtant mon sommeil, c'est qu'on vous a prévenu... #playsound:VOX_Player_siiciprevenu
    * [(Au loin) Vous m'avez trahi...] PLAYER: Vous m'avez trahi. Je pensais pouvoir vous faire confiance... #playsound:VOX_Player_vousmaveztrahi
- PLAYER: Approchez-vous... Contemplez le visage de celui que vous avez condamné... #playsound:VOX_Player_approchezcontemplez #audience:choc
#move(Agathe)
AGATHE: Ce lieu saint a abrité davantage de sauvageons que vous n'en avez croisé dans toute votre vie, mon enfant... #playsound:Play_MUS_Story_SC_Eglise_AgathesBetrayal #playsound:VOX_Agathe_sauvageons
AGATHE: Cependant aucun d'entre eux ne s'était rendu coupable d'un acte aussi grave que le vôtre... #audience:debate #anim:Agathe:contempt #anim:Player:ashamed #playsound:VOX_Agathe_aucuncoupable
AGATHE: Lorsque j’ai appris qui vous cachiez dans votre navire... #audience:debate #playsound:VOX_Agathe_cachieznavire
AGATHE: J’ai su qu’il était de mon devoir, non envers la Couronne mais la Déesse elle-même, de vous dénoncer.#audience:choc #anim:Player:disappointed #anim:Capucine:laugh #playsound:VOX_Agathe_mondevoir
{CAPUCINE}: Tout le monde t'abandonne à ton triste sort, marmot. #playsound:VOX_Capucine_toutlemondetabandonne
{CAPUCINE}: Mais tu ne seras bientôt plus seul... Tu vas aller rejoindre ton affreuse amie, vermine ! #playsound:VOX_Capucine_maistuneserabientôtplusseul
{CAPUCINE}: Marcello, attrape-le !! #playsound:VOX_Capucine_marcelloattrape
- -> barge.scene_5