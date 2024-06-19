using System;
using System.Collections;
using System.Collections.Generic;
using AK.Wwise;
using MonoBehavior.Managers;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Options : MonoBehaviour
{
    #region Attributes

    #region Parameters

    [Header("=== Fonts ===")] 
    [SerializeField] private TMP_FontAsset _defaultFont; 
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
    private Button _mainMenuButton;
    private Button _closeMenuButton;
    
    // Toggles
    //      ScreenShake
    private Toggle _screenShakeToggle;

    
    //      Fonts 
    private Toggle _defaultFontToggle;
    private Toggle _dyslexicFontToggle;

    #endregion
    
    #endregion
    
    #region Events

    public UnityEvent Open;
    public UnityEvent Close;
    
    #endregion

    #region Unity API

    void Awake()
    {
        ConnectAttributes();
        ConnectListenners();
        
        SetupRTPC();
    }

    void Start()
    {
        ActingManager.Instance.PhaseStart.AddListener(() => { _openMenuButton.gameObject.SetActive(true);});

        _defaultFontToggle.isOn = true;
        _screenShakeToggle.isOn = true;
        _openMenuButton.gameObject.SetActive(false);
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
        _mainMenuButton = _panel.transform.Find("MainMenuButton").GetComponent<Button>();
        _closeMenuButton = _panel.transform.Find("BackButton").GetComponent<Button>();
        
        // Font toggle
        var fontLocation = "FontsParameters/";
        _defaultFontToggle = _panel.transform.Find(fontLocation + "DefaultFont").GetComponent<Toggle>();
        _dyslexicFontToggle   = _panel.transform.Find(fontLocation + "DyslexicFont").GetComponent<Toggle>();
        
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
        // Events
        Open.AddListener(OnOpen);
        Close.AddListener(OnClose);
        
        
        
        // Visual
        _opacitySlider.onValueChanged.AddListener(delegate { ActingManager.Instance.ChangeOpacityUI(_opacitySlider.value); });
        
        // Button
        _openMenuButton.onClick.AddListener(OnClickOpenButton);
        _mainMenuButton.onClick.AddListener(OnClickMainMenuButton);
        _closeMenuButton.onClick.AddListener(OnClickCloseButton);
        
        // Toggles
        _defaultFontToggle.onValueChanged.AddListener( 
            delegate { ChangeFont(_defaultFont); });
        _dyslexicFontToggle.onValueChanged.AddListener(   
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

    void SetupRTPC()
    {
        _rtpcMainVolumeSlider.value = 75;
        _rtpcEnvironmentVolumeSlider.value  = 50;
        _rtpcMusicVolumeSlider.value        = 50;
        _rtpcSFXVolumeSlider.value          = 50;
        _rtpcUIVolumeSlider.value           = 50;
        _rtpcVoicesVolumeSlider.value       = 50;
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
        GameManager.Instance.ChangeFont.Invoke(font);
        
        foreach (var textMeshObject in GameObject.FindObjectsByType(typeof(TextMeshProUGUI), FindObjectsSortMode.None))
            ((TextMeshProUGUI)textMeshObject).font = font;
    }

    #endregion

    #region EventHandlers

    void OnOpen()
    {
        _panel.SetActive(true);
        Time.timeScale = 0.0f;
        GameManager.Instance._playerInput.Player.Interact.Disable();
        _openMenuButton.gameObject.SetActive(false);
    }

    void OnClose()
    {
        _panel.SetActive(false);
        Time.timeScale = 1.0f;
        GameManager.Instance._playerInput.Player.Interact.Enable();
        _openMenuButton.gameObject.SetActive(true);
    }
    
    public void OnClickOpenButton()     => Open.Invoke();

    public void OnClickCloseButton()    => Close.Invoke();

    public void OnClickMainMenuButton() => SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    
    void UpdateRTPC(string parameterName, float value) => AkSoundEngine.SetRTPCValue(parameterName, value);

    private void OnEnable()
    {
        // foreach (var textMeshObject in FindObjectsByType(typeof(TextMeshProUGUI), FindObjectsSortMode.None))
        //     ((TextMeshProUGUI)textMeshObject).font = GameManager.Instance._currentFont;
    }

    #endregion
}
