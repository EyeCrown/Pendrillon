using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using MonoBehavior.Managers;
using UnityEngine;
using TMPro;
using UnityEngine.Events;

public class CharacterHandler : MonoBehaviour
{
    #region Attributes

    public Character _character;

    Animator _anim;
    
    // UI
    Canvas _canvas;
    GameObject _uiActing;
    TextMeshProUGUI _nameText;
    TextMeshProUGUI _dialogueText;

    public Vector2Int _coordsOnStatge;
    
    //[Range(1, 200)] [SerializeField] private int maxLengthDialogue;
    
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
    

    #region Movements

    public void SetPosition(Vector2Int positionOnStage)
    {
        transform.position = GameManager.Instance._gridScene.GetWorldPositon(positionOnStage);
    }

    private static float GetSpeed(string speedText)
    {
        float speed = 0;

        switch (speedText)
        {
            case Constants.SlowName:    speed = Constants.SlowSpeed;
                break;
            case Constants.NormalName:  speed = Constants.NormalSpeed;
                break;
            case Constants.QuickName:   speed = Constants.QuickSpeed;
                break;
        }

        return speed;
    }
    
    public void Move(Vector2Int destination, string speedText, System.Action callbackOnFinish)
    {
        Vector3 end = GameManager.Instance._gridScene.GetWorldPositon(destination);
        transform.LookAt(end);
        
        float speed = GetSpeed(speedText);
        float distance = Vector3.Distance(transform.position, end);
        float duration = distance / speed;
        
        //TODO: Add animations when moving

        StartCoroutine(MovePositionCoroutine(end, duration, callbackOnFinish));
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
        
        //_anim.SetTrigger("Idle");
    }

    public void OnDialogueUpdate(string text)
    {
        //Debug.Log($"CharacterHandler.OnDialogueUpdate > {_character.name}:{text}");
        _uiActing.SetActive(true);
    }

    #endregion

    
    #region Coroutine

    public IEnumerator PlayAnimCoroutine(string triggerName, System.Action callbackOnFinish)
    {
        if (!HasParameter(triggerName, _anim))
        {
            Debug.LogError($"{_character.name}.{MethodBase.GetCurrentMethod()?.Name} > Error: Animation {triggerName} doesn't exists.");
            callbackOnFinish();
            yield break;
        }
        
        Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod()?.Name} > Animation {triggerName} start");
        
        _anim.SetTrigger(triggerName);
        
        //Wait until we enter the current state
        while (!_anim.GetCurrentAnimatorStateInfo(0).IsName(triggerName))
        {
            //Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod().Name} > Animation on the way");

            yield return null;
        }
        
        //Now, Wait until the current state is done playing
        while ((_anim.GetCurrentAnimatorStateInfo(0).normalizedTime) % 1 < 0.99f)
        {
            //Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod().Name} > Animation running");

            yield return null;

        }
        
        Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod().Name} > Animation ended");

        //Done playing. Do something below!
        callbackOnFinish();
        // if (!_anim.GetCurrentAnimatorStateInfo(0).loop)
        // {
        //     //Debug.Log("Animation is not a loop so go back to idle");
        //     _anim.SetTrigger("Idle");
        // }
    }
    
    IEnumerator MovePositionCoroutine(Vector3 targetPosition, float duration, System.Action callbackOnFinish)
    {
        float time = 0.0f;
        Vector3 startPosition = transform.position;

        while (Vector3.Distance(transform.position, targetPosition) > 0.0001f)
        {
            transform.position = Vector3.Lerp(startPosition, targetPosition, _character.movementCurve.Evaluate(time/duration));
            transform.position = Vector3.Lerp(startPosition, targetPosition, _character.movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        transform.position = targetPosition;
        transform.LookAt(Camera.main.transform);
        callbackOnFinish();
    }

    #endregion
    
    public static bool HasParameter(string paramName, Animator animator)
    {
        foreach (AnimatorControllerParameter param in animator.parameters)
        {
            if (param.name == paramName)
                return true;
        }
        return false;
    }
}