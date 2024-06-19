using System;
using System.Collections;
using System.Collections.Generic;
using MonoBehavior.Managers;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class MainMenu : MonoBehaviour
{
    #region Attributes

    [Header("=== Buttons ===")] 
    [SerializeField] private Button _playButton;
    [SerializeField] private Button _optionButton;
    [SerializeField] private Button _creditButton;
    [SerializeField] private Button _quitButton;
    [SerializeField] private Button _returnCreditButton;

    [Header("=== Credits Panel ===")] 
    [SerializeField] private GameObject _creditPanel;
    
    #endregion

    #region Unity API

    void Awake()
    {
        _creditPanel.SetActive(false);
        
        _playButton.onClick.AddListener(OnClickPlayButton);
        _creditButton.onClick.AddListener(OnClickCreditButton);
        _quitButton.onClick.AddListener(OnClickQuitButton);
        _returnCreditButton.onClick.AddListener(OnClickReturnCreditButton);
    }

    #endregion

    #region Buttons

    void OnClickPlayButton()
    {
        gameObject.SetActive(false);
        GameManager.Instance.StartGame.Invoke();
    }
    
    void OnClickCreditButton()
    {
        _creditPanel.SetActive(true);
        foreach (var textMeshObject in FindObjectsByType(typeof(TextMeshProUGUI), FindObjectsSortMode.None))
            ((TextMeshProUGUI)textMeshObject).font = GameManager.Instance._currentFont;
    }
    
    void OnClickQuitButton()
    {
        Application.Quit();
    }

    void OnClickReturnCreditButton()
    {
        _creditPanel.SetActive(false);
    }
    

    #endregion
    
    
}
