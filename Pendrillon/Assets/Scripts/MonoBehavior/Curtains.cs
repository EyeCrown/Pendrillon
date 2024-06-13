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

    public UnityEvent Call;

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

    void CloseCurtains()
    {
        _isOpen = true;
        _anim.SetBool("curtainopen", _isOpen);
    }

    #endregion

    #region Event Handlers

    void OnCall()
    {
        if (_isOpen)
            SetCurtains(false);
        else
            SetCurtains(true);
    }

    #endregion
    
}
