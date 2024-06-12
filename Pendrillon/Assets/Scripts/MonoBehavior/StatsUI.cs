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
        
        HideStats.Invoke();
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
        _dexterity.text     = GameManager.Instance._story.variablesState["p_stre"].ToString();
        _strength.text      = GameManager.Instance._story.variablesState["p_dext"].ToString();
        //_composition.text   = "CST > " + GameManager.Instance._story.variablesState["p_comp"];
    }

    #endregion
    
    #region Observables

    void MakeObservables()
    {
        GameManager.Instance._story.ObserveVariable ("p_char", (string varName, object newValue) => {
            UpdateCharisma((int)newValue); });
        GameManager.Instance._story.ObserveVariable ("p_stre", (string varName, object newValue) => {
            UpdateDexterity((int)newValue); });
        GameManager.Instance._story.ObserveVariable ("p_dext", (string varName, object newValue) => {
            UpdateStrength((int)newValue); });
        // GameManager.Instance._story.ObserveVariable ("p_comp", (string varName, object newValue) => {
        //     UpdateComposition((int)newValue); });
        
    }
    void UpdateCharisma(int newValue)    => _charisma.text      = "CHR > " + newValue;
    void UpdateDexterity(int newValue)   => _dexterity.text     = "DXT > " + newValue;
    void UpdateStrength(int newValue)    => _strength.text      = "FRC > " + newValue;
    //void UpdateComposition(int newValue) => _composition.text   = "CST > " + newValue;

    #endregion

    #endregion

    #region Event Handlers

    void OnDisplayStats()
    {
        gameObject.SetActive(true);
    }

    void OnHideStats()
    {
        gameObject.SetActive(false);
    }
    
    #endregion
    
    #region Mouse Events

    public void OnPointerEnter(PointerEventData eventData)
    {
        _anim.SetBool("InOut", true);
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        _anim.SetBool("InOut", false);
    }

    #endregion
}
