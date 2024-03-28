using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum CharacteristicType
{
    ELOQUENCE,
    CHARISMA,
    STRENGHT,
    DEXTERITY,
    CONSTITUTION,
    LUCK,
}

[Serializable]
public struct Characteristic
{
    
    public CharacteristicType type;
    public readonly int baseValue;
    public int currValue;
    
    public Characteristic(CharacteristicType type, int baseValue, int currValue)
        {
            this.type = type;
            this.baseValue = baseValue;
            this.currValue = currValue;
        }
}

[CreateAssetMenu(fileName = "Character", menuName = "Pendrillon/Character")]
public class Character : ScriptableObject
{
    public new String name;

    public List<Characteristic> _characteristics;
    
    
}
