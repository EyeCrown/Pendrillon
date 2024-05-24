
public static class Constants
{
    #region TAGS

    public const string Separator = ":";    // Separator between tags paramaters

    public const string TagActor        = "actor";         // #actor:Character:Name1:Name2:...:NameN   Character: nom du personnage    Name1: 1er surnom     Name2: 2ème surnom  ...  NameN: Nième surnom   
    
    public const string TagMove         = "move";           // #move:Character:X:Y:Speed?    Character: nom du personnage    X: position en X    Y: position en Y   Speed: (Optionnel) vitesse de déplacement (voir MovementSpeed region)
    public const string TagPlaySound    = "playsound";      // #playsound:Sound             Sound: son à jouer
    public const string TagAnim         = "anim";           // #anim:Character:Animation    Character: nom du personnage    Animation: animation à jouer
    public const string TagWait         = "wait";           // #wait:Time           Time: temps d'attente en secondes
    public const string TagSleep        = "sleep";          // #sleep:Time          Time: temps d'attente en secondes
    public const string TagBox          = "box";            // #box
    public const string TagScreenShake  = "screenshake";    // #screenshake:Intensity:Time  Intensity: Puissance du screenshake     Time: durée du screenshake en secondes
    public const string TagLook         = "look";           // #look:Character:Target       Character: nom du personnage    Target: cible vers laquelle se tourner
    
    
    // public const string TagCurtains     = "curtains";       // #curtains
    // public const string TagOpenCurtains = "open";           // #curtains
    // public const string TagCloseCurtains = "close";         // #curtains
    
    #endregion

    #region MovementSpeed

    public const string SlowName    = "slow";
    public const float  SlowSpeed   = 0.5f;
    public const string NormalName  = "walk";
    public const float  NormalSpeed = 2.0f;
    public const string QuickName   = "run";
    public const float  QuickSpeed  = 4.0f;

    #endregion

    #region Characters

    public const string PrompterName = "souffleur";

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

    #region Stage

    public const string FirstSetOnStage = "barge";

    #endregion

    #region Button types

    public const string TypeCharisma = "Charisma";
    public const string TypeStrength = "Strength";
    public const string TypeDexterity = "Dexterity";
    public const string TypeComposition = "Composition";
    public const string TypeLuck = "Luck";


    #endregion
}

