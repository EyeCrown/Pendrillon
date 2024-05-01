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

    public Story _story;

    public List<GameObject> charactersOnStage;
    
    // UI
    public Canvas canvas;
    public GameObject uiParent;
    // Text box
    public TextMeshProUGUI dialogueText;
    
    // Tags box
    public TextMeshProUGUI tagsText;
    
    // Buttons
    public Button choiceButtonPrefab;
    public List<Button> choicesButtonList;
    public Button nextDialogueButton;
    public Button backButton;

    private string currentDialogue;
    
    private Stack<string> savedJsonStack;
    
    public UnityEvent startActingPhase;
    public UnityEvent nextDialogue;
    public UnityEvent<List<String>> endOfActingPhase;
    public UnityEvent clearUI;
    
    
    
   private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
            return;
        }

        Instance = this;
        DontDestroyOnLoad(this.gameObject);
        
        startActingPhase.AddListener(StartStory);
        endOfActingPhase.AddListener(CloseUI);
    }

    void Start()
    {
    }

    private void StartStory()
    {
        uiParent.gameObject.SetActive(true);
        _story = new Story(GameManager.Instance.inkAsset.text);
        savedJsonStack = new Stack<string>();


        GameManager.Instance.GetCharacter("PLAYER").character.charisma.SetupBase((int)_story.variablesState["p_char"]);
        GameManager.Instance.GetCharacter("PLAYER").character.strength.SetupBase((int)_story.variablesState["p_stre"]);
        GameManager.Instance.GetCharacter("PLAYER").character.dexterity.SetupBase((int)_story.variablesState["p_dext"]);
        GameManager.Instance.GetCharacter("PLAYER").character.constitution.SetupBase((int)_story.variablesState["p_comp"]);
        GameManager.Instance.GetCharacter("PLAYER").character.luck.SetupBase((int)_story.variablesState["p_luck"]);
        
        Debug.Log($"AM.StartStory() > GameManager.Instance.GetCharacter(\"PLAYER\").character:{GameManager.Instance.GetCharacter("PLAYER").character.ToString()}");
        
        Debug.Log(_story);
        
        Refresh();
    }

    public void Clear()
    {
        dialogueText.text = String.Empty;
        tagsText.text = "Tags:\n";

        foreach (var button in choicesButtonList)
        {
            Destroy(button.gameObject);
        }
        choicesButtonList.Clear();
        
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
            //Debug.Log(currentDialogue);
            
            if (currentDialogue == String.Empty)
                Refresh();
            
            currentDialogue = currentDialogue.Trim();

            savedJsonStack.Push(_story.state.ToJson());
            
            currentDialogue = ParseDialogue(currentDialogue);
            
            dialogueText.text += currentDialogue;

            Debug.Log($"AC.Refresh() > _story.state.currentPathString:{_story.state.currentPathString}");
            CheckBeginOfFight(_story.state.currentPathString);
            
            
            /*var output = new List<string>();
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
            }*/
            
            // Tags
            if (_story.currentTags.Count > 0)
            {
                foreach (var tag in _story.currentTags)
                {
                    tagsText.text += tag.Trim() + "\n";
                    //ParseTag(tag);
                }
            }
            

            // Choices
            if (_story.currentChoices.Count > 0)
            {
                Vector2 buttonPos = new Vector2(115, 100);
                for (int i = 0; i < _story.currentChoices.Count; i++)
                {
                    Choice choice = _story.currentChoices[i];
                    Button button = Instantiate(choiceButtonPrefab, uiParent.transform);
                    button.GetComponent<RectTransform>().position = buttonPos;
                    button.GetComponentInChildren<TextMeshProUGUI>().text = _story.currentChoices[i].text;
                    
                    button.onClick.AddListener (delegate {
                        OnClickChoiceButton (choice);
                    });
                    buttonPos.x += button.GetComponent<RectTransform>().sizeDelta.x + 10;
                    choicesButtonList.Add(button);
                    Debug.Log($"AM.Refresh() > button.GetComponentInChildren<TextMeshProUGUI>().text:{button.GetComponentInChildren<TextMeshProUGUI>().text}");
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
            
            // Button button = choicesButtonList[0];
            // button.gameObject.SetActive(true);
            // TextMeshProUGUI textButton = button.GetComponentInChildren<TextMeshProUGUI>();
            // textButton.text = "Restart?";
            // button.onClick.AddListener(delegate{
            //     StartStory();
            // });
            
        }
    }

    void CheckBeginOfFight(String path)
    {
        if (path == null)
        {
            return;
        }
        
        String[] words = path.Split(".");

        if (words.Length <= 1)
            return;
        
        Debug.Log($"AC.CheckBeginOfFight > words[1]:{words[1]}");
        
        String marcello = "MARCELLO";
        String rudolf = "RUDOLF";
        List<String> enemies = new List<string>();
        
        switch (words[1])
        {
            case "battle_against_two_guards":
                enemies.Add(marcello);
                enemies.Add(rudolf);
                Debug.Log($"AC.CheckBeginOfFight > battle_against_two_guards");
                endOfActingPhase.Invoke(enemies);

                break;
            case "battle_against_marcello":
                enemies.Add(marcello);
                Debug.Log($"AC.CheckBeginOfFight > battle_against_marcello");
                endOfActingPhase.Invoke(enemies);

                break;
            case "battle_against_rudolf":
                enemies.Add(rudolf);
                Debug.Log($"AC.CheckBeginOfFight > battle_against_rudolf");
                endOfActingPhase.Invoke(enemies);

                break;
        }
        

    }

    void CloseUI(List<String> list)
    {
        Debug.Log("AM.CloseUI()");
        uiParent.gameObject.SetActive(false);
    }

    public String ParseDialogue(String text)
    {
        String[] words = text.Split(":");
        String speaker = words[0].Replace(" ", "");
        String result = String.Join(":", words.Skip(1));
        
        HandlerTagChar(speaker, result);

        return result;
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
                //HandlerTagChar(words[1]);
                break;
            
            case Constants.TagMove:
                HandlerTagMove(words[1]);
                break;
                
            case Constants.TagPlaySound:
                
                GameManager.Instance._wwiseEvent.Post(gameObject);
                break;
            default:
                //Debug.LogError("ActingManager.CheckTab(.) > Error: tag unknown.");
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

    private void HandlerTagChar(string character, string text)
    {
        dialogueText.text += character + ": ";
        CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);
        //Debug.Log($"AM.HandlerTagChar > {character} <> {text}");
        
        characterHandler?.Dialogue.Invoke(text);
        
        characterHandler?.UpdateDialogue(text);
        
    }


    private void HandlerTagMove(string coordonates)
    {
        string[] words = tag.Split(",");
        string character = words[0];
        string x = words[1];
        string y = words[2];
        
        //Debug.Log($"{character} wants to go to [{x},{y}].   Size of words[]: {words.Length}");
        
        CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);
        characterHandler?.Move(new Vector2Int(Int32.Parse(x), Int32.Parse(y)));
        
    }

    #endregion





}
