using System;
using UnityEngine;

[CreateAssetMenu(fileName = "Event", menuName = "Pendrillon/Events/Default")]
public class TheaterEvent : ScriptableObject
{
    public virtual void Perform(ref GameManager gameManager){}

    public override String ToString()
    {
        return "Default Event";
    }

}
