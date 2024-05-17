using System;
using System.Collections;
using System.Reflection;
using MonoBehavior.Managers;
using UnityEngine;
using TMPro;
using UnityEngine.Events;

public class CharacterHandler : MonoBehaviour
{
    #region Attributes

    public Character _character;

    public Animator _anim;
    
    public Canvas _canvas;
    private GameObject _uiActing;
    public TextMeshProUGUI _nameText;
    
    public TextMeshProUGUI _dialogueText;

    public Vector2Int _coordsOnStatge;


    [Range(1, 200)] [SerializeField] private int maxLengthDialogue;
    
    #endregion

    #region Events

    public UnityEvent<string> DialogueUpdate;

    #endregion
    
    #region UnityAPI

    private void Awake()
    {
        _anim = GetComponentInChildren<Animator>();
        ResetAllAnimTriggers();
        
        _canvas         = transform.Find("Canvas").GetComponent<Canvas>();
        _uiActing       = transform.Find("Canvas/ACTING_PART").gameObject;
        _nameText       = _uiActing.transform.Find("NameBox/NameText").GetComponent<TextMeshProUGUI>();
        _dialogueText   = _uiActing.transform.Find("DialogueBox/DialogueText").GetComponent<TextMeshProUGUI>();

        _canvas.worldCamera = Camera.main;
        _canvas.gameObject.SetActive(true);

        ActingManager.Instance.ClearUI.AddListener(OnClearUI);
        DialogueUpdate.AddListener(OnDialogueUpdate);
        
    }

    void Start()
    {
        _nameText.text = _character.name;
        //Debug.Log($"{_character.name} se réveille.");

        //SetPosition(coordsOnStatge);
    }

    

    #endregion
    
    public void OnDialogueUpdate(string text)
    {
        //Debug.Log($"CharacterHandler.OnDialogueUpdate > {_character.name}:{text}");
        _uiActing.SetActive(true);
        _dialogueText.text = text;
        //Debug.Log($"CharacterHandler.OnDialogueUpdate > _dialogueText.text:{_dialogueText.text}");
    }
    
    

    #region Movements

    public void SetPosition(Vector2Int positionOnStage)
    {
        //transform.position = GameManager.Instance._gridScene._grid.GetCellCenterWorld(V);
    }
    
    public void Move(Vector2Int destination)
    {
        Vector3 end = Vector3.zero; // GameManager.Instance._gridScene.GetCell(destination).position;
        float duration = 3.0f;

        StartCoroutine(LerpPosition(end, duration));
    }
    
    IEnumerator LerpPosition(Vector3 targetPosition, float duration)
    {
        float time = 0.0f;
        Vector3 startPosition = transform.position;

        while (time < duration)
        {
            transform.position = Vector3.Lerp(startPosition, targetPosition, _character.movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        transform.position = targetPosition;
    }

    #endregion

    
    
    
    
    private void ResetAllAnimTriggers()
    {
        foreach (var param in _anim.parameters)
        {
            if (param.type == AnimatorControllerParameterType.Trigger)
            {
                _anim.ResetTrigger(param.name);
            }
        }
    }
    

    #region EventHandlers

    private void OnClearUI()
    {
        _dialogueText.text = String.Empty;
        _uiActing.SetActive(false);
        
        _anim.SetTrigger("Idle");
    }

    public void OnUpdateDialogue(String dialogue)
    {
        //Debug.Log($"CharacterHandler.OnDialogueUpdate > {_character.name}:{text}");
        _uiActing.SetActive(true);
        _dialogueText.text = dialogue;
        //Debug.Log($"CharacterHandler.OnDialogueUpdate > _dialogueText.text:{_dialogueText.text}");
    }

    #endregion

    #region Coroutine

    public IEnumerator PlayAndWaitForAnimCoroutine(string triggerName)
    {
        Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod().Name} > Animation start");

        _anim.SetTrigger(triggerName);
        
        //Wait until we enter the current state
        while (!_anim.GetCurrentAnimatorStateInfo(0).IsName(triggerName))
        {
            yield return null;
        }

        //Now, Wait until the current state is done playing
        while ((_anim.GetCurrentAnimatorStateInfo(0).normalizedTime) % 1 < 0.99f)
        {
            yield return null;
        }
        
        //Done playing. Do something below!
        Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod().Name} > Animation ended");
        if (!_anim.GetCurrentAnimatorStateInfo(0).loop)
        {
            Debug.Log("Animation is loop so go back to idle");
            _anim.SetTrigger("Idle");
        }
    }

    #endregion
}