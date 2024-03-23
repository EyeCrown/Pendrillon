using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{

    // TODO: improve characteristics system
    //private Characteristics _characteristics;
    const int DEFAULT_VALUE = 1;
    public int _eloquence { get;  } = DEFAULT_VALUE; 
    public int _charisma { get;  } = DEFAULT_VALUE; 
    public int _strength { get;  } = DEFAULT_VALUE; 
    public int _dexterity { get;  } = DEFAULT_VALUE; 
    public int _luck { get;  } = DEFAULT_VALUE;

    
    void Start()
    {
        Debug.Log("Player::Start() > Debug");
    }

    void Update()
    {
        
    }
    
    
    
}
