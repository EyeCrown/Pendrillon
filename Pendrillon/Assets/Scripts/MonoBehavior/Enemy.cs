using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
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
        FightingManager.Instance.ValidateTarget.AddListener(BecomeUntargetable);
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
    void BecomeUntargetable(FightAction action)
    {
        canBeTargeted = false;
        GetComponent<Renderer>().material.color = Color.white;
        
        Debug.Log(gameObject.name + " can be targeted");
    }

    public void TakeDamage(int damage)
    {
        hp -= damage;
        if (hp <= 0)
        {
            FightingManager.Instance.RemoveEnemy(this);
            Destroy(gameObject);
        }

        if (hp > 8)
            hp = 8;
        hpText.text = hp + "HP";

    }

    public int GetDamage()
    {
        int whatAttack = Random.Range(0, 3);
        Debug.Log($"Enemy.GetDamage > attack type: {whatAttack}");
        int damageAttack = 0;
        switch (whatAttack)
        {
            case 0:
                if (Random.Range(0, 10) < 9)
                    damageAttack = 1;
                break;
            case 1:
                if (Random.Range(0, 10) < 7)
                    damageAttack = 2;
                break;
            case 2:
                damageAttack = 0;
                if (Random.Range(0, 10) < 6)
                    TakeDamageEvent.Invoke(-4);
                break;
        }

        return damageAttack;
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
