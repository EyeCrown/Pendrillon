using System;
using System.Collections.Generic;
using Ink.Runtime;
using UnityEngine;
using TMPro;
using UnityEngine.InputSystem;
using UnityEngine.SceneManagement;

public enum GameState
{
    ACTING,
    FIGHTING,
    PAUSE,
    
}

public class GameManager : MonoBehaviour
{
    #region Attributes
    public static GameManager Instance { get; private set; }
    public ActingManager   ActingManager   { get; private set; }
    public FightingManager FightingManager { get; private set; }
    
    public GameState State { get; private set; }

    public List<CharacterHandler> characters;

    public GameObject enemyPrefab;
    
    public GroundGrid gridScene;

    
    public TextAsset inkAsset;  
    

    public AK.Wwise.Event _wwiseEvent;
    
    
    
    #endregion
    
    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
            return;
        }

        Instance = this;
        DontDestroyOnLoad(this.gameObject);

        FightingManager = GetComponentInChildren<FightingManager>();
        ActingManager = GetComponentInChildren<ActingManager>();

        ActingManager.endOfActingPhase.AddListener(FromActingPhaseToFightingPhase);
    }

    private void Start()
    {
        foreach (var character in characters)
        {
            CharacterHandler characterHandler = Instantiate(character, transform);
            characterHandler.Dialogue.AddListener(characterHandler.UpdateDialogue);
        }
        
        
        BeginGame();
    }

    public CharacterHandler GetCharacter(string characterName)
    {
        for (int i = 0; i < characters.Count; i++)
        {
            if (characters[i].character.name.ToUpper() == characterName)
                return characters[i];
        }

        return null;
    }


    void BeginGame()
    {
        // Tell to AM to Begin
        ActingManager.Instance.startActingPhase.Invoke();
    }

    void FromActingPhaseToFightingPhase(List<String> enemiesToFight)
    {
        Debug.Log("GM.FromActingPhaseToFightingPhase > Can prepare the fight");
        SceneManager.LoadScene("DemoFightingScene");

        foreach (var enemyName in enemiesToFight)
        {
            Enemy enemy = Instantiate(enemyPrefab, FightingManager.Instance.transform).GetComponent<Enemy>();
            enemy._character = GetCharacter(enemyName).character;
            enemy.damage = 5;
            FightingManager.Instance.enemies.Add(enemy);
            FightingManager.Instance.BeginPlayerTurn.Invoke();
        }
        
        
    }


}
