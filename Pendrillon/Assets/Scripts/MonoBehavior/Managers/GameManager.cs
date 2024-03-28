using System;
using UnityEngine;
using TMPro;
using UnityEngine.InputSystem;

public enum GameState
{
    ACTING,
    FIGHTING,
    PAUSE,
    
}

public class GameManager : MonoBehaviour
{
   

    #region Attributes
    public static GameManager Instance { get; private set; }
    public ActingManager   ActingManager   { get; private set; }
    public FightingManager FightingManager { get; private set; }
    
    public GameState State { get; private set; }

    #endregion
    
    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
            return;
        }

        Instance = this;

        FightingManager = GetComponentInChildren<FightingManager>();
        ActingManager = GetComponentInChildren<ActingManager>();
    }
}
