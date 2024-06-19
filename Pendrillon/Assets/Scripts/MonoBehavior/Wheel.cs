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
    
    private GameObject _axle;
    private GameObject _wheel;
    private GameObject _resultBox;

    private Light _light;

    private IEnumerator _spinCoroutine;
    
    public bool _onStage;
    
    public AnimationCurve _movementCurve;

    private Color _successColor = new Color(0.76f, 0.77f, 0.31f);
    private Color _failColor = new Color(0.8f, 0.27f, 0.27f);

    [Header("=== Positions ===")] 
    [SerializeField] [Range(0, -10)] private float _yOffset;
    private Vector3 _positionOutsideStage;
    private Vector3 _positionOnStage;

    [Header("=== Light Colors ===")] 
    [SerializeField] private Color _colorLightCharisma;
    [SerializeField] private Color _colorLightStrength;
    [SerializeField] private Color _colorLightDexterity;
    [SerializeField] private Color _colorLightNeutral;
    
    #endregion

    #region Unity API

    void Awake()
    {
        _uiBox = GameObject.Find("Canvas/ACTING_PART/SkillcheckBox").gameObject;
        _resultText     = _uiBox.transform.Find("ResultText").GetComponent<TextMeshProUGUI>();
        _mustObtainText = _uiBox.transform.Find("MustObtainText").GetComponent<TextMeshProUGUI>();
        _maxText        = _uiBox.transform.Find("MaxText").GetComponent<TextMeshProUGUI>();
        _typeText       = _uiBox.transform.Find("TypeText").GetComponent<TextMeshProUGUI>();
        //_levelUpText    = _uiBox.transform.Find("LevelUpText").GetComponent<TextMeshProUGUI>();
        
        _resultBox = _uiBox.transform.Find("ResultColor").gameObject;
        
        _axle = transform.Find("Axle").gameObject;
        _wheel = _axle.transform.Find("Wheel").gameObject;
        _anim = _wheel.GetComponent<Animator>();
        
        _light = transform.Find("Area Light").GetComponent<Light>();
        
        _positionOutsideStage = transform.position;
        _positionOnStage = new Vector3(transform.position.x, transform.position.y + _yOffset, transform.position.z);
    }
    
    void Start()
    {
        _uiBox.SetActive(false);
        _onStage = false;
        _light.gameObject.SetActive(false);
    }


    #endregion

    #region Methods

    public void Spin(int score, int mustObtain, string type, Action handleDialogueText = null)
    {
        _spinCoroutine = SpinningCoroutine(score, mustObtain, type, handleDialogueText);
        StartCoroutine(_spinCoroutine);
        AkSoundEngine.PostEvent("Play_UI_HUD_SkillCheck_Roll", gameObject);

    }

    void UpdateText(int score, int mustObtain, string type)
    {
        SetUIBox(type);
        _light.color = GetColorByType(type);
        
        _resultText.text = score.ToString();
        _mustObtainText.text = mustObtain.ToString();
        
        //_levelUpText.text = "";

        if (score <= mustObtain)
        {
            _resultBox.GetComponent<Image>().color = _successColor;
            AkSoundEngine.PostEvent("Play_UI_HUD_SkillCheck_Success", gameObject);
        }
        else
        {
            _resultBox.GetComponent<Image>().color = _failColor;
            AkSoundEngine.PostEvent("Play_UI_HUD_SkillCheck_Failed", gameObject);
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
                _typeText.text = Constants.TranslateType(type);
                
                return;
            }
        }
        sprite = Resources.Load <Sprite>($"SkillcheckUI/Neutral");
        _uiBox.GetComponent<Image>().sprite = sprite;
    }

    Color GetColorByType(string typeName)
    {
        switch (typeName)
        {
            case Constants.TypeCharisma:
                return _colorLightCharisma;
            case Constants.TypeStrength:
                return _colorLightStrength;
            case Constants.TypeDexterity:
                return _colorLightDexterity;
        }

        return _colorLightNeutral;
    }
    
    #endregion

    #region Coroutines

    public IEnumerator SpinningCoroutine(int score, int mustObtain, string type, Action handleDialogueText = null)
    {
        // UpdateText(score, mustObtain, type);
        
        float duration = 1.4f, time = 0.0f;
        
        _axle.transform.rotation = Quaternion.Euler(score * -3.6f, 0, 0);
        _anim.Play("Spin");
        _light.gameObject.SetActive(true);
        
        var startPos = _positionOutsideStage;
        var endPos = _positionOnStage;
        
        //Debug.Log($"Wheel.SpinningCoroutine > Start rotate anim + move down");
        while (time < duration)
        {
            transform.position = Vector3.Lerp(_positionOutsideStage, _positionOnStage, 
                _movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        //Debug.Log($"Wheel.SpinningCoroutine > Rotate anim is done + Is on stage");
        UpdateText(score, mustObtain, type);

        StartCoroutine(DisplayScoreCoroutine(handleDialogueText));
    }


    IEnumerator DisplayScoreCoroutine(Action handleDialogueText = null)
    {
        float time = 0.0f, duration = 0.5f;
        _uiBox.SetActive(true);
        // Scale from 0 to 1
        //Debug.Log($"Wheel.DisplayScoreCoroutine > Begin display");
        while (time < duration)
        {
            var size = time / duration;
            _uiBox.transform.localScale = new Vector3(size, size, size);
            time += Time.deltaTime;
            yield return null;
        }
        //Debug.Log($"Wheel.DisplayScoreCoroutine > End display");
        GameManager.Instance._playerInput.Player.Interact.performed += ActingManager.Instance.OnClickCloseSkillcheck;
        handleDialogueText();
    }

    public IEnumerator CloseScoreCoroutine()
    {
        StopCoroutine(_spinCoroutine);
        StopCoroutine(DisplayScoreCoroutine());
        
        //Debug.Log("Wheel.CloseScoreCoroutine > Start");
        
        _light.gameObject.SetActive(false);

        _onStage = false;
        ActingManager.Instance._canContinueDialogue = true;
        
        // Scale from 1 to 0
        float time = 0.0f, duration = 0.5f;

        time = 0.0f;
        while (time < duration)
        {
            var size = 1 - time / duration;
            _uiBox.transform.localScale = new Vector3(size, size, size);
            
            transform.position = Vector3.Lerp(_positionOnStage,_positionOutsideStage, 
                _movementCurve.Evaluate(time / duration));
            
            time += Time.deltaTime;
            yield return null;
        }
        _uiBox.SetActive(false);
        
        //Debug.Log("Wheel.CloseScoreCoroutine > End");

    }

    #endregion
}
