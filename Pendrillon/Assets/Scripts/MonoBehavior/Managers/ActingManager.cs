using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActingManager : MonoBehaviour
{
    public static ActingManager Instance { get; private set; }

    public ActingManager()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
            return;
        }

        Instance = this;
    }
    
    
}
