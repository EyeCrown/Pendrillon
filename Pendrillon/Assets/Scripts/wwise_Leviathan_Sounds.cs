using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class wwise_Leviathan_Sounds : MonoBehaviour
{
    // Start is called before the first frame update
    void PlaySoundAttackJaw()
    {
        AkSoundEngine.PostEvent("Play_SFX_NPC_Leviathan_AttackJaw", gameObject);
    }

    void PlaySoundScream()
    {
        AkSoundEngine.PostEvent("Play_SFX_NPC_Leviathan_Scream", gameObject);
    }

    void PlaySoundBoatHit()
    {
        AkSoundEngine.PostEvent("Play_SFX_Boat_Hit", gameObject);
    }

    void PlaySoundAttackTail()
    {
        AkSoundEngine.PostEvent("Play_SFX_NPC_Leviathan_AttackTail", gameObject);
    }

    void PlaySoundHurt()
    {
        AkSoundEngine.PostEvent("Play_SFX_NPC_Leviathan_Hurt", gameObject);
    }


    void PlaySoundTurnStart()
    {
        AkSoundEngine.PostEvent("Play_SFX_NPC_Leviathan_TurnStart", gameObject);
    }

    void PlaySoundUnderwater()
    {
        AkSoundEngine.PostEvent("Play_SFX_NPC_Leviathan_Underwater", gameObject);
    }

    void PlaySoundDefeated()
    {
        AkSoundEngine.PostEvent("Play_SFX_NPC_Leviathan_Defeated", gameObject);
    }

    void PlaySoundSpawn()
    {
        AkSoundEngine.PostEvent("Play_SFX_NPC_Leviathan_Spawn", gameObject);
    }
    
}
