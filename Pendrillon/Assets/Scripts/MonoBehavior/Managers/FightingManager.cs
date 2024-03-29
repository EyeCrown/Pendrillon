using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FightingManager : MonoBehaviour
{
    public static FightingManager Instance { get; private set; }

    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
            return;
        }

        Instance = this;
    }
    
}
