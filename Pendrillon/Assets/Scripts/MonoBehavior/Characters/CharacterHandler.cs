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

    Animator _anim;
    private GameObject _rope;
    private Vector3 _ropeOffset = new Vector3(0, 10.0f, -0.35f);

    public bool _playAnim = false;
    
    // UI
    Canvas _canvas;
    GameObject _uiActing;
    //TextMeshProUGUI _nameText;
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
        {
            //Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod().Name} > Animation on the way");

            yield return null;
        }
        //Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod()?.Name} > Animation Start");

        
        PlayEmotionSoundsVFX(triggerName, _character.name);
        
        ////
        if (callbackOnFinish != null) 
            callbackOnFinish();
        //Now, Wait until the current state is done playing
        while ((_anim.GetCurrentAnimatorStateInfo(0).normalizedTime) % 1 < 0.99f)
        {
            //Debug.Log($"{_character.name}.{MethodBase.GetCurrentMethod().Name} > Animation running");

            yield return null;
        }
        
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


    public IEnumerator ArriveOnStage(Vector3 targetPosition, float duration = 6.0f)
    {
        float time = 0.0f;
        Vector3 startPosition = targetPosition + new Vector3(0, 10.0f,0);

        _rope.SetActive(true);
        _rope.transform.localPosition = _ropeOffset;
        
        transform.position = startPosition;
        _anim.SetTrigger("falling");
        
        // Character start arriving
        while (Vector3.Distance(transform.position, targetPosition) > 0.0001f)
        {
            transform.position = Vector3.Lerp(startPosition, targetPosition, _character.movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        Debug.Log($"{gameObject.name} is done");
        _anim.SetTrigger("idle");

        // Character is on stage -> Rope goes up
        var ropeStart = _ropeOffset;
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
        

    }
    
    
    public IEnumerator LeaveStage(float duration = 6.0f)
    {
        float time = 0.0f;
        Vector3 startPosition = transform.position;
        Vector3 targetPosition = transform.position + new Vector3(0, 10.0f,0);
        
        
        _rope.SetActive(true);
        var ropeStart = targetPosition + _ropeOffset;
        var ropeDestination = _ropeOffset;
        _rope.transform.localPosition = ropeStart;
        // Rope is arriving
        while (Vector3.Distance(_rope.transform.localPosition, ropeDestination) > 0.001f)
        {
            _rope.transform.localPosition = Vector3.Lerp(ropeStart, ropeDestination, 
                _character.movementCurve.Evaluate(time/ (duration/4)));
            time += Time.deltaTime;
            yield return null;
        }
        
        // Rope is here -> Character goes up
        _anim.SetTrigger("falling");
        while (Vector3.Distance(transform.position, targetPosition) > 0.0001f)
        {
            transform.position = Vector3.Lerp(startPosition, targetPosition, 
                _character.movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        // Character is up
        Debug.Log($"{gameObject.name} has leave the stage");
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