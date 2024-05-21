
public static class Constants
{
    #region TAGS

    public const string Separator = ":";    // Separator between tags paramaters
    
    public const string TagMove = "move";           // #move:Character:X:Y          Character: nom du personnage    X: position en X    Y: position en Y
    public const string TagPlaySound = "playsound"; // #playsound:Sound             Sound: son à jouer
    public const string TagAnim = "anim";           // #anim:Character:Animation    Character: nom du personnage    Animation: animation à jouer
    public const string TagWait = "wait";           // #wait:Time           Time: temps d'attente en secondes
    public const string TagSleep = "sleep";         // #sleep:Time          Time: temps d'attente en secondes
    public const string TagBox = "box";             // #box
    

    #endregion

    #region SPEED

    public const string SlowName    = "slow";
    public const float  SlowSpeed   = 0.5f;
    public const string NormalName  = "walk";
    public const float  NormalSpeed = 2.0f;
    public const string QuickName   = "run";
    public const float  QuickSpeed  = 4.0f;

    #endregion

    #region CHARACTER



    #endregion


}

