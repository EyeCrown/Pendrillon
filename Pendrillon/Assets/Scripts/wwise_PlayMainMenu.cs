using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class wwise_PlayMainMenu : MonoBehaviour
{
    public void PlayMainButton()
    {
        AkSoundEngine.PostEvent("Play_UI_Combat_Hover", gameObject);
        AkSoundEngine.PostEvent("Break_AMB_SC_Theater_CrowdChatter", gameObject);

    }

    public void OtherMainButton()
    {
        AkSoundEngine.PostEvent("Play_UI_Combat_Hover", gameObject);
    }

}
