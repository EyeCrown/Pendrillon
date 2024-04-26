using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Sequence", menuName = "Pendrillon/Events/Sequence")]
public class SequenceEvent : TheaterEvent
{
    public List<TheaterEvent> eventList;

    public override void Perform(ref GameManager gameManager)
    {
        foreach (TheaterEvent theaterEvent in eventList)
        {
            Debug.Log(theaterEvent.name);            
        }
    }

    public override string ToString()
    {
        String text = "Sequence of events :\n";
        foreach (TheaterEvent theaterEvent in eventList)
        {
            text += theaterEvent.ToString() + "\n";            
        }
        return text;
    }
}
