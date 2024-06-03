using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wheel : MonoBehaviour
{
    #region Attributes

    private Animator _anim;

    [Range(0, 100)] public int _score;

    #endregion

    #region Unity API

    void Awake()
    {
    }

    private void OnEnable()
    {
        _anim = GetComponentInChildren<Animator>();
        Spin(_score);
    }

    #endregion

    #region Methods

    public void Spin(int score)
    {
        transform.rotation = Quaternion.Euler(score * 3.6f, 0, 0);
        StartCoroutine(SpinningCoroutine());
    }

    #endregion

    #region Coroutines

    IEnumerator SpinningCoroutine()
    {
        _anim.Play("Spin");
        // Start anim
        Debug.Log("Start anim");
        while ((_anim.GetCurrentAnimatorStateInfo(0).normalizedTime) % 1 < 0.99f)
            yield return null;
        Debug.Log("End anim");
        // Anim is over
    }

    #endregion
}
