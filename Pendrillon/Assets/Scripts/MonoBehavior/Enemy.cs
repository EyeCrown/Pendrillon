using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    private bool canBeTargeted;
    [SerializeField] private Character _character;
    
    // Start is called before the first frame update
    void Start()
    {
        canBeTargeted = false;
        FightingManager.Instance.MustSelectTarget.AddListener(BecomeTargetable);
    }
    
    public void Initialize()
    {
        _character.Initialize();
    }
    
    void BecomeTargetable()
    {
        canBeTargeted = true;
        GetComponent<Renderer>().material.color = Color.red;
        
        Debug.Log(gameObject.name + " can be targeted");
    }
    
    void OnMouseDown(){
        if (canBeTargeted)
        {
            FightingManager.Instance.AddTargetableAction(this.gameObject);
            canBeTargeted = false;
            GetComponent<Renderer>().material.color = Color.white;

        }
    }
}
