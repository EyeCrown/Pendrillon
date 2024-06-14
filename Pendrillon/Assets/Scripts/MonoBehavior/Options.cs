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
    [SerializeField] private TMP_FontAsset _secondFont;  
    [SerializeField] private TMP_FontAsset _openDyslexicFont;  

    #endregion
    
    

    #region UI Attributes

    // Panel        [Header("=== Panel ===")]
    private GameObject _panel;
    
    // Sliders      [Header("=== Sliders ===")] 
    private Slider _opacitySlider;
    
    private Slider _rtpcMainVolumeSlider;
    private Slider _rtpcEnvironmentVolumeSlider;
    private Slider _rtpcMusicVolumeSlider;
    private Slider _rtpcSFXVolumeSlider;
    private Slider _rtpcUIVolumeSlider;
    private Slider _rtpcVoicesVolumeSlider;
    
    // Buttons
    private Button _openMenuButton;
    
    // Toggles
    //      ScreenShake
    private Toggle _screenShakeToggle;

    
    //      Fonts 
    private Toggle _originalFontToggle;
    private Toggle _secondFontToggle;
    private Toggle _thirdFontToggle;

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
        _screenShakeToggle.isOn = true;
        _panel.SetActive(false);
    }

    #endregion

    #region Methods

    #region Setup

    void ConnectAttributes()
    {
        _panel = transform.Find("Panel").gameObject;

        // Visual
        var visualLocation = "VisualParameters/";
        _opacitySlider = _panel.transform.Find(visualLocation+"Opacity"+"/Slider").GetComponent<Slider>();
        
        // Buttons
        _openMenuButton = transform.Find("OpenMenuButton").GetComponent<Button>();
        
        // Font toggle
        var fontLocation = "FontsParameters/";
        _originalFontToggle = _panel.transform.Find(fontLocation + "OriginalFont").GetComponent<Toggle>();
        _secondFontToggle   = _panel.transform.Find(fontLocation + "SecondFont").GetComponent<Toggle>();
        _thirdFontToggle    = _panel.transform.Find(fontLocation + "ThirdFont").GetComponent<Toggle>();
        
        // RTPC
        var soundLocation = "SoundParameters/";
        _rtpcMainVolumeSlider   = _panel.transform.Find(soundLocation + "MainVolume" + "/Slider").gameObject.GetComponent<Slider>();
        _rtpcEnvironmentVolumeSlider = _panel.transform.Find(soundLocation + "EnvironmentVolume" + "/Slider").gameObject.GetComponent<Slider>();
        _rtpcMusicVolumeSlider = _panel.transform.Find(soundLocation + "MusicVolume" + "/Slider").gameObject.GetComponent<Slider>();
        _rtpcSFXVolumeSlider    = _panel.transform.Find(soundLocation + "SFXVolume" + "/Slider").gameObject.GetComponent<Slider>();
        _rtpcUIVolumeSlider     = _panel.transform.Find(soundLocation + "UIVolume" + "/Slider").gameObject.GetComponent<Slider>();
        _rtpcVoicesVolumeSlider = _panel.transform.Find(soundLocation + "VoicesVolume" + "/Slider").gameObject.GetComponent<Slider>();
        
        // Screenshake
        
        _screenShakeToggle = _panel.transform.Find(visualLocation + "ScreenshakeToggle").GetComponent<Toggle>();

    }

    void ConnectListenners()
    {
        // Visual
        _opacitySlider.onValueChanged.AddListener(delegate { ActingManager.Instance.ChangeOpacityUI(_opacitySlider.value); });
        
        // Button
        _openMenuButton.onClick.AddListener(OnClickOpenButton);
        
        // Toggles
        _originalFontToggle.onValueChanged.AddListener( 
            delegate { ChangeFont(_originalFont); });
        _secondFontToggle.onValueChanged.AddListener(   
            delegate { ChangeFont(_secondFont); });
        _thirdFontToggle.onValueChanged.AddListener(   
            delegate { ChangeFont(_openDyslexicFont); });
        
        _screenShakeToggle.onValueChanged.AddListener(
            delegate { ActingManager.Instance._allowScreenshake = _screenShakeToggle.isOn; });
        
        // RTPC
        _rtpcMainVolumeSlider.onValueChanged.AddListener(
            delegate { UpdateRTPC("Main_Volume",   _rtpcMainVolumeSlider.value); });
        _rtpcEnvironmentVolumeSlider.onValueChanged.AddListener(
            delegate { UpdateRTPC("Environment_Volume", _rtpcEnvironmentVolumeSlider.value); });
        _rtpcMusicVolumeSlider.onValueChanged.AddListener(
            delegate { UpdateRTPC("Music_Volume", _rtpcMusicVolumeSlider.value); });
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
        // foreach (var toggle in _toggles)
        //     toggle.isOn = false;
        //
        // currentToggle.isOn = true;
        Debug.Log("Change font");
        foreach (var textMeshObject in FindObjectsByType(typeof(TextMeshProUGUI), FindObjectsSortMode.None))
            ((TextMeshProUGUI)textMeshObject).font = font;
    }

    void ChangeFont(TMP_FontAsset font)
    {
        foreach (var textMeshObject in GameObject.FindObjectsByType(typeof(TextMeshProUGUI), FindObjectsSortMode.None))
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
