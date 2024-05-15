using System;
using System.Collections;
using System.Collections.Generic;
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

        public List<FightAction> _actionsList;
        public List<FightAction> _selectedActions;
        public List<Tuple<FightAction, Button>> _actionButtonList;

        // Targetable
        private TargetableAction _waitingAction;
        
        // UI Debug 
        public GameObject _uiParent;
        public TextMeshProUGUI _playerDataText;
        public TextMeshProUGUI _actionSelectedText;
        public Button _buttonPrefab;

        // Sound
        [SerializeField] private AK.Wwise.Event _wwiseSelectAttack;
        [SerializeField] private AK.Wwise.Event _wwiseConfirmAttack;
        [SerializeField] private AK.Wwise.Event _wwiseRemoveAttack;
        [SerializeField] private AK.Wwise.Event _wwiseSelectCharacter;
        [SerializeField] private AK.Wwise.Event _wwiseEndTurn;

        #endregion


        #region Events

        public UnityEvent BeginFight;
        public UnityEvent BeginPlayerTurn;
        public UnityEvent Validate;
        public UnityEvent MustSelectTarget;
        public UnityEvent<FightAction> ValidateTarget;
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
        
            BeginFight.AddListener(OnBeginFight);
            BeginPlayerTurn.AddListener(BeginTurn);
            BeginPlayerTurn.AddListener(UpdateUIText);
            ValidateTarget.AddListener(UpdateDependences);
            
            _uiParent       = GameObject.Find("Canvas/FIGHTING_PART").gameObject;
            _playerDataText       = _uiParent.transform.Find("PlayerDataText").GetComponent<TextMeshProUGUI>();
            _actionSelectedText   = _uiParent.transform.Find("ActionSelectedText").GetComponent<TextMeshProUGUI>();
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
            _actionButtonList = new List<Tuple<FightAction, Button>>();
        }

        #endregion

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
            BeginTurn();
        }
    
        void SetupActionButtons()
        {
            Vector2 buttonPos = new Vector2(150, 150);
            foreach (var action in _actionsList)
            {
                action.alreadyUse = false;
                Debug.Log($"FM.SetupActionButtons > {_actionButtonList.ToString()}");
            
                Button button = Instantiate(_buttonPrefab, _uiParent.transform);
                button.GetComponent<RectTransform>().position = buttonPos;
                button.GetComponentInChildren<TextMeshProUGUI>().text = action.ToString();
            
                button.onClick.AddListener(delegate {SelectAction(action, button);});
                //Debug.Log(action.ToString());

                buttonPos.x += button.GetComponent<RectTransform>().sizeDelta.x + 20;
                //buttonsList.Add(button);
            
                if (!action.accesibleByDefault)
                    button.gameObject.SetActive(false);
            
                _actionButtonList.Add(new Tuple<FightAction, Button>(action, button));
            }
        }

        void BeginTurn()
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

            for (int i=0; i< _actionButtonList.Count; i++)
            {
                if (_actionButtonList[i].Item1.cost <= _actionPoints && !(_actionButtonList[i].Item1.usableOnce && _actionButtonList[i].Item1.alreadyUse))
                    _actionButtonList[i].Item2.interactable = true;
                else
                    _actionButtonList[i].Item2.interactable = false;
            }
        
            _playerDataText.text = _actionPoints+"PA\n" + _player._character;
            Debug.Log("Begin");
        }

        public void SelectAction(FightAction action, Button buttonObject)
        {
            buttonObject.interactable = false;
            _actionPoints -= action.cost;
            if (action is TargetableAction)
            {
                _waitingAction = action as TargetableAction;
                MustSelectTarget.Invoke();
            }
            else
            {
                AddActionToSelection(action);
            }
        }

        void AddActionToSelection(FightAction action)
        {
            if (_selectedActions.Count < 3)
            {
                _selectedActions.Add(action);
                _actionSelectedText.text += action.name + "\n";
                Debug.Log("Add " + action.name + " to list actions");
                //buttonObject.gameObject.SetActive(false);
            
                for (int i=0; i< _actionButtonList.Count; i++)
                {
                    if (_actionButtonList[i].Item1.cost > _actionPoints)
                        _actionButtonList[i].Item2.interactable = false;
                    else
                        _actionButtonList[i].Item2.interactable = true;
                }
        
                _playerDataText.text = _actionPoints+"PA\n" + _player._character;
                ValidateTarget.Invoke(action);
            }
            else
            {
                Debug.Log("List full !");
            }
        }


        public void AddTargetableAction(GameObject target)
        {
            PlaySoundSelectCharacter();
            ValidateTarget.Invoke(_waitingAction);
        
            _waitingAction.target = target;
        
            if (_waitingAction != null) AddActionToSelection(_waitingAction);
            _waitingAction = null;

            ValidateAttacks();
        }

        public void UpdateDependences(FightAction action)
        {
            foreach (var tuple in _actionButtonList)
            {
                if (tuple.Item1.dependence == action)
                {
                    Debug.Log($"FC.UpdateDependences(FightAction action) > Dependence found between {action.name} & {tuple.Item1.name}");
                    tuple.Item2.gameObject.SetActive(true);
                }
            }
        }


        private void UpdateUIText()
        {
            _playerDataText.text = _actionPoints+"PA\n" + _player._character;
        }


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

        IEnumerator DoingAction()
        {
            foreach (var action in _selectedActions)
            {
                action.Perform();
            }
        
            yield return new WaitForSeconds(0.1f);
        
            EnemiesTurn();
        }
    
        #region Sound

        private void PlaySoundConfirmAttack()
        {
            _wwiseConfirmAttack.Post(gameObject);
        }

        private void PlaySoundEndTurn()
        {
            _wwiseEndTurn.Post(gameObject);
        }

        private void PlaySoundRemoveAttack()
        {
            _wwiseRemoveAttack.Post(gameObject);
        }

        private void PlaySoundSelectAttack()
        {
            _wwiseSelectAttack.Post(gameObject);
        }

        private void PlaySoundSelectCharacter()
        {
            _wwiseSelectCharacter.Post(gameObject);
        }


        #endregion Sound
    
    }
}
