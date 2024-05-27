using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Cinemachine;
using Ink.Runtime;
using UnityEngine;
using UnityEngine.InputSystem;

/*public enum GameState
{
    ACTING,
    FIGHTING,
    PAUSE,
}*/

namespace MonoBehavior.Managers
{
    public class GameManager : MonoBehaviour
    {
        #region Attributes
        public static GameManager Instance { get; private set; }
    
        //public GameState State { get; private set; }

        public List<Character> _charactersBase = new List<Character>();
        public List<CharacterHandler> _characters = new List<CharacterHandler>();

        public CharacterHandler _player;
        public Prompter _prompter;
        
        [Header("=== Prefabs ===")]
        [SerializeField] private GameObject _characterPrefab;
        [SerializeField] private GameObject _playerPrefab;
        [SerializeField] private GameObject _arlePrefab;
        [SerializeField] private GameObject _passeurPrefab;
        [SerializeField] private GameObject _prompterPrefab;
        [SerializeField] private GameObject _naidaPrefab;

        [Header("=== Locations ===")]
        public GroundGrid _gridScene;

        public float _gridYBase = 0.65f;
        public float _gridYBarge = 2.25f;

        public Transform _enemyPos;
        
        [Header("=== Ink File ===")]
        [SerializeField] private TextAsset _inkAsset;
        [HideInInspector] public Story _story;

        public Vector2 _buttonPos = new Vector2(250, 150);
        
        public AK.Wwise.Event _wwiseEvent;

        // Screen shake
        private CinemachineBasicMultiChannelPerlin _cameraPerlin;

        [HideInInspector] public PlayerInputs _playerInput = null;
        
        
        [Header("=== Timers ===")] 
        [Range(0, 5)] public float _timeButtonSpawnInSec;
        [Range(0, 5)] public float _timeTextToAppearInSec;
        
        
        [Header("=== Debug ===")]
        [SerializeField] private bool _goDirectToFight;
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
            DontDestroyOnLoad(this.gameObject);

            // Connect Attributes
            _gridScene = GameObject.Find("Grid").GetComponent<GroundGrid>();
            _gridScene.transform.position = new Vector3(-23.0f, _gridYBase, -6.5f);
            _cameraPerlin = GameObject.Find("Virtual Camera").GetComponent<CinemachineVirtualCamera>()
                .GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();

            _playerInput = new PlayerInputs();
            
            
            // Connect Events
            ActingManager.Instance.PhaseEnded.AddListener(PrepareFightingPhase);
            
            /*if (_inkAsset == null)
            Resources.Load<TextAsset>("InkFiles/");*/
            
            _story = new Story(_inkAsset.text);

            var path = _story.state.currentPointer;
            Debug.Log($"GM.Awake > _story.state.currentPathString: {path}");
        }

        private void Start()
        {
            SetupPlayer();
            SetupCharacters();
            SetupPrompter();
            
            FightingManager.Instance._player = GetPlayer();
            
            _cameraPerlin.m_AmplitudeGain = 0.0f;

            BeginGame();
        }
        
        #endregion

        #region Setup

        public void SetupPlayer()
        {
            //GeneratePlayerStats();
            _player = Instantiate(_playerPrefab).GetComponent<CharacterHandler>();
            _player.transform.position = _gridScene.GetWorldPositon(new Vector2Int(-100, -100));
            
            Destroy(_player.GetComponent<Enemy>());
            
            _player.transform.LookAt(Camera.main.transform);
            
            _player._character._nicknames.Clear();
            _player._character._nicknames.Add(_player._character.name);
            _player.name = "Player"; //_player.GetComponent<CharacterHandler>()._character.name;
        }
        
        public void SetupCharacters()
        {
            for (var i = 0; i < _charactersBase.Count; i++)
            {
                GameObject character;
                Debug.Log($"Setup > {_charactersBase[i]}");
                switch (_charactersBase[i].name)
                {
                    case "Arle":
                        character = Instantiate(_arlePrefab);
                        break;
                    case "Passeur":
                        character = Instantiate(_passeurPrefab);
                        break;
                    case "Naïda":
                        character = Instantiate(_naidaPrefab);
                        break;
                    default:
                        character = Instantiate(_characterPrefab);
                        break;
                }
                
                //character.transform.position = _gridScene.GetWorldPositon(_gridScene._enemyPosition + new Vector2Int(i*3, i*2)); // (new Vector3Int(4 + i * 2, 0, 10 + i * 2));
                character.transform.position = _gridScene.GetWorldPositon(new Vector2Int(-100, -100)); 
                
                //character.transform.rotation = _enemyPos.rotation;
                character.transform.LookAt(Camera.main.transform);
                character.GetComponent<CharacterHandler>()._character = _charactersBase[i];
                character.GetComponent<CharacterHandler>()._character._nicknames.Clear();
                character.GetComponent<CharacterHandler>()._character._nicknames.Add(character.GetComponent<CharacterHandler>()._character.name);

                // character.GetComponent<Enemy>()._character = _charactersBase[i];
                // character.GetComponent<Enemy>().enabled = false;
                
                character.name = character.GetComponent<CharacterHandler>()._character.name;
                
                _characters.Add(character.GetComponent<CharacterHandler>());
            }
        }

        public void SetupPrompter()
        {
            _prompter = Instantiate(_prompterPrefab).GetComponent<Prompter>();
            _prompter.transform.position = _gridScene.GetWorldPositon(new Vector2Int(-100, -100));
            _prompter.name = Constants.PrompterName;
        }

        #endregion
        
    
        public CharacterHandler GetCharacter(string characterName)
        {
            if (characterName.ToLower() == "player")
                return GetPlayer();
                
            foreach (var character in _characters)
            {
                foreach (var nickname in character._character._nicknames)
                {
                    if (characterName == nickname)
                        return character;
                }
            }

            return null;
        }

        public void ClearStageCharacters()
        {
            Vector2Int coords = new Vector2Int(-10, -10);
            _player.SetPosition(coords);

            foreach (var character in _characters)
            {
                character.SetPosition(coords);
            }
        }
        
        
        public CharacterHandler GetPlayer()
        {
            return _player;
        }


        public void SetGridHeight(string stage = null)
        {
            var y = _gridYBase;
            if (stage == Constants.SetBarge)
            {
                y = _gridYBarge;
                Debug.Log($"GM.Grid > Changement {y}");
            }
            
            _gridScene.transform.position = new Vector3(-23.0f, y, -6.5f);
            Debug.Log($"GM.Grid > {y}");
        }
        
        void BeginGame()
        {
            //MoveCharactersOutsideScene();
            if (_goDirectToFight)
            {
                var enemies = new List<CharacterHandler>
                {
                    GetCharacter("Marcello"),
                    GetCharacter("Rudolf")
                };

                FightingManager.Instance.InitializeEnemies(enemies);
                FightingManager.Instance.BeginFight.Invoke();
            }
            else
            {  
                ActingManager.Instance.PhaseStart.Invoke();
            }
        }

        void PrepareFightingPhase()
        {
            //Debug.Log("GM.PrepareFightingPhase > Can prepare the fight");

            MoveCharactersOutsideScene();
            
            // TODO: Maybe put event call into Initialize function ?
            FightingManager.Instance.InitializeEnemies(ActingManager.Instance.GetEnemiesToFight());
            FightingManager.Instance.BeginFight.Invoke();
        }

        void MoveCharactersOutsideScene()
        {
            foreach (var character in _characters)
            {
                character.transform.position = new Vector3(-999, -999, -999);
            }
        }
        
        
        void GeneratePlayerStats()
        {

            _player._character.name = "Player";//(string) _story.variablesState["p_name"];
            _player._character.hp = (int) _story.variablesState["p_hp"];
            
            _player._character.charisma.SetupBase((int)_story.variablesState["p_char"]);
            _player._character.strength.SetupBase((int)_story.variablesState["p_stre"]);
            _player._character.dexterity.SetupBase((int)_story.variablesState["p_dext"]);
            _player._character.constitution.SetupBase((int)_story.variablesState["p_comp"]);
            _player._character.luck.SetupBase((int)_story.variablesState["p_luck"]);
            
            Debug.Log($"Player data: {_player._character}");
        }

        /*void GenerateCharacterStats(ref Character character, string inkId)
        {
            
        }*/
        
        
        #region Coroutines

        public IEnumerator ScreenShakeCoroutine(Action callbackOnFinish, float intensity = Constants.ScreenShakeIntensity, float time = Constants.ScreenShakeTime)
        {
            Debug.Log($"GM.{MethodBase.GetCurrentMethod()?.Name} > Begin screen shake with {intensity} intensity during {time} seconds");
            _cameraPerlin.m_AmplitudeGain = intensity;
            yield return new WaitForSeconds(time);
            _cameraPerlin.m_AmplitudeGain = 0.0f;
            
            Debug.Log($"GM.{MethodBase.GetCurrentMethod()?.Name} > End screen shake");

            callbackOnFinish();
        }

        #endregion

        private void OnEnable()
        {
            _playerInput.Enable();
        }

        private void OnDisable()
        {
            _playerInput.Disable();
        }
    }
}