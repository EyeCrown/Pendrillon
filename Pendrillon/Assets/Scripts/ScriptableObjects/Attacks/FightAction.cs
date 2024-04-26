using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FightAction : ScriptableObject
{
    [Range(0, 100)] [SerializeField] public int successRate;

    [Range(1, 3)] [SerializeField] public int cost;
    
    [SerializeField] private string description;
    
    public virtual void Perform(){}

    public override string ToString()
    {
        return name + ": \n" +
               cost.ToString() +"PA  " + successRate.ToString() + "%\n" +
               description;
    }
}
