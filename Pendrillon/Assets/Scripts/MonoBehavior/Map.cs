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
    [SerializeField] private Vector3 _place1;
    [SerializeField] private Vector3 _place2;
    [SerializeField] private Vector3 _place3;
    [SerializeField] private Vector3 _place4;
    
    [Header("=== Positions ===")] 
    [SerializeField] [Range(0, -10)] private float _yOffset;
    private Vector3 _positionOutsideStage;
    private Vector3 _positionOnStage;
    
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
        _cursor.transform.position = _place1;
    }
    
    #endregion

    #region Methods

    public void DisplayTravel(string travel)
    {                
        Debug.Log($"Map.DisplayTravel > Travel: {travel}");

        switch (travel)
        {
            case Constants.TravelTMP1:
                StartCoroutine(ArriveOnStage(MoveCursor(_place1, _place2)));
                break;
            case Constants.TravelTMP2:
                StartCoroutine(ArriveOnStage(MoveCursor(_place2, _place1)));
                break;
            default:
                Debug.LogError($"Map.DisplayTravel > Error: unknown travel name: {travel}");
                break;
        }
        
        
    }

    #endregion
    

    #region Coroutines

    IEnumerator ArriveOnStage(IEnumerator coroutine)
    {
        Debug.Log("Map.ArriveOnStage > Start arriving");
        float time = 0.0f, duration = 1.4f;

        while (time < duration)
        {
            transform.position = Vector3.Lerp(_positionOutsideStage, _positionOnStage, time / duration);
            time += Time.deltaTime;
            yield return null;
        }

        StartCoroutine(coroutine);
    }
    
    IEnumerator LeaveStage()
    {
        float time = 0.0f, duration = 1.4f;

        while (time < duration)
        {
            transform.position = Vector3.Lerp(_positionOnStage,_positionOutsideStage, time / duration);
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
            _cursor.transform.localPosition = Vector3.Lerp(startPos, endPos, time / duration);
            _cursor.transform.localPosition = 
                new Vector3(0.105f, _cursor.transform.localPosition.y, _cursor.transform.localPosition.z);
            time += Time.deltaTime;
            yield return null;
        }
        
        _light.SetActive(false);
        StartCoroutine(LeaveStage());
    }


    #endregion

    #region Gizmos

    private void OnDrawGizmosSelected()
    {
        
        Color _color1 = Color.green;
        Color _color2 = Color.red;
        Color _color3 = Color.blue;
        Color _color4 = Color.yellow;
        
        Gizmos.color = _color1;
        Gizmos.DrawLine(transform.localPosition + _place1, transform.localPosition + _place1 + Vector3.right);
        Gizmos.color = _color2;
        Gizmos.DrawLine(transform.position + _place2, transform.position + _place2 + Vector3.right);
        Gizmos.color = _color3;
        Gizmos.DrawLine(transform.position + _place3, transform.position + _place3 + Vector3.right);
        Gizmos.color = _color4;
        Gizmos.DrawLine(transform.position + _place4, transform.position + _place4 + Vector3.right);
        
    }

    #endregion
}
