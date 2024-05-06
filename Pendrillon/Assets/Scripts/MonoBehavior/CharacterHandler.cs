using System;
using System.Collections;
using MonoBehavior.Managers;
using UnityEngine;
using TMPro;
using UnityEngine.Events;

public class CharacterHandler : MonoBehaviour
{
    #region Attributes

    public Character character;

    public Canvas _canvas;
    public TextMeshProUGUI nameText;
    public TextMeshProUGUI _dialogueText;

    public Vector2Int coordsOnStatge;

    public UnityEvent<string> DialogueUpdate;

    // Movements attributes
    // 

    #endregion


    #region UnityAPI

    private void Awake()
    {
        //nameText.text = character.name;
        //nameText.text = _tempCharName;
        //_dialogueText.text = String.Empty;
        
        DialogueUpdate.AddListener(UpdateDialogue);
        
        _canvas.worldCamera = Camera.main;
        _canvas.gameObject.SetActive(true);
    }

    void Start()
    {
        nameText.text = character.name;
        ActingManager.Instance.ClearUI.AddListener(OnClearUI);
        Debug.Log($"{character.name} se réveille.");

        //SetPosition(coordsOnStatge);
        
    }

    #endregion
    
    public void UpdateDialogue(string text)
    {
        //Debug.Log($"CharacterHandler.UpdateDialogue > {character.name}:{text}");
        _canvas.gameObject.SetActive(true);
        _dialogueText.text = text;
        //Debug.Log($"CharacterHandler.UpdateDialogue > _dialogueText.text:{_dialogueText.text}");
    }

    

    public void SetPosition(Vector2Int positionOnStage)
    {
        transform.position = GameManager.Instance._gridScene.GetCell(positionOnStage).position;
    }
    
    public void Move(Vector2Int destination)
    {
        Vector3 end = GameManager.Instance._gridScene.GetCell(destination).position;
        float duration = 3.0f;

        StartCoroutine(LerpPosition(end, duration));
    }
    
    IEnumerator LerpPosition(Vector3 targetPosition, float duration)
    {
        float time = 0.0f;
        Vector3 startPosition = transform.position;

        while (time < duration)
        {
            transform.position = Vector3.Lerp(startPosition, targetPosition, character.movementCurve.Evaluate(time/duration));
            time += Time.deltaTime;
            yield return null;
        }
        transform.position = targetPosition;
    }

    private void OnClearUI()
    {
        _dialogueText.text = String.Empty;
        _canvas.gameObject.SetActive(false);
    }

    public void OnUpdateDialogue(String dialogue)
    {
        //Debug.Log($"CharacterHandler.UpdateDialogue > {character.name}:{text}");
        _canvas.gameObject.SetActive(true);
        _dialogueText.text = dialogue;
        //Debug.Log($"CharacterHandler.UpdateDialogue > _dialogueText.text:{_dialogueText.text}");
    }
}