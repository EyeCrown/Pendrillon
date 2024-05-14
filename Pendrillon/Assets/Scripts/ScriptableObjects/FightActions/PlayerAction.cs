using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
using UnityEngine;

[CreateAssetMenu(fileName = "OnPlayerAction", menuName = "Pendrillon/Fight Action/OnPlayerAction")]
public class PlayerAction : FightAction
{
    [Range(0, 100)]
    public int value;

    public CharacteristicType type;
    
    public override void Perform()
    {
        base.Perform();
        if (Random.Range(0, 100) < precison)
        {
            FightingManager.Instance._player._character.ModifyCharacteristic(type, value);
            Debug.Log("Modifying "+ type.ToString() + " with " + value.ToString());
        }
    }
    
    public override string ToString()
    {
        return base.ToString() + "\n" + type.ToString() +" : increase with " + value.ToString();
    }
}
