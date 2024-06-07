using System;
using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
using TMPro;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

public class Wheel : MonoBehaviour
{
    #region Attributes

    #region Components
    private Animator _anim;
    #endregion

    #region UI Attributes

    public GameObject _uiBox;
    private TextMeshProUGUI _resultText;
    private TextMeshProUGUI _mustObtainText;
    private TextMeshProUGUI _maxText;
    private TextMeshProUGUI _typeText;
    private TextMeshProUGUI _levelUpText;

    #endregion
    
    
    private GameObject _wheel;
    private GameObject _resultBox;
    
    
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
        _uiBox = GameObject.Find("Canvas/ACTING_PART/SkillcheckBox").gameObject;
        _resultText     = _uiBox.transform.Find("ResultText").GetComponent<TextMeshProUGUI>();
        _mustObtainText = _uiBox.transform.Find("MustObtainText").GetComponent<TextMeshProUGUI>();
        _maxText        = _uiBox.transform.Find("MaxText").GetComponent<TextMeshProUGUI>();
        _typeText       = _uiBox.transform.Find("TypeText").GetComponent<TextMeshProUGUI>();
        _levelUpText    = _uiBox.transform.Find("LevelUpText").GetComponent<TextMeshProUGUI>();
        
        _resultBox = _uiBox.transform.Find("ResultColor").gameObject;
        
        _wheel = transform.Find("Wheel").gameObject;
        
        _positionOutsideStage = transform.position;
        _positionOnStage = new Vector3(transform.position.x, transform.position.y + _yOffset, transform.position.z);
    }
    
    void Start()
    {
        _uiBox.SetActive(false);
    }

    private void OnEnable()
    {
        _anim = GetComponentInChildren<Animator>();
    }

    #endregion

    #region Methods

    /*public void Spin()
    {
        transform.rotation = Quaternion.Euler(_score * 3.6f, 0, 0);
        StartCoroutine(SpinningCoroutine());
    }*/

    void UpdateText(int score, int mustObtain, string type)
    {
        SetUIBox(type);
        
        _resultText.text = score.ToString();
        _mustObtainText.text = mustObtain.ToString();
        _typeText.text = "";
        _levelUpText.text = type + " > +1";

        if (score <= mustObtain)
        {
            _resultBox.GetComponent<Image>().color = Color.green;
        }
        else
        {
            _resultBox.GetComponent<Image>().color = Color.red;
        }
    }


    void SetUIBox(string typeName)
    {
        Sprite sprite;
        foreach (var type in Constants.ButtonTypesArray)
        {
            if (type == typeName)
            {
                sprite = Resources.Load <Sprite>($"SkillcheckUI/{typeName}");
                _uiBox.GetComponent<Image>().sprite = sprite;
                return;
            }
        }
        sprite = Resources.Load <Sprite>($"SkillcheckUI/Neutral");
        _uiBox.GetComponent<Image>().sprite = sprite;
    }
    
    #endregion

    #region Coroutines

    public IEnumerator SpinningCoroutine(int score, int mustObtain, string type)
    {
        UpdateText(score, mustObtain, type);
        
        float duration = 1.4f, time = 0.0f;
        
        _wheel.transform.rotation = Quaternion.Euler(score * -3.6f, 0, 0);
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

        StartCoroutine(DisplayScore());
        yield return new WaitForSeconds(1.0f);

        ActingManager.Instance._canContinueDialogue = true;

        time = 0.0f;
        while (time < duration)
        {
            transform.position = Vector3.Lerp(_positionOnStage,_positionOutsideStage, 
                _movementCurve.Evaluate(time / duration));
            time += Time.deltaTime;
            yield return null;
        }
    }


    IEnumerator DisplayScore()
    {
        float time = 0.0f, duration = 0.5f;
        _uiBox.SetActive(true);
        // Scale from 0 to 1
        while (time < duration)
        {
            var size = time / duration;
            _uiBox.transform.localScale = new Vector3(size, size, size);
            time += Time.deltaTime;
            yield return null;
        }
        
        // Wait X.x seconds
        yield return new WaitForSeconds(1.0f);
        
        // Scale from 1 to 0
        time = 0.0f;
        while (time < duration)
        {
            var size = 1 - time / duration;
            _uiBox.transform.localScale = new Vector3(size, size, size);
            time += Time.deltaTime;
            yield return null;
        }
        _uiBox.SetActive(false);
    }

    #endregion
}
