using System;
using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
using UnityEditor;
using UnityEngine;

public class Wheel : MonoBehaviour
{
    #region Attributes

    #region Components
    private Animator _anim;
    #endregion

    public AnimationCurve _movementCurve;

    [Range(0, 100)] public int _score;

    [Header("=== Positions ===")] 
    [SerializeField] [Range(0, -10)] private float _yOffset;
    private Vector3 _positionOutsideStage;
    private Vector3 _positionOnStage;
    
    #endregion

    #region Unity API

    void Awake()
    {
        _positionOutsideStage = transform.position;
        _positionOnStage = new Vector3(transform.position.x, transform.position.y + _yOffset, transform.position.z);
    }
    
    void Start()
    {
        //StartCoroutine(LerpPositionCoroutine(_positionOnStage, Spin));
    }

    private void OnEnable()
    {
        _anim = GetComponentInChildren<Animator>();
        //Spin(_score);
    }

    #endregion

    #region Methods

    /*public void Spin()
    {
        transform.rotation = Quaternion.Euler(_score * 3.6f, 0, 0);
        StartCoroutine(SpinningCoroutine());
    }*/

    #endregion

    #region Coroutines

    public IEnumerator SpinningCoroutine(int score)
    {
        float duration = 1.4f, time = 0.0f;
        transform.rotation = Quaternion.Euler(score * -3.6f, 0, 0);
        _anim.Play("Spin");

        var startPos = _positionOutsideStage;
        var endPos = _positionOnStage;
        
        Debug.Log($"Wheel.SpinningCoroutine > Start rotate anim + move down");
        while (time < duration)
        {
            transform.position = Vector3.Lerp(_positionOutsideStage, _positionOnStage, 
                _movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        Debug.Log($"Wheel.SpinningCoroutine > Rotate anim is done + Is on stage");
        
        yield return new WaitForSeconds(1.5f);

        ActingManager.Instance._canContinueDialogue = true;

        time = 0.0f;
        while (time < duration)
        {
            transform.position = Vector3.Lerp(_positionOnStage,_positionOutsideStage, _movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
    }

    #endregion
}
