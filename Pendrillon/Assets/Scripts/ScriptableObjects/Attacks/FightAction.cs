using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FightAction : ScriptableObject
{
    [SerializeField] private CharacteristicType characteristic;
    [Range(0, 20)] [SerializeField] public int damage;
    [Range(0, 100)] [SerializeField] public int precison;

    [Range(1, 10)] [SerializeField] public int cost;
    
    [SerializeField] public string description;

    [SerializeField] public bool accesibleByDefault;
    [SerializeField] public FightAction dependence;
    [SerializeField] public bool usableOnce;
    public bool alreadyUse = false;


    public virtual void Perform()
    {
        alreadyUse = true;
    }

    public override string ToString()
    {
        return name + ": \n" +
               cost.ToString() +"PA  " + precison.ToString() + "%\n" +
               description;
    }
}
