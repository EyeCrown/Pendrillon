using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Map : MonoBehaviour
{
    #region Attributes

    private GameObject _cursor;
    private GameObject _light;

    [Header("=== Places ===")] 
    [SerializeField] private Vector3 _placeMiraterre;
    [SerializeField] private Vector3 _placeLeviathan;
    
    [Header("=== Positions ===")] 
    [SerializeField] [Range(0, -10)] private float _yOffset;
    private Vector3 _positionOutsideStage;
    private Vector3 _positionOnStage;

    [Header("=== Movement Curves ===")] 
    [SerializeField] private AnimationCurve _arrivingCurve;
    [SerializeField] private AnimationCurve _leavingCurve;
    [SerializeField] private AnimationCurve _cursorCurve;
    public float multiplier;
    
    #endregion

    #region Unity API

    void Awake()
    {
        _cursor = transform.Find("Cursor").gameObject;
        _light = transform.Find("Area Light").gameObject;
        
        _positionOutsideStage = transform.position;
        _positionOnStage = new Vector3(transform.position.x, transform.position.y + _yOffset, transform.position.z);
    }

    void Start()
    {
        //StartCoroutine(MoveCursor(_place1, _place2));
        _light.SetActive(false);
        _cursor.transform.localPosition = _placeMiraterre;
    }
    
    #endregion

    #region Methods

    public void DisplayTravel(string travel)
    {                
        Debug.Log($"Map.DisplayTravel > Travel: {travel}");

        switch (travel)
        {
            case Constants.MapTravelDeparture:
                StartCoroutine(MoveCursor(_placeMiraterre, _placeLeviathan));
                break;
            case Constants.MapTravelArrival:
                StartCoroutine(MoveCursor(_placeLeviathan, _placeMiraterre));
                break;
            case Constants.MapDisplay:
                StartCoroutine(ArriveOnStage());
                break;
            case Constants.MapLeave:
                StartCoroutine(LeaveStage());
                break;
            default:
                Debug.LogError($"Map.DisplayTravel > Error: unknown travel name: {travel}");
                break;
        }
        
        
    }

    #endregion
    

    #region Coroutines

    IEnumerator ArriveOnStage()
    {
        Debug.Log("Map.ArriveOnStage > Start arriving");
        float time = 0.0f, duration = 2.5f;

        while (time < duration)
        {
            transform.position = Vector3.Lerp(_positionOutsideStage, _positionOnStage, 
                _arrivingCurve.Evaluate(time / duration));
            time += Time.deltaTime;
            yield return null;
        }
    }
    
    IEnumerator LeaveStage()
    {
        float time = 0.0f, duration = 1.4f;

        while (time < duration)
        {
            transform.position = Vector3.Lerp(_positionOnStage,_positionOutsideStage, 
                _leavingCurve.Evaluate(time / duration));
            time += Time.deltaTime;
            yield return null;
        }
    }
    
    IEnumerator MoveCursor(Vector3 startPos, Vector3 endPos)
    {
        _light.SetActive(true);
        float time = 0.0f, duration = 2.0f;

        if (startPos.z > endPos.z)
        {
            _cursor.transform.localScale = new Vector3(0.015f, 0.015f, 0.015f);
            _cursor.transform.rotation = Quaternion.Euler(0, 0,0);
        }
        else
        {
            _cursor.transform.localScale = new Vector3(-0.015f, -0.015f, -0.015f);
            _cursor.transform.rotation = Quaternion.Euler(0, 0,180);
        }

        while (time < duration)
        {
            _cursor.transform.localPosition = Vector3.Lerp(startPos, endPos, 
                _cursorCurve.Evaluate(time / duration));
            _cursor.transform.localPosition = 
                new Vector3(0.105f, _cursor.transform.localPosition.y, _cursor.transform.localPosition.z);
            time += Time.deltaTime;
            yield return null;
        }
        
        _light.SetActive(false);
    }


    #endregion

    #region Gizmos

    private void OnDrawGizmosSelected()
    {
        
        Color _colorMiraterre = Color.green;
        Color _colorLeviathan = Color.red;
        
        Gizmos.color = _colorMiraterre;
        Gizmos.DrawLine(transform.localPosition + _placeMiraterre, transform.localPosition + _placeMiraterre + Vector3.right);
        Gizmos.color = _colorLeviathan;
        Gizmos.DrawLine(transform.position + _placeLeviathan, transform.position + _placeLeviathan + Vector3.right);
        
    }

    #endregion
}
