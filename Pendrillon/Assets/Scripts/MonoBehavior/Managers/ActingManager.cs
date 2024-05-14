using System;
using System.Collections.Generic;
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
    
        public List<GameObject> _charactersOnStage;
    
        // UI
        public GameObject _uiParent;
        public TextMeshProUGUI _dialogueText;   // Text box
        public TextMeshProUGUI _tagsText;       // Tags box
    
        // Buttons
        [SerializeField] private Button _choiceButtonPrefab;
        public List<Button> _choicesButtonList;
        [SerializeField] private Button _nextDialogueButton;
        [SerializeField] private Button _backButton;

        //Sound
        [SerializeField] private AK.Wwise.Event _wwiseChoiceDialogueButton;

        /* Cet event est lancé depuis le bouton vert d'UI
         [SerializeField] private AK.Wwise.Event _wwiseNextDialogueButton; */
        [SerializeField] private AK.Wwise.Event _wwiseBackButton;
        [SerializeField] private AK.Wwise.Event _wwiseChoiceDialogueButtonAppears;
        [SerializeField] private AK.Wwise.Event _wwiseDialogAppears;

        private string _currentDialogue;
    
        private Stack<string> savedJsonStack;


        private List<CharacterHandler> _enemiesToFight = new List<CharacterHandler>();

        #endregion

        #region Events
    
        public UnityEvent PhaseStart;
        public UnityEvent PhaseEnded;
        public UnityEvent NextDialogue;
        public UnityEvent ClearUI;
    
        #endregion
    
        #region UnityAPI
        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(this);
                return;
            }

            Instance = this;
            //DontDestroyOnLoad(this.gameObject);
        
            PhaseStart.AddListener(OnPhaseStart);
            PhaseEnded.AddListener(OnPhaseEnded);
        
            ClearUI.AddListener(OnClearUI);
        
            //Debug.Log(MethodBase.GetCurrentMethod()?.Name);
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
        
            _currentDialogue = String.Empty;
        
            // if(savedJsonStack.Count != 0)
            //     _backButton.gameObject.SetActive(true);
        
            if (GameManager.Instance._story.canContinue)
            {
                _currentDialogue = GameManager.Instance._story.Continue();
                //Debug.Log(_currentDialogue);
                //Debug.Log($"AC.Refresh() > GameManager.Instance._story.state.currentPathString:{GameManager.Instance._story.state.currentPathString}");
                if (CheckBeginOfFight(GameManager.Instance._story.state.currentPathString))
                    return;
                
            
                if (_currentDialogue == String.Empty)
                    Refresh();
                //savedJsonStack.Push(GameManager.Instance._story.state.ToJson());
                
                HandleDialogue();
                HandleTags();
                HandleChoices();
            
            }
            else
            {
                Debug.Log("Reach end of content.");
            
                // Button button = _choicesButtonList[0];
                // button.gameObject.SetActive(true);
                // TextMeshProUGUI textButton = button.GetComponentInChildren<TextMeshProUGUI>();
                // textButton.text = "Restart?";
                // button.onClick.AddListener(delegate{
                //     OnPhaseStart();
                // });
            
            }
        }

        void HandleDialogue()
        {
            // split dialogue in 2
            String[] words = _currentDialogue.Split(":");
        
            // get character speaking
            String speaker = words[0].Replace(" ", "");
            String dialogue = String.Join(":", words.Skip(1));

            // send to character the dialogue
            if (speaker == GameManager.Instance.GetPlayer()._character.name)
                GameManager.Instance.GetPlayer().OnDialogueUpdate(dialogue);
            else if (GameManager.Instance.GetCharacter(speaker) == null)
                Debug.LogError($"AM.{MethodBase.GetCurrentMethod()?.Name} > {speaker}");
            else
                GameManager.Instance.GetCharacter(speaker).OnDialogueUpdate(dialogue);

            // play sound
            PlaySoundDialogAppears();
        
            _dialogueText.text = _currentDialogue;
        }
        
    
        void HandleTags()
        {
            if (GameManager.Instance._story.currentTags.Count > 0)
            {
                foreach (var tagName in GameManager.Instance._story.currentTags)
                {
                    _tagsText.text += tagName.Trim() + "\n";
                    //ParseTag(tag);
                }
            }
        }

        void HandleChoices()
        {
            if (GameManager.Instance._story.currentChoices.Count > 0)
            {
                for (int i = 0; i < GameManager.Instance._story.currentChoices.Count; i++)
                {
                    GenerateButton(i);
                    PlaySoundChoiceButtonAppears();
                    
                }
            }
            else // if there is 
            {
                _nextDialogueButton.gameObject.SetActive(true);
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
        
        
        public void ParseTag(string tagName)
        {
            Debug.Log(tagName);
            string[] words = tagName.Split(Constants.Separator);
        
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
                case Constants.TagMove:
                    HandlerTagMove(words[1]);
                    break;
                case Constants.TagPlaySound:
                
                    GameManager.Instance._wwiseEvent.Post(gameObject);
                    break;
            }
        }


        #region ButtonHandlers
        public void OnClickChoiceButton (Choice choice) {
            GameManager.Instance._story.ChooseChoiceIndex (choice.index);
            PlaySoundChoiceButtonClicked();
            Refresh();
        }

        public void OnClickBackButton()
        {
            GameManager.Instance._story.state.LoadJson(savedJsonStack.Pop());
            PlaySoundBackButton();
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
        
            _nextDialogueButton.gameObject.SetActive(false);
            _backButton.gameObject.SetActive(false);
        }
        #endregion
        
        
        #region TagHandlers
        // TODO: refactor movements
        private void HandlerTagMove(string coordonates)
        {
            string[] words = coordonates.Split(",");
            string character = words[0];
            string x = words[1];
            string y = words[2];
        
            //Debug.Log($"{character} wants to go to [{x},{y}].   Size of words[]: {words.Length}");
        
            CharacterHandler characterHandler = GameManager.Instance.GetCharacter(character);
            characterHandler?.Move(new Vector2Int(Int32.Parse(x), Int32.Parse(y)));
        
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
    }
}
