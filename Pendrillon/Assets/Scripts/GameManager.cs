using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.InputSystem;

public class GameManager : MonoBehaviour
{
    private List<Dialogue> _dialogues = new List<Dialogue>();

    public TextMeshProUGUI dialogueText;

    public int index;
    public float textSpeed;
    
    
    void Start()
    {
        Dialogue dialogue1 = new Dialogue("First dialogue", "Sigmund", "Calm");
        Dialogue dialogue2 = new Dialogue("Second dialogue", "Camille", "Happy");
        Dialogue dialogue3 = new Dialogue("Thrid dialogue", "Sigmund", "Aggressive");
        
        
        _dialogues.Add(dialogue1);
        _dialogues.Add(dialogue2);
        _dialogues.Add(dialogue3);
        
        
        dialogueText.text = String.Empty;
        StartDialogue();
    }

    void Update()
    {
        
    }

    void StartDialogue()
    {
        index = 0;
        dialogueText.text = _dialogues[index].To_String();
        Debug.Log(_dialogues[index].To_String());
        //StartCoroutine(TypeLine());
    }

    public void NextLine(InputAction.CallbackContext context)
    {
        if (context.performed)
        {
            if (index >= _dialogues.Count)
            {
                gameObject.SetActive(false);
            }
            else
            {
                index++;
                dialogueText.text = String.Empty;
                dialogueText.text = _dialogues[index].To_String();
            }
        }
    }

    IEnumerator TypeLine()
    {
        foreach (char c in _dialogues[index]._dialogue.ToCharArray())
        {
            dialogueText.text += c;
            yield return new WaitForSeconds(textSpeed);
        }
    }
}
