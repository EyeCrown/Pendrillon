using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using MonoBehavior.Managers;
using UnityEngine;
using TMPro;
using Unity.VisualScripting;
using UnityEngine.Events;

public class CharacterHandler : MonoBehaviour
{
    #region Attributes

    public Character _character;

    public Vector2Int _coordsOnStatge;
    public bool _onStage = false;
    
    Animator _anim;
    private GameObject _rope;
    private Vector3 _ropeOffset = new Vector3(0, 10.0f, -0.35f);

    public bool _playAnim = false;
    
    // UI
    Canvas _canvas;
    GameObject _uiActing;
    //TextMeshProUGUI _nameText;
    TextMeshProUGUI _dialogueText;

    // Coroutines booleans
    private bool _leaveCoroutine = false;
    private bool _arriveCoroutine = false;
    
    #endregion

    #region Events

    public UnityEvent<string> DialogueUpdate;

    #endregion
    
    #region UnityAPI

    private void Awake()
    {
        _anim = GetComponentInChildren<Animator>();
        ResetAllAnimTriggers();
        
        _canvas     = transform.Find("Canvas").GetComponent<Canvas>();
        _uiActing   = transform.Find("Canvas/ACTING_PART").gameObject;
        _rope       = transform.Find("Rope").gameObject;
        
        _canvas.worldCamera = Camera.main;
        _canvas.gameObject.SetActive(true);
        
        ActingManager.Instance.ClearUI.AddListener(OnClearUI);
        DialogueUpdate.AddListener(OnDialogueUpdate);
    }

    /*void Start()
    {
        //_nameText.text = _character.name;
        //Debug.Log($"{_character.name} se réveille.");

        //SetPosition(coordsOnStatge);
    }*/
    

    #endregion
    

    #region Movements

    public void SetPosition(Vector2Int positionOnStage)
    {
        transform.position = GameManager.Instance._gridScene.GetWorldPositon(positionOnStage);

        //StartCoroutine(ArriveOnStage(GameManager.Instance._gridScene.GetWorldPositon(positionOnStage)));
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
    
    public void Move(Vector2Int destination, string speedText, Action callbackOnFinish)
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
        //_dialogueText.text = String.Empty;
        _uiActing.SetActive(false);
        
        //_anim.SetTrigger("Idle");
        foreach (AnimatorControllerParameter param in _anim.parameters)
            _anim.ResetTrigger(param.name);
    }

    private void OnDialogueUpdate(string text)
    {
        //Debug.Log($"CharacterHandler.OnDialogueUpdate > {_character.name}:{text}");
        _uiActing.SetActive(true);
        
        // play neutral anim
        if (!_playAnim)
            StartCoroutine(PlayAnimCoroutine(Constants.AnimTalk));
    }

    #endregion

    
    #region Coroutine

    public IEnumerator PlayAnimCoroutine(string triggerName, Action callbackOnFinish = null)
    {
        if (!HasParameter(triggerName, _anim))
        {
            Debug.LogError($"{_character.name}.{MethodBase.GetCurrentMethod()?.Name} > Error: Animation {triggerName} doesn't exists.");
            callbackOnFinish();
            yield break;
        }
        
        //Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod()?.Name} > Animation {triggerName} start");
        
        _anim.SetTrigger(triggerName);
        
        //Wait until we enter the current state
        while (!_anim.GetCurrentAnimatorStateInfo(0).IsName(triggerName))
            yield return null;
        
        //Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod()?.Name} > Animation Start");
        PlayEmotionSoundsVFX(triggerName, _character.name);
        
        if (callbackOnFinish != null) 
            callbackOnFinish();
        //Now, Wait until the current state is done playing
        while ((_anim.GetCurrentAnimatorStateInfo(0).normalizedTime) % 1 < 0.99f)
            yield return null;
        
        //Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod()?.Name} > Animation ended");
        //Done playing. Do something below!
        _playAnim = false;
    }
    
    IEnumerator MovePositionCoroutine(Vector3 targetPosition, float duration, Action callbackOnFinish)
    {
        float time = 0.0f;
        Vector3 startPosition = transform.position;

        while (Vector3.Distance(transform.position, targetPosition) > 0.0001f)
        {
            transform.position = Vector3.Lerp(startPosition, targetPosition, _character.movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        transform.position = targetPosition;
        transform.LookAt(Camera.main.transform);
        callbackOnFinish();
    }


    public IEnumerator ArriveOnStage(Vector2Int targetCoordPosition, float duration = 10.0f)
    {
        _arriveCoroutine = true;
        Debug.Log($"{name} start arriving on stage");

        while (_leaveCoroutine)
        {
            Debug.Log("Waiting leaving coroutine to finish");
            yield return null;
        }
        
        _coordsOnStatge = targetCoordPosition;
        Vector3 targetPosition = GameManager.Instance._gridScene.GetWorldPositon(targetCoordPosition);
        
        float time = 0.0f;
        Vector3 startPosition = targetPosition + new Vector3(0, 10.0f,0);

        _rope.SetActive(true);
        _rope.transform.localPosition = _ropeOffset;
        
        transform.position = startPosition;
        _anim.SetBool("falling", true);
        
        // Character start arriving
        Debug.Log($"{gameObject.name} start moving");
        while (Vector3.Distance(transform.position, targetPosition) > 0.0001f)
        {
            transform.position = Vector3.Lerp(startPosition, targetPosition, 
                _character.movementCurve.Evaluate(time/ (duration / 2)));
            time += Time.deltaTime;
            yield return null;
        }
        Debug.Log($"{gameObject.name} is now on stage");
        
        _anim.SetBool("falling", false);

        // Character is on stage -> Rope goes up
        var ropeStart = _rope.transform.localPosition;
        var ropeDestination = ropeStart + new Vector3(0, 20.0f, 0);
        time = 0.0f;
        while (Vector3.Distance(_rope.transform.localPosition, ropeDestination) > 0.001f)
        {
            _rope.transform.localPosition = Vector3.Lerp(ropeStart, ropeDestination, 
                _character.movementCurve.Evaluate(time/ (duration/4)));
            time += Time.deltaTime;
            yield return null;
        }
        _rope.SetActive(false);
        Debug.Log($"{gameObject.name}.Rope is done");

        _onStage = true;
        _arriveCoroutine = false;
    }
    
    
    public IEnumerator LeaveStage(float duration = 4.0f)
    {
        _leaveCoroutine = true;
        Debug.Log($"{name} start leaving stage");
        
        float time = 0.0f;
        Vector3 startPosition = transform.position;
        Vector3 targetPosition = transform.position + new Vector3(0, 10.0f,0);
        
        
        _rope.SetActive(true);
        var ropeStart = _ropeOffset + new Vector3(0, 10f, 0);
        var ropeDestination = _ropeOffset;
        _rope.transform.localPosition = ropeStart;
        // Rope is arriving
        while (Vector3.Distance(_rope.transform.localPosition, ropeDestination) > 0.001f)
        {
            _rope.transform.localPosition = Vector3.Lerp(ropeStart, ropeDestination, 
                _character.movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        
        // Rope is here -> Character goes up
        _anim.SetBool("falling", true);

        time = 0.0f;
        
        while (Vector3.Distance(transform.position, targetPosition) > 0.0001f)
        {
            Debug.Log($"LeaveStage: {time}/{duration}");
            transform.position = Vector3.Lerp(startPosition, targetPosition, 
                _character.movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        // Character is up
        Debug.Log($"{gameObject.name} has leave the stage");
        _onStage = false;
        _anim.SetBool("falling", false);
        _leaveCoroutine = false;
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


    void PlayEmotionSoundsVFX(string emotionName, string characterName)
    {
        Debug.Log("playing sound Play_VOX_" + characterName + "_Emotion_" + emotionName);
        AkSoundEngine.PostEvent("Play_VOX_" + characterName + "_Emotion_" + emotionName, gameObject);
    }
    
    
}