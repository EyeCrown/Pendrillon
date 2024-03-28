using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Dialogue", menuName = "Pendrillon/Events/Dialogue")]
public class DialogueEvent : TheaterEvent
{
    public List<Character> charactersOnStage;

    public List<String> lines;
    
    
    public override void Perform(ref GameManager gameManager)
    {
        
    }

    public override string ToString()
    {
        return "Dialogue";
    }
}
