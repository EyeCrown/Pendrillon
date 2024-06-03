using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class Wheel : MonoBehaviour
{
    #region Attributes

    #region Components
    private Animator _anim;
    #endregion
    

    [Range(0, 100)] public int _score;

    [Header("=== Positions ===")] 
    [SerializeField] private Vector3 _positionOutsideStage;
    [SerializeField] private Vector3 _positionOnStage;
    
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

    IEnumerator ArriveOnStage()
    {
        //TODO
        yield return null;
    }
    
    IEnumerator LeaveStage()
    {
        //TODO
        yield return null;
    }
    
    
    
    
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

    #region Gizmos

    private void OnDrawGizmosSelected()
    {
        
    }

    #endregion
}
