using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class wwiseCharacterPlaySound : MonoBehaviour
{

    [SerializeField] private AK.Wwise.Event neutre;
    [SerializeField] private AK.Wwise.Event joie;
    [SerializeField] private AK.Wwise.Event colere;
    [SerializeField] private AK.Wwise.Event triste;
    [SerializeField] private AK.Wwise.Event stress;
    [SerializeField] private AK.Wwise.Event deception;
    [SerializeField] private AK.Wwise.Event surprise;

    // Start is called before the first frame update
    void EmoNeutre()
    {
        neutre.Post(gameObject);
    }

    // Update is called once per frame
    void EmoJoie()
    {
        joie.Post(gameObject);
    }

    void EmoColere()
    {
        colere.Post(gameObject);
    }

    void EmoTriste()
    {
        triste.Post(gameObject);
    }

    void EmoStress()
    {
        stress.Post(gameObject);
    }

    void EmoDeception()
    {
        deception.Post(gameObject);
    }

    void EmoSurprise()
    {
        surprise.Post(gameObject);
    }

}
