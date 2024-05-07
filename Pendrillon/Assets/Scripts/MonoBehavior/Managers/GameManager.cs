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

        public CharacterHandler _player;
        
        // Tmp
        public Character _playerCharacter;
        
        public GameObject _characterPrefab;
        public GameObject _enemyPrefab;
    
        public GroundGrid _gridScene;

        public Transform _playerPos;
        public Transform _enemyPos;
        
        [SerializeField] private TextAsset _inkAsset;
        [HideInInspector] public Story _story;

        public Vector2 _buttonPos = new Vector2(250, 150);
        public AK.Wwise.Event _wwiseEvent;
    
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

            /*if (_inkAsset == null)
            Resources.Load<TextAsset>("InkFiles/");*/
        
            _story = new Story(_inkAsset.text);

            ActingManager.Instance.PhaseEnded.AddListener(FromActingPhaseToFightingPhase);
        }

        private void Start()
        {
            SetupPlayer();
            SetupCharacters();
        
            FightingManager.Instance._player = GetPlayer();
            FightingManager.Instance._player.transform.position = _playerPos.position;
            FightingManager.Instance._player.transform.LookAt(Camera.main.transform);
        
            BeginGame();
        }
        #endregion

        public void SetupPlayer()
        {
            _player = Instantiate(_characterPrefab).GetComponent<CharacterHandler>();
            _player.transform.position = _playerPos.position;
            _player.transform.rotation = _playerPos.rotation;
            //_player.name = _player.GetComponent<CharacterHandler>()._character.name;
            _player._character = _playerCharacter;
            _player.name = _playerCharacter.name;
            
            Destroy(GetComponent<Enemy>());
        }
        
        public void SetupCharacters()
        {
            for (var i = 0; i < _charactersBase.Count; i++)
            {
                var character = Instantiate(_characterPrefab);
                character.transform.position = _enemyPos.position + new Vector3(i * 3.0f, 0, i * 2.5f);
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
            // Tell to AM to Begin

            
            if (true) // Want to test battle part
                _story.ChoosePathString("boat_slip_1.guards_are_called");
            
            ActingManager.Instance.PhaseStart.Invoke();
        }

        void FromActingPhaseToFightingPhase()
        {
            Debug.Log("GM.FromActingPhaseToFightingPhase > Can prepare the fight");
            //SceneManager.LoadScene("DemoFightingScene");

            foreach (var character in _characters)
            {
                character.transform.position = new Vector3(-100, -100, -100);
            }
            
            for (int i = 0; i < ActingManager.Instance.GetEnemiesToFight().Count; i++)
            {
                CharacterHandler enemyCharacter = ActingManager.Instance.GetEnemiesToFight()[i];
                enemyCharacter.transform.position = _enemyPos.position + new Vector3(i * 3.0f, 0, i * 2.5f);
                enemyCharacter._character = enemyCharacter._character;

                enemyCharacter.GetComponent<Enemy>().enabled = true;
                
                FightingManager.Instance._enemies.Add(enemyCharacter.GetComponent<Enemy>());
            }
        
            FightingManager.Instance.BeginFight.Invoke();
        }


    }
}
