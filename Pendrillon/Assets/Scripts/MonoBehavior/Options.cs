using System;
using System.Collections;
using System.Collections.Generic;
using AK.Wwise;
using MonoBehavior.Managers;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class Options : MonoBehaviour
{
    #region Attributes

    #region Parameters

    [Header("=== Fonts ===")] 
    [SerializeField] private TMP_FontAsset _originalFont;
    [SerializeField] private TMP_FontAsset _secondFont; // TODO: Rename to be more explicit 

    #endregion
    
    

    #region UI Attributes

    // Panel        [Header("=== Panel ===")]
    private GameObject _panel;
    
    // Sliders      [Header("=== Sliders ===")] 
    private Slider _rtpcMainVolumeSlider;
    private Slider _rtpcEnvironmentVolumeSlider;
    private Slider _rtpcSFXVolumeSlider;
    private Slider _rtpcUIVolumeSlider;
    private Slider _rtpcVoicesVolumeSlider;
    
    // Buttons
    private Button _openMenuButton;
    
    // Toggles
    private List<Toggle> _toggles;
    private Toggle _originalFontToggle;
    private Toggle _secondFontToggle;

    #endregion
    
    
    #endregion

    #region Unity API

    void Awake()
    {
        ConnectAttributes();
        ConnectListenners();
        
    }

    void Start()
    {
        _originalFontToggle.isOn = true;
        _panel.SetActive(false);
    }

    #endregion

    #region Methods

    #region Setup

    void ConnectAttributes()
    {
        _panel = transform.Find("Panel").gameObject;

        // Buttons
        _openMenuButton = transform.Find("OpenMenuButton").GetComponent<Button>();
        
        // Toggles
        var fontLocation = "FontsParameters/";
        _originalFontToggle = _panel.transform.Find(fontLocation + "OriginalFont").GetComponent<Toggle>();
        _secondFontToggle   = _panel.transform.Find(fontLocation + "SecondFont").GetComponent<Toggle>();
        _toggles = new List<Toggle>();
        _toggles.Add(_originalFontToggle);
        _toggles.Add(_secondFontToggle); 
        
        // RTPC
        var soundLocation = "SoundParameters/";
        _rtpcMainVolumeSlider   = _panel.transform.Find(soundLocation + "MainVolume" + "/Slider").gameObject.GetComponent<Slider>();
        _rtpcEnvironmentVolumeSlider = _panel.transform.Find(soundLocation + "EnvironmentVolume" + "/Slider").gameObject.GetComponent<Slider>();
        _rtpcSFXVolumeSlider    = _panel.transform.Find(soundLocation + "SFXVolume" + "/Slider").gameObject.GetComponent<Slider>();
        _rtpcUIVolumeSlider     = _panel.transform.Find(soundLocation + "UIVolume" + "/Slider").gameObject.GetComponent<Slider>();
        _rtpcVoicesVolumeSlider = _panel.transform.Find(soundLocation + "VoicesVolume" + "/Slider").gameObject.GetComponent<Slider>();
        
    }

    void ConnectListenners()
    {
        // Button
        _openMenuButton.onClick.AddListener(OnClickOpenButton);
        
        // Toggles
        _originalFontToggle.onValueChanged.AddListener( 
            delegate { UpdateFont(_originalFont, _originalFontToggle); });
        _secondFontToggle.onValueChanged.AddListener(   
            delegate { UpdateFont(_secondFont, _secondFontToggle); });
        // TODO: FIX THIS SHIT
        
        
        // RTPC
        _rtpcMainVolumeSlider.onValueChanged.AddListener(
            delegate { UpdateRTPC("Main_Volume",   _rtpcMainVolumeSlider.value); });
        _rtpcEnvironmentVolumeSlider.onValueChanged.AddListener(
            delegate { UpdateRTPC("Environment_Volume", _rtpcEnvironmentVolumeSlider.value); });
        _rtpcSFXVolumeSlider.onValueChanged.AddListener(
            delegate { UpdateRTPC("SFX_Volume", _rtpcSFXVolumeSlider.value); });
        _rtpcUIVolumeSlider.onValueChanged.AddListener(
            delegate { UpdateRTPC("UI_Volume",  _rtpcUIVolumeSlider.value); });
        _rtpcVoicesVolumeSlider.onValueChanged.AddListener(
            delegate { UpdateRTPC("Voices_Volume", _rtpcVoicesVolumeSlider.value); });
    }

    #endregion

    
    void UpdateFont(TMP_FontAsset font, Toggle currentToggle)
    {
        foreach (var toggle in _toggles)
            toggle.isOn = false;
        
        currentToggle.isOn = true;
        Debug.Log("Change font");
        foreach (var textMeshObject in FindObjectsOfType(typeof(TextMeshProUGUI)))
            ((TextMeshProUGUI)textMeshObject).font = font;
    }

    #endregion

    #region EventHandlers

    void OnClickOpenButton()
    {
        if (_panel.activeSelf)
        {
            _panel.SetActive(false);
            Time.timeScale = 1.0f;
            GameManager.Instance._playerInput.Player.Interact.Enable();
        }
        else
        {
            _panel.SetActive(true);
            Time.timeScale = 0.0f;
            GameManager.Instance._playerInput.Player.Interact.Disable();
        }
    }
    
    void UpdateRTPC(string parameterName, float value) => AkSoundEngine.SetRTPCValue(parameterName, value);

    #endregion
}
