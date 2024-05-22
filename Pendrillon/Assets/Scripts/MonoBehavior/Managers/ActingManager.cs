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
using UnityEngine.UI;

namespace MonoBehavior.Managers
{
    public class ActingManager : MonoBehaviour
    {
        #region Attributes
        public static ActingManager Instance { get; private set; }
    
        // UI
        [HideInInspector] public GameObject _uiParent { get; private set; }
        private GameObject _dialogueBox;
        private TextMeshProUGUI _dialogueText;   // Text box
        private TextMeshProUGUI _tagsText;       // Tags box
    
        // Buttons
        [SerializeField] private Button _choiceButtonPrefab;
        private List<Button> _choicesButtonList;
        private Button _nextDialogueButton;
        private Button _backButton;
        
        private string _currentDialogue;
        private Stack<string> savedJsonStack;
        private bool mustWait = false;
        private float _timeToWait = 0.0f;
        
        private List<CharacterHandler> _enemiesToFight = new();

        // Tag list ordering
        private List<Action> _tagMethods = new();
        private bool _isActionDone = false;
        private bool _dialogueAlreadyHandle = false;
        
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
        private void Awake()
        {
            // Singleton pattern
            if (Instance != null && Instance != this)
            {
                Destroy(this);
                return;
            }
            Instance = this;
        
            // Connect Attributes
            _uiParent           = GameObject.Find("Canvas/ACTING_PART").gameObject;
            _dialogueBox        = _uiParent.transform.Find("DialogueBox").gameObject;
            _dialogueText       = _uiParent.transform.Find("DialogueBox/DialogueText").GetComponent<TextMeshProUGUI>();
            _tagsText           = _uiParent.transform.Find("TagsText").GetComponent<TextMeshProUGUI>();
            _nextDialogueButton = _uiParent.transform.Find("DialogueBox/NextButton").GetComponent<Button>();
            _backButton         = _uiParent.transform.Find("DialogueBox/BackButton").GetComponent<Button>();
            
            // Connect Events
            PhaseStart.AddListener(OnPhaseStart);
            PhaseEnded.AddListener(OnPhaseEnded);
            ClearUI.AddListener(OnClearUI);
        
            _nextDialogueButton.onClick.AddListener(OnClickNextDialogue);
            
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
                
                Debug.Log($"AM.Refresh > _currentDialogue:{_currentDialogue}");
                
                // Debug.Log($"AM.Refresh > _story.state.currentPathString:" +
                //           $"{GameManager.Instance._story.state.currentPathString}");
                
                if (CheckBeginOfFight(GameManager.Instance._story.state.currentPathString))
                    return;
                
                if (_currentDialogue == String.Empty)
                    Refresh();
                //savedJsonStack.Push(GameManager.Instance._story.state.ToJson());
                
                HandleTags();
                HandleDialogue();
                HandleChoices();

                /*foreach (var method in _tagMethods)
                {
                    Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Do method in list {method.Method.Name}");
                    method();
                }*/

                StartCoroutine(ExecuteTagMethods());

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
                _nextDialogueButton.gameObject.SetActive(true);
                // TODO: Make button subscribe correct action (=> next dialogue)
            }
        }

        void GenerateButton(int index)
        {
            Choice choice = GameManager.Instance._story.currentChoices[index];
            Button button = Instantiate(_choiceButtonPrefab, _uiParent.transform);
            
            Vector2 offset = new Vector2(index * (button.GetComponent<RectTransform>().sizeDelta.x + 20), 0);
        
            button.GetComponent<RectTransform>().position = 
                GameManager.Instance._buttonPos + offset;
        
            button.GetComponentInChildren<TextMeshProUGUI>().text = 
                GameManager.Instance._story.currentChoices[index].text;
                
            button.onClick.AddListener (delegate {
                OnClickChoiceButton (choice);
            });

            button.interactable = false; // De base les boutons sont désactivées
            _choicesButtonList.Add(button);
            //Debug.Log($"AM.Refresh() > button.GetComponentInChildren<TextMeshProUGUI>().text:{button.GetComponentInChildren<TextMeshProUGUI>().text}");
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
        public void OnClickNextDialogue()
        {
            Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Call next dialogue");
            Refresh();
        }

        public void OnClickContinueCurrentDialogue()
        {
            Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} ><");
        }
        #endregion
        
        public void OnClickChoiceButton (Choice choice) {
            GameManager.Instance._story.ChooseChoiceIndex (choice.index);
            Refresh();
        }

        public void OnClickBackButton()
        {
            GameManager.Instance._story.state.LoadJson(savedJsonStack.Pop());
            Refresh();

        }

        #endregion

        #region EventHandlers
        void OnPhaseStart()
        {
            _uiParent.gameObject.SetActive(true);
            savedJsonStack = new Stack<string>();

            GameManager.Instance.GetPlayer()._character.charisma.SetupBase((int)GameManager.Instance._story.variablesState["p_char"]);
            GameManager.Instance.GetPlayer()._character.strength.SetupBase((int)GameManager.Instance._story.variablesState["p_stre"]);
            GameManager.Instance.GetPlayer()._character.dexterity.SetupBase((int)GameManager.Instance._story.variablesState["p_dext"]);
            GameManager.Instance.GetPlayer()._character.constitution.SetupBase((int)GameManager.Instance._story.variablesState["p_comp"]);
            GameManager.Instance.GetPlayer()._character.luck.SetupBase((int)GameManager.Instance._story.variablesState["p_luck"]);
        
            //Debug.Log($"AM.OnPhaseStart() > GameManager.Instance.GetCharacter(\"PLAYER\")._character:{GameManager.Instance.GetPlayer()._character}");
        
            //var beginSceneName = "trip_return";
            // Debug.Log($"AM.{MethodBase.GetCurrentMethod().Name} > " +
            //           $"GameManager.Instance._story.path:" +
            //           $"{GameManager.Instance._story.path}");

            
            
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
            _nextDialogueButton.gameObject.SetActive(false);
            _backButton.gameObject.SetActive(false);
        }
        #endregion
        
        
        #region TagHandlers

        private void ParseTag(string tagName)
        {
            //Debug.Log(tagName);
            string[] words = tagName.Split(Constants.Separator);
        
            // foreach (var word in words)
            // {
            //     Debug.Log("word: " + word);
            // }

            CheckTag(words);
        
        }
        
        // ReSharper disable Unity.PerformanceAnalysis
        private void CheckTag(string[] words)
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
            }
        }

        // ReSharper disable Unity.PerformanceAnalysis
        void TagActionOver()
        {
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > TagAction is over");
            _isActionDone = true;
        }
        
        private void HandleTagActor(string[] data)
        {
            //[] words = coordonates.Split(",");
            string character = data[0];
            
            string debugList = "";
            foreach (var item in data)
                debugList += item + ", ";
            Debug.Log($"AM.{MethodBase.GetCurrentMethod().Name} > {character}'s alias : {debugList}");
        
            
            CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);
            foreach (var nickname in data.Skip(1).Cast<String>())
            {
                characterHandler._character._nicknames.Add(nickname);
            }
        }
        
        private void HandleTagMove(string[] data)
        {
            //[] words = coordonates.Split(",");
            string character = data[0];
            string x = data[1];
            string y = data[2];
            string speed = data.Length == 4 ? data[3] : Constants.NormalName;

            //Debug.Log($"{character} wants to go to [{x},{y}] at {speed} speed.   Size of words[]: {data.Length}");
        
            CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);
            _tagMethods.Add(() =>
                characterHandler?.Move(new Vector2Int(Int32.Parse(x), Int32.Parse(y)), speed, TagActionOver));
        }

        private void HandleTagPlaysound(string soundToPlay)
        {
            Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Play sound {soundToPlay}");
            
            //AkSoundEngine.PostEvent(soundToPlay, gameObject);

            _tagMethods.Add(() =>
            {
                AkSoundEngine.PostEvent(soundToPlay, gameObject);
                TagActionOver();
            });
        }
        
        
        private void HandleTagAnim(string[] data)
        {
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > {data[0]} must play {data[1]} anim");

            _tagMethods.Add(() => 
                StartCoroutine(GameManager.Instance.GetCharacter(data[0]).PlayAnimCoroutine(data[1], TagActionOver))
            );
            //StartCoroutine(GameManager.Instance.GetCharacter(data[0]).PlayAnimCoroutine(data[1]));

        }
        
        private void HandleTagWait(string timeToWaitString)
        {
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Dialogue must wait {timeToWaitString}");

            var timeToWait = float.Parse(timeToWaitString, CultureInfo.InvariantCulture);
            mustWait = true;
            
            _tagMethods.Add(() => StartCoroutine(WaitingCoroutine(timeToWait)));

        }
        
        private void HandleTagSleep(string timeToSleepString)
        {

            var timeToWait = float.Parse(timeToSleepString, CultureInfo.InvariantCulture);
            mustWait = true;
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Actions must wait {timeToWait} seconds before begin");

            _tagMethods.Insert(0, () => StartCoroutine(WaitingCoroutine(timeToWait)));

        }

        private void HandleScreenShake(string[] data)
        {
            if (data.Length == 1)
            {
                _tagMethods.Add(() => StartCoroutine(GameManager.Instance.ScreenShakeCoroutine(TagActionOver)));
            }
            else
            {
                var intensity = float.Parse(data[1], CultureInfo.InvariantCulture);
                var time = float.Parse(data[2], CultureInfo.InvariantCulture);
                
                _tagMethods.Add(() => StartCoroutine(GameManager.Instance.ScreenShakeCoroutine(TagActionOver, intensity, time)));
            }
        }

        private void HandleCurtains()
        {
            //TODO: Make curtains tag handlers
            
            
        }
        
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
                //Debug.Log($"{nameof(ExecuteTagMethods)} > Start action");

                _tagMethods[i]();
                while (!_isActionDone)
                {
                    //Debug.Log($"{nameof(ExecuteTagMethods)} > Wait to finish");
                    yield return null;
                }
                //Debug.Log($"{nameof(ExecuteTagMethods)} > Action is done");
                ++i;
            }
        }

        #endregion
    }
}
