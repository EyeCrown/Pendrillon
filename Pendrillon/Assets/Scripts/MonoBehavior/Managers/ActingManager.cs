using System;
using System.Collections;
using System.Collections.Generic;
using Ink.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ActingManager : MonoBehaviour
{
    public static ActingManager Instance { get; private set; }

    public TextAsset inkAsset;
    public Story _story;
    
    // UI
    
    // Text box
    public TextMeshProUGUI dialogueText;
    
    // Tags box
    public TextMeshProUGUI tagsText;
    
    // Buttons
    public List<Button> choicesButtonList;
    public Button nextDialogueButton;
    public Button backButton;
    
    
    private Stack<string> savedJsonStack;
   
    
    
   private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
            return;
        }

        Instance = this;

        StartStory();
    }

    private void StartStory()
    {
        _story = new Story(inkAsset.text);
        savedJsonStack = new Stack<string>();

        Debug.Log(_story.ob);
        
        
        Refresh();
    }
   
    private void GenerateTheaterEvents()
    {
        _story = new Story(inkAsset.text);

        while (_story.canContinue)
        {
            Debug.Log(_story.Continue());
            
            if( _story.currentChoices.Count > 0 )
            {
                for (int i = 0; i < _story.currentChoices.Count; ++i) {
                    Choice choice = _story.currentChoices [i];
                    Debug.Log("Choice " + (i + 1) + ". " + choice.text);
                }
            }

        }
        
        
    }

    public void Clear()
    {
        dialogueText.text = String.Empty;
        tagsText.text = "Tags:\n";

        foreach (var button in choicesButtonList)
        {
            TextMeshProUGUI textButton = button.GetComponentInChildren<TextMeshProUGUI>();
            textButton.text = String.Empty;
            
            button.gameObject.SetActive(false);
        }
        nextDialogueButton.gameObject.SetActive(false);
        backButton.gameObject.SetActive(false);

    }

    public void Refresh()
    {
        Clear();

        String dialogue = String.Empty;
        
        if(savedJsonStack.Count != 0)
            backButton.gameObject.SetActive(true);
        
        if (_story.canContinue)
        {
            dialogue = _story.Continue();
            
            savedJsonStack.Push(_story.state.ToJson());

            // Tags
            foreach (var tag in _story.currentTags)
            {
                tagsText.text += tag.Trim() + "\n";
                ParseTag(tag);
            }
            
            // Text
            // while (_story.canContinue)
            // {
            //     
            // }
            dialogue = dialogue.Trim();
    
            dialogueText.text += dialogue + "\n";

            // Choices
            if (_story.currentChoices.Count > 0)
            {
                int numberChoices = Math.Min(4, _story.currentChoices.Count);

                for (int i = 0; i < numberChoices; i++)
                {
                    Choice choice = _story.currentChoices [i];
                    Button button = choicesButtonList[i];
                    button.gameObject.SetActive(true);

                    TextMeshProUGUI textButton = button.GetComponentInChildren<TextMeshProUGUI>();
                    textButton.text = _story.currentChoices[i].text;
                    
                    button.onClick.AddListener (delegate {
                        OnClickChoiceButton (choice);
                    });
                }
            }
            else //if(!_story.canContinue)
            {
                nextDialogueButton.gameObject.SetActive(true);
            }
            
        }
        else
        {
            Debug.Log("Reach end of content.");
            Button button = choicesButtonList[0];
            button.gameObject.SetActive(true);
            TextMeshProUGUI textButton = button.GetComponentInChildren<TextMeshProUGUI>();
            textButton.text = "Restart?";
            button.onClick.AddListener(delegate{
                StartStory();
            });
        }
    }


    public void ParseTag(string tag)
    {
        Debug.Log(tag);
        string[] words = tag.Split("=");
        
        foreach (var word in words)
        {
            Debug.Log("word: " + word);
        }

        CheckTag(words);
        
    }


    private void CheckTag(string[] words)
    {
        switch (words[0])
        {
            case Constants.tagCharacter:
                HandlerTagChar(words[1]);
                break;
            
            default:
                Debug.LogError("ActingManager.CheckTab(.) > Error: tag unknown.");
                break;
        }

    }
    
    
    
    

    public void OnClickChoiceButton (Choice choice) {
        _story.ChooseChoiceIndex (choice.index);
        Refresh();
    }

    public void OnClickBackButton()
    {
        _story.state.LoadJson(savedJsonStack.Pop());
        Refresh();

    }


    #region TagHandlers

    private void HandlerTagChar(string author)
    {
        Debug.Log(author + " is speaking");

        dialogueText.text += author + ": ";
    }


    #endregion





}
