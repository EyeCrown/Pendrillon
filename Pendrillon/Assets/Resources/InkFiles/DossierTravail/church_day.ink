// CHURCH DAY SCENE

// Variables
VAR capucine_nickname = ""
VAR marcello_nickname = ""

// Scene
=== church_day ===
// Define the actors of the scene
#actor:Player:PLAYER
#actor:Agathe:AGATHE
#actor:Capucine:CAPUCINE
#actor:Marcello:MARCELLO
-> start

= start
#anim:Player:sleep
#sleep:4
MARCELLO: Et si on le réveillait avec une tape sur le museau, cheffe ?
CAPUCINE: Cet abruti dort comme un nourrisson...
#sleep:4
#anim:Player:wake_up
PLAYER: Vous, ici ?
CAPUCINE: Nous même...
CAPUCINE: Heureuse de constater que tu nous reconnaîs... 
CAPUCINE: Remets-tu des noms sur nos visages, vermisseau ?
PLAYER: J'ai bien peur... vous êtes...
    * [Capucine la larbine...] PLAYER: Capucine la larbine...
    * [Capucine la marcassine...] PLAYER: Capucine la marcassine...
    * [Capucine la tartine...] PLAYER: Capucine la tartine...
- #anim:Capucine:shameful
- PLAYER: ... accompagnée de son affreux sbire...
    * [Marcellogre...] ... Marcellogre.
    * [Marcellotarie...] ... Marcellotarie.
    * [Marcellocroupie...] ... Marcellocroupie.
- #anim:Marcello:shameful
- CAPUCINE: Tu... Tu te crois malin, abruti ?
    * [Mais vous n'êtes pas seuls...] PLAYER: Vous êtes déjà de trop, cependant ai-je la tristesse de constater que vous n'êtes point seuls...
    * [Si vous êtes ici, c'est que...] PLAYER: Si vous êtes ici, écourtant mon sommeil, c'est qu'on vous a prévenu...
    * [(Au loin) Vous m'avez trahi...] PLAYER: Vous m'avez trahi. Je pensais pouvoir vous faire confiance...
- PLAYER: Approchez-vous... Contemplez le visage de celui que vous avez condamné...
#move(Agathe)
AGATHE: Ce lieu saint a abrité davantage de sauvageons que vous n'en avez croisé dans toute votre vie, mon enfant...
#sleep:2
AGATHE: Cependant aucun d'entre eux ne s'était rendu coupable d'une telle ignominie...
#anim:Agathe:contempt
#anim:Player:ashamed
#audience:shock
#sleep:3
AGATHE: Lorsque j’ai appris pourquoi vous étiez recherché, j’ai su qu’il était de mon devoir, non envers la Couronne mais envers la Déesse elle-même, de vous dénoncer.
#anim:Player:disappointed
#anim:Capucine:laugh
CAPUCINE: Tout le monde t'abandonne à ton triste sort, marmot.
CAPUCINE: Mais tu ne seras bientôt plus seul... Tu vas aller rejoindre ton ami, misérable vermine !
-> battle_capucine_marcello_agathe

// Battle against Capucine, Marcello and Agathe
= battle_capucine_marcello_agathe
Combat entre Capucine, Marcello et la prêtresse Agathe.
-> end_scene

= end_scene
-> END