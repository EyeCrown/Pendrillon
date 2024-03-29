using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public enum CharacteristicType
{
    ELOQUENCE,
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
    
    [HideInInspector]
    public int currValue;
    
    public Characteristic(CharacteristicType type, int baseValue)
        {
            this.type = type;
            this.baseValue = baseValue;
            this.currValue = baseValue;
        }
}

[CreateAssetMenu(fileName = "Character", menuName = "Pendrillon/Character")]
public class Character : ScriptableObject
{
    public new String name;
    
    public Characteristic eloquence     = new Characteristic(CharacteristicType.ELOQUENCE,      50);
    public Characteristic charisma      = new Characteristic(CharacteristicType.CHARISMA,       50);
    public Characteristic strength      = new Characteristic(CharacteristicType.STRENGTH,       50);
    public Characteristic dexterity     = new Characteristic(CharacteristicType.DEXTERITY,      50);
    public Characteristic constitution  = new Characteristic(CharacteristicType.CONSTITUTION,   50);
    public Characteristic luck          = new Characteristic(CharacteristicType.LUCK,           50);
    
    
}
