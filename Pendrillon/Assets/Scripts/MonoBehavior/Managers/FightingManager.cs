using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;
using Random = UnityEngine.Random;

public class FightingManager : MonoBehaviour
{
    public static FightingManager Instance { get; private set; }

    public enum Turn
    {
        Player,
        Enemy,
    } 
    
    private Turn turn;

    public CharacterHandler player;

    public List<Enemy> enemies;
    
    public List<FightAction> actionsList;

    public int actionPoints;

    public List<FightAction> selectedActions;


    public UnityEvent BeginPlayerTurn;
    public UnityEvent Validate;
    public UnityEvent MustSelectTarget;
    //public UnityAction EndFight;
    
    
    
    // Targetable
    private TargetableAction waitingAction;
    
    
    // UI Debug 
    public Canvas canvas;
    public GameObject uiParent;
    public TextMeshProUGUI playerDataText;
    public TextMeshProUGUI actionSelectedText;
    public Button buttonPrefab;
    private List<Button> buttonsList;
    
    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
            return;
        }
        Instance = this;
        DontDestroyOnLoad(this.gameObject);
        
        BeginPlayerTurn.AddListener(BeginFight);
        BeginPlayerTurn.AddListener(UpdateUIText);
    }

    void Start()
    {
        uiParent.gameObject.SetActive(false);
        player = GameManager.Instance.GetCharacter("PLAYER");
        player.character.Initialize();

        foreach (var enemy in enemies)
        {
            enemy.Initialize();
        }
        
        actionSelectedText.text = String.Empty;
        selectedActions.Clear();
        
        //BeginPlayerTurn.Invoke();

    }

    void BeginFight()
    {
        uiParent.gameObject.SetActive(true);
        player.character.Initialize();
        player.transform.position = new Vector3(-4.0f, 0, 2.0f);
        
        float x = 0, z = 0;
        foreach (var enemy in enemies)
        {
            enemy.transform.position = new Vector3(1.5f + x, 0, 3.0f + z);
            enemy.Initialize();
            
            x += 1.5f;
            z -= 1.5f;
        }
        SetupActionButtons();
        BeginTurn();
    }
    
    void SetupActionButtons()
    {
        Vector2 buttonPos = new Vector2(115, 100);
        foreach (var action in actionsList)
        {
            Debug.Log(action.GetType());
            
            Button button = Instantiate(buttonPrefab, uiParent.transform);
            button.GetComponent<RectTransform>().position = buttonPos;
            button.GetComponentInChildren<TextMeshProUGUI>().text = action.ToString();
            
            button.onClick.AddListener(delegate {SelectAction(action, button);});
            Debug.Log(action.ToString());

            buttonPos.x += button.GetComponent<RectTransform>().sizeDelta.x + 10;
            buttonsList.Add(button);
        }
    }

    void BeginTurn()
    {
        if (player.character.hp <= 0)
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

        for (int i=0; i< actionsList.Count; i++)
        {
            if (actionsList[i].cost > actionPoints)
                buttonsList[i].interactable = false;
            else
                buttonsList[i].interactable = true;
        }
        
        playerDataText.text = actionPoints+"PA\n" + player.character;
        Debug.Log("Begin");
    }

    public void SelectAction(FightAction action, Button buttonObject)
    {
        buttonObject.interactable = false;
        actionPoints -= action.cost;
        if (action is TargetableAction)
        {
            waitingAction = action as TargetableAction;
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
            
            for (int i=0; i< actionsList.Count; i++)
            {
                if (actionsList[i].cost > actionPoints)
                    buttonsList[i].interactable = false;
                else
                    buttonsList[i].interactable = true;
            }
        
            playerDataText.text = actionPoints+"PA\n" + player.character;
        }
        else
        {
            Debug.Log("List full !");
        }
    }


    public void AddTargetableAction(GameObject target)
    {
        waitingAction.target = target;
        if (waitingAction != null) AddActionToSelection(waitingAction);
        waitingAction = null;
        
        ValidateAttacks();
    }


    private void UpdateUIText()
    {
        playerDataText.text = actionPoints+"PA\n" + player.character;
    }


    public void ValidateAttacks()
    {
        Debug.Log("Launch all attacks: \n" + actionSelectedText.text);

        StartCoroutine(DoingAction());
        
        //playerDataText.text = actionPoints+"PA\n" + player.character.ToString();

        /*foreach (var button in buttonsList)
        {
            button.gameObject.SetActive(true);
        }*/
        
        actionSelectedText.text = String.Empty;
        selectedActions.Clear();

    }

    void EnemiesTurn()
    {
        Debug.Log("Enemy turn");

        foreach (var enemy in enemies)
        {
            
            player.character.hp -= enemy.damage;
            Debug.Log($"Player has lost {enemy.damage} hp.");
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
            int success = Random.Range(0, 101);

            if (success <= action.successRate)
            {
                Debug.Log(success + "/"+action.successRate+" > Action succeded");
                action.Perform();
            }
            else
            {
                Debug.Log(success + "/"+action.successRate+" > Action failed");
            }
        }
        
        yield return new WaitForSeconds(0.1f);
        
        EnemiesTurn();
    }
    
    
}
