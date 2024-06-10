using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using Febucci.UI.Core;
using Ink.Runtime;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.InputSystem;
using UnityEngine.UI;

namespace MonoBehavior.Managers
{
    public class ActingManager : MonoBehaviour
    {
        /*enum ActState
        {
            Choose,
            Wait,
            Next,
        }*/
        
        #region Attributes
        public static ActingManager Instance { get; private set; }
        
        // Scene
        public string _stage = "";//Constants.FirstSetOnStage;

        #region Set Attributes
        [Header("=== Sets ===")]
        public GameObject _setBarge;
        public GameObject _setCale;
        public GameObject _setPort;
        public GameObject _setChurch;
        public GameObject _setTrial;
        public GameObject _setTempest;
        public GameObject _setForest;
        private GameObject _currentSet;

        #endregion

        #region UI Attributes
        [HideInInspector] public GameObject _uiParent { get; private set; }
        GameObject _dialogueBox;
        TextMeshProUGUI _dialogueText;  // Text box
        TextMeshProUGUI _speakerText;   // Text box
        TextMeshProUGUI _tagsText;  // Tags box
        GameObject _historyBox;     // History box
        GameObject _masks;
        private string _playerName;
        
        // UI - ParticuleSystems
        private ParticleSystem _particleSystemBoo;
        private ParticleSystem _particleSystemThumbUp;
        private ParticleSystem _particleSystemCry;
        private ParticleSystem _particleSystemLaugh;
        
        // UI - TypeWriters
        private TypewriterCore _dialogueTypewriter;
        private TypewriterCore _prompterTypewriter;
        
        TextMeshProUGUI _historyText;
        RawImage _nextDialogueIndicator;
        readonly float _minButtonPosX = -960;
        readonly float _maxButtonPosX =  960;
        float _buttonPosY =  -260;

        [HideInInspector] public string _choiceType;
        
        #endregion

        #region Button Attributes

        [Header("=== Buttons ===")]
        [SerializeField] Button _choiceButtonLeftPrefab;
        [SerializeField] Button _choiceButtonMiddlePrefab;
        [SerializeField] Button _choiceButtonRightPrefab;
        public List<Button> _choicesButtonList;

        #endregion

        [Header("=== Wheel ===")]
        public Wheel _wheel;
        /*[HideInInspector]*/ public bool _canContinueDialogue;

        [Header("=== Map ===")] 
        public Map _map;
        
        // Dialogue
        string _currentDialogue;
        //Stack<string> savedJsonStack;
        bool mustWait = false;
        readonly float _timeToWait = 0.0f;

        // Tag list ordering
        List<Action> _tagMethods = new();
        bool _isActionDone = false;
        bool _dialogueAlreadyHandle = false;

        readonly Dictionary<string, Vector3> _directions = new Dictionary<string, Vector3>();
        
        
        #region Wwise Attributes

        [Header("=== Wwise attributes ===")]
        [SerializeField] private AK.Wwise.Event _wwiseChoiceDialogueButton;

        /* Cet event est lancé depuis le bouton vert d'UI
         [SerializeField] private AK.Wwise.Event _wwiseNextDialogueButton; */
        [SerializeField] private AK.Wwise.Event _wwiseBackButton;
        [SerializeField] private AK.Wwise.Event _wwiseChoiceDialogueButtonAppears;
        [SerializeField] private AK.Wwise.Event _wwiseDialogAppears;
        #endregion
        
        #endregion

        #region Events
        
        [HideInInspector] public UnityEvent PhaseStart;
        [HideInInspector] public UnityEvent PhaseEnded;
        [HideInInspector] public UnityEvent NextDialogue;
        [HideInInspector] public UnityEvent ClearUI;
    
        #endregion
    
        #region UnityAPI
        void Awake()
        {
            // Singleton pattern
            if (Instance != null && Instance != this)
            {
                Destroy(this);
                return;
            }
            Instance = this;
        
            // Connect Attributes
            _uiParent = GameObject.Find("Canvas/ACTING_PART").gameObject;
            _dialogueBox    = _uiParent.transform.Find("DialogueBox").gameObject;
            _dialogueText   = _uiParent.transform.Find("DialogueBox/DialogueText").GetComponent<TextMeshProUGUI>();
            _speakerText    = _uiParent.transform.Find("DialogueBox/SpeakerText").GetComponent<TextMeshProUGUI>();
            _masks          = _uiParent.transform.Find("DialogueBox/Masks").gameObject;
            _tagsText       = _uiParent.transform.Find("TagsText").GetComponent<TextMeshProUGUI>();
            _nextDialogueIndicator = _uiParent.transform.Find("NextDialogueIndicator").GetComponent<RawImage>();
            _historyBox     = _uiParent.transform.Find("History").gameObject;
            _historyText    = _historyBox.transform.Find("Scroll View/Viewport/Content").GetComponent<TextMeshProUGUI>();

            _particleSystemBoo = _uiParent.transform.Find("UIParticleBoo").GetComponentInChildren<ParticleSystem>();
            _particleSystemCry = _uiParent.transform.Find("UIParticleCry").GetComponentInChildren<ParticleSystem>();
            
            _dialogueTypewriter = _dialogueText.GetComponent<TypewriterCore>();
            _prompterTypewriter = _uiParent.transform.Find("PROMPTER_PART/DialogueBox/DialogueText").GetComponent<TypewriterCore>();

            _wheel = GameObject.Find("WheelSupport").GetComponent<Wheel>();
            _map = GameObject.Find("Map").GetComponent<Map>();
            
            if (_dialogueTypewriter == null)
                Debug.LogError("AHH");
            if (_prompterTypewriter == null)
                Debug.LogError("OHH");
            
            var dirPos = GameObject.Find("Directions").transform.position;
            // Front
            _directions.Add(Constants.StageFront, dirPos + new Vector3(30, 0, 0));
            // Back
            _directions.Add(Constants.StageBack, dirPos + new Vector3(-30, 0, 0));
            // Garden
            _directions.Add(Constants.StageGarden, dirPos + new Vector3(0, 0, -30));
            // Courtyard
            _directions.Add(Constants.StageCourtyard, dirPos + new Vector3(0, 0, 30));

            foreach (var pair in _directions)
            {
                Debug.Log($"Awake > {pair.Key}: {pair.Value}");
            }
            
            
            _nextDialogueIndicator.gameObject.SetActive(false);
            
            
            // Connect Events
            PhaseStart.AddListener(OnPhaseStart);
            PhaseEnded.AddListener(OnPhaseEnded);
            ClearUI.AddListener(OnClearUI);
        
            // _dialogueTypewriter.onTextShowed.AddListener(DialogueTextFinished);
            // _prompterTypewriter.onTextShowed.AddListener(PrompterTextFinished);
            
            _setBarge   = Instantiate(_setBarge,  GameObject.Find("Environment").transform);
            _setCale    = Instantiate(_setCale,   GameObject.Find("Environment").transform);
            //_setPort    = Instantiate(_setPort,   GameObject.Find("Environment").transform);
            _setChurch  = Instantiate(_setChurch, GameObject.Find("Environment").transform);
            //_setTrial   = Instantiate(_setTrial,   GameObject.Find("Environment").transform);
            _setTempest = Instantiate(_setTempest, GameObject.Find("Environment").transform);
            _setForest  = Instantiate(_setForest,  GameObject.Find("Environment").transform);
            
            _canContinueDialogue = true;
        }

        void Start()
        {
            _uiParent.SetActive(false);
        }
        
        void Update()
        {
            
            _dialogueBox.GetComponent<Image>().color = new Color(
                _dialogueBox.GetComponent<Image>().color.r,
                _dialogueBox.GetComponent<Image>().color.g,
                _dialogueBox.GetComponent<Image>().color.b,
                GameManager.Instance._opacityUI
            );
            var speakerBox = _uiParent.transform.Find("PROMPTER_PART/DialogueBox");
            speakerBox.GetComponent<RawImage>().color = new Color(
                speakerBox.GetComponent<RawImage>().color.r,
                speakerBox.GetComponent<RawImage>().color.g,
                speakerBox.GetComponent<RawImage>().color.b,
                GameManager.Instance._opacityUI
            );

            foreach (Transform mask in _masks.transform)
            {
                mask.GetComponent<Image>().color = new Color(
                    mask.GetComponent<Image>().color.r,
                    mask.GetComponent<Image>().color.g,
                    mask.GetComponent<Image>().color.b,
                    GameManager.Instance._opacityUI
                );
            }
        }
        
        #endregion

        #region Methods

        public void Refresh()
        {
            ClearUI.Invoke();

            AkSoundEngine.PostEvent("Stop_VOX_ALL", gameObject); //Stoppe toutes les voix en cours de lecture

            _dialogueAlreadyHandle = false;
            _currentDialogue = String.Empty;
        
            
            if (GameManager.Instance._story.canContinue)
            {
                _currentDialogue = GameManager.Instance._story.Continue();
                Debug.Log($"AM.Refresh > _currentDialogue:{_currentDialogue}");
                
                // Add to history
                //_historyText.text += _currentDialogue + "\n";
                
                // var path = GameManager.Instance._story.state.currentPathString;
                // Debug.Log($"AM.Refresh > _story.state.currentPathString: {path}");

                // string[] words = path != null ? path.Split(".") : new []{_stage};
                // Debug.Log($"AM.Refresh > Location: {words[0]}");
                
                HandleTags();
                HandleDialogue();
                //HandleChoices();

                if (IsCurrentDialogueNotValid() && !GameManager.Instance._story.currentChoices.Any())
                {
                    Debug.Log($"AM.Refresh > RECURSIVE CALL");
                    Refresh();
                    return;
                }
                
                StartCoroutine(ExecuteTagMethods());
            }
            else
            {
                Debug.Log("Story cannot continue.");
            }
        }

        
        void HandleDialogue()
        {
            if (!_dialogueAlreadyHandle)
            {
                if (IsCurrentDialogueNotValid())
                    return;
                
                //Debug.Log($"AM.HandleDialogue > Dialogue > {_currentDialogue} | Length: {_currentDialogue.Length}");
                _canContinueDialogue = true;
                
                // split dialogue in 2
                String[] words = _currentDialogue.Split(":");
                
                // foreach (var word in words)     Debug.Log($"AM.HandleDialogue > Part > {word}");
                
                // Check if there is a skillcheck
                if (words[0].Contains("]"))
                {
                    _canContinueDialogue = false;
                    string scoreText = words[0].Remove(words[0].IndexOf("]") + 1,
                        words[0].Length - (words[0].IndexOf("]") + 1));

                    string resultText = scoreText.Remove(scoreText.IndexOf("/")).Remove(0, 1);
                    int result = int.Parse(resultText);

                    string mustObtainText = scoreText.Remove(scoreText.IndexOf("/") + 4)
                        .Remove(0, scoreText.IndexOf("/") + 1);
                    int mustObtain = int.Parse(mustObtainText);
                    
                    Debug.Log($"AM.HandleDialogue > Contains skillcheck: {scoreText} | Result: {result} / MustObtain {mustObtain}");
                    
                    words[0] = words[0].Remove(0, words[0].IndexOf(']')+1).Trim();
                    
                    GameManager.Instance._playerInput.Player.Interact.performed += OnClickCloseSkillcheck;
                    _wheel.Spin(result, mustObtain, _choiceType);
                }
                else
                {
                    _canContinueDialogue = true;
                }
                
                HandleDialogueText(words);
            }
        }


        void HandleDialogueText(string[] words)
        {
            // get character speaking
            String speaker; 
            String dialogue;

            if (words.Length == 1)
            {
                Debug.LogError("ONLY ONE WORD");
                speaker = "ERROR";
                dialogue = _currentDialogue;
            }
            else
            {
                speaker = words[0].Trim();
                dialogue = String.Join(":", words.Skip(1));
            }
                
            Debug.Log($"AM.HandleDialogue > Speaker: {speaker}");
                
            if (speaker == "PLAYER")
                _speakerText.text = _playerName;
            else
                _speakerText.text = speaker;
                
            _tagMethods.Add(() =>
            {
                // send to character the dialogue
                if (speaker.ToLower() == Constants.PrompterName.ToLower())
                {
                    _prompterTypewriter.onTextShowed.AddListener(PrompterTextFinished);
                    GameManager.Instance._prompter.DialogueUpdate.Invoke(dialogue);
                    TagActionOver();
                }
                else
                {
                    var character = GameManager.Instance.GetCharacter(speaker);
                        
                    if (character == null)
                        Debug.LogError($"AM.{MethodBase.GetCurrentMethod()?.Name} > Unknown speaker | {speaker} |");
                    else
                    {
                        character.DialogueUpdate.Invoke(dialogue);
                        _masks.transform.Find(character.name.ToLower())?.gameObject.SetActive(true);
                    }

                        
                    // play sound
                    PlaySoundDialogAppears();
        
                    StartCoroutine(GenerateText(dialogue));
                }
            });
                
            _dialogueAlreadyHandle = true;
        }
        
    
        void HandleTags()
        {
            _tagMethods.Clear();
            if (GameManager.Instance._story.currentTags.Count > 0)
            {
                foreach (var tagName in GameManager.Instance._story.currentTags)
                {
                    _tagsText.text += tagName.Trim() + "\n";
                    ParseTag(tagName);
                }
            }
        }

        void HandleChoices()
        {
            //Debug.Log("Click += DisplayText");
            GameManager.Instance._playerInput.Player.Interact.performed += OnClickDisplayText;
            
            if (GameManager.Instance._story.currentChoices.Any())
            {
                GameManager.Instance._playerInput.Player.Interact.performed -= OnClickNextDialogue;

                StartCoroutine(GenerateButtonCoroutine());
            }
            else 
            {
                //Debug.Log("No choices, so click can display text");
            }
        }

        void GenerateButton(int index)
        {
            Choice choice = GameManager.Instance._story.currentChoices[index];
            Button button;

            int nbChoices = GameManager.Instance._story.currentChoices.Count;

            if (index < nbChoices/2)
            {
                button = Instantiate(_choiceButtonLeftPrefab, _uiParent.transform);
            }
            else if (nbChoices % 2 == 1 && index == nbChoices / 2)
            {
                button = Instantiate(_choiceButtonMiddlePrefab, _uiParent.transform);
            }
            else // (index > nbChoices / 2)
            {
                button = Instantiate(_choiceButtonRightPrefab, _uiParent.transform);
            }
            

            /*switch (GameManager.Instance._story.currentChoices.Count)
            {
                case 1 :
                    button = Instantiate(_choiceButtonMiddlePrefab, _uiParent.transform);
                    break;
                case 2:
                    button = Instantiate(index == 0 ? _choiceButtonLeftPrefab : _choiceButtonRightPrefab, _uiParent.transform);
                    break;
                case 3:
                    if (index == 0)
                        button = Instantiate(_choiceButtonLeftPrefab, _uiParent.transform);
                    else if (index == 1)
                        button = Instantiate(_choiceButtonMiddlePrefab, _uiParent.transform);
                    else
                        button = Instantiate(_choiceButtonRightPrefab, _uiParent.transform);
                    break;
                default:
                    return;
            }*/
            
            // Button Position
            float t = (float) (index + 1) / (GameManager.Instance._story.currentChoices.Count + 1);
            float xPos = Mathf.Lerp(_minButtonPosX, _maxButtonPosX, t);
            button.GetComponent<RectTransform>().anchoredPosition= new Vector2(xPos, _buttonPosY);
            
            // Button Text
            button.GetComponentInChildren<TextMeshProUGUI>().text = choice.text;
            
            // Button Type
            SetButtonType(button, choice);
            
            button.GetComponent<Image>().color = new Color(
                button.GetComponent<Image>().color.r,
                button.GetComponent<Image>().color.g,
                button.GetComponent<Image>().color.b,
                GameManager.Instance._opacityUI
            );

            button.interactable = false; // De base les boutons sont désactivées
            _choicesButtonList.Add(button);
            //Debug.Log($"AM.Refresh > button.GetComponentInChildren<TextMeshProUGUI>().text:{button.GetComponentInChildren<TextMeshProUGUI>().text}");
        }

        void SetButtonType(Button button, Choice choice)
        {
            foreach (var typeName in Constants.ButtonTypesArray)
            {
                if (choice.text.Contains(typeName))
                {
                    //Debug.Log($"AM.SetButtonType > This button is {typeName} > Wheel must appear");
                    button.transform.Find(typeName).gameObject.SetActive(true);
                    
                    button.onClick.AddListener (delegate {
                        OnClickChoiceButton (choice, typeName);
                    });
                    
                    return;
                }
            }
            //Debug.Log("AM.SetButtonType > This button is neutral");
            button.onClick.AddListener (delegate {
                OnClickChoiceButton (choice);
            });
        }
        
        void ChangePlayerName(string newName)
        {
            Debug.Log($"AM.ChangePleyrName > {newName}");
            _playerName = newName;
        }

        bool IsRopeActionRunning()
        {
            bool running = GameManager.Instance._player.IsRopeRunning();
            foreach (var character in GameManager.Instance._characters)
                running |= character.IsRopeRunning();

            return running;
        }

        bool IsCurrentDialogueNotValid()
        {
            return _currentDialogue == String.Empty || _currentDialogue.Length <= 1;
        }
        

        #endregion

        #region TypeWriting

        void DialogueTextFinished()
        {
            Debug.Log("Dialogue Text is finished");

            if (GameManager.Instance._story.canContinue)
            {
                GameManager.Instance._playerInput.Player.Interact.performed += OnClickNextDialogue;
                //Debug.Log("Click += NextDialogue");
                if (!GameManager.Instance._story.currentChoices.Any())
                    StartCoroutine(FadeImageCoroutine(_nextDialogueIndicator, 0, 1, 1.0f));
            }
        }


        void PrompterTextFinished()
        {
            Debug.Log("Prompter Text is finished");
            
            if (GameManager.Instance._story.canContinue)
            {
                GameManager.Instance._playerInput.Player.Interact.performed += OnClickNextDialogue;
                //Debug.Log("Click += NextDialogue");
                if (!GameManager.Instance._story.currentChoices.Any())
                    StartCoroutine(FadeImageCoroutine(_nextDialogueIndicator, 0, 1, 1.0f));
            }
        }


        #endregion
        
        
        #region ButtonHandlers

        #region NextButton
        public void OnClickNextDialogue(InputAction.CallbackContext context)
        {
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Call next dialogue || Refresh call || Click -= NextDialogue");
            GameManager.Instance._playerInput.Player.Interact.performed -= OnClickNextDialogue;
            Refresh();
        }

        public void OnClickDisplayText(InputAction.CallbackContext context)
        {
            //Debug.Log($"DisplayText > End the typewriter");

            if (_dialogueTypewriter.isShowingText)
            {
                //Debug.Log($"DisplayText > Dialogue TW");
                _dialogueTypewriter.SkipTypewriter();
            }

            if (_prompterTypewriter.isShowingText)
            {
                //Debug.Log($"DisplayText > Prompter TW");
                _prompterTypewriter.SkipTypewriter();
            }
            
            GameManager.Instance._playerInput.Player.Interact.performed -= OnClickDisplayText;
            //Debug.Log("Click -= NextDialogue");
            
        }

        public void OnClickCloseSkillcheck(InputAction.CallbackContext context)
        {
            Debug.Log($"CloseSkillcheck > close skillcheck window");
            StartCoroutine(_wheel.CloseScoreCoroutine());
            GameManager.Instance._playerInput.Player.Interact.performed -= OnClickCloseSkillcheck;
        }
        
        
        #endregion
        
        public void OnClickChoiceButton (Choice choice, string type = null)
        {
            _choiceType = type;
            _historyText.text += $"     > {choice.text}\n";
            GameManager.Instance._story.ChooseChoiceIndex(choice.index);
            Refresh();
        }
        
        public void OnClickHistory(InputAction.CallbackContext context)
        {
            Debug.Log($"AM.OnClickHistory");

            if (_historyBox.activeSelf)
            {
                Debug.Log($"AM.OnClickHistory > Hide history");
                _historyBox.SetActive(false);
                // if (status == ActState.Next)
                //     GameManager.Instance._playerInput.Player.Interact.performed += OnClickNextDialogue;
            }
            else
            {
                Debug.Log($"AM.OnClickHistory > Display history");
                _historyBox.SetActive(true);
                // if (status == ActState.Next)
                //     GameManager.Instance._playerInput.Player.Interact.performed -= OnClickNextDialogue;
            }
        }

        #endregion

        #region EventHandlers
        void OnPhaseStart()
        {
            _uiParent.SetActive(true);

            GameManager.Instance.GetPlayer()._character.charisma.SetupBase((int)GameManager.Instance._story.variablesState["p_char"]);
            GameManager.Instance.GetPlayer()._character.strength.SetupBase((int)GameManager.Instance._story.variablesState["p_stre"]);
            GameManager.Instance.GetPlayer()._character.dexterity.SetupBase((int)GameManager.Instance._story.variablesState["p_dext"]);
            GameManager.Instance.GetPlayer()._character.constitution.SetupBase((int)GameManager.Instance._story.variablesState["p_comp"]);
            GameManager.Instance.GetPlayer()._character.luck.SetupBase((int)GameManager.Instance._story.variablesState["p_luck"]);
        
            //Debug.Log($"AM.OnPhaseStart() > GameManager.Instance.GetCharacter(\"PLAYER\")._character:{GameManager.Instance.GetPlayer()._character}");
        
            _historyText.text = String.Empty;
            _historyBox.SetActive(false);

            _playerName = (string) GameManager.Instance._story.variablesState["p_name"];
            
            GameManager.Instance._story.ObserveVariable("p_name", (variableName, value) => 
                ChangePlayerName((string) value));
            
            Debug.Log($"AM.OnPhaseStart > Start story | Refresh call ");
            Refresh();
        }
        void OnPhaseEnded()
        {
            Debug.Log("AM.OnPhaseEnded()");
            // Clear UI
            _uiParent.SetActive(false);
            ClearUI.Invoke();
        }
        void OnClearUI()
        {
            _dialogueText.text = String.Empty;
            _tagsText.text = "Tags:\n";

            foreach (var button in _choicesButtonList)
            {
                Destroy(button.gameObject);
            }
            _choicesButtonList.Clear();
        
            _dialogueTypewriter.onTextShowed.RemoveListener(DialogueTextFinished);
            _prompterTypewriter.onTextShowed.RemoveListener(PrompterTextFinished);
            _dialogueBox.SetActive(false);
            
            // Clear masks
            foreach (Transform mask in _masks.transform)
            {
                mask.gameObject.SetActive(false);
            }
            
            
            StartCoroutine(FadeImageCoroutine(_nextDialogueIndicator, _nextDialogueIndicator.color.a, 0, 0.05f));

            //_nextDialogueIndicator.gameObject.SetActive(false);

        }
        
        #endregion
        
        
        #region TagHandlers

        void ParseTag(string tagName)
        {
            Debug.Log($"AM.ParseTag > Tag to parse: {tagName}");
            string[] words = tagName.Split(Constants.Separator);
        
            // foreach (var word in words)
            //     Debug.Log("word: " + word);

            CheckTag(words);
        }
        
        
        void CheckTag(string[] words)
        {
            switch (words[0])
            {
                case Constants.TagMove:     HandleTagMove(words.Skip(1).ToArray());     break;
                case Constants.TagPosition: HandleTagPosition(words.Skip(1).ToArray()); break;
                case Constants.TagSet:      HandleTagSet(words[1]);                         break;
                case Constants.TagPlaySound: HandleTagPlaysound(words[1]);                  break;
                case Constants.TagAnim:     HandleTagAnim(words.Skip(1).ToArray());     break;
                case Constants.TagWait:     HandleTagWait(words[1]);                        break;
                case Constants.TagSleep:    HandleTagSleep(words[1]);                       break;
                case Constants.TagBox:      HandleDialogue();                               break;
                case Constants.TagActor:    HandleTagActor(words.Skip(1).ToArray());    break;
                case Constants.TagScreenShake: HandleTagScreenShake(words);                 break;
                case Constants.TagLook:     HandleTagLook(words.Skip(1).ToArray());     break;
                case Constants.TagAudience: HandleTagAudience(words[1]);                    break;
                case Constants.TagRope:     HandleTagRope(words[1]);                        break;
                case Constants.TagMap:      HandleTagMap(words[1]);                         break;
                default: Debug.LogError($"AM.CheckTag > Error: {words[0]} is an unkwown tag."); break;
            }
        }
        
        void TagActionOver()
        {
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > TagAction is over =======");
            _isActionDone = true;
        }
        
        void HandleTagActor(string[] data)
        {
            string character = data[0];
            
            // string debugList = "";
            // foreach (var item in data)
            //     debugList += item + ", ";
            // Debug.Log($"AM.{MethodBase.GetCurrentMethod().Name} > {character}'s alias : {debugList}");
            
            CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);

            if (characterHandler == null)
            {
                Debug.LogError($"AM.HandlerTagActor > Error: Character {data[0]} is unvalid");
                return;
            }
            
            foreach (var nickname in data.Skip(1))
                characterHandler._character._nicknames.Add(nickname);
            
            //characterHandler.SetPosition(new Vector2Int(10, 10));
        }
        
        void HandleTagSet(string location)
        {
            Debug.Log($"AM.HandleTagSet > Change from {_stage} to {location}");
            _stage = location;
            
            // reset character._onStage 
            foreach (var character in GameManager.Instance._characters)
            {
                if (character._onStage)
                    StartCoroutine(character.LeaveStageCoroutine());
            }
            if (GameManager.Instance._player._onStage)
                StartCoroutine(GameManager.Instance._player.LeaveStageCoroutine());
            
            AkSoundEngine.PostEvent("Play_SFX_SC_Theater_TransitionTo" + location, gameObject);

            if (_currentSet != null)
            {
                var animator = _currentSet.GetComponent<Animator>();
                if (animator != null)
                    animator.SetBool("InOut",false);
            }

            GameManager.Instance.ClearStageCharacters();
            
            //_setBarge.SetActive(false);
            //_setCale.SetActive(false);
            //_setPort.SetActive(false);
            _setChurch.SetActive(false);
            //_setTrial.SetActive(false);
            _setTempest.SetActive(false);
            //_setForest.SetActive(false);
            
            GameManager.Instance.SetGridHeight();
            
            switch (_stage)
            {
                case Constants.SetBarge:
                    _setBarge.SetActive(true);
                    _setBarge.GetComponent<Animator>().SetBool("InOut",true);
                    _currentSet = _setBarge;
                    break;
                case Constants.SetCale:
                    _setCale.SetActive(true);
                    _setCale.GetComponent<Animator>().SetBool("InOut",true);
                    _currentSet = _setCale;
                    break;
                case Constants.SetPort:
                    _setPort.SetActive(true);
                    //_setPort.GetComponent<Animator>().SetBool("InOut",true);
                    _currentSet = _setPort;
                    break;
                case Constants.SetChuch:
                    _setChurch.SetActive(true);
                    //_setChurch.GetComponent<Animator>().SetBool("InOut",true);
                    _currentSet = _setChurch;
                    break;
                case Constants.SetTrial:
                    _setTrial.SetActive(true);
                    //_setTrial.GetComponent<Animator>().SetBool("InOut",true);
                    _currentSet = _setTrial;
                    break;
                case Constants.SetTempest:
                    _setTempest.SetActive(true);
                    //_setTempest.GetComponent<Animator>().SetBool("InOut",true);
                    _currentSet = _setTempest;
                    break;
                case Constants.SetForest:
                    _setForest.SetActive(true);
                    _setForest.GetComponent<Animator>().SetBool("InOut",true);
                    _currentSet = _setForest;
                    break;
                default:
                    Debug.LogError($"AM.HandleTagSet > Unknown location | {_stage} |");
                    break;
            }
            GameManager.Instance.SetGridHeight(_stage);
        }
        
        void HandleTagPosition(string[] data)
        {
            if (data.Length != 3)
            {
                string debugList = "";
                foreach (var item in data)
                    debugList += item + ", ";
                Debug.LogError($"AM.HandleTagPosition > Error: Wrong number of arguments | {debugList}");
                return;
            }

            var character = GameManager.Instance.GetCharacter(data[0]);
            if (character == null)
            {
                Debug.LogError($"AM.HandleTagPosition > Error: Character unvalid | {data[0]}");
                return;
            }

            //Debug.Log($"AM.HandleTagPosition > Set {data[0]} to position [{position.x}, {position.y}]");

            character._coordsOnStatge = new Vector2Int(int.Parse(data[1]), int.Parse(data[2]));
            
            StartCoroutine(character.ArriveOnStageCoroutine());
        }

        
        void HandleTagMove(string[] data)
        {
            if (data.Length < 3 || data.Length > 4) 
            {
                Debug.LogError($"AM.HandleTagAnim > Error: Wrong number of parameters | {data}");
                return;
            }
            //[] words = coordonates.Split(",");
            string character = data[0];
            string x = data[1];
            string y = data[2];
            string speed = data.Length == 4 ? data[3] : Constants.NormalName;

            CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);
            if (characterHandler == null)
            {
                Debug.LogError($"AM.HandleTagAnim > Error: Character unvalid | {data[0]}");
                return;
            }

            Vector2Int vector = new Vector2Int(Int32.Parse(x), Int32.Parse(y));
            
            //Debug.Log($"{character} wants to go to [{x},{y}] at {speed} speed.   Size of words[]: {data.Length}");
        

            void MoveAction() =>
                characterHandler.Move(vector, speed, TagActionOver);
            
            _tagMethods.Add(MoveAction);
        }

        void HandleTagPlaysound(string soundToPlay)
        {
            Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Play sound {soundToPlay}");

            //Même probleme que dans le Audience tag pour le son, j'ai fix sale déso

            AkSoundEngine.PostEvent(soundToPlay, gameObject);
            if (soundToPlay.Contains("VOX"))
            {
                Debug.Log("Stopped Emotion Sound FX");
                AkSoundEngine.PostEvent("Stop_VOX_Emotions", gameObject);
            }

            void PlaysoundAction()
            {
                /*
                AkSoundEngine.PostEvent(soundToPlay, gameObject);
                if (soundToPlay.Contains("VOX"))
                {
                    Debug.Log("Stopped Emotion Sound FX");
                    AkSoundEngine.PostEvent("Stop_VOX_Emotions", gameObject);
                }
                */
                TagActionOver();
            }
            
            _tagMethods.Add(PlaysoundAction);
        }
        
        void HandleTagAnim(string[] data)
        {
            if (data.Length != 2)
            {
                string arrayString = String.Empty;
                data.ToList().ForEach(i => arrayString += i +" ");
                Debug.LogError($"AM.HandleTagAnim > Error: Wrong size of parameters | {arrayString}|");
                return;
            }

            var character = GameManager.Instance.GetCharacter(data[0]);
            if (character == null)
            {
                Debug.LogError($"AM.HandleTagAnim > Error: Character unvalid | {data[0]} |");
                return;
            }
            
            var trigger = data[1];
            
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > {character._character.name} must play {trigger} anim");
            character._playAnim = true;
            
            void AnimAction()
            {
                StartCoroutine(character.PlayAnimCoroutine(trigger, TagActionOver));
            }
            
            _tagMethods.Add(AnimAction);
            //StartCoroutine(GameManager.Instance.GetCharacter(data[0]).PlayAnimCoroutine(data[1]));
        }
        
        void HandleTagWait(string timeToWaitString)
        {
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Dialogue must wait {timeToWaitString}");

            var timeToWait = float.Parse(timeToWaitString, CultureInfo.InvariantCulture);
            mustWait = true;

            void WaitAction() => StartCoroutine(WaitingCoroutine(timeToWait));
            
            _tagMethods.Add(WaitAction);

        }
        
        void HandleTagSleep(string timeToSleepString)
        {

            var timeToWait = float.Parse(timeToSleepString, CultureInfo.InvariantCulture);
            mustWait = true;
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Actions must wait {timeToWait} seconds before begin");

            void SleepAction() => StartCoroutine(WaitingCoroutine(timeToWait));

            if (_tagMethods.Count > 0 && _tagMethods[0].Method.Name == "SleepAction")
            {
                Debug.LogError($"AM.HandleTagSleep > Error: SleepAction already used");
                return;
            }
            
            _tagMethods.Insert(0, SleepAction);

        }

        void HandleTagScreenShake(string[] data)
        {
            if (data.Length == 1)
            {
                void ScreenShakeAction()
                {
                    StartCoroutine(GameManager.Instance.ScreenShakeCoroutine(TagActionOver));
                }
                _tagMethods.Add(ScreenShakeAction);
            }
            else
            {
                var intensity = float.Parse(data[1], CultureInfo.InvariantCulture);
                var time = float.Parse(data[2], CultureInfo.InvariantCulture);
                
                void ScreenShakeAction()
                {
                    StartCoroutine(GameManager.Instance.ScreenShakeCoroutine(TagActionOver, intensity, time));
                }
                _tagMethods.Add(ScreenShakeAction);
            }
        }

        void HandleTagLook(string[] data)
        {
            Debug.Log($"AM.HandleTagLook > {data[0]} must look to {data[1]}");
            var character = GameManager.Instance.GetCharacter(data[0]);
            if (character == null)
            {
                Debug.LogError($"AM.HandleTagLook > Error: Character unvalid | {data[0]} |");
                return;
            }
            
            Vector3 target = Vector3.zero;
            
            var other = GameManager.Instance.GetCharacter(data[1]);
            if (other != null)
            {
                //target = other.transform.position;
                target = GameManager.Instance._gridScene.GetWorldPositon(other._coordsOnStatge);
                Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Target: {target}");
            }
            else
            {
                if (_directions.ContainsKey(data[1]))
                    target = _directions[data[1]];
                else
                    Debug.LogError($"AM.{MethodBase.GetCurrentMethod()?.Name} > {data[2]} is unvalid");
            }
            
            if (target == Vector3.zero)
            {
                Debug.LogError($"AM.HandleTagLook > Error: Target unvalid | {data[0]} |");
                return;
            }

            void LookAction()
            {
                //character.transform.LookAt(target, Vector3.forward);
                //TagActionOver();
                StartCoroutine(character.RotationCoroutine(target, TagActionOver));
            }

            _tagMethods.Add(LookAction);

        }

        void HandleTagAudience(string reaction)
        {
            List<ParticleSystem> particleSystemEmiters = new();

            void AddToEmiter(ParticleSystem ps, float rate)
            {
                var emission = ps.emission;
                emission.rateOverTime = rate;
                particleSystemEmiters.Add(ps);
            }
            
            switch (reaction)
            {
                case Constants.ReactBooing:

                    AddToEmiter(_particleSystemBoo, 25.0f);
                    AddToEmiter(_particleSystemCry, 100.0f);
                    
                    break;
                case Constants.ReactOvation:
                    break;
                case Constants.ReactDebate:
                    
                    AddToEmiter(_particleSystemBoo, 1.0f);
                    AddToEmiter(_particleSystemCry, 500.0f);
                    
                    break;
                case Constants.ReactApplause:
                    
                    AddToEmiter(_particleSystemCry, 10.0f);
                    
                    break;
                case Constants.ReactChoc:
                    break;
                case Constants.ReactLaughter:
                    break;
                default:
                    Debug.LogError($"AM.HandleTagAudience > Unkwonw reaction | {reaction} |");
                    return;
            }
            Debug.Log($"AM.HandleTagAudience > Reaction: {reaction}");

            var soundToPlay = "Play_CrowdReaction_" + reaction;

            AkSoundEngine.PostEvent(soundToPlay, gameObject); //le son de réaction marche pas dans AudienceAction(), je le déclenche ici et je l'ai commenté la bas

            void AudienceAction()
            {

                // AkSoundEngine.PostEvent(soundToPlay, gameObject);

                foreach (var particleSystem in particleSystemEmiters)
                {
                    Debug.Log($"AudienceAction > Emit particles from {particleSystem.transform.parent.name}");
                    particleSystem.Play();
                }
                
                TagActionOver();
            }
            
            _tagMethods.Add(AudienceAction);
        }

        void HandleTagRope(string characterName)
        {
            CharacterHandler character = GameManager.Instance.GetCharacter(characterName);
            if (character == null)
            {
                Debug.LogError($"AM.HandleTagRope > Error: Unknown character name | {characterName} |");
                return;
            }

            void RopeAction() => character.RopeAction(TagActionOver);

            _tagMethods.Add(RopeAction);
        }
        
        
        void HandleTagMap(string travelName)
        {
            Debug.Log($"AM.HandleTagMap > travel: {travelName}");

            string travel = string.Empty;
            
            foreach (var travelType in Constants.TravelArray)
            {
                if (travelName == travelType)
                {
                    travel = travelName;
                    Debug.Log($"AM.HandleTagMap > Valide travel name");
                    break;
                }
            }

            if (travel == string.Empty)
            {
                Debug.LogError($"AM.HandleTagMap > Error: unknown travel name: {travel}");
                return;
            }
            
            void MapAction()
            {
                Debug.Log("MapAction");
                if (travel != string.Empty)
                    _map.DisplayTravel(travel);
                
                TagActionOver();
            }

            _tagMethods.Add(MapAction);
        }
        
        //TODO: Make curtains tag handlers
        /* void HandleCurtains()
        {
        }*/
        
        #endregion

        //Le code pour le son :) par Romain
        #region SoundHandler

        private void PlaySoundChoiceButtonClicked()
        {
            _wwiseChoiceDialogueButton.Post(gameObject);
        }

        /*
        private void PlaySoundNextButton()
        {
            _wwiseNextDialogueButton.Post(gameObject);
        }
        */

        private void PlaySoundBackButton()
        {
            _wwiseBackButton.Post(gameObject);
        }

        private void PlaySoundDialogAppears()
        {
            _wwiseDialogAppears.Post(gameObject);
        }

        private void PlaySoundChoiceButtonAppears()
        {
            _wwiseChoiceDialogueButtonAppears.Post(gameObject);
        }


        #endregion SoundHandler

        #region Coroutines

        IEnumerator GenerateButtonCoroutine()
        {
            for (int i = 0; i < GameManager.Instance._story.currentChoices.Count; i++)
            {
                yield return new WaitForSeconds(GameManager.Instance._timeButtonSpawnInSec);

                GenerateButton(i);
                
                // play sound button creation
            }

            foreach (var button in _choicesButtonList)
            {
                button.interactable = true;
            }
            //GoChoose();
        }

        IEnumerator GenerateText(string textToDisplay)
        {
            while (!_canContinueDialogue)
            {
                //Debug.Log("Wait to display text");
                yield return null;
            }
            
            _dialogueBox.SetActive(true);
            
            _dialogueTypewriter.onTextShowed.AddListener(DialogueTextFinished);
            _prompterTypewriter.onTextShowed.AddListener(PrompterTextFinished);
            
            GameManager.Instance._playerInput.Player.Interact.performed -= OnClickNextDialogue;     // C'est très sale
            
            if (mustWait)
            {
                yield return new WaitForSeconds(_timeToWait);
            }
            else
            {
                yield return new WaitForSeconds(GameManager.Instance._timeTextToAppearInSec);
            }

            Debug.Log($"Update _dialogueText > {textToDisplay}");
            //_dialogueText.text = textToDisplay;
            _dialogueTypewriter.ShowText(textToDisplay);
            
            mustWait = false;
            
            TagActionOver();
        }


        IEnumerator WaitingCoroutine(float timeToWait)
        {
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Begin waiting for {timeToWait} seconds");
            yield return new WaitForSeconds(timeToWait);
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Finish waiting for {timeToWait} seconds");
            TagActionOver();
        }


        IEnumerator FadeImageCoroutine(RawImage img, float begin, float end, float duration)
        {
            //Debug.Log($"FadeImageCoroutine > Begin: {begin} to {end}");
            var timeElapsed = 0.0f;
            Color color;
            while (timeElapsed < duration)
            {
                color = img.color;
                color.a = Mathf.Lerp(begin, end, timeElapsed/duration);
                img.color = color;
                timeElapsed += Time.deltaTime;
                yield return null;
            }
            color = img.color;
            color.a = end;
            img.color = color;
            //Debug.Log($"FadeImageCoroutine > It's done");
        }
        

        /// <summary>
        /// Execute Tag methods one by one
        /// </summary>
        /// <returns></returns>
        IEnumerator ExecuteTagMethods()
        {
            // Waiting if someone is still using a rope
            // while (!_canContinueDialogue)
            // {
            //     Debug.Log("Wait to display text");
            //     yield return null;
            // }
            
            foreach (var tagAction in _tagMethods)
            {
                Debug.Log($"{tagAction.Method.Name}");
                _isActionDone = false;
                tagAction();
                while (!_isActionDone)
                    yield return null;
            }
            
            HandleChoices();
        }

        #endregion
    }
}
