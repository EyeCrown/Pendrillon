using System;
using UnityEngine;
using Ink.Runtime;
[CreateAssetMenu(fileName = "Event", menuName = "Pendrillon/Events/Default")]
public class TheaterEvent : ScriptableObject
{
    public virtual void Perform(ref GameManager gameManager){}

    public override String ToString()
    {
        return "Default Event";
    }

}
