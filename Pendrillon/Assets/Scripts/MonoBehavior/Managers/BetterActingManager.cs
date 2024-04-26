using System.Collections;
using System.Collections.Generic;
using Ink.Runtime;
using UnityEngine;
using UnityEngine.Events;

public class BetterActingManager : MonoBehaviour
{
    #region Attributes
    public static BetterActingManager Instance { get; private set; }

    public TextAsset inkAsset;
    private Story _story;
    
    private string currentDialogue;


    #endregion

    #region Events
    public UnityEvent Begin;    // Wake up Acting Manager with the 
    public UnityEvent Continue; // 
    public UnityEvent End;      // 

    #endregion

    #region Unity API

    void Awake()
    {
        Begin.AddListener(BeginEventHandler);
    }

    void Start()
    {
        
    }
    
    #endregion

    #region Event Handlers

    void BeginEventHandler()
    {
        Debug.Log("Begin the acting phase");
        
        
        
    }


    #endregion











}
