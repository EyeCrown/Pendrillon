using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using MonoBehavior.Managers;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

public class Prompter : MonoBehaviour
{

    #region Attributes

    private GameObject _uiPart;
    private TextMeshProUGUI _dialogueText;

    private bool isOnStage = false;

    #endregion

    #region Events

    public UnityEvent<string> DialogueUpdate;

    #endregion
    
    #region UnityAPI

    void Awake()
    {
        // Connect Attributes
        _uiPart = ActingManager.Instance._uiParent.transform.Find("PROMPTER_PART").gameObject;
        _dialogueText = _uiPart.transform.Find("DialogueBox/DialogueText").GetComponent<TextMeshProUGUI>();
        _uiPart.SetActive(false);
        
        // Connect Events
        ActingManager.Instance.ClearUI.AddListener(OnClearUI);
        DialogueUpdate.AddListener(OnDialogueUpdate);
    }

    #endregion

    #region Methods

    void GoOnStage()
    {
        transform.position = GameManager.Instance._gridScene.GetWorldPositon(new Vector2Int(16, 6));
        transform.LookAt(Camera.main.transform);
        isOnStage = true;
        Debug.Log($"Prompter.{MethodBase.GetCurrentMethod().Name}");
    }

    void LeaveStage()
    {
        transform.position = GameManager.Instance._gridScene.GetWorldPositon(new Vector2Int(-100, -100));
        isOnStage = false;
        Debug.Log($"Prompter.{MethodBase.GetCurrentMethod().Name}");
    }
    
    #endregion

    #region EventHandlers

    void OnClearUI()
    {
        if (isOnStage)
            LeaveStage();
        
        _uiPart.SetActive(false);
        _dialogueText.text = string.Empty;
    }
    
    void OnDialogueUpdate(string dialogue)
    {
        if (!isOnStage)
            GoOnStage();
        
        _uiPart.SetActive(true);
        _dialogueText.text = dialogue;
        Debug.Log($"Prompter.{MethodBase.GetCurrentMethod().Name} > Prompter is speaking");

    }

    #endregion
}
