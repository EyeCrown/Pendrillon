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

    // UI
    private GameObject _uiPart;
    private TextMeshProUGUI _dialogueText;
    private GameObject _iconTalking;
    
    private Animator _anim;

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

        _iconTalking = transform.Find("Canvas").gameObject;
        _iconTalking.SetActive(false);
        
        _anim = GetComponentInChildren<Animator>();
        
        
        // Connect Events
        ActingManager.Instance.ClearUI.AddListener(OnClearUI);
        DialogueUpdate.AddListener(OnDialogueUpdate);
    }

    #endregion

    #region Methods

    void GoOnStage()
    {
        //transform.position = GameManager.Instance._gridScene.GetWorldPositon(new Vector2Int(12, 12));
        //transform.LookAt(Camera.main.transform);
        
        _anim.SetBool("InOut", true);
        
        isOnStage = true;
        Debug.Log($"Prompter.{MethodBase.GetCurrentMethod().Name}");
    }

    void LeaveStage()
    {
        _anim.SetBool("InOut", false);

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
        _iconTalking.SetActive(false);
    }
    
    void OnDialogueUpdate(string dialogue)
    {
        if (!isOnStage)
            GoOnStage();
        
        _uiPart.SetActive(true);
        _dialogueText.text = dialogue;
        _iconTalking.SetActive(true);
        Debug.Log($"Prompter.{MethodBase.GetCurrentMethod().Name} > Prompter is speaking");

    }

    #endregion
}
