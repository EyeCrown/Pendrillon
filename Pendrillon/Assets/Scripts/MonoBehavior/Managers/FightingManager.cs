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

        public CharacterHandler player;

        public List<Enemy> enemies;
    
        public List<FightAction> actionsList;

        public int actionPoints;

        public List<FightAction> selectedActions;

        
        // Targetable
        private TargetableAction _waitingAction;
    
    
        // UI Debug 
        public GameObject _uiParent;
        public TextMeshProUGUI playerDataText;
        public TextMeshProUGUI actionSelectedText;
        public Button buttonPrefab;
    
    
        public List<Tuple<FightAction, Button>> actionButtonList;
        
        #endregion


        #region Events

        public UnityEvent BeginFight;
        public UnityEvent BeginPlayerTurn;
        public UnityEvent Validate;
        public UnityEvent MustSelectTarget;
        public UnityEvent<FightAction> ValidateTarget;
        //public UnityAction EndFight;

        #endregion
    
    
    
        
    
        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(this);
                return;
            }
            Instance = this;
            //DontDestroyOnLoad(this.gameObject);
        
            BeginPlayerTurn.AddListener(BeginTurn);
            BeginPlayerTurn.AddListener(UpdateUIText);
        
            ValidateTarget.AddListener(UpdateDependences);
        }

        void Start()
        {
            _uiParent.gameObject.SetActive(false);
            //player = GameManager.Instance.GetPlayer();
            //player._character.Initialize();

            foreach (var enemy in enemies)
            {
                enemy.Initialize();
            }
        
            actionSelectedText.text = String.Empty;
            selectedActions.Clear();
        
            //BeginPlayerTurn.Invoke();
            actionButtonList = new List<Tuple<FightAction, Button>>();
        }

        public void OnBeginFight()
        {
            _uiParent.gameObject.SetActive(true);
            
            player = GameManager.Instance.GetPlayer();
            player._character.Initialize();
            //player.transform.position = new Vector3(-4.0f, 0, 2.0f);
        
            float x = 0, z = 0;
            foreach (var enemy in enemies)
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
            foreach (var action in actionsList)
            {
                action.alreadyUse = false;
                Debug.Log($"FM.SetupActionButtons > {actionButtonList.ToString()}");
            
                Button button = Instantiate(buttonPrefab, _uiParent.transform);
                button.GetComponent<RectTransform>().position = buttonPos;
                button.GetComponentInChildren<TextMeshProUGUI>().text = action.ToString();
            
                button.onClick.AddListener(delegate {SelectAction(action, button);});
                //Debug.Log(action.ToString());

                buttonPos.x += button.GetComponent<RectTransform>().sizeDelta.x + 20;
                //buttonsList.Add(button);
            
                if (!action.accesibleByDefault)
                    button.gameObject.SetActive(false);
            
                actionButtonList.Add(new Tuple<FightAction, Button>(action, button));
            }
        }

        void BeginTurn()
        {
            if (player._character.hp <= 0)
            {
                Debug.Log("Player is dead.");
                EndFight(false);
                return;
            }

            if (enemies.Count <= 0)
            {
                Debug.Log("All enemies are dead.");
                EndFight(true);
            }
        
            actionPoints += 3;

            for (int i=0; i< actionButtonList.Count; i++)
            {
                if (actionButtonList[i].Item1.cost <= actionPoints && !(actionButtonList[i].Item1.usableOnce && actionButtonList[i].Item1.alreadyUse))
                    actionButtonList[i].Item2.interactable = true;
                else
                    actionButtonList[i].Item2.interactable = false;
            }
        
            playerDataText.text = actionPoints+"PA\n" + player._character;
            Debug.Log("Begin");
        }

        public void SelectAction(FightAction action, Button buttonObject)
        {
            buttonObject.interactable = false;
            actionPoints -= action.cost;
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
            if (selectedActions.Count < 3)
            {
                selectedActions.Add(action);
                actionSelectedText.text += action.name + "\n";
                Debug.Log("Add " + action.name + " to list actions");
                //buttonObject.gameObject.SetActive(false);
            
                for (int i=0; i< actionButtonList.Count; i++)
                {
                    if (actionButtonList[i].Item1.cost > actionPoints)
                        actionButtonList[i].Item2.interactable = false;
                    else
                        actionButtonList[i].Item2.interactable = true;
                }
        
                playerDataText.text = actionPoints+"PA\n" + player._character;
                ValidateTarget.Invoke(action);
            }
            else
            {
                Debug.Log("List full !");
            }
        }


        public void AddTargetableAction(GameObject target)
        {
            ValidateTarget.Invoke(_waitingAction);
        
            _waitingAction.target = target;
        
            if (_waitingAction != null) AddActionToSelection(_waitingAction);
            _waitingAction = null;
        
            ValidateAttacks();
        }

        public void UpdateDependences(FightAction action)
        {
            foreach (var tuple in actionButtonList)
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
            playerDataText.text = actionPoints+"PA\n" + player._character;
        }


        public void ValidateAttacks()
        {
            Debug.Log("Launch all attacks: \n" + actionSelectedText.text);
        
            StartCoroutine(DoingAction());
        
            actionSelectedText.text = String.Empty;
            selectedActions.Clear();

        }

        void EnemiesTurn()
        {
            Debug.Log("Enemy turn");

            foreach (var enemy in enemies)
            {
                int hits = enemy.GetDamage();
                player._character.hp -= hits;
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
            enemies.Remove(enemy);
        }

        IEnumerator DoingAction()
        {
            foreach (var action in selectedActions)
            {
            
                action.Perform();
            }
        
            yield return new WaitForSeconds(0.1f);
        
            EnemiesTurn();
        }
    
    
    }
}
