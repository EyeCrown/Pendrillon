using System;
using System.Collections;
using MonoBehavior.Managers;
using UnityEngine;
using TMPro;
using UnityEngine.Events;

public class CharacterHandler : MonoBehaviour
{
    #region Attributes

    public Character _character;

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
        ActingManager.Instance.ClearUI.AddListener(OnClearUI);
        DialogueUpdate.AddListener(OnDialogueUpdate);
        
        _canvas         = transform.Find("Canvas").GetComponent<Canvas>();
        _uiActing       = transform.Find("Canvas/ACTING_PART").gameObject;
        _nameText       = _uiActing.transform.Find("NameBox/NameText").GetComponent<TextMeshProUGUI>();
        _dialogueText   = _uiActing.transform.Find("DialogueBox/DialogueText").GetComponent<TextMeshProUGUI>();

        _canvas.worldCamera = Camera.main;
        _canvas.gameObject.SetActive(true);

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


    #region EventHandlers

    private void OnClearUI()
    {
        _dialogueText.text = String.Empty;
        _uiActing.SetActive(false);
    }

    public void OnUpdateDialogue(String dialogue)
    {
        //Debug.Log($"CharacterHandler.OnDialogueUpdate > {_character.name}:{text}");
        _uiActing.SetActive(true);
        _dialogueText.text = dialogue;
        //Debug.Log($"CharacterHandler.OnDialogueUpdate > _dialogueText.text:{_dialogueText.text}");
    }

    #endregion
}