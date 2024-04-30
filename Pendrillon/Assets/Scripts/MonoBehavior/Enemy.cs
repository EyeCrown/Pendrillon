using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

public class Enemy : MonoBehaviour
{
    private bool canBeTargeted;
    [SerializeField] public Character _character;

    public int hp;
    private TextMeshProUGUI hpText;

    [SerializeField] public int damage;
    
    public UnityEvent<int> TakeDamageEvent;
    public UnityEvent DieEvent;
    
    // Start is called before the first frame update
    void Start()
    {
        TakeDamageEvent.AddListener(TakeDamage);
        
        Initialize();
        hpText = GetComponentInChildren<TextMeshProUGUI>();
        hpText.text = hp + "HP";
        
        //Character.CreateInstance("Enemy");
        
        canBeTargeted = false;
        FightingManager.Instance.MustSelectTarget.AddListener(BecomeTargetable);
    }
    
    public void Initialize()
    {
        _character.Initialize();
        hp = 8;
    }
    
    void BecomeTargetable()
    {
        canBeTargeted = true;
        GetComponent<Renderer>().material.color = Color.red;
        
        Debug.Log(gameObject.name + " can be targeted");
    }

    public void TakeDamage(int damage)
    {
        hp -= damage;
        hpText.text = hp + "HP";
        if (hp <= 0)
        {
            FightingManager.Instance.RemoveEnemy(this);
            Destroy(gameObject);
        }
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
