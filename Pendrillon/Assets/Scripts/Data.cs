
public static class Constants
{
    #region TAGS

    public const string Separator = ":";    // Separator between tags paramaters

    public const string TagIntro        = "intro";         // #intro            Indique si nous sommes dans l'intro
    
    public const string TagActor        = "actor";         // #actor:Character:Name1:Name2:...:NameN   Character: nom du personnage    Name1: 1er surnom     Name2: 2ème surnom  ...  NameN: Nième surnom   
    public const string TagPosition     = "position";      // #position:Character:X:Y        Character: nom du personnage    X: position en X    Y: position en Y  
    public const string TagSet          = "set";           // #set:Location        Location: nom du décor  
    
    public const string TagMove         = "move";           // #move:Character:X:Y:Speed?    Character: nom du personnage    X: position en X    Y: position en Y   Speed: (Optionnel) vitesse de déplacement (voir MovementSpeed region)
    public const string TagPlaySound    = "playsound";      // #playsound:Sound             Sound: son à jouer
    public const string TagAnim         = "anim";           // #anim:Character:Animation    Character: nom du personnage    Animation: animation à jouer
    public const string TagWait         = "wait";           // #wait:Time           Time: temps d'attente en secondes
    public const string TagSleep        = "sleep";          // #sleep:Time          Time: temps d'attente en secondes
    public const string TagBox          = "box";            // #box             Affiche le texte au milieu des tags
    public const string TagScreenShake  = "screenshake";    // #screenshake:Intensity:Time  Intensity: Puissance du screenshake     Time: durée du screenshake en secondes
    public const string TagLook         = "look";           // #look:Character:Target       Character: nom du personnage    Target: cible vers laquelle se tourner
    public const string TagAudience     = "audience";       // #audience:Reaction           Reaction: type de réaction
    public const string TagRope         = "rope";           // #rope:Character              Character: nom du personnage
    public const string TagMap          = "map";            // #map:Travel                  Travel: nom du voyage (voir TravelNames region)
    public const string TagTrial        = "trial";          // #trial               Effectue les actions de trial
    public const string TagCurtains     = "curtains";       // #curtains:State              State:état des rideaux
    public const string TagBattle       = "battle";         // #battle:State                State:état du combat de boss
    public const string TagHeight       = "height";         // #height:Yoffset              Yoffset: valeur de décalage en hauteur
    
    #endregion

    #region MovementSpeed

    public const string SlowName    = "slow";
    public const float  SlowSpeed   = 3.0f;
    public const string NormalName  = "walk";
    public const float  NormalSpeed = 6.0f;
    public const string QuickName   = "run";
    public const float  QuickSpeed  = 8.0f;

    #endregion

    #region Characters

    public const string PrompterName = "Souffleur";

    #endregion

    #region ScreenShake

    public const float ScreenShakeIntensity = 3.0f;
    public const float ScreenShakeTime = 1.0f;

    #endregion

    #region LookDirection

    public const string StageBack       = "back";
    public const string StageFront      = "front";
    public const string StageGarden     = "left";
    public const string StageCourtyard  = "right";

    #endregion

    #region Skill types

    public const string TypeCharisma    = "Charisma";
    public const string TypeStrength    = "Strength";
    public const string TypeDexterity   = "Dexterity";
    public const string TypeComposition = "Composition";
    public const string TypeLuck        = "Luck";

    public static readonly string[] ButtonTypesArray = new[]
    {
        TypeCharisma,
        TypeStrength,
        TypeDexterity,
        TypeComposition,
        TypeLuck
    };

    public static string TranslateType(string englishType)
    {
        string frenchName = "";
        switch (englishType)
        {
            case TypeCharisma:  frenchName = "Charisme";    break;
            case TypeStrength:  frenchName = "Force";       break;
            case TypeDexterity: frenchName = "Dexterité";   break;
        }
        return frenchName;
    }
    
    #endregion

    #region Sets

    public const string FirstSetOnStage = "barge";
    
    public const string SetBarge   = "barge";
    public const string SetCale    = "cale";
    public const string SetPort    = "port";
    public const string SetChuchNight = "church_night";
    public const string SetChuchDay   = "church_day";
    public const string SetTrial   = "trial";
    public const string SetTempest = "tempest";
    public const string SetForest  = "forest";
    public const string SetEmpty   = "empty";
    
    #endregion

    #region AudienceReactions

    public const string ReactBooing     = "booing";
    public const string ReactOvation    = "ovation";
    public const string ReactDebate     = "debate";
    public const string ReactApplause   = "applause";
    public const string ReactChoc       = "choc";
    public const string ReactLaughter   = "laughter";
    public const string ReactDisgust    = "disgust"; 
    public const string ReactEmpathy    = "empathy";
    public const string ReactHush       = "hush";
    public const string ReactSilent     = "silent";


    public static readonly string[] ReactArray = new string[]
    {
        ReactBooing,
        ReactOvation,
        ReactDebate,
        ReactApplause,
        ReactChoc,
        ReactLaughter,
        ReactDisgust,
        ReactEmpathy,
        ReactHush,
        ReactSilent
    };

    #endregion

    #region Animations

    public const string AnimTalk = "talk";

    #endregion

    #region MapStates

    public const string MapDisplay = "down";
    public const string MapTravelDeparture = "departure";
    public const string MapTravelArrival = "arrival";
    public const string MapLeave = "up";

    public static readonly string[] TravelArray = new string[]
    {
        MapDisplay,
        MapTravelDeparture,
        MapTravelArrival,
        MapLeave
    };

    #endregion

    #region PlayerArchetypes

    public const string ArchetypeCharisma = "Beau Parleur";
    public const string ArchetypeStrength = "Force de la Nature";
    public const string ArchetypeDexterity = "Acrobate";

    #endregion

    #region Curtain States
    
    public const string StateCurtainsOpen = "open";
    public const string StateCurtainsClose = "close";

    #endregion

    #region Battle States

    public const string BattleBegin = "begin";
    public const string BattleEnd   = "end";
    
    #endregion
    
    #region Boss States

    public const string BossDefault     = "default";
    public const string BossOpenMouth   = "open mouth";
    public const string BossOnBoat      = "on boat";
    public const string BossUnderwater  = "under water";
    
    #endregion
}