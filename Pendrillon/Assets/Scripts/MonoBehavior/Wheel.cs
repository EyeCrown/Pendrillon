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
        StartCoroutine(LerpPositionCoroutine(_positionOnStage, Spin));
    }

    private void OnEnable()
    {
        _anim = GetComponentInChildren<Animator>();
        //Spin(_score);
    }

    #endregion

    #region Methods

    public void Spin()
    {
        transform.rotation = Quaternion.Euler(_score * 3.6f, 0, 0);
        StartCoroutine(SpinningCoroutine());
    }

    #endregion

    #region Coroutines

    IEnumerator LerpPositionCoroutine(Vector3 destination, Action callbackOnFinish = null, float duration = 4.0f)
    {
        float time = 0.0f;

        Vector3 start = transform.position;
        
        while (time < duration)
        {
            transform.position = Vector3.Lerp(start, destination, _movementCurve.Evaluate(time / duration));
            time += Time.deltaTime;
            yield return null;
        }

        callbackOnFinish();
    }
    
    IEnumerator SpinningCoroutine()
    {
        _anim.Play("Spin");
        // Start anim
        Debug.Log("Start anim");
        while ((_anim.GetCurrentAnimatorStateInfo(0).normalizedTime) % 1 < 0.99f)
            yield return null;
        Debug.Log("End anim");

        yield return new WaitForSeconds(2.0f);

        StartCoroutine(LerpPositionCoroutine(_positionOutsideStage));
    }

    #endregion

    /*#region Gizmos

    private void OnDrawGizmosSelected()
    {
        var position = new Vector3(transform.position.x, transform.position.y + _yOffset, transform.position.z);
        DrawWireCapsule(position, Quaternion.Euler(0, 0, 90), 1,1);
    }

    public static void DrawWireCapsule(Vector3 _pos, Quaternion _rot, float _radius, float _height, Color _color = default(Color))
    {
        if (_color != default(Color))
            Handles.color = _color;
        Matrix4x4 angleMatrix = Matrix4x4.TRS(_pos, _rot, Handles.matrix.lossyScale);
        using (new Handles.DrawingScope(angleMatrix))
        {
            var pointOffset = (_height - (_radius * 2)) / 2;
 
            //draw sideways
            Handles.DrawWireArc(Vector3.up * pointOffset, Vector3.left, Vector3.back, -180, _radius);
            Handles.DrawLine(new Vector3(0, pointOffset, -_radius), new Vector3(0, -pointOffset, -_radius));
            Handles.DrawLine(new Vector3(0, pointOffset, _radius), new Vector3(0, -pointOffset, _radius));
            Handles.DrawWireArc(Vector3.down * pointOffset, Vector3.left, Vector3.back, 180, _radius);
            //draw frontways
            Handles.DrawWireArc(Vector3.up * pointOffset, Vector3.back, Vector3.left, 180, _radius);
            Handles.DrawLine(new Vector3(-_radius, pointOffset, 0), new Vector3(-_radius, -pointOffset, 0));
            Handles.DrawLine(new Vector3(_radius, pointOffset, 0), new Vector3(_radius, -pointOffset, 0));
            Handles.DrawWireArc(Vector3.down * pointOffset, Vector3.back, Vector3.left, -180, _radius);
            //draw center
            Handles.DrawWireDisc(Vector3.up * pointOffset, Vector3.up, _radius);
            Handles.DrawWireDisc(Vector3.down * pointOffset, Vector3.up, _radius);
 
        }
    }

    
    #endregion*/
}
