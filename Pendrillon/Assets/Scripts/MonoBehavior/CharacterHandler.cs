using System;
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

    //public UnityEvent<string> Dialogue;
    
    private void Awake()
    {
        nameText.text = character.name;
        //nameText.text = _tempCharName;
        dialogueText.text = String.Empty;
    }

    public void UpdateDialogue(string text)
    {
        canvas.gameObject.SetActive(true);
        dialogueText.text = text;

    }

    public void ClearUI()
    {
        dialogueText.text = String.Empty;
        canvas.gameObject.SetActive(false);
    }
}
