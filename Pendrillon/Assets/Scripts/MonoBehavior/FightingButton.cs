using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
using UnityEngine;
using UnityEngine.UI;

public class FightingButton : MonoBehaviour
{
    #region Attributes

    public FightAction action;

    private Button _button;

    #endregion

    #region Events

    

    #endregion

    #region UnityAPI

    void Awake()
    {
        FightingManager.Instance.BeginPlayerTurn.AddListener(OnBeginPlayerTurn);
        
        _button = GetComponent<Button>();
        _button.onClick.AddListener(delegate
        {
            // TODO: Complete this
        });
    }
    
    void Start()
    {
        _button.interactable = false;
    }
    

    #endregion

    #region Methods

    
    
    void BecomeAvailable()
    {
        _button.interactable = true;
    }

    #endregion

    #region EventHandlers

    void OnBeginPlayerTurn()
    {
        if (FightingManager.Instance._actionPoints >= action.cost)
            BecomeAvailable();
    }
    

    #endregion
}
