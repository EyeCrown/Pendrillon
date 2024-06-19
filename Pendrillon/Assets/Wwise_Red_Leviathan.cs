using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wwise_Red_Leviathan : MonoBehaviour
{
    void PlaySoundRedLeviathan()
    {
        AkSoundEngine.PostEvent("Play_RealLeviathan", gameObject);
    }

}
