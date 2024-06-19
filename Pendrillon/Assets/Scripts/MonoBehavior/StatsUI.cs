using System;
using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;

public class StatsUI : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler
{
    #region Attributes
    
    #region Stats Text Attributes

    private TextMeshProUGUI _charisma;
    private TextMeshProUGUI _dexterity;
    private TextMeshProUGUI _strength;
    //private TextMeshProUGUI _composition;

    #endregion

    private Animator _anim;

    #endregion

    #region Events

    public UnityEvent DisplayStats;
    public UnityEvent HideStats;

    #endregion

    #region Unity API

    void Awake()
    {
        _anim = GetComponent<Animator>();
        
        DisplayStats.AddListener(OnDisplayStats);
        HideStats.AddListener(OnHideStats);
    }
    
    void Start()
    {
        ConnectAttributes();
        SetupStats();
        MakeObservables();

        _anim.SetBool("Accessible", false);
        
    }

    #endregion

    #region Methods
    
    #region Setup

    void ConnectAttributes()
    {
        _charisma   = transform.Find("Charisma/Text").GetComponent<TextMeshProUGUI>();
        _dexterity  = transform.Find("Dexterity/Text").GetComponent<TextMeshProUGUI>();
        _strength   = transform.Find("Strength/Text").GetComponent<TextMeshProUGUI>();
    }
    
    void SetupStats()
    {
        _charisma.text      = GameManager.Instance._story.variablesState["p_char"].ToString();
        _dexterity.text     = GameManager.Instance._story.variablesState["p_dext"].ToString();
        _strength.text      = GameManager.Instance._story.variablesState["p_stre"].ToString();
    }

    #endregion

    
    
    #region Observables

    void MakeObservables()
    {
        GameManager.Instance._story.ObserveVariable ("p_char", (string varName, object newValue) => {
            UpdateCharisma((int)newValue); });
        GameManager.Instance._story.ObserveVariable ("p_stre", (string varName, object newValue) => {
            UpdateStrength((int)newValue); });
        GameManager.Instance._story.ObserveVariable ("p_dext", (string varName, object newValue) => {
            UpdateDexterity((int)newValue); });
    }

    void UpdateCharisma(int newValue)
    {
        Debug.Log("Charisma +1");
        
        //gameObject.SetActive(true);

        StartCoroutine(CharismaLevelUpCoroutine(newValue));
    }
    void UpdateDexterity(int newValue)
    { 
        Debug.Log("Dexterity +1");
        
        //gameObject.SetActive(true);

        StartCoroutine(DexterityLevelUpCoroutine(newValue));

    }
    void UpdateStrength(int newValue)
    {
        Debug.Log("Strength +1");
        
        //gameObject.SetActive(true);

        StartCoroutine(StrengthLevelUpCoroutine(newValue));

    }

    #endregion

    
    #endregion

    #region Event Handlers

    void OnDisplayStats()
    {
        _anim.SetBool("Accessible", true);
        
        //gameObject.SetActive(true);
    }

    void OnHideStats()
    {
        _anim.SetBool("Accessible", false);

        //gameObject.SetActive(false);
    }
    
    #endregion
    
    #region Mouse Events

    public void OnPointerEnter(PointerEventData eventData)
    {
        _anim.SetBool("InOut", true);
        AkSoundEngine.PostEvent("Play_UI_HUD_ChoiceBubble_Appears", gameObject);
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        _anim.SetBool("InOut", false);
    }

    #endregion

    #region Coroutines

    IEnumerator StrengthLevelUpCoroutine(int newValue)
    {
        var animName = "LvlUp"+"Strength";
        _anim.SetTrigger(animName);
        AkSoundEngine.PostEvent("Play_UI_HUD_LevelUp", gameObject);

        while (!_anim.GetCurrentAnimatorStateInfo(0).IsName(animName))
            yield return null;
        
        while ((_anim.GetCurrentAnimatorStateInfo(0).normalizedTime) % 1 < 0.75f)
            yield return null;
        
        _strength.text = newValue.ToString();
        
    }
    
    IEnumerator DexterityLevelUpCoroutine(int newValue)
    {
        var animName = "LvlUp"+"Dexterity";
        _anim.SetTrigger(animName);
        AkSoundEngine.PostEvent("Play_UI_HUD_LevelUp", gameObject);

        Debug.Log("Start lvl up");
        while (!_anim.GetCurrentAnimatorStateInfo(0).IsName(animName))
            yield return null;
        Debug.Log("Start Anim lvl up");

        while ((_anim.GetCurrentAnimatorStateInfo(0).normalizedTime) % 1 < 0.75f)
            yield return null;
        Debug.Log("Change lvl value");

        _dexterity.text = newValue.ToString();
        
        Debug.Log("End lvl up");

    }
    
    IEnumerator CharismaLevelUpCoroutine(int newValue)
    {
        var animName = "LvlUp"+"Charisma";
        _anim.SetTrigger(animName);
        AkSoundEngine.PostEvent("Play_UI_HUD_LevelUp", gameObject);

        while (!_anim.GetCurrentAnimatorStateInfo(0).IsName(animName))
            yield return null;
        
        Debug.Log($"Before {_charisma.text}");
        while ((_anim.GetCurrentAnimatorStateInfo(0).normalizedTime) % 1 < 0.75f)
            yield return null;
        _charisma.text = newValue.ToString();
        Debug.Log($"Now {_charisma.text}");

    }

    #endregion
}
