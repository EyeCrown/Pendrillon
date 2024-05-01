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

    public Transform playerPos;
    public Transform enemyPos;
    
    
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
        // foreach (var character in characters)
        // {
        //     CharacterHandler characterHandler = Instantiate(character, transform);
        //     characterHandler.Dialogue.AddListener(characterHandler.UpdateDialogue);
        //     character = characterHandler;
        // }

        for (int i = 0; i < characters.Count; i++)
        {
            CharacterHandler characterHandler = Instantiate(characters[i]);
            characterHandler.transform.position = new Vector3(-5 + i * 1.5f, 0, 5);
            characterHandler.Dialogue.AddListener(characterHandler.UpdateDialogue);
            characters[i] = characterHandler;
        }
        
        FightingManager.Instance.player = GetCharacter("PLAYER");
        FightingManager.Instance.player.transform.position = playerPos.position;
        FightingManager.Instance.player.transform.LookAt(Camera.main.transform);
        
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
        /*String marcello = "MARCELLO";
        String rudolf = "RUDOLF";
        List<String> enemies = new List<string>();
        enemies.Add(marcello);
        enemies.Add(rudolf);
        FromActingPhaseToFightingPhase(enemies);*/
    }

    void FromActingPhaseToFightingPhase(List<String> enemiesToFight)
    {
        Debug.Log("GM.FromActingPhaseToFightingPhase > Can prepare the fight");
        //SceneManager.LoadScene("DemoFightingScene");

        float x = 0, z = 0;
        foreach (var enemyName in enemiesToFight)
        {
            Enemy enemy = Instantiate(enemyPrefab).GetComponent<Enemy>();
            enemy.transform.position = enemyPos.position;
            enemy._character = GetCharacter(enemyName).character;
            //enemy.damage = 5;
            FightingManager.Instance.enemies.Add(enemy);
            
            x += 1.5f;
            z -= 1.5f;
        }
        
        FightingManager.Instance.BeginFight();
    }


}
