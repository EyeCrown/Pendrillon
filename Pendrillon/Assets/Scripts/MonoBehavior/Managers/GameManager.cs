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
        
        
        public GameObject _characterPrefab;
        public GameObject _enemyPrefab;
    
        public GroundGrid _gridScene;

        public Transform _playerPos;
        public Transform _enemyPos;
        
        [SerializeField] private TextAsset _inkAsset;
        [HideInInspector] public Story _story;

        public Vector2 _buttonPos = new Vector2(150, 150);
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
            // foreach (var character in _characters)
            // {
            //     CharacterHandler characterHandler = Instantiate(character, transform);
            //     characterHandler.DialogueUpdate.AddListener(characterHandler.UpdateDialogue);
            //     character = characterHandler;
            // }

            for (var i = 0; i < _charactersBase.Count; i++)
            {
                var character = Instantiate(_characterPrefab);
                character.transform.position = new Vector3(-5 + i * 1.5f, 0, 5);
                character.GetComponent<CharacterHandler>().character = _charactersBase[i];
                character.GetComponent<CharacterHandler>().DialogueUpdate.AddListener(
                    character.GetComponent<CharacterHandler>().UpdateDialogue);

                character.name = character.GetComponent<CharacterHandler>().character.name;
                
                _characters.Add(character.GetComponent<CharacterHandler>());
            }
        
            FightingManager.Instance.player = GetCharacter("PLAYER");
            FightingManager.Instance.player.transform.position = _playerPos.position;
            FightingManager.Instance.player.transform.LookAt(Camera.main.transform);
        
            BeginGame();
        }
        #endregion
    
    
        public CharacterHandler GetCharacter(string characterName)
        {
            for (var i = 0; i < _characters.Count; i++)
            {
                if (_characters[i].character.name.ToLower() == characterName.ToLower())
                    return _characters[i];
            }

            return null;
        }


        void BeginGame()
        {
            // Tell to AM to Begin
            ActingManager.Instance.PhaseStart.Invoke();
            /*String marcello = "MARCELLO";
        String rudolf = "RUDOLF";
        List<String> enemies = new List<string>();
        enemies.Add(marcello);
        enemies.Add(rudolf);
        FromActingPhaseToFightingPhase(enemies);*/
        }

        void FromActingPhaseToFightingPhase()
        {
            Debug.Log("GM.FromActingPhaseToFightingPhase > Can prepare the fight");
            //SceneManager.LoadScene("DemoFightingScene");
            
            float x = 0, z = 0;
            foreach (var enemyCharacter in ActingManager.Instance.GetEnemiesToFight())
            {
                var enemy = Instantiate(_enemyPrefab).GetComponent<Enemy>();
                enemy.transform.position = _enemyPos.position;
                enemy._character = enemyCharacter.character;
                //enemy.damage = 5;
                FightingManager.Instance.enemies.Add(enemy);
            
                x += 1.5f;
                z -= 1.5f;
            }
        
            FightingManager.Instance.BeginFight();
        }


    }
}
