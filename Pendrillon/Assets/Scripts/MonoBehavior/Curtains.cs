using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Curtains : MonoBehaviour
{
    #region Attributes

    private Animator _anim;

    private bool _isOpen;

    #endregion

    #region Events

    public UnityEvent<string> Call;

    #endregion

    #region UnityAPI

    void Awake()
    {
        _anim = GetComponent<Animator>();

        _isOpen = false;
        
        Call.AddListener(OnCall);
    }

    #endregion

    #region Methods

    void SetCurtains(bool state)
    {
        _isOpen = state;
        _anim.SetBool("curtainopen", _isOpen);
    }

    #endregion

    #region Event Handlers

    void OnCall(string stateText)
    {                
        //Debug.Log($"Curtains.OnCall > State [{stateText}]"); 
        
        bool state;
        switch (stateText)
        {
            case Constants.StateCurtainsOpen:   
                state = true;       break;
            case Constants.StateCurtainsClose:  
                state = false;      break;
            default: 
                Debug.LogError($"Curtains.OnCall > Error: invalid state [{stateText}]"); 
                return;
        }

        if (state == _isOpen)
            return;
        
        SetCurtains(state);
    }

    #endregion
    
}
