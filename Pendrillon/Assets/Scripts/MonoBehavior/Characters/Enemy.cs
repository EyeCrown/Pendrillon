using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

public class Enemy : MonoBehaviour
{
    #region Attributes

    public Character _character;
    public int _baseHP;
    public int _hp;
    public int _damage;
    
    [SerializeField] private GameObject _uiFight;
    [SerializeField] private TextMeshProUGUI _hpText;
    private bool _canBeTargeted;
    
    #endregion

    #region Events

    public UnityEvent<int> TakeDamageEvent;
    public UnityEvent DieEvent;

    #endregion

    #region UnityAPI

    void Awake()
    {
        TakeDamageEvent.AddListener(OnTakeDamage);
        FightingManager.Instance.MustSelectTarget.AddListener(OnBecomeTargetable);
        FightingManager.Instance.ValidateTarget.AddListener(OnBecomeUntargetable);
        FightingManager.Instance.BeginFight.AddListener(OnBeginFight);

        _uiFight = transform.Find("Canvas/FightDataBox").gameObject;
        _hpText = _uiFight.GetComponentInChildren<TextMeshProUGUI>();
        _uiFight.SetActive(false);
    }
    
    void Start()
    {
        Initialize();
        _hpText.text = _hp + "HP";
        
        //Character.CreateInstance("Enemy");
        _canBeTargeted = false;
    }

    #endregion
    
    public void Initialize()
    {
        _character.Initialize();
        _hp = _baseHP;
    }
    
    public int GetDamage()
    {
        int whatAttack = Random.Range(0, 3);
        //Debug.Log($"Enemy.GetDamage > attack type: {whatAttack}");
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

    #region EventHandlers

    void OnBeginFight()
    {
        _uiFight.SetActive(true);
    }
    
    void OnBecomeTargetable()
    {
        _canBeTargeted = true;
        
        // Signs to indicate that target is now selectable 
        //GetComponent<Renderer>().material.color = Color.red;
        
        //Debug.Log(gameObject.name + " can be targeted");
    }
    void OnBecomeUntargetable(FightAction action)
    {
        _canBeTargeted = false;
        
        //GetComponent<Renderer>().material.color = Color.white;
        
        //Debug.Log(gameObject.name + " can be targeted");
    }

    public void OnTakeDamage(int damage)
    {
        _hp -= damage;
        if (_hp <= 0)
        {
            FightingManager.Instance.RemoveEnemy(this);
            Destroy(gameObject);
        }

        if (_hp > 8)
            _hp = 8;
        _hpText.text = _hp + "HP";
    }

    #endregion
    
    
    void OnMouseDown(){
        if (_canBeTargeted)
        {
            FightingManager.Instance.AddTargetableAction(this.gameObject);
            _canBeTargeted = false;
            GetComponent<Renderer>().material.color = Color.white;

        }
    }
}
