using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public enum CharacteristicType
{
    CHARISMA,
    STRENGTH,
    DEXTERITY,
    CONSTITUTION,
    LUCK,
}

[Serializable]
public struct Characteristic
{
    
    private CharacteristicType type;
    [Range(0, 100)]
    [SerializeField] private int baseValue;
    
    //[HideInInspector]
    public int currValue;
    
    public Characteristic(CharacteristicType type, int baseValue)
    {
        this.type = type;
        this.baseValue = baseValue;
        this.currValue = baseValue;
    }

    public override string ToString()
    {
        return type.ToString() + ": "+currValue.ToString();
    }

    public void Initialize()
    {
        currValue = baseValue;
    }
}

[CreateAssetMenu(fileName = "Character", menuName = "Pendrillon/Character")]
[Serializable]
public class Character : ScriptableObject
{
    public new String name;

    public int hp;
    public const int baseHp = 20;
    
    public Characteristic charisma      = new Characteristic(CharacteristicType.CHARISMA,       50);
    public Characteristic strength      = new Characteristic(CharacteristicType.STRENGTH,       50);
    public Characteristic dexterity     = new Characteristic(CharacteristicType.DEXTERITY,      50);
    public Characteristic constitution  = new Characteristic(CharacteristicType.CONSTITUTION,   50);
    public Characteristic luck          = new Characteristic(CharacteristicType.LUCK,           50);
    
    public AnimationCurve movementCurve = AnimationCurve.Linear(0.0f, 0.0f, 1.0f, 1.0f);


    public void Initialize()
    {
        hp = baseHp;
        
        charisma.Initialize();
        strength.Initialize();
        dexterity.Initialize();
        constitution.Initialize();
        luck.Initialize();
    }
    
    public override string ToString()
    {
        return name + ": \n" +
               hp.ToString() + "HP\n" +
               charisma.ToString() + " " + strength.ToString() + "\n" +
               dexterity.ToString() + " " + constitution.ToString() + "\n" +
               luck.ToString();
    }

    public void ModifyCharacteristic(CharacteristicType type, int val)
    {
        switch (type)
        {
            case CharacteristicType.CHARISMA:
                charisma.currValue += val;
                break;
            case CharacteristicType.STRENGTH:
                strength.currValue += val;
                break;
            case CharacteristicType.DEXTERITY:
                dexterity.currValue += val;
                break;
            case CharacteristicType.CONSTITUTION:
                constitution.currValue += val;
                break;
            case CharacteristicType.LUCK:
                luck.currValue += val;
                break;
        }
    }


    // public static Character CreateInstance(string name)
    // {
    //     var character = ScriptableObject.CreateInstance<Character>();
    //     return character;
    // }
}
