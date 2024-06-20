using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using Febucci.UI.Core;
using Ink.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.InputSystem;
using UnityEngine.SceneManagement;
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
        public GameObject _setChurchNight;
        public GameObject _setChurchDay;
        public GameObject _setTrial;
        public GameObject _setTempest;
        public GameObject _setForest;
        public GameObject _setEmpty;
        private GameObject _currentSet;

        private Curtains _curtains;

        #region Set Object Animators

        // Forest
        private Animator _forestBushAnimator;
        
        // Church
        private Animator _churchNightTorchAnimator;
        
        // Trial
        private Animator _trialBellAnimator;
        private Animator _trialBalanceAnimator;
        
        // Tempest
        private Animator _tempestCanonAnimator;
        private Animator _tempestHarpoonAnimator;
        private Animator _tempestBarrelAnimator;
        private Animator _tempestMastAnimator;
        private Animator _tempestLeviathanAnimator;
        private Animator _tempestRedLeviathanAnimator;
        
        #endregion

        private string _lastBossState;
        
        #endregion

        #region UI Attributes
        [HideInInspector] public GameObject _uiParent { get; private set; }
        GameObject _dialogueBox;
        TextMeshProUGUI _dialogueText;  // Text box
        TextMeshProUGUI _speakerText;   // Text box
        GameObject _historyBox;     // History box
        GameObject _masks;
        GameObject _nameBoxes;
        private string _playerName;

        private Button _mainMenuEndGameButton;
        
        // UI - ParticuleSystems
        private ParticleSystem _particleSystemBoo;
        private ParticleSystem _particleSystemThumbUp;
        private ParticleSystem _particleSystemCry;
        private ParticleSystem _particleSystemLaugh;
        
        // UI - TypeWriters
        private TypewriterCore _dialogueTypewriter;
        private TypewriterCore _prompterTypewriter;
        
        TextMeshProUGUI _historyText;
        readonly float _minButtonPosX = -960;
        readonly float _maxButtonPosX =  960;
        float _buttonPosY =  -260;

        [HideInInspector] public string _choiceType;
        
        // UI - Stats panel
        private StatsUI _statsUI;
        
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

        [Header("=== Battle HUD ===")]
        public BattleHUD _battleHUD;
        
        #region Introduction

        [Header("=== Intro ===")] 
        [SerializeField] private GameObject _introDialoguePrefab;
        [SerializeField] private GameObject _regularDialoguePrefab;
        [SerializeField] private Button     _introButtonPrefab;
        [SerializeField] Button _choiceButtonRegularLeftPrefab;
        [SerializeField] Button _choiceButtonRegularMiddlePrefab;
        [SerializeField] Button _choiceButtonRegularRightPrefab;
        
        #endregion 
        
        // Dialogue
        string _currentDialogue;
        //Stack<string> savedJsonStack;
        bool mustWait = false;
        readonly float _timeToWait = 0.0f;

        // Tag list ordering
        List<Action> _tagMethods = new();
        bool _isActionDone = false;
        bool _dialogueAlreadyHandle = false;

        readonly public Dictionary<string, Vector3> _directions = new Dictionary<string, Vector3>();

        public bool _allowScreenshake { private get; set; }

        
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
        [HideInInspector] public UnityEvent IntroEnded;
        [HideInInspector] public UnityEvent RingBell;
    
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
            _dialogueBox = Instantiate(_regularDialoguePrefab, _uiParent.transform);
            _dialogueBox.gameObject.name = _dialogueBox.gameObject.name.Remove(_dialogueBox.gameObject.name.IndexOf('('));

            ConnectAttributes();
            ConnectEvents();
            SetupSets();
            AssignElements();
            SetDirections();    // For tag #look
            
            _canContinueDialogue = true;
        }

        void Start()
        {
            _mainMenuEndGameButton.gameObject.SetActive(false);
            _uiParent.SetActive(false);
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
                //Debug.Log($"AM.Refresh > _currentDialogue:{_currentDialogue}");
                
                // Add to history
                //_historyText.text += _currentDialogue + "\n";
                
                // var path = GameManager.Instance._story.state.currentPathString;
                // Debug.Log($"AM.Refresh > _story.state.currentPathString: {path}");

                // string[] words = path != null ? path.Split(".") : new []{_stage};
                // Debug.Log($"AM.Refresh > Location: {words[0]}");
                
                HandleTags();
                HandleDialogue();
                //HandleChoices();

                if (IsCurrentDialogueNotValid() && !GameManager.Instance._story.currentChoices.Any() && !_tagMethods.Any())
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
                // Invoke PhaseEnd -> End game
                PhaseEnded.Invoke();
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
                    
                    void action() => HandleDialogueText(words);
                    
                    _wheel.Spin(result, mustObtain, _choiceType, action);
                }
                else
                {
                    HandleDialogueText(words);
                } 
            }
        }


        void HandleDialogueText(string[] words)
        {
            //Debug.Log("Begin Handle Dialogue Text");
            // get character speaking
            String speaker; 
            String dialogue;

            if (words.Length == 1)
            {
                Debug.LogWarning($"ONLY ONE WORD > {words[0]}");
                _currentDialogue = words[0];
                if (IsCurrentDialogueNotValid())
                {
                    
                    Debug.Log($"AM.HandleDialogueText > Add Refresh()");
                    _tagMethods.Add(() =>
                    {
                        Debug.LogWarning("CALL REFRESH AFTER EMPTY DIALOGUE BECAUSE SKILLCHECK");
                        Refresh();
                    } );

                    return;
                }
                
                speaker = string.Empty;
                dialogue = _currentDialogue;
            }
            else
            {
                speaker = words[0].Trim();
                dialogue = String.Join(":", words.Skip(1));
            }
                
            //Debug.Log($"AM.HandleDialogue > Speaker: {speaker}");
            
            _speakerText.font = GameManager.Instance._currentFont;
            
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
                    {
                        switch (speaker)
                        {
                            case "VIGIE" :
                                _nameBoxes.transform.Find("NameBox_Marcello").gameObject.SetActive(true);
                                break;
                            case "MOUSSAILLON" :
                                _nameBoxes.transform.Find("NameBox_Capucine").gameObject.SetActive(true);
                                break;
                            default:
                                Debug.LogError($"AM.{MethodBase.GetCurrentMethod()?.Name} > Unknown speaker | {speaker} |");
                                break;
                        }
                    }                    
                    else
                    {
                        character.DialogueUpdate.Invoke(dialogue);
                        _masks.transform.Find(character.name.ToLower())?.gameObject.SetActive(true);
                        _nameBoxes.transform.Find("NameBox_" + character.name).gameObject.SetActive(true);
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
            Debug.Log("CLEAR _tagMethods");
            _tagMethods.Clear();
            if (GameManager.Instance._story.currentTags.Count > 0)
            {
                foreach (var tagName in GameManager.Instance._story.currentTags)
                {
                    //Debug.Log("Tag: " + tagName);
                    string[] words = tagName.Split(Constants.Separator);
                    //foreach (var word in words) Debug.Log("Tag: " + word);
                    CheckTag(words);
                }
            }
        }

        void HandleChoices()
        {
            GameManager.Instance._playerInput.Player.Interact.performed += OnClickDisplayText;
            
            if (GameManager.Instance._story.currentChoices.Any())
            {
                GameManager.Instance._playerInput.Player.Interact.performed -= OnClickNextDialogue;

                StartCoroutine(GenerateButtonCoroutine());
            }
            else 
            {
                Debug.Log("No choices, so click can display text");

                if (IsCurrentDialogueNotValid())
                {
                    Debug.LogWarning("Invalid dialogue > call Refresh()");
                    Refresh();
                }
            }
        }


        #region Setup

        void ConnectAttributes()
        {
            // Attach to _dialogueBox
            _dialogueBox    = _uiParent.transform.Find("DialogueBox").gameObject;
            _dialogueText   = _dialogueBox.transform.Find("DialogueText").GetComponent<TextMeshProUGUI>();
            _speakerText    = _dialogueBox.transform.Find("SpeakerText").GetComponent<TextMeshProUGUI>();
            _masks          = _dialogueBox.transform.Find("Masks").gameObject;
            _nameBoxes      = _dialogueBox.transform.Find("NameBoxes").gameObject;

            _mainMenuEndGameButton = _uiParent.transform.Find("MainMenuButton").GetComponent<Button>();
            _mainMenuEndGameButton.onClick.AddListener(() => SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex));
            
            
            _dialogueTypewriter = _dialogueText.GetComponent<TypewriterCore>();
            
            // Attach History
            _historyBox  = _uiParent.transform.Find("History").gameObject;
            _historyText = _historyBox.transform.Find("Scroll View/Viewport/Content").GetComponent<TextMeshProUGUI>();

            ConnectParticuleSystems();
            
            _prompterTypewriter = _uiParent.transform.Find("PROMPTER_PART/DialogueBox/DialogueText").GetComponent<TypewriterCore>();
        }

        void ConnectParticuleSystems()
        {
            // Attach Particule System 
            _particleSystemBoo = _uiParent.transform.Find("UIParticleBoo").GetComponentInChildren<ParticleSystem>();
            _particleSystemCry = _uiParent.transform.Find("UIParticleCry").GetComponentInChildren<ParticleSystem>();
        }
        
        void SetDirections()
        {            
            // Set directions
            var dirPos = GameObject.Find("Directions").transform.position;
            _directions.Add(Constants.StageFront, dirPos + new Vector3(30, 0, 0));
            _directions.Add(Constants.StageBack, dirPos + new Vector3(-30, 0, 0));
            _directions.Add(Constants.StageGarden, dirPos + new Vector3(0, 0, -30));
            _directions.Add(Constants.StageCourtyard, dirPos + new Vector3(0, 0, 30));
        }

        void AssignElements()
        {
            _wheel      = GameObject.Find("WheelSupport").GetComponent<Wheel>();
            _map        = GameObject.Find("Map/Map").GetComponent<Map>();
            _curtains   = GameObject.Find("MainCurtains").GetComponent<Curtains>();
            _statsUI    = GameObject.Find("Canvas/PLAYER_STATS").GetComponent<StatsUI>();
            _battleHUD  = GameObject.Find("Canvas/BATTLE_HUD").GetComponent<BattleHUD>();
            
            // Forest Animator
            var _bushAnimatorAddress = "Mesh_Sc_Foret_Move";
            _forestBushAnimator = _setForest.transform.Find(_bushAnimatorAddress).GetComponent<Animator>();
            
            // Church Animator
            var lightAnimatorAddress = "Mesh_Sc_Eglise_Statue/lampe/FlammesOnOff";
            _churchNightTorchAnimator = _setChurchNight.transform.Find(lightAnimatorAddress).GetComponent<Animator>();
            
            // Trial Animator
            var trialBaseName = "Mesh_Sc_Tribunal_";
            _trialBellAnimator = _setTrial.transform.Find(trialBaseName + "Cloche").GetComponent<Animator>();
            _trialBalanceAnimator = _setTrial.transform.Find(trialBaseName + "Balance").GetComponent<Animator>();
            
            // Tempest Animators
            string tempestAddressAnimators = "AnimatorObjects/", tempestBaseName = "Mesh_Sc_Tempete_";
            string tempestName = tempestAddressAnimators + tempestBaseName;
            _tempestCanonAnimator   = _setTempest.transform.Find($"{tempestName}Canon").GetComponent<Animator>();
            _tempestHarpoonAnimator = _setTempest.transform.Find($"{tempestName}Harpon").GetComponent<Animator>();
            _tempestBarrelAnimator  = _setTempest.transform.Find($"{tempestName}BarilExplosif").GetComponent<Animator>();
            _tempestMastAnimator    = _setTempest.transform.Find($"{tempestName}MatPart01").GetComponent<Animator>();
            _tempestLeviathanAnimator = _setTempest.transform.Find($"{tempestName}Leviathan").GetComponent<Animator>();
            _tempestRedLeviathanAnimator = _setTempest.transform.Find($"{tempestBaseName}RedLeviathan").GetComponent<Animator>();
        }

        void ConnectEvents()
        {
            PhaseStart.AddListener(OnPhaseStart);
            PhaseEnded.AddListener(OnPhaseEnded);
            ClearUI.AddListener(OnClearUI);
            IntroEnded.AddListener(OnIntroEnded);
        }

        void SetupSets()
        {
            _setBarge   = Instantiate(_setBarge,    GameObject.Find("Environment").transform);
            _setCale    = Instantiate(_setCale,     GameObject.Find("Environment").transform);
            _setChurchNight = Instantiate(_setChurchNight, GameObject.Find("Environment").transform);
            _setChurchDay   = Instantiate(_setChurchDay, GameObject.Find("Environment").transform);
            _setTrial   = Instantiate(_setTrial,    GameObject.Find("Environment").transform);
            _setTempest = Instantiate(_setTempest,  GameObject.Find("Environment").transform);
            _setForest  = Instantiate(_setForest,   GameObject.Find("Environment").transform);
            _setEmpty  = Instantiate(_setEmpty,   GameObject.Find("Environment").transform);
        }

        #region Observables

        #region Trial Observables

        void SetTrialObservable()
        {
            RingBell.AddListener(OnRingBell);
            
            GameManager.Instance._story.ObserveVariable ("t_audience_judgement", 
                (string varName, object newValue) => ModifyTrialValue(newValue));
        }
        
        
        void ModifyTrialValue(object valueObj)
        {
            float value = float.Parse(valueObj.ToString(), CultureInfo.InvariantCulture.NumberFormat);

            float maxInk = 100;
            value /= maxInk;
            
            _setTrial.transform.Find("Mesh_Sc_Tribunal_Balance")
                .GetComponent<Animator>().SetFloat("balance", value); 
        }

        void SetTrialPropsOnStage(bool inOut)
        {
            _trialBellAnimator.SetBool("InOut", inOut);
            _trialBalanceAnimator.SetBool("InOut", inOut);
        }

        #endregion

        #region Forest Observables

        void SetForestObservable()
        {
            GameManager.Instance._story.ObserveVariable ("bush_moved", 
                (string varName, object newValue) => MoveForestBush(newValue));
        }

        void MoveForestBush(object newValue)
        {
            if ((bool) newValue)
                _forestBushAnimator.SetTrigger("pull");
        }
        
        void SetForestPropsOnStage(bool inOut)
        {
            _forestBushAnimator.SetBool("InOut", inOut);
        }
        
        #endregion
        
        
        #region Chruch Night Observables

        void SetChruchObservable()
        {
            GameManager.Instance._story.ObserveVariable ("irene_torch_is_on", 
                (string varName, object newValue) => ChangeChurchNightLights(newValue));
            
            GameManager.Instance._story.ObserveVariable ("t_3_stained_glass_1_talk", 
                (string varName, object newValue) => SetStainedGlassLight("1", newValue));
            
            GameManager.Instance._story.ObserveVariable ("t_3_stained_glass_2_talk", 
                (string varName, object newValue) => SetStainedGlassLight("2", newValue));
            
            GameManager.Instance._story.ObserveVariable ("t_3_stained_glass_3_talk", 
                (string varName, object newValue) => SetStainedGlassLight("3", newValue));
        }

        void ChangeChurchNightLights(object newValue)
        {
            _churchNightTorchAnimator.SetBool("lightOn", (bool) newValue);
        }

        void SetStainedGlassLight(string indexText, object newValue)
        {
            if ((bool) newValue)
                _setChurchNight.GetComponent<Animator>().SetTrigger("light"+indexText);
        }
        
        void SetChurchNightPropsOnStage(bool inOut) { }
        
        #endregion

        #region Tempest Observables

        void SetTempestObservable()
        {
            
            _lastBossState = (string) GameManager.Instance._story.variablesState["b_boss_state"];
            
            GameManager.Instance._story.ObserveVariable ("b_player_won", 
                (string varName, object newValue) => ResultBossBattle(newValue));
            
            GameManager.Instance._story.ObserveVariable ("b_player_is_on_top_of_mast", 
                (string varName, object newValue) => ChangePlayerMastState(newValue));
            
            
            // Harpoon
            GameManager.Instance._story.ObserveVariable ("b_harpoon_is_loaded", 
                (string varName, object newValue) => ChangeHarpoonState(newValue));
            // Canon
            GameManager.Instance._story.ObserveVariable ("b_canon_is_loaded", 
                (string varName, object newValue) => ChangeCanonState(newValue));
            
            // TODO: Connect barrel
            GameManager.Instance._story.ObserveVariable ("b_explosive_barrel_is_used", 
                (string varName, object newValue) => ChangeBarrelState(newValue));
            
            // Mast
            GameManager.Instance._story.ObserveVariable ("b_sail_is_down", 
                (string varName, object newValue) => ChangeMastSailState(newValue));
            GameManager.Instance._story.ObserveVariable ("b_mast_is_cracked", 
                (string varName, object newValue) => ChangeMastCrackedState(newValue));
            GameManager.Instance._story.ObserveVariable ("b_mast_is_broken", 
                (string varName, object newValue) => ChangeMastBrokenState(newValue));
            
            // Boss
            GameManager.Instance._story.ObserveVariable ("b_boss_state", 
                (string varName, object newValue) => ChangeBossState(newValue));
            GameManager.Instance._story.ObserveVariable ("boss_is_attacking", 
                (string varName, object newValue) => LauchBossAttack((bool) newValue));
        }

        void SetTempestPropsOnStage(bool inOut)
        {
            _tempestCanonAnimator.SetBool("InOut", inOut);
            _tempestHarpoonAnimator.SetBool("InOut", inOut);
            _tempestBarrelAnimator.SetBool("InOut", inOut);
            _tempestMastAnimator.SetBool("InOut", inOut);
        }
        
        void ResultBossBattle(object state)
        {
            //Debug.Log($"Boss new state: {(bool) state}");

            // If player won then play boss death anim
            if ((bool) state)
                _tempestLeviathanAnimator.SetTrigger("death");
                AkSoundEngine.PostEvent("Stop_BossMusic", gameObject);
        }
        
        void ChangePlayerMastState(object state)
        {
            Debug.Log($"Player on top of mast: {(bool) state}");

            // If player won then play boss death anim
            if ((bool)state)
                StartCoroutine(GameManager.Instance.GetPlayer().MoveHeightPositionCoroutine(6.0f, null));
            else
                StartCoroutine(GameManager.Instance.GetPlayer().MoveHeightPositionCoroutine(-6.0f, null));
        }

        void ChangeHarpoonState(object state)
        {
            //Debug.Log($"Harpon new state: {(bool) state}");
            if ((bool)state)
            {
                _tempestHarpoonAnimator.SetBool("charged", true);
            }
            else
            {
                _tempestHarpoonAnimator.SetTrigger("shoot");
                AkSoundEngine.PostEvent("Play_SFX_Combat_Harpoon_shot", gameObject); 
                _tempestHarpoonAnimator.SetBool("charged", false);
            }
        }

        void ChangeCanonState(object state)
        {
            //Debug.Log($"Canon new state: {(bool) state}");
            if ((bool)state)
            {
                _tempestCanonAnimator.SetBool("charged", true);
            }
            else
            {
                _tempestCanonAnimator.SetTrigger("shoot");
                AkSoundEngine.PostEvent("Play_SFX_Combat_Cannon_shot", gameObject);
                _tempestCanonAnimator.SetBool("charged", false);
            }
        }
        
        void ChangeBarrelState(object state)
        {
            //Debug.Log($"Barrel is used: {(bool) state}");
            if ((bool)state)
            {
                _tempestBarrelAnimator.SetBool("Used", true);
                AkSoundEngine.PostEvent("Play_SFX_Combat_BarrelExplosion", gameObject);
            }
        }
        
        void ChangeMastSailState(object state)
        {
            //Debug.Log($"Sail is down new state: {(bool)state}");
            if((bool) state)
                _tempestMastAnimator.SetTrigger("voileoff");
        }

        void ChangeMastCrackedState(object state)
        {
            //Debug.Log($"Mast cracked new state: {(bool)state}");
            if((bool) state)
                _tempestMastAnimator.SetTrigger("startbroke");
        }
        
        void ChangeMastBrokenState(object state)
        {
            //Debug.Log($"Mast broken new state: {(bool)state}");
            if((bool) state)   
                _tempestMastAnimator.SetTrigger("broke");

        }

        // Boss Observables
        void ChangeBossState(object state)
        {
            switch ((string) state)
            {
                case Constants.BossDefault :
                    break;
                case Constants.BossOpenMouth : 
                    _tempestLeviathanAnimator.SetTrigger("openmouth");
                    break;
                case Constants.BossOnBoat : 
                    _tempestLeviathanAnimator.SetTrigger("onboat");
                    break;
                case Constants.BossUnderwater : 
                    _tempestLeviathanAnimator.SetTrigger("underwater");
                    break;
                default: Debug.LogError($"AM.ChangeBossState > Error: Unknown boss state [{(string) state}]");
                    return;
            }
            _lastBossState = (string)state;
        }

        void LauchBossAttack(object isAttacking)
        {
            Debug.Log($"Boss is attacking: {(bool) isAttacking}");

            if (!(bool) isAttacking)
                return;
            
            // Player took damage so
            switch (_lastBossState)
            {
                case Constants.BossDefault :
                    _tempestLeviathanAnimator.SetTrigger("attack");
                    break;
                case Constants.BossOpenMouth : 
                    _tempestLeviathanAnimator.SetTrigger("openmouth_attack");
                    break;
                case Constants.BossOnBoat : 
                    _tempestLeviathanAnimator.SetTrigger("onboat_attack");
                    break;
                case Constants.BossUnderwater : 
                    _tempestLeviathanAnimator.SetTrigger("underwater_attack");
                    break;
                default: Debug.LogError($"LauchBossAttack > Error: this is not supposed to happen [{_lastBossState}]");
                    break;
            }
            
        }

        #endregion
        
        #endregion
        
        #endregion

        public void ChangeOpacityUI(float value)
        {
            GameManager.Instance._opacityUI = value;
            
            _dialogueBox.GetComponent<Image>().color = new Color(
                _dialogueBox.GetComponent<Image>().color.r,
                _dialogueBox.GetComponent<Image>().color.g,
                _dialogueBox.GetComponent<Image>().color.b,
                value
            );
            var speakerBox = _uiParent.transform.Find("PROMPTER_PART/DialogueBox");
            speakerBox.GetComponent<RawImage>().color = new Color(
                speakerBox.GetComponent<RawImage>().color.r,
                speakerBox.GetComponent<RawImage>().color.g,
                speakerBox.GetComponent<RawImage>().color.b,
                value
            );

            foreach (Button button in _choicesButtonList)
            {
                button.GetComponent<Image>().color = new Color(
                    button.GetComponent<Image>().color.r,
                    button.GetComponent<Image>().color.g,
                    button.GetComponent<Image>().color.b,
                    value
                );
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
            
            // Button Position
            float t = (float) (index + 1) / (GameManager.Instance._story.currentChoices.Count + 1);
            float xPos = Mathf.Lerp(_minButtonPosX, _maxButtonPosX, t);
            button.GetComponent<RectTransform>().anchoredPosition= new Vector2(xPos, _buttonPosY);
            
            // Button Text
            button.GetComponentInChildren<TextMeshProUGUI>().text = choice.text;
            button.GetComponentInChildren<TextMeshProUGUI>().font = GameManager.Instance._currentFont;
            
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
                    _statsUI.DisplayStats.Invoke();

                    //Debug.Log($"AM.SetButtonType > This button is {typeName} > Wheel must appear");
                    button.transform.Find(typeName).gameObject.SetActive(true);
                    
                    button.onClick.AddListener (delegate {
                        OnClickChoiceButton (choice, typeName);
                    });
                    
                    return;
                }
            }

            if (GameManager.Instance._intro)
                switch (choice.text)
                {
                    case Constants.ArchetypeCharisma:
                        button.transform.Find(Constants.TypeCharisma).gameObject.SetActive(true);
                        break;
                    case Constants.ArchetypeStrength:
                        button.transform.Find(Constants.TypeStrength).gameObject.SetActive(true);
                        break;
                    case Constants.ArchetypeDexterity:
                        button.transform.Find(Constants.TypeDexterity).gameObject.SetActive(true);
                        break;
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


        void SetIntro()
        {
            DestroyImmediate(_dialogueBox);
            _dialogueBox = Instantiate(_introDialoguePrefab, _uiParent.transform);
            
            _dialogueBox.gameObject.name = 
                _dialogueBox.gameObject.name.Remove(_dialogueBox.gameObject.name.IndexOf('(')).Remove(0, 5);
            
            _choiceButtonLeftPrefab     = _introButtonPrefab;
            _choiceButtonMiddlePrefab   = _introButtonPrefab;
            _choiceButtonRightPrefab    = _introButtonPrefab;

            ConnectAttributes();
            ClearUI.Invoke();
        }
        
        #endregion

        #region TypeWriting

        void DialogueTextFinished()
        {
            //Debug.Log("Dialogue Text is finished");

            if (GameManager.Instance._story.canContinue)
            {
                GameManager.Instance._playerInput.Player.Interact.performed += OnClickNextDialogue;
                //Debug.Log("Click += NextDialogue");
            }
        }


        void PrompterTextFinished()
        {
            //Debug.Log("Prompter Text is finished");
            
            if (GameManager.Instance._story.canContinue)
            {
                GameManager.Instance._playerInput.Player.Interact.performed += OnClickNextDialogue;
                //Debug.Log("Click += NextDialogue");
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
            Debug.Log($"DisplayText > End the typewriter");

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
            //Refresh();
        }
        
        #endregion
        
        public void OnClickChoiceButton (Choice choice, string type = null)
        {
            _choiceType = type;
            _historyText.text += $"     > {choice.text}\n";

            PlaySoundChoiceButtonClicked();
            
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

            if (GameManager.Instance._beginCurtainsOpen)
                _curtains.Call.Invoke(Constants.StateCurtainsOpen, null);
            
            if (GameManager.Instance._intro)
                SetIntro();
            
            SetChruchObservable();
            SetForestObservable();
            SetTrialObservable();
            SetTempestObservable();
            
            GameManager.Instance.GetPlayer()._character.charisma.SetupBase((int)GameManager.Instance._story.variablesState["p_char"]);
            GameManager.Instance.GetPlayer()._character.strength.SetupBase((int)GameManager.Instance._story.variablesState["p_stre"]);
            GameManager.Instance.GetPlayer()._character.dexterity.SetupBase((int)GameManager.Instance._story.variablesState["p_dext"]);
            GameManager.Instance.GetPlayer()._character.constitution.SetupBase((int)GameManager.Instance._story.variablesState["p_comp"]);
            GameManager.Instance.GetPlayer()._character.luck.SetupBase((int)GameManager.Instance._story.variablesState["p_luck"]);
        
            //Debug.Log($"AM.OnPhaseStart() > GameManager.Instance.GetCharacter(\"PLAYER\")._character:{GameManager.Instance.GetPlayer()._character}");

            _historyText.font = GameManager.Instance._currentFont;
            _historyText.text = String.Empty;
            _historyBox.SetActive(false);

            _playerName = (string) GameManager.Instance._story.variablesState["p_name"];
            
            GameManager.Instance._story.ObserveVariable("p_name", (variableName, value) => 
                ChangePlayerName((string) value));
            
            //Debug.Log($"AM.OnPhaseStart > Start story | Refresh call ");
            Refresh();
        }
        
        void OnPhaseEnded()
        {
            Debug.Log("AM.OnPhaseEnded()");
            // Clear UI
            //_uiParent.SetActive(false);
            ClearUI.Invoke();
            _mainMenuEndGameButton.gameObject.SetActive(true);
        }
        
        void OnClearUI()
        {
            _dialogueText.text = String.Empty;
            _statsUI.HideStats.Invoke();
            
            foreach (var button in _choicesButtonList)
                Destroy(button.gameObject);
            _choicesButtonList.Clear();
        
            _dialogueTypewriter.onTextShowed.RemoveListener(DialogueTextFinished);
            _prompterTypewriter.onTextShowed.RemoveListener(PrompterTextFinished);
            _dialogueBox.SetActive(false);
            
            // Clear masks
            foreach (Transform mask in _masks.transform)
                mask.gameObject.SetActive(false);
            foreach (Transform nameBox in _nameBoxes.transform)
                nameBox.gameObject.SetActive(false);
        }
        

        void OnIntroEnded()
        {
            Debug.Log("AM.IntroEnded is invoke");
            GameManager.Instance._intro = false;
            // _dialogueBox
            DestroyImmediate(_dialogueBox);
            _dialogueBox = Instantiate(_regularDialoguePrefab, _uiParent.transform);
            _dialogueBox.gameObject.name = 
                _dialogueBox.gameObject.name.Remove(_dialogueBox.gameObject.name.IndexOf('('));

            _choiceButtonLeftPrefab = _choiceButtonRegularLeftPrefab;
            _choiceButtonMiddlePrefab = _choiceButtonRegularMiddlePrefab;
            _choiceButtonRightPrefab = _choiceButtonRegularRightPrefab;

            ConnectAttributes();
            ClearUI.Invoke();
        }

        void OnRingBell()
        {
            _trialBellAnimator.SetTrigger("bell_use");
            AkSoundEngine.PostEvent("Play_SFX_Story_JudgeBellFarTrial", gameObject);
        }
        
        #endregion
        
        
        #region TagHandlers
        
        void CheckTag(string[] words)
        {
            switch (words[0])
            {
                case Constants.TagIntro:    HandleTagIntro();                               break;
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
                case Constants.TagTrial:    HandleTagTrial();                               break;
                case Constants.TagCurtains: HandleTagCurtains(words[1]);                    break;
                case Constants.TagBattle:   HandleTagBattle(words[1]);                      break;
                case Constants.TagHeight:   HandleTagHeight(words.Skip(1).ToArray());       break;
                default: Debug.LogError($"AM.CheckTag > Error: {words[0]} is an unkwown tag."); break;
            }
        }
        
        void TagActionOver()
        {
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > TagAction is over =======");
            _isActionDone = true;
        }
        
        void HandleTagIntro()
        {
            GameManager.Instance._intro = true;
            SetIntro();
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
            //Debug.Log($"AM.HandleTagSet > Change from {_stage} to {location}");
            _stage = location;
            
            if (GameManager.Instance._intro)
                IntroEnded.Invoke();
            
            _setEmpty.GetComponent<Animator>().SetBool("InOut", false);
            
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
                if (_currentSet == _setTempest)
                    SetTempestPropsOnStage(false);
                if (_currentSet == _setChurchNight)
                    SetChurchNightPropsOnStage(false);
                if (_currentSet == _setForest)
                    SetForestPropsOnStage(false);
                if (_currentSet == _setTrial)
                    SetTrialPropsOnStage(false);
            }

            GameManager.Instance.ClearStageCharacters();
            
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
                case Constants.SetChuchNight:
                    _setChurchNight.SetActive(true);
                    _setChurchNight.GetComponent<Animator>().SetBool("InOut",true);
                    SetChurchNightPropsOnStage(true);
                    _currentSet = _setChurchNight;
                    break;
                case Constants.SetChuchDay:
                    _setChurchDay.SetActive(true);
                    _setChurchDay.GetComponent<Animator>().SetBool("InOut",true);
                    _currentSet = _setChurchDay;
                    break;
                case Constants.SetTrial:
                    _setTrial.SetActive(true);
                    _setTrial.GetComponent<Animator>().SetBool("InOut",true);
                    SetTrialPropsOnStage(true);
                    _currentSet = _setTrial;
                    // Judge set position
                    StartCoroutine(GameManager.Instance.GetCharacter("Judge").SetJudgePositionCoroutine());
                    break;
                case Constants.SetTempest:
                    _setTempest.SetActive(true);
                    _setTempest.GetComponent<Animator>().SetBool("InOut",true);
                    SetTempestPropsOnStage(true);
                    _currentSet = _setTempest;
                    break;
                case Constants.SetForest:
                    _setForest.SetActive(true);
                    _setForest.GetComponent<Animator>().SetBool("InOut",true);
                    SetForestPropsOnStage(true);
                    _currentSet = _setForest;
                    break;
                case Constants.SetEmpty:
                    _setEmpty.SetActive(true);
                    _setEmpty.GetComponent<Animator>().SetBool("InOut",true);
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
            //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Play sound {soundToPlay}");

            //Même probleme que dans le Audience tag pour le son, j'ai fix sale déso

            /*AkSoundEngine.PostEvent(soundToPlay, gameObject);
            if (soundToPlay.Contains("VOX"))
            {
                Debug.Log("Stopped Emotion Sound FX");
                AkSoundEngine.PostEvent("Stop_VOX_Emotions", gameObject);
            }*/

            void PlaysoundAction()
            {
                AkSoundEngine.PostEvent(soundToPlay, gameObject);
                if (soundToPlay.Contains("VOX"))
                {
                    //Debug.Log("Stopped Emotion Sound FX");
                    AkSoundEngine.PostEvent("Stop_VOX_Emotions", gameObject);
                }
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
                    if (_allowScreenshake)
                        StartCoroutine(GameManager.Instance.ScreenShakeCoroutine(TagActionOver));
                    else
                        TagActionOver();
                }
                _tagMethods.Add(ScreenShakeAction);
            }
            else
            {
                var intensity = float.Parse(data[1], CultureInfo.InvariantCulture);
                var time = float.Parse(data[2], CultureInfo.InvariantCulture);
                
                void ScreenShakeAction()
                {
                    if (_allowScreenshake)
                        StartCoroutine(GameManager.Instance.ScreenShakeCoroutine(TagActionOver, intensity, time));
                    else
                        TagActionOver();
                }
                _tagMethods.Add(ScreenShakeAction);
            }
        }

        void HandleTagLook(string[] data)
        {
            //Debug.Log($"AM.HandleTagLook > {data[0]} must look to {data[1]}");
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
                //Debug.Log($"AM.{MethodBase.GetCurrentMethod()?.Name} > Target: {target}");
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
                case Constants.ReactDisgust:
                    break;
                case Constants.ReactEmpathy:
                    break;
                case Constants.ReactHush:
                    break;
                case Constants.ReactSilent:
                    break;
                default:
                    Debug.LogError($"AM.HandleTagAudience > Unkwonw reaction | {reaction} |");
                    return;
            }
            //Debug.Log($"AM.HandleTagAudience > Reaction: {reaction}");

            var soundToPlay = "Play_CrowdReaction_" + reaction;

            AkSoundEngine.PostEvent(soundToPlay, gameObject); //le son de réaction marche pas dans AudienceAction(), je le déclenche ici et je l'ai commenté la bas

            void AudienceAction()
            {

                // AkSoundEngine.PostEvent(soundToPlay, gameObject);

                foreach (var particleSystem in particleSystemEmiters)
                {
                    //Debug.Log($"AudienceAction > Emit particles from {particleSystem.transform.parent.name}");
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
                    //Debug.Log($"AM.HandleTagMap > Valide travel name");
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
                //Debug.Log("MapAction");
                // if (travel != string.Empty)
                //     _map.DisplayTravel(travel);
                if (travel != string.Empty)
                    _map.GetComponent<Animator>().SetTrigger(travel);
                
                TagActionOver();
            }

            _tagMethods.Add(MapAction);
        }


        void HandleTagTrial()
        {
            Debug.Log("AM.HandleTagTrial");
            
            HandleDialogue();
            HandleTagPlaysound("Play_SFX_Story_JudgeBellFarTrial");
            HandleTagScreenShake(new[] { "screenshake" });
            HandleTagWait("0.5");
            HandleTagAudience(Constants.ReactChoc);
            
            foreach (var character in GameManager.Instance._characters)
            {
                if (character._onStage)
                {
                    Debug.Log($"{character.name} > is on stage");
                    StartCoroutine(character.PlayAnimCoroutine("surprised", TagActionOver));
                }
            }
            StartCoroutine(GameManager.Instance.GetPlayer().PlayAnimCoroutine("surprised", TagActionOver));
            
        }
        
        
         void HandleTagCurtains(string state)
        {
           Debug.Log($"AM.HandleTagCurtains > Curtains must be {state}");

            _tagMethods.Add(() =>
            {
                _curtains.Call.Invoke(state, TagActionOver);
            });
        }


        void HandleTagBattle(string state)
        {
            switch (state)
            {
                case Constants.BattleBegin:
                    Debug.Log($"AM.HandleTagBattle > Battle begin");
                    _battleHUD.BattleBegin.Invoke();
                    _tempestLeviathanAnimator.SetBool("InOut", true);
                    break;
                case Constants.BattleEnd:
                    Debug.Log($"AM.HandleTagBattle > Battle end");
                    _battleHUD.BattleEnded.Invoke();
                    _tempestLeviathanAnimator.SetTrigger("underwater");
                    _tempestLeviathanAnimator.SetBool("InOut", false);
                    _tempestRedLeviathanAnimator.SetTrigger("endBattle");
                    break;
                default:
                    Debug.LogError($"AM.HandleTagBattle > Error: Unknown battle state [{state}]");
                    break;
                
            }
        }


        void HandleTagHeight(string[] data)
        {
            if (data.Length != 2)
            {
                Debug.LogError($"AM.HandleTagHeight > Error: invalid number of parameters [{data.Length}]");
                return;
            }

            var character = GameManager.Instance.GetCharacter(data[0]);
            if (character == null)
            {
                Debug.LogError($"AM.HandleTagHeight > Error: invalid character [{data[0]}]");
                return;
            }

            float height = float.MaxValue;
            try {
                height = float.Parse(data[1], CultureInfo.InvariantCulture);
            }
            catch (FormatException) {
                Debug.LogError($"AM.HandleTagHeight > Error: '{data[1]}' is not in a valid format.");
                return;
            }
            catch (OverflowException) {
                Debug.LogError($"AM.HandleTagHeight > Error: {data[1]} is outside the range of a Single.");
                return;
            }

            if (height == float.MaxValue || height == 0)
            {
                Debug.LogWarning($"AM.HandleTagHeight > Warning: height == 0 or is invalid [{data[0]}]");
                return;
            }
            
            void HeightAction()
            {
                StartCoroutine(character.MoveHeightPositionCoroutine(height, TagActionOver));
            }
            
            _tagMethods.Add(HeightAction);
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

            //Debug.Log($"Update _dialogueText > {textToDisplay}");
            //_dialogueText.text = textToDisplay;
            _dialogueText.font = GameManager.Instance._currentFont;
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

        /// <summary>
        /// Execute Tag methods one by one
        /// </summary>
        /// <returns></returns>
        IEnumerator ExecuteTagMethods()
        {
            //Debug.Log("Begin AM.ExecuteTagMethods");
            // Waiting if something needed to be done first
            while (!_canContinueDialogue)
            {
                //Debug.Log("Wait to display text");
                yield return null;
            }
            Debug.Log($"AM.ExecuteTagMethods > Can start execute Tags: {_tagMethods.Count} methods");
            foreach (var tagAction in _tagMethods)
            {
                Debug.Log($"{tagAction.Method.Name}");
                _isActionDone = false;
                tagAction();
                while (!_isActionDone)
                    yield return null;
            }
            Debug.Log($"AM.ExecuteTagMethods > finish executing Tags");

            HandleChoices();
        }

        #endregion
    }
}
