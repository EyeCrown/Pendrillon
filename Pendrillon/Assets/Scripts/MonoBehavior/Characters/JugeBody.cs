using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
using UnityEngine;

public class JugeBody : MonoBehaviour
{
    #region Methods

    public void RingBell()
    {
        ActingManager.Instance.RingBell.Invoke();
    }

    #endregion
}
