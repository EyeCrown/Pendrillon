using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using TMPro;

public class DialogueManager : MonoBehaviour
{
    public TextMeshProUGUI textComponent;
    public string[] lines;
    public float textSpeed;

    private int index;
    
    // Start is called before the first frame update
    void Start()
    {
        textComponent.text = String.Empty;
        StartDialogue();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void StartDialogue()
    {
        index = 0;
        StartCoroutine(TypeLine());
    }

    public void NextLine(InputAction.CallbackContext context)
    {
        if (context.performed)
        {
            Debug.Log("Dialogue::NextLine() > Iteration " + index);
            if (index < lines.Length-1)
            {
                if (textComponent.text == lines[index])
                {
                    index++;
                    textComponent.text = String.Empty;
                    StartCoroutine(TypeLine());
                }
                else
                {
                    textComponent.text = lines[index];
                    StopAllCoroutines();
                }
            }
            else
            {
                gameObject.SetActive(false);
            }
        }
    }

    IEnumerator TypeLine()
    {
        foreach (char c in lines[index].ToCharArray())
        {
            textComponent.text += c;
            yield return new WaitForSeconds(textSpeed);
        }
    }
}
