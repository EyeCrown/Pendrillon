using System.Collections.Generic;
using Ink.Runtime;
using UnityEngine;


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

        public Character _playerData;
        public CharacterHandler _player;
        
        public GameObject _characterPrefab;
    
        public GroundGrid _gridScene;

        public Transform _playerPos;
        public Transform _enemyPos;
        
        [SerializeField] private TextAsset _inkAsset;
        [HideInInspector] public Story _story;

        public Vector2 _buttonPos = new Vector2(250, 150);
        [HideInInspector] public AK.Wwise.Event _wwiseEvent;
    
        public AK.Wwise.Event _wwiseEvent;

        [Header("Timers")] 
        [Range(0, 5)] public float _timeButtonSpawnInSec;
        
        
        
        [Header("Debug")]
        [SerializeField] private bool _goDirectToFight;
        
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
            DontDestroyOnLoad(this.gameObject);

            // Connect Events
            ActingManager.Instance.PhaseEnded.AddListener(PrepareFightingPhase);
            
            /*if (_inkAsset == null)
            Resources.Load<TextAsset>("InkFiles/");*/
        
            _story = new Story(_inkAsset.text);
            
        }

        private void Start()
        {
            SetupPlayer();
            SetupCharacters();

            FightingManager.Instance._player = GetPlayer();
        
            BeginGame();
        }
        #endregion

        public void SetupPlayer()
        {
            GeneratePlayerStats();
            _player = Instantiate(_characterPrefab).GetComponent<CharacterHandler>();
            _player.transform.position = _gridScene.GetWorldPositon(_gridScene._playerPosition);
            
            Destroy(_player.GetComponent<Enemy>());
            
            _player.transform.rotation = _playerPos.rotation;
            
            _player.name = "Player"; //_player.GetComponent<CharacterHandler>()._character.name;
        }
        
        public void SetupCharacters()
        {
            for (var i = 0; i < _charactersBase.Count; i++)
            {
                var character = Instantiate(_characterPrefab);
                
                character.transform.position = _gridScene.GetWorldPositon(_gridScene._enemyPosition + new Vector2Int(i*3, i*2)); // (new Vector3Int(4 + i * 2, 0, 10 + i * 2));
                
                character.transform.rotation = _enemyPos.rotation;
                character.GetComponent<CharacterHandler>()._character = _charactersBase[i];
                character.GetComponent<Enemy>()._character = _charactersBase[i];
                character.GetComponent<Enemy>().enabled = false;

                character.name = character.GetComponent<CharacterHandler>()._character.name;
                
                _characters.Add(character.GetComponent<CharacterHandler>());
            }
        }
    
        public CharacterHandler GetCharacter(string characterName)
        {
            if (characterName.ToLower() == "player")
                return GetPlayer();
            
            for (var i = 0; i < _characters.Count; i++)
            {
                if (_characters[i]._character.name.ToLower() == characterName.ToLower())
                    return _characters[i];
            }

            return null;
        }

        public CharacterHandler GetPlayer()
        {
            return _player;
        }
        
        
        void BeginGame()
        {
            MoveCharactersOutsideScene();
            if (_goDirectToFight)
            {
                var enemies = new List<CharacterHandler>();
                enemies.Add(GetCharacter("Marcello"));
                enemies.Add(GetCharacter("Rudolf"));
                
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

            _playerData.name = "Player";//(string) _story.variablesState["p_name"];
            _playerData.hp = (int) _story.variablesState["p_hp"];
            
            _playerData.charisma.SetupBase((int)_story.variablesState["p_char"]);
            _playerData.strength.SetupBase((int)_story.variablesState["p_stre"]);
            _playerData.dexterity.SetupBase((int)_story.variablesState["p_dext"]);
            _playerData.constitution.SetupBase((int)_story.variablesState["p_comp"]);
            _playerData.luck.SetupBase((int)_story.variablesState["p_luck"]);


            _player._character = _playerData;
            Debug.Log($"Player data: {_playerData}");
        }

    }
}



