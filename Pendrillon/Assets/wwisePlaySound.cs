using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class wwisePlaySound : MonoBehaviour
{
   [SerializeField] private AK.Wwise.Event WwiseSound;

    public void PlaySound()
    {
        WwiseSound.Post(gameObject);
    }

    

}
