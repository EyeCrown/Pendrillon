using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "TargetableAction", menuName = "Pendrillon/Fight Action/OnTargetAction")]
public class TargetableAction : FightAction
{
    public GameObject target;
    
    public override void Perform()
    {
        base.Perform();
        if (Random.Range(0, 100) < precison)
        {
            target.GetComponent<Enemy>().TakeDamageEvent.Invoke(damage);
            Debug.Log("Interact with " + target.name);
        }
    }
    
    public override string ToString()
    {
        return base.ToString(); // + "\nTarget: " + target.ToString() + "";
    }

    public void AssignTarget(GameObject targetToAssign)
    {
        target = targetToAssign;
    }
}
