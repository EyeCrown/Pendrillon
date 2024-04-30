using System;
using System.Collections.Generic;
using System.Linq;
using Ink.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;

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

    private string currentDialogue;
    
    private Stack<string> savedJsonStack;
    
    public UnityEvent startActingPhase;
    public UnityEvent nextDialogue;
    public UnityEvent endOfActingPhase;
    public UnityEvent clearUI;
    
    
    
   private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
            return;
        }

        Instance = this;
    }

    void Start()
    {
        StartStory();
    }

    private void StartStory()
    {
        _story = new Story(GameManager.Instance.inkAsset.text);
        savedJsonStack = new Stack<string>();

        Debug.Log(_story);
        
        Refresh();
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

        // Clear UI of every character on stage
        foreach (var characterHandler in GameManager.Instance.characters)
        {
            characterHandler.ClearUI();
        }
    }

    public void Refresh()
    {
        Clear();
        clearUI.Invoke();
        
        currentDialogue = String.Empty;
        
        if(savedJsonStack.Count != 0)
            backButton.gameObject.SetActive(true);
        
        if (_story.canContinue)
        {
            
            currentDialogue = _story.Continue();
            currentDialogue = currentDialogue.Trim();

            savedJsonStack.Push(_story.state.ToJson());

            currentDialogue = ParseDialogue(currentDialogue);
            
            var output = new List<string>();
            var knots = _story.mainContentContainer.namedContent.Keys;
            knots.ToList().ForEach((knot) =>
            {
                output.Add(knot);

                var container = _story.KnotContainerWithName(knot);
                var stitchKeys = container.namedContent.Keys;
                stitchKeys.ToList().ForEach((stitch) =>
                {
                    output.Add(knot + "." + stitch);
                });
            });

            foreach (var text in output)
            {
                Debug.Log(text);
            }
            
            // Tags
            if (_story.currentTags.Count > 0)
            {
                foreach (var tag in _story.currentTags)
                {
                    tagsText.text += tag.Trim() + "\n";
                    ParseTag(tag);
                }
            }
            else
            {
                dialogueText.text += currentDialogue + "\n";
            }
            

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
            
            endOfActingPhase.Invoke();
        }
    }

    public String ParseDialogue(String text)
    {
        String[] words = text.Split(":");
        
        HandlerTagChar(words[0].Replace(" ", ""));

        return words[1];
    }


    public void ParseTag(string tag)
    {
        Debug.Log(tag);
        string[] words = tag.Split(Constants.Separator);
        
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
            case Constants.TagCharacter:
                HandlerTagChar(words[1]);
                break;
            
            case Constants.TagMove:
                HandlerTagMove(words[1]);
                break;
                
            case Constants.TagPlaySound:
                
                GameManager.Instance._wwiseEvent.Post(gameObject);
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

    private void HandlerTagChar(string character)
    {
        Debug.Log(character + " is speaking");

        dialogueText.text += character + ": ";

        CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);
        
        characterHandler?.UpdateDialogue(currentDialogue);
    }


    private void HandlerTagMove(string coordonates)
    {
        string[] words = tag.Split(",");
        string character = words[0];
        string x = words[1];
        string y = words[2];
        
        Debug.Log($"{character} wants to go to [{x},{y}].   Size of words[]: {words.Length}");
        
        CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);
        characterHandler?.Move(new Vector2Int(Int32.Parse(x), Int32.Parse(y)));
        
    }

    #endregion





}
