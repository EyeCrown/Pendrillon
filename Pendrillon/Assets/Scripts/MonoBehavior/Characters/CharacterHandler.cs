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

    public Vector2Int _coordsOnStatge;
    public bool _onStage = false;
    
    Animator _anim;
    private GameObject _rope;
    private Vector3 _ropeOffset = new Vector3(0, 10.0f, 0f);
    private Vector3 _ropeUpOffset = new Vector3(0, 30.0f, 0f);
    private Vector3 _ropeDownOffset = new Vector3(0, 10.0f, 0f);

    public bool _playAnim = false;
    private GameObject _charaRig;
    
    // UI
    Canvas _canvas;
    GameObject _uiActing;
    //TextMeshProUGUI _nameText;
    TextMeshProUGUI _dialogueText;

    // Coroutines booleans
    private bool _leaveCoroutine = false;
    private bool _arriveCoroutine = false;
    private bool _ropeCoroutine = false;

    private Vector3 _lookAt = Vector3.zero;
    
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
        _charaRig   = transform.Find("Chara_Rig").gameObject;
        
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

    public bool IsRopeRunning()
    {
        return _leaveCoroutine || _arriveCoroutine;
    }
    

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
        if (destination == _coordsOnStatge)
        {
            callbackOnFinish();
            return;
        }

        _coordsOnStatge = destination;
        
        Vector3 end = GameManager.Instance._gridScene.GetWorldPositon(destination);
        transform.LookAt(end);
        
        float speed = GetSpeed(speedText);
        float distance = Vector3.Distance(transform.position, end);
        float duration = distance / speed;
        
        StartCoroutine(MovePositionCoroutine(end, duration, callbackOnFinish));
    }


    public void RopeAction(Action callbackOnFinish)
    {
        if (_onStage)
        {
            Debug.Log($"{name}.RopeAction > Leaves stage");
            StartCoroutine(LeaveStageCoroutine());
        }
        else
        {
            Debug.Log($"{name}.RopeAction > Arrives on stage");
            StartCoroutine(ArriveOnStageCoroutine());
        }

        callbackOnFinish();
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

    void SetCanvasPosition()
    {
        var left = ActingManager.Instance._directions[Constants.StageGarden];
        var right = ActingManager.Instance._directions[Constants.StageCourtyard];
        Vector3 direction = (transform.position.z < Camera.main.transform.position.z) ? right - left : left - right;
        direction.Normalize();
        direction *= 1.2f * transform.localScale.y;
        Vector3 offset = new Vector3(0.7f, 4.0f, 0.0f);

        if (_character.name == "Judge")
            offset = new Vector3(0.7f, 3.3f, 0.0f) * transform.localScale.y; // * 2.0f actually
        
        _canvas.transform.LookAt(Camera.main.transform);
        
        _canvas.transform.position = transform.position + direction + offset;
        
        if (_canvas.transform.position.z < transform.position.z)
            _canvas.transform.rotation = Quaternion.Euler(
                _canvas.transform.rotation.eulerAngles.x,
                _canvas.transform.rotation.eulerAngles.y - 180,
                _canvas.transform.rotation.eulerAngles.z);
    }

    #region Jugde Functions

    public void SetJudgePosition()
    {
        var judgePos = GameManager.Instance._gridScene.GetWorldPositon(new Vector2Int(2, 9));
        transform.position = new Vector3(judgePos.x, 0.0f, judgePos.z);
        _rope.SetActive(false);
        _onStage = true;
    }

    #endregion

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
        SetCanvasPosition();
        
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
        _playAnim = true;
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
        while (!_anim.GetCurrentAnimatorStateInfo(0).IsName("Idle"))
            yield return null;
        
        float time = 0.0f;
        Vector3 startPosition = transform.position;
        _anim.SetBool("walking", true);

        Debug.Log("Start moving");
        while (time < duration)
        {
            //transform.position = Vector3.Lerp(startPosition, targetPosition, _character.movementCurve.Evaluate(time/duration));
            transform.position = Vector3.Lerp(startPosition, targetPosition, time/duration);
            time += Time.deltaTime;
            yield return null;
        }
        transform.position = targetPosition;
        transform.LookAt(Camera.main.transform);
        transform.rotation = Quaternion.Euler(0, transform.rotation.eulerAngles.y, 0);
        _anim.SetBool("walking", false);
        callbackOnFinish();
    }

    public IEnumerator RotationCoroutine(Vector3 targetPosition, Action callbackOnFinish)
    {
        float time = 0.0f, duration = 0.2f;
        var startRotation = transform.rotation;
        //targetPosition += (targetPosition - transform.position);
        _lookAt = targetPosition;
        var targetRotation = Quaternion.LookRotation((targetPosition - transform.position), Vector3.up);
        //transform.rotation = startRotation;
        
        //Debug.Log($"{name} > Start rotation: {startRotation} to {targetPosition}");
        while (time < duration)
        {
            transform.rotation = Quaternion.Slerp(startRotation, targetRotation, time/duration);
            time += Time.deltaTime;
            
            //Debug.Log($"{name} > {transform.rotation.eulerAngles}");
            yield return null;
        }
        
        transform.rotation = Quaternion.Euler(0, transform.rotation.eulerAngles.y, 0);
        //Debug.Log($"{name} > Rotation done");
        callbackOnFinish();
    }


    IEnumerator MoveRopeCoroutine(Vector3 localStartPos, Vector3 localEndPos, float duration = 1.0f)
    {
        _ropeCoroutine = true;
        
        float time = 0.0f;
        //Debug.Log($"{_character.name}.MoveRopeCoroutine > Start");
        
        // Move charaRig to zero to
        var charaRigStart = _charaRig.transform.localPosition;
        
        while (time < duration)
        {
            _rope.transform.localPosition = Vector3.Lerp(localStartPos, localEndPos, 
                _character.movementCurve.Evaluate(time/ duration));

            _charaRig.transform.localPosition = Vector3.Lerp(charaRigStart, Vector3.zero, time / duration);
            
            time += Time.deltaTime;
            yield return null;
        }
        
        //Debug.Log($"{_character.name}.MoveRopeCoroutine > End");
        _ropeCoroutine = false;
    }
    
    
    public IEnumerator LeaveStageCoroutine(float duration = 2.0f)
    {
        _leaveCoroutine = true;

        // Make rope goes down
        _rope.SetActive(true);
        StartCoroutine(MoveRopeCoroutine(_ropeUpOffset, _ropeDownOffset));

        while (_ropeCoroutine)
            yield return null;
        
        // Make player goes up
        _anim.SetBool("falling", true);
        var startPos = transform.position;
        var endPos = startPos + new Vector3(0, 20.0f, 0);
        float time = 0.0f;
        while (time < duration)
        {
            //_charaRig.transform.localPosition = Vector3.zero;
            
            transform.position = Vector3.Lerp(startPos, endPos, 
                _character.movementCurve.Evaluate(time / duration));
            time += Time.deltaTime;
            yield return null;
        }
        _anim.SetBool("falling", false);
        transform.rotation = Quaternion.Euler(0, 90.0f, 0);
        _onStage = false;
        _leaveCoroutine = false;
    }
    
    public IEnumerator ArriveOnStageCoroutine(float duration = 4.0f)
    {
        _arriveCoroutine = true;
        //Debug.Log($"{name} start arriving on stage");
        
        while (_leaveCoroutine)
            yield return null;
        
        transform.rotation = Quaternion.Euler(0, 90.0f, 0);

        // Make player goes down
        _charaRig.transform.localPosition = Vector3.zero;
        _anim.SetBool("falling", true);
        var endPos = GameManager.Instance._gridScene.GetWorldPositon(_coordsOnStatge);
        var startPos = endPos + new Vector3(0, 20.0f, 0);

        _rope.SetActive(true);
        _rope.transform.localPosition = _ropeDownOffset;
        
        float time = 0.0f;
        while (time < duration)
        {
            _charaRig.transform.localPosition = new Vector3(0, 0, 0.09f);
            
            transform.position = Vector3.Lerp(startPos, endPos, 
                _character.movementCurve.Evaluate(time / duration));
            time += Time.deltaTime;
            yield return null;
        }
        _anim.SetBool("falling", false);
        
        // Make rope goes up
        StartCoroutine(MoveRopeCoroutine(_ropeDownOffset, _ropeUpOffset, 1.0f));
        
        while (_ropeCoroutine)
            yield return null;
        
        _charaRig.transform.localPosition = Vector3.zero;
        
        _onStage = true;
        _arriveCoroutine = false;
    }


    public IEnumerator MoveHeightPositionCoroutine(float height, Action callbackOnFinish)
    {
        float time = 0.0f, duration = (height < 0) ? 1.0f : 3.0f;

        Vector3 startPos = transform.position;
        Vector3 endPos = startPos + new Vector3(0, height, 0);
        
        if (height < 0) // Player is falling
            _anim.SetBool("falling", true);
        else
            _anim.SetBool("climbing", true);

        
        while (time < duration)
        {
            transform.position = Vector3.Lerp(startPos, endPos, time / duration);
            time += Time.deltaTime;
            yield return null;
        }
        
        if (height < 0) // Player is falling
            _anim.SetBool("falling", false);
        else
            _anim.SetBool("climbing", false);

        transform.rotation = Quaternion.Euler(0, transform.rotation.eulerAngles.y, 0);
        callbackOnFinish();
    }
    
    
    public IEnumerator SetJudgePositionCoroutine()
    {
        yield return new WaitForSeconds(3.0f);
        
        var judgePos = GameManager.Instance._gridScene.GetWorldPositon(new Vector2Int(2, 9));
        transform.position = new Vector3(judgePos.x, 0.4f, judgePos.z);
        _rope.SetActive(false);
        _onStage = true;
    }
    
    
    /*public IEnumerator OldArriveOnStage(float duration = 8.0f)
    {
        _arriveCoroutine = true;
        //Debug.Log($"{name} start arriving on stage");

        while (_leaveCoroutine)
        {
            //Debug.Log("Waiting leaving coroutine to finish");
            yield return null;
        }
        
        Vector3 targetPosition = GameManager.Instance._gridScene.GetWorldPositon(_coordsOnStatge);
        
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
        //Debug.Log($"{gameObject.name} is now on stage");
        
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
        //Debug.Log($"{gameObject.name}.Rope is done");

        _onStage = true;
        _arriveCoroutine = false;
    }
    public IEnumerator OldLeaveStage(float duration = 2.0f)
    {
        _leaveCoroutine = true;
        //Debug.Log($"{name} start leaving stage");
        
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
            //Debug.Log($"LeaveStage: {time}/{duration}");
            transform.position = Vector3.Lerp(startPosition, targetPosition, 
                _character.movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        // Character is up
        //transform.position = new Vector3(-100, -100, -100);
        //Debug.Log($"{gameObject.name} has leave the stage");
        _onStage = false;
        _anim.SetBool("falling", false);
        _leaveCoroutine = false;
    }*/
    
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
        //Debug.Log("playing sound Play_VOX_" + characterName + "_Emotion_" + emotionName);
        if (characterName == "Naïda")
        {
            AkSoundEngine.PostEvent("Play_VOX_Naida_Emotion_" + emotionName, gameObject);
        }
        else
        {
            AkSoundEngine.PostEvent("Play_VOX_" + characterName + "_Emotion_" + emotionName, gameObject);
        }
    }

    #region Gizmos

    void OnDrawGizmosSelected()
    {
        if (_lookAt != Vector3.zero)
        {
            //Debug.Log($"Gizmos: {transform.position} to {_lookAt}");
            Gizmos.color = Color.red;
            Gizmos.DrawLine(transform.position, _lookAt + 5.0f * (_lookAt - transform.position));
        }
        
        
    }

    #endregion
}