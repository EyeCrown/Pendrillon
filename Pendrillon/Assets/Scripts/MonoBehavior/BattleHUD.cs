using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BattleHUD : MonoBehaviour
{
    #region Attributes

    private Animator _anim; 
    
    private GameObject _actionPointsPanel;


    #endregion

    #region Unity API

    void Awake()
    {
        ConnectAttributes();
    }

    #endregion


    #region Methods

    #region Setup

    void ConnectAttributes()
    {
        _anim = GetComponent<Animator>();
    }

    #endregion

    #endregion
    
}
