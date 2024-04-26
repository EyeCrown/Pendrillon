using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

[CreateAssetMenu(fileName = "Hit", menuName = "Pendrillon/Attacks/Hit")]
public class HitEnemy : FightAction
{
    [Range(0, 100)]
    public int damage;
    
    public override void Perform()
    {
        Debug.Log("Must hit enemy");
    }

    public override string ToString()
    {
        return base.ToString() + "\nHit Enemy: deals " + damage.ToString() +" damage";
    }
}
