using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

[CreateAssetMenu(fileName = "Hit", menuName = "Pendrillon/Attacks/Hit")]
public class HitEnemy : TargetableAction
{
    [Range(0, 100)]
    public new int damage;
    
    public override void Perform()
    {
        target.GetComponent<Enemy>().TakeDamageEvent.Invoke(damage);
        Debug.Log($"Deals {damage} damage to {target.name}");
    }

    public override string ToString()
    {
        return base.ToString() + "\nHit Enemy: deals " + damage.ToString() +" damage";
    }
}
