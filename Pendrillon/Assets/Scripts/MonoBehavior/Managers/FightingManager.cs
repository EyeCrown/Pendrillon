using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace MonoBehavior.Managers
{
    public class FightingManager : MonoBehaviour
    {
        #region Attributes

        public static FightingManager Instance { get; private set; }

        /*public enum Turn
        {
            Player,
            Enemy,
        } 
    
        private Turn turn;*/

        public CharacterHandler _player;
        public List<Enemy> _enemies;
        
        public int _actionPoints;

        public List<FightAction> _actions;
        public List<FightAction> _selectedActions;

        //public List<FightActionButton> _ActionButtons;
        

        // Targetable
         private TargetableAction _waitingAction;
        
        // UI Debug 
        public GameObject _uiParent;
        public TextMeshProUGUI _playerDataText;
        public TextMeshProUGUI _actionSelectedText;
        public GameObject _buttonPrefab;
        
        #endregion


        #region Events

        public UnityEvent BeginFight;
        public UnityEvent BeginPlayerTurn;
        public UnityEvent PlayerReadyToPlay;
        public UnityEvent EndPlayerTurn;
        public UnityEvent BeginEnemyTurn;

        public UnityEvent<FightAction> AddFightAction;
        
        public UnityEvent Validate;
        
        public UnityEvent CanSelectTarget;
        public UnityEvent<Enemy> ValidateTarget;
        //public UnityAction EndFight;

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
        
            _uiParent       = GameObject.Find("Canvas/FIGHTING_PART").gameObject;
            _playerDataText       = _uiParent.transform.Find("PlayerDataText").GetComponent<TextMeshProUGUI>();
            _actionSelectedText   = _uiParent.transform.Find("ActionSelectedText").GetComponent<TextMeshProUGUI>();
            
            BeginFight.AddListener(OnBeginFight);
            BeginPlayerTurn.AddListener(OnBeginTurn);
            PlayerReadyToPlay.AddListener(OnUpdateUIText);
            AddFightAction.AddListener(OnAddFightAction);
            EndPlayerTurn.AddListener(OnEndPlayerTurn);
            BeginEnemyTurn.AddListener(OnBeginEnemyTurn);
            ValidateTarget.AddListener(OnValidateTarget);
            
            }

        void Start()
        {
            _uiParent.gameObject.SetActive(false);
            //_player = GameManager.Instance.GetPlayer();
            //_player._character.Initialize();

            foreach (var enemy in _enemies)
            {
                enemy.Initialize();
            }
        
            _actionSelectedText.text = String.Empty;
            _selectedActions.Clear();
        
            //BeginPlayerTurn.Invoke();
            //_actionButtonList = new List<Tuple<FightAction, Button>>();
        }

        #endregion

        #region Methods

        public void InitializeEnemies(List<CharacterHandler> enemies)
        {
            for (int i = 0; i < enemies.Count; i++)
            {
                var enemy = enemies[i];
                enemy.transform.position =
                    GameManager.Instance._gridScene._grid.GetCellCenterWorld(new Vector3Int(4 + i * 2, 0, 6 + i * 2));
                //enemyCharacter._character = GetCharacter(enemyCharacter._character.name)._character;

                enemy.GetComponent<Enemy>().enabled = true;
                
                FightingManager.Instance._enemies.Add(enemy.GetComponent<Enemy>());
            }
        }
        
        void SetupActionButtons()
        {
            //Debug.Log($"FM.SetupActionButtons > {_actionButtonList}");

            Vector2 buttonPos = new Vector2(150, 150);
            foreach (var action in _actions)
            {
                action.alreadyUse = false;
                
                var actionButton = Instantiate(_buttonPrefab, _uiParent.transform);

                //actionButton.GetComponent<FightActionButton>().Initialize(action, buttonPos);

                buttonPos.x += actionButton.GetComponent<Button>().GetComponent<RectTransform>().sizeDelta.x + 20;
            
                if (!action.accesibleByDefault)
                    actionButton.gameObject.SetActive(false);
                
            }
        }


        public void PassTurn()
        {
            _selectedActions.Clear();
            
            BeginEnemyTurn.Invoke();
        }

        #endregion
        

        /*void AddActionToSelection(FightAction action)
        {
            if (_selectedActions.Count < 3)
            {
                _selectedActions.Add(action);
                _actionSelectedText.text += action.name + "\n";
                Debug.Log("Add " + action.name + " to list actions");
                //buttonObject.gameObject.SetActive(false);
            
                
        
                _playerDataText.text = _actionPoints+"PA\n" + _player._character;
                //ValidateTarget.Invoke(action);
            }
            else
            {
                Debug.Log("List full !");
            }
        }*/


        /*public void AddTargetableAction(GameObject target)
        {
            ValidateTarget.Invoke(_waitingAction);
        
            _waitingAction.target = target;
        
            if (_waitingAction != null) AddActionToSelection(_waitingAction);
            _waitingAction = null;
        
            ValidateAttacks();
        }*/
        
        public void ValidateAttacks()
        {
            Debug.Log("Launch all attacks: \n" + _actionSelectedText.text);
        
            StartCoroutine(DoingAction());
        
            _actionSelectedText.text = String.Empty;
            _selectedActions.Clear();

        }

        void EnemiesTurn()
        {
            Debug.Log("Enemy turn");

            foreach (var enemy in _enemies)
            {
                int hits = enemy.GetDamage();
                _player._character.hp -= hits;
                Debug.Log($"Player has lost {hits} hp.");
            }
        
            BeginPlayerTurn.Invoke();
        }

        void EndFight(bool win)
        {
            String winText = "Fight is over, ";
            if (win)
            {
                Debug.Log(winText + " player WIN the fight");
                Application.Quit();
            }
            else
            {
                Debug.Log(winText + " player LOST the fight");
                Application.Quit();
            }
        }

        public void RemoveEnemy(Enemy enemy)
        {
            _enemies.Remove(enemy);
        }


        #region EventHandlers

        public void OnBeginFight()
        {
            _uiParent.gameObject.SetActive(true);
            
            _player = GameManager.Instance.GetPlayer();
            _player._character.Initialize();
            //_player.transform.position = new Vector3(-4.0f, 0, 2.0f);
        
            float x = 0, z = 0;
            foreach (var enemy in _enemies)
            {
                enemy.transform.position = GameManager.Instance._enemyPos.position + new Vector3(1.5f + x, 0, 3.0f + z);
                enemy.transform.LookAt(Camera.main.transform);
                enemy.Initialize();
            
                x += 3.0f;
                z += 3.0f;
            }
            SetupActionButtons();
            
            // TODO: Connect with applausemeter to check who begin
            BeginPlayerTurn.Invoke();
        }

        void OnBeginTurn()
        {
            if (_player._character.hp <= 0)
            {
                Debug.Log("Player is dead.");
                EndFight(false);
                return;
            }

            if (_enemies.Count <= 0)
            {
                Debug.Log("All enemies are dead.");
                EndFight(true);
            }
        
            _actionPoints += 3;
        
            
            Debug.Log("Begin");
            PlayerReadyToPlay.Invoke();
        }


        private void OnAddFightAction(FightAction action)
        {
            //_selectedActions.Add(action);
            
            
            if (_selectedActions.Count < 3)
            {
                _actionPoints -= action.cost;
                _selectedActions.Add(action);
                
                if (action is TargetableAction)
                    CanSelectTarget.Invoke();
                
                // update ui
                _actionSelectedText.text += action.name + "\n";
                
                // debug
                Debug.Log("Add " + action.name + " to list actions");
                
                OnUpdateUIText();
            }
            else
            {
                Debug.Log("List full !");
            }
        }
        
        private void OnUpdateUIText()
        {
            _playerDataText.text = _actionPoints+"PA\n" + _player._character;
            
            _actionSelectedText.text = "Selected actions: ";
            foreach (var action in _selectedActions)
            {
                _actionSelectedText.text += "> " + action.name + "\n";
            }
        }

        private void OnEndPlayerTurn()
        {
            
            // Do attacks
            StartCoroutine(DoingAction());
            
            BeginEnemyTurn.Invoke();
        }

        void OnBeginEnemyTurn()
        {
            EnemiesTurn();
        }

        void OnValidateTarget(Enemy target)
        {
            foreach (var action in _selectedActions)
            {
                if (action is TargetableAction)
                {
                    //(action as TargetableAction).AssignTarget(target);
                }
            }
            
            EndPlayerTurn.Invoke();
        }
        
        #endregion
        

        #region Coroutines

        IEnumerator DoingAction()
        {
            foreach (var action in _selectedActions)
            {
                action.Perform();            
                yield return new WaitForSeconds(0.1f);
            }
            _selectedActions.Clear();
            OnUpdateUIText();
        }

        #endregion
    
    
    }
}
