using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class FightActionButton : MonoBehaviour
{
    #region Attributes

    public FightAction _action;

    private Button _button;

    #endregion

    #region Events

    

    #endregion

    #region UnityAPI

    void Awake()
    {
        _button = GetComponent<Button>();
        _button.interactable = false;

        
        FightingManager.Instance.PlayerReadyToPlay.AddListener(OnPlayerReadyToPlay);
        FightingManager.Instance.AddFightAction.AddListener(OnAddFightAction);
        
    }

    #endregion

    #region Methods

    public void Initialize(FightAction action, Vector2 position)
    {
        _action = action;
        gameObject.name = _action.name + "Button";
        GetComponent<RectTransform>().position = position;
        GetComponentInChildren<TextMeshProUGUI>().text = action.ToString();
        
        _button.onClick.AddListener(delegate
        {
            FightingManager.Instance.AddFightAction.Invoke(_action);
        });
        
    }
    
    void BecomeAvailable()
    {
        Debug.Log($"{gameObject.name} > Button is available");

        _button.interactable = true;
    }

    void BecomeUnavailable()
    {
        _button.interactable = false;
    }


    void RefreshAvailability()
    {
        if (FightingManager.Instance._actionPoints < _action.cost)
        {
            Debug.Log($"{gameObject.name} > {FightingManager.Instance._actionPoints} < {_action.cost}");
            BecomeUnavailable();
            return;
        }
        
        BecomeAvailable();
    }

    #endregion

    #region EventHandlers

    void OnPlayerReadyToPlay()
    {
        if (_action.dependence == null)
            RefreshAvailability();
    }
    
    void OnAddFightAction(FightAction action)
    {
        Debug.Log($"{gameObject.name}.OnAddFightAction > {_action.dependence?.name} == {action.name}");
        if (_action.dependence == null || _action.dependence.name == action.name)
        {
            RefreshAvailability();
        }
    }
    

    #endregion
}
