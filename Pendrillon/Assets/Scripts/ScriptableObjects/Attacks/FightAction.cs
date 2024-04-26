using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FightAction : ScriptableObject
{
    [Range(0, 100)] [SerializeField] private int successRate;

    [Range(1, 10)] [SerializeField] public int cost;
    
    [SerializeField] private string description;
    
    public virtual void Perform(){}

    public override string ToString()
    {
        return name + ": \n" +
               cost.ToString() +"PA  " + successRate.ToString() + "%\n" +
               description;
    }
}
