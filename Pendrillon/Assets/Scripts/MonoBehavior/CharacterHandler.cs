using System;
using System.Collections;
using UnityEngine;
using TMPro;
using UnityEngine.Events;

public class CharacterHandler : MonoBehaviour
{
    public Character character;

    public string _tempCharName;

    public Canvas canvas;
    public TextMeshProUGUI nameText;
    public TextMeshProUGUI dialogueText;

    public Vector2Int coordsOnStatge;

    //public UnityEvent<string> Dialogue;

    // Movements attributes
    // 
    
    
    private void Awake()
    {
        //nameText.text = character.name;
        //nameText.text = _tempCharName;
        //dialogueText.text = String.Empty;

    }

    void Start()
    {
        //SetPosition(coordsOnStatge);
    }
    
    public void UpdateDialogue(string text)
    {
        canvas.gameObject.SetActive(true);
        //dialogueText.text = text;
    }

    public void ClearUI()
    {
        //dialogueText.text = String.Empty;
        canvas.gameObject.SetActive(false);
    }

    public void SetPosition(Vector2Int positionOnStage)
    {
        transform.position = GameManager.Instance.gridScene.GetCell(positionOnStage).position;
    }
    
    public void Move(Vector2Int destination)
    {
        Vector3 end = GameManager.Instance.gridScene.GetCell(destination).position;
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
}