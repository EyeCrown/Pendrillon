using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
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
        enum ActState
        {
            Choose,
            Wait,
            Next,
        }
        
        #region Attributes
        public static ActingManager Instance { get; private set; }

        private ActState status;
        
        // Scene
        // TODO: put the name of the first scene (in Constants)
        string _stage = "UNDEFINED";      // Name of the actual set
    
        // UI
        [HideInInspector] public GameObject _uiParent { get; private set; }
        GameObject _dialogueBox;
        TextMeshProUGUI _dialogueText;      // Text box
        TextMeshProUGUI _tagsText;          // Tags box
        GameObject _historyBox;        // History box
        TextMeshProUGUI _historyText;
        Image _nextDialogueIndicator;
        float _minButtonPosX = -960;
        float _maxButtonPosX =  960;
        float _buttonPosY =  -260;
        
    
        // Buttons
        [SerializeField] Button _choiceButtonPrefab;
        [SerializeField] Button _choiceButtonLeftPrefab;
        [SerializeField] Button _choiceButtonMiddlePrefab;
        [SerializeField] Button _choiceButtonRightPrefab;
        public List<Button> _choicesButtonList;
        Button _backButton;
        
        // Dialogue
        string _currentDialogue;
        //Stack<string> savedJsonStack;
        bool mustWait = false;
        float _timeToWait = 0.0f;
        
        List<CharacterHandler> _enemiesToFight = new();

        // Tag list ordering
        List<Action> _tagMethods = new();
        bool _isActionDone = false;
        bool _dialogueAlreadyHandle = false;

        Dictionary<string, Transform> _directions = new Dictionary<string, Transform>();
        
        //Sound
        [Header("=== Wwise attributes ===")]
        [SerializeField] private AK.Wwise.Event _wwiseChoiceDialogueButton;

        /* Cet event est lancé depuis le bouton vert d'UI
         [SerializeField] private AK.Wwise.Event _wwiseNextDialogueButton; */
        [SerializeField] private AK.Wwise.Event _wwiseBackButton;
        [SerializeField] private AK.Wwise.Event _wwiseChoiceDialogueButtonAppears;
        [SerializeField] private AK.Wwise.Event _wwiseDialogAppears;
        
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
            _tagsText       = _uiParent.transform.Find("TagsText").GetComponent<TextMeshProUGUI>();
            _backButton     = _uiParent.transform.Find("DialogueBox/BackButton").GetComponent<Button>();
            _nextDialogueIndicator = _uiParent.transform.Find("NextDialogueIndicator").GetComponent<Image>();
            _historyBox     = _uiParent.transform.Find("History").gameObject;
            _historyText    = _historyBox.transform.Find("Scroll View/Viewport/Content").GetComponent<TextMeshProUGUI>();
            
            
            var dirTransform = GameObject.Find("Directions").transform;
            // Front
            var dirPos = dirTransform;
            dirPos.position +=   new Vector3(30, 0, 0);
            _directions.Add(Constants.StageFront, dirPos);
            // Back
            dirPos.position += dirTransform.transform.position + new Vector3(-30, 0, 0);
            _directions.Add(Constants.StageBack, dirPos);
            // Garden
            dirPos.position += dirTransform.transform.position + new Vector3(0, 0, -30);
            _directions.Add(Constants.StageGarden, dirPos);
            // Courtyard
            dirPos.position += dirTransform.transform.position + new Vector3(0, 0, 30);
            _directions.Add(Constants.StageCourtyard, dirPos);

            
            // Connect Events
            PhaseStart.AddListener(OnPhaseStart);
            PhaseEnded.AddListener(OnPhaseEnded);
            ClearUI.AddListener(OnClearUI);
        
            //_nextDialogueButton.onClick.AddListener(OnClickNextDialogue);
            
            //Debug.Log(MethodBase.GetCurrentMethod()?.Name);
        }

        void Start()
        {
            _uiParent.SetActive(false);
        }
        
        #endregion

        #region Getters

        public List<CharacterHandler> GetEnemiesToFight()
        {
            return _enemiesToFight;
        }

        #endregion
    
        

        public void Refresh()
        {
            ClearUI.Invoke();

            _dialogueAlreadyHandle = false;
            _currentDialogue = String.Empty;
        
            // if(savedJsonStack.Count != 0)
            //     _backButton.gameObject.SetActive(true);
            
            if (GameManager.Instance._story.canContinue)
            {
                _currentDialogue = GameManager.Instance._story.Continue();
                //Debug.Log($"AM.Refresh > _currentDialogue:{_currentDialogue}");
                
                // Add to history
                _historyText.text += _currentDialogue + "\n";
                
                
                var path = GameManager.Instance._story.state.currentPathString;
                Debug.Log($"AM.Refresh > _story.state.currentPathString: {path}");

                string[] words = path != null ? path.Split(".") : new []{_stage};
                Debug.Log($"AM.Refresh > Location: {words[0]}");

                if (words[0] != _stage)
                {
                    Debug.Log($"AM.Refresh > Change from {_stage} to {words[0]}");
                    // TODO: DoChangeOfSet()
                    _stage = words[0];
                }
                
                if (CheckBeginOfFight(GameManager.Instance._story.state.currentPathString))
                    return;

                if (_currentDialogue == String.Empty)
                {
                    Debug.Log($"AM.Refresh > RECURSIVE CALL");
                    Refresh();
                    return;
                }
                
                HandleTags();
                HandleDialogue();
                //HandleChoices();

                /*foreach (var method in _tagMethods)
                {
                    Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Do method in list {method.Method.Name}");
                    method();
                }*/

                StartCoroutine(ExecuteTagMethods());
                //HandleChoices();

            }
            else
            {
                Debug.Log("Reach end of content.");
            }
        }

        void HandleDialogue()
        {
            if (!_dialogueAlreadyHandle)
            {
                // split dialogue in 2
                String[] words = _currentDialogue.Split(":");
        
                // get character speaking
                String speaker = words[0].Replace(" ", "");
                String dialogue = String.Join(":", words.Skip(1));

                _tagMethods.Add(() =>
                {
                    // send to character the dialogue
                    if (speaker.ToLower() == Constants.PrompterName)
                    {
                        GameManager.Instance._prompter.DialogueUpdate.Invoke(dialogue);
                    }
                    else
                    {
                        if (GameManager.Instance.GetCharacter(speaker) == null)
                            Debug.LogError($"AM.{MethodBase.GetCurrentMethod()?.Name} > {speaker}");
                        else
                            GameManager.Instance.GetCharacter(speaker).DialogueUpdate.Invoke(dialogue);
                            
                        // play sound
                        PlaySoundDialogAppears();
        
                        StartCoroutine(GenerateText());
                    }
                    
                });
                
                
                _dialogueAlreadyHandle = true;

            }
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
            if (GameManager.Instance._story.currentChoices.Count > 0)
            {
                StartCoroutine(GenerateButtonCoroutine());
            }
            else 
            {
                Debug.Log("Activate next button");
                
                // TODO: Make button subscribe correct action (=> next dialogue)

                GoNext();
                //_nextDialogueIndicator.gameObject.SetActive(true);
                StartCoroutine(FadeImageCoroutine(_nextDialogueIndicator, 0, 1, 1.0f));
            }
        }

        void GenerateButton(int index)
        {
            Choice choice = GameManager.Instance._story.currentChoices[index];
            Button button;

            switch (GameManager.Instance._story.currentChoices.Count)
            {
                case 1 :
                    button = Instantiate(_choiceButtonMiddlePrefab, _uiParent.transform);
                    break;
                case 2:
                    if (index == 0)
                        button = Instantiate(_choiceButtonLeftPrefab, _uiParent.transform);
                    else
                        button = Instantiate(_choiceButtonRightPrefab, _uiParent.transform);
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
            }
            
            // Button Position
            float t = (float) (index + 1) / (GameManager.Instance._story.currentChoices.Count + 1);
            float xPos = Mathf.Lerp(_minButtonPosX, _maxButtonPosX, t);
            button.GetComponent<RectTransform>().anchoredPosition= new Vector2(xPos, _buttonPosY);
            
            // Button Text
            button.GetComponentInChildren<TextMeshProUGUI>().text = choice.text;
            
            // Button Type
            SetButtonType(button, choice.text);
            
            button.onClick.AddListener (delegate {
                OnClickChoiceButton (choice);
            });

            button.interactable = false; // De base les boutons sont désactivées
            _choicesButtonList.Add(button);
            //Debug.Log($"AM.Refresh > button.GetComponentInChildren<TextMeshProUGUI>().text:{button.GetComponentInChildren<TextMeshProUGUI>().text}");
        }

        void SetButtonType(Button button, string choiceText)
        {
            if (choiceText.Contains(Constants.TypeCharisma))
            {
                Debug.Log("AM.SetButtonType > This button is Charisma");
                button.transform.Find(Constants.TypeCharisma).gameObject.SetActive(true);
                return;
            }
            if (choiceText.Contains(Constants.TypeStrength))
            {
                Debug.Log("AM.SetButtonType > This button is Strength");
                button.transform.Find(Constants.TypeStrength).gameObject.SetActive(true);

                return;
            }
            if (choiceText.Contains(Constants.TypeDexterity))
            {
                Debug.Log("AM.SetButtonType > This button is Dexterity");
                button.transform.Find(Constants.TypeDexterity).gameObject.SetActive(true);

                return;
            }
            if (choiceText.Contains(Constants.TypeComposition))
            {
                Debug.Log("AM.SetButtonType > This button is Composition");
                button.transform.Find(Constants.TypeComposition).gameObject.SetActive(true);

                return;
            }
            if (choiceText.Contains(Constants.TypeLuck))
            {
                Debug.Log("AM.SetButtonType > This button is Luck");
                //button.transform.Find(Constants.TypeLuck).gameObject.SetActive(true);

                return;
            }
            
            Debug.Log("AM.SetButtonType > This button is neutral");
        }
        

        bool CheckBeginOfFight(String path)
        {
            if (path == null)
                return false;
        
            String[] words = path.Split(".");
            if (words.Length <= 1)
                return false;
        
            String[] battleWords = words[1].Split("_");
            if (battleWords[0].ToLower() != "battle")
                return false;
            
            
            _enemiesToFight.Clear();
            foreach (var enemyName in battleWords.Skip(1))
            {
                CharacterHandler character = GameManager.Instance.GetCharacter(enemyName);
                if (character != null)
                {
                    _enemiesToFight.Add(character);
                    //Debug.Log($"AC.CheckBeginOfFight > Add {enemyName} to fight");
                }
            }
            
            PhaseEnded.Invoke();
            return true;
        }
        
        
        

        #region ButtonHandlers

        #region NextButton
        public void OnClickNextDialogue(InputAction.CallbackContext context)
        {
            Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Call next dialogue || Refresh call");
            Refresh();
            //_nextDialogueButton.gameObject.SetActive(false);
        }

        public void OnClickContinueCurrentDialogue()
        {
            Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} ><");
        }
        #endregion
        
        public void OnClickChoiceButton (Choice choice)
        {
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
                if (status == ActState.Next)
                    GameManager.Instance._playerInput.Player.Interact.performed += OnClickNextDialogue;
            }
            else
            {
                Debug.Log($"AM.OnClickHistory > Display history");
                _historyBox.SetActive(true);
                if (status == ActState.Next)
                    GameManager.Instance._playerInput.Player.Interact.performed -= OnClickNextDialogue;
            }
        }

        #endregion

        #region EventHandlers
        void OnPhaseStart()
        {
            Debug.Log($"AM.OnPhaseStart > _story.state.currentPathString: " +
                      $"{GameManager.Instance._story.state.currentPointer}");
            
            _uiParent.gameObject.SetActive(true);

            GameManager.Instance.GetPlayer()._character.charisma.SetupBase((int)GameManager.Instance._story.variablesState["p_char"]);
            GameManager.Instance.GetPlayer()._character.strength.SetupBase((int)GameManager.Instance._story.variablesState["p_stre"]);
            GameManager.Instance.GetPlayer()._character.dexterity.SetupBase((int)GameManager.Instance._story.variablesState["p_dext"]);
            GameManager.Instance.GetPlayer()._character.constitution.SetupBase((int)GameManager.Instance._story.variablesState["p_comp"]);
            GameManager.Instance.GetPlayer()._character.luck.SetupBase((int)GameManager.Instance._story.variablesState["p_luck"]);
        
            //Debug.Log($"AM.OnPhaseStart() > GameManager.Instance.GetCharacter(\"PLAYER\")._character:{GameManager.Instance.GetPlayer()._character}");
        
            _historyText.text = String.Empty;
            _historyBox.SetActive(false);
            GameManager.Instance._playerInput.Player.History.performed += OnClickHistory;

            Debug.Log($"AM.OnPhaseStart > Start story | Refresh call ");
            Refresh();
        }
        void OnPhaseEnded()
        {
            Debug.Log("AM.OnPhaseEnded()");
            // Clear UI
            _uiParent.gameObject.SetActive(false);
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
        
            _dialogueBox.SetActive(false);
            
            _backButton.gameObject.SetActive(false);
            
            if (_nextDialogueIndicator.color.a != 0)
                StartCoroutine(FadeImageCoroutine(_nextDialogueIndicator, 1, 0, 0.1f));

            //_nextDialogueIndicator.gameObject.SetActive(false);

        }
        #endregion
        
        
        #region TagHandlers

        void ParseTag(string tagName)
        {
            //Debug.Log(tagName);
            string[] words = tagName.Split(Constants.Separator);
        
            // foreach (var word in words)
            // {
            //     Debug.Log("word: " + word);
            // }

            CheckTag(words);
        
        }
        
        
        void CheckTag(string[] words)
        {
            switch (words[0])
            {
                case Constants.TagMove:
                    HandleTagMove(words.Skip(1).Cast<String>().ToArray());
                    break;
                case Constants.TagPlaySound:
                    HandleTagPlaysound(words[1]);
                    //GameManager.Instance._wwiseEvent.Post(gameObject);
                    break;
                case Constants.TagAnim:
                    HandleTagAnim(words.Skip(1).Cast<String>().ToArray());
                    break;
                case Constants.TagWait:
                    HandleTagWait(words[1]);
                    break;
                case Constants.TagSleep:
                    HandleTagSleep(words[1]);
                    break;
                case Constants.TagBox:
                    HandleDialogue();
                    break;
                case Constants.TagActor:
                    HandleTagActor(words.Skip(1).Cast<String>().ToArray());
                    break;
                case Constants.TagScreenShake:
                    HandleScreenShake(words);
                    break;
                case Constants.TagLook:
                    HandleLook(words.Skip(1).Cast<String>().ToArray());
                    break;
                default:
                    Debug.LogError($"AM.CheckTag > Error: {words[0]} is an unkwown tag.");
                    break;
            }
        }

        
        void TagActionOver()
        {
            Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > TagAction is over");
            _isActionDone = true;
        }
        
        void HandleTagActor(string[] data)
        {
            //[] words = coordonates.Split(",");
            string character = data[0];
            
            string debugList = "";
            foreach (var item in data)
                debugList += item + ", ";
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod().Name} > {character}'s alias : {debugList}");
        
            
            CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);
            foreach (var nickname in data.Skip(1).Cast<String>())
            {
                characterHandler._character._nicknames.Add(nickname);
            }
            
            characterHandler.transform.position = GameManager.Instance._gridScene.GetWorldPositon(new Vector2Int(10, 10)); // (new Vector3Int(4 + i * 2, 0, 10 + i * 2));

        }
        
        void HandleTagMove(string[] data)
        {
            //[] words = coordonates.Split(",");
            string character = data[0];
            string x = data[1];
            string y = data[2];
            string speed = data.Length == 4 ? data[3] : Constants.NormalName;

            //Debug.Log($"{character} wants to go to [{x},{y}] at {speed} speed.   Size of words[]: {data.Length}");
        
            CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);

            void MoveAction() =>
                characterHandler?.Move(new Vector2Int(Int32.Parse(x), Int32.Parse(y)), speed, TagActionOver);
            
            _tagMethods.Add(MoveAction);
        }

        void HandleTagPlaysound(string soundToPlay)
        {
            Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Play sound {soundToPlay}");
            
            void PlaysoundAction()
            {
                AkSoundEngine.PostEvent(soundToPlay, gameObject);

                TagActionOver();
            }
            
            _tagMethods.Add(PlaysoundAction);
        }
        
        
        void HandleTagAnim(string[] data)
        {
            var trigger = data[1];
            
            Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > {data[0]} must play {trigger} anim");
            
            void AnimAction() =>
                StartCoroutine(GameManager.Instance.GetCharacter(data[0]).PlayAnimCoroutine(trigger, TagActionOver));
            
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
            
            _tagMethods.Insert(0, SleepAction);

        }

        void HandleScreenShake(string[] data)
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

        void HandleLook(string[] data)
        {
            Debug.Log($"AM.HandleLook > {data[0]} must look to {data[1]}");
            var character = GameManager.Instance.GetCharacter(data[0]);

            Transform target = null;
            
            var other = GameManager.Instance.GetCharacter(data[1]);
            if (other != null)
            {
                target = other.transform;
            }
            else
            {
                if (_directions.ContainsKey(data[1]))
                    target = _directions[data[1]];
                else
                    Debug.LogError($"AM.{MethodBase.GetCurrentMethod().Name} > {data[2]} is unvalid");
            }
            
            if (target == null)
                return;

            void LookAction()
            {
                character.transform.LookAt(target);
                TagActionOver();
            }

            _tagMethods.Add(LookAction);

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


        #region Status

        void GoChoose()
        {
            GameManager.Instance._playerInput.Player.Interact.performed -= OnClickNextDialogue;
            status = ActState.Choose;
        }

        
        void GoWait()
        {
            GameManager.Instance._playerInput.Player.Interact.performed -= OnClickNextDialogue;
            status = ActState.Wait;
        }

        void GoNext()
        {
            GameManager.Instance._playerInput.Player.Interact.performed += OnClickNextDialogue;
            status = ActState.Next;
        }
        
        #endregion

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
            GoChoose();
        }

        IEnumerator GenerateText()
        {
            _dialogueBox.SetActive(true);
            if (mustWait)
            {
                yield return new WaitForSeconds(_timeToWait);
            }
            else
            {
                yield return new WaitForSeconds(GameManager.Instance._timeTextToAppearInSec);
            }
            
            _dialogueText.text = _currentDialogue;
            
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


        IEnumerator FadeImageCoroutine(Image img, float begin, float end, float duration)
        {
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
        }
        

        /// <summary>
        /// Execute Tag methods one by one
        /// </summary>
        /// <returns></returns>
        IEnumerator ExecuteTagMethods()
        {
            var i = 0;
            while (i < _tagMethods.Count)
            {
                if (!_tagMethods.Any())
                    break;                
                _isActionDone = false;
                Debug.Log($"{_tagMethods[i].Method.Name} > Start action");

                _tagMethods[i]();
                while (!_isActionDone)
                {
                    //Debug.Log($"{_tagMethods[i].Method.Name} > Wait to finish");
                    yield return null;
                }
                Debug.Log($"{_tagMethods[i].Method.Name} > Action is done");
                ++i;
            }
            
            HandleChoices();
        }

        #endregion
    }
}
