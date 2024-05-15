using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "TargetableAction", menuName = "Pendrillon/Fight Action/OnTargetAction")]
public class TargetableAction : FightAction
{
    public Enemy target;
    
    public override void Perform()
    {
        base.Perform();
        if (Random.Range(0, 100) < precison)
        {
            Debug.Log("Interact with " + target.name);

            target.TakeDamageEvent.Invoke(damage);
        }
    }
    
    public override string ToString()
    {
        return base.ToString(); // + "\nTarget: " + target.ToString() + "";
    }

    public void AssignTarget(Enemy targetToAssign)
    {
        target = targetToAssign;
    }
}
