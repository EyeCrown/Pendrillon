public struct Characteristics
{
    enum CharacName
    {
        ELOQ,
        CHAR,
        STRG,
        DEXT,
        LUCK
    }
    public Characteristics(int eloquence, int charisma, int strength, int dexterity, int luck)
    {
        Eloquence = eloquence;
        Charisma = charisma;
        Strength = strength;
        Dexterity = dexterity;
        Luck = luck;
    }

    public int Eloquence { get;  }
    public int Charisma { get;  }
    public int Strength { get;  }
    public int Dexterity { get;  }
    public int Luck { get;  }
    
    
    
}
