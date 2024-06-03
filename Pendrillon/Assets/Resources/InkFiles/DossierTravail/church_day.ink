// CHURCH DAY SCENE

// Variables
VAR CAPUCINE = ""
VAR MARCELLO = ""
VAR capucine_surname = "la tartine"
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
#set:church
// Set the actor's positions
#position:Player:4:2
#position:Agathe:4:13
#position:Marcello:2:11
#position:Capucine:3:6
// Audience reaction
#wait:1 #audience:applause #wait:5 #audience:ovation #wait:3

// Start the scene
#anim:Player:sleep
MARCELLO: Et si on le réveillait avec une tape sur le museau, cheffe ?
CAPUCINE: Cet abruti dort comme un nourrisson...
#anim:Player:wake_up
PLAYER: Vous, ici ?!
CAPUCINE: Heureuse de constater que tu nous reconnaîs... 
CAPUCINE: Remets-tu des noms sur nos visages, vermisseau ?
SOUFFLEUR: SOUFFLEUR: Psssst... Hé, l'ami !
SOUFFLEUR: Avec ces deux-là, pas besoin d'y aller mollo pour faire rire le public !
SOUFFLEUR: Ils ont beau se disputer sur scène, sache qu'en dehors des planches, ils sont mari et femme !
SOUFFLEUR: Je sais qu'ils ont l'air méchants, mais ils adorent être ridiculisés !
- PLAYER: J'ai bien peur de vous reconnaître, en effet... vous êtes...
    * [Capucine la larbine...] PLAYER: Capucine la larbine... #audience:laughter #anim:Capucine:shameful
        ~ CAPUCINE = "CAPUCINE LA LARBINE"
        ~ capucine_surname = "la larbine"
    * [Capucine la marcassine...] PLAYER: Capucine la marcassine... #audience:laughter #anim:Capucine:shameful
        ~ CAPUCINE = "CAPUCINE LA MARCASSINE"
        ~ capucine_surname = "la marcassine"
    * [Capucine la tartine...] PLAYER: Capucine la tartine... #audience:laughter #anim:Capucine:shameful
        ~ CAPUCINE = "CAPUCINE LA TARTINE"
        ~ capucine_surname = "la tartine"
- PLAYER: ... accompagnée de son affreux sbire...
    * [Marcellogre...] PLAYER: ... Marcellogre ! #audience:laughter #anim:Capucine:applause #anim:Marcello:shameful
        ~ MARCELLO = "MARCELLOGRE"
        ~ marcello_surname = "Marcellogre"
    * [Marcellotarie...] PLAYER: ... Marcellotarie ! #audience:laughter #anim:Capucine:applause #anim:Marcello:shameful
        ~ MARCELLO = "MARCELLOTARIE"
        ~ marcello_surname = "Marcellotarie"
    * [Marcellocroupie...] PLAYER: ... Marcellocroupie ! #audience:laughter #anim:Capucine:applause #anim:Marcello:shameful
        ~ MARCELLO = "MARCELLOCROUPIE"
        ~ marcello_surname = "Marcellocroupie"
- #anim:Marcello:shameful
- {CAPUCINE}: Tu... Tu te crois malin, abruti ?
- {MARCELLO}: Il se prend pour notre mère, à nous donner des sobriquets pareils ?
    * [Mais vous n'êtes pas seuls...] PLAYER: Vous êtes déjà de trop, cependant ai-je la tristesse de constater que vous n'êtes point seuls...
    * [Si vous êtes ici, c'est que...] PLAYER: Si vous êtes ici, écourtant mon sommeil, c'est qu'on vous a prévenu...
    * [(Au loin) Vous m'avez trahi...] PLAYER: Vous m'avez trahi. Je pensais pouvoir vous faire confiance...
- PLAYER: Approchez-vous... Contemplez le visage de celui que vous avez condamné... #audience:choc
#move(Agathe)
AGATHE: Ce lieu saint a abrité davantage de sauvageons que vous n'en avez croisé dans toute votre vie, mon enfant...
AGATHE: Cependant aucun d'entre eux ne s'était rendu coupable d'un acte aussi grave que le votre... #audience:debate #anim:Agathe:contempt #anim:Player:ashamed
AGATHE: Lorsque j’ai appris pourquoi vous étiez recherché, j’ai su qu’il était de mon devoir, non envers la Couronne mais la Déesse elle-même, de vous dénoncer.#audience:ovation #anim:Player:disappointed #anim:Capucine:laugh
{CAPUCINE}: Tout le monde t'abandonne à ton triste sort, marmot.
{CAPUCINE}: Mais tu ne seras bientôt plus seul... Tu vas aller rejoindre ton affreuse amie, vermine !
{CAPUCINE}: Marcello, attrappe-le !! #anim:Marcello:hit
- -> barge.scene_5

= end_scene
-> END