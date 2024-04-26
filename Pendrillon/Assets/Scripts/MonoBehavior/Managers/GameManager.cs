using System;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.InputSystem;

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

    public GroundGrid gridScene;

    #endregion
    
    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
            return;
        }

        Instance = this;

        FightingManager = GetComponentInChildren<FightingManager>();
        ActingManager = GetComponentInChildren<ActingManager>();
    }

    private void Start()
    {
        /*foreach (var character in characters)
        {
            GroundCell cell = gridScene.GetCell(character.coordsOnStatge);
            Vector3 charPos = cell.position;
            charPos.y = character.transform.position.y;
            
            character.transform.position = charPos;
        }
        */
        
        // BeginGame()
        
        
    }

    public CharacterHandler GetCharacter(string characterName)
    {
        for (int i = 0; i < characters.Count; i++)
        {
            if (characters[i].character.name == characterName)
                return characters[i];
        }

        return null;
    }


    void BeginGame()
    {
        // Tell to AM to Begin
        //BetterActingManager.Instance.Begin.Invoke();
    }

    void FromActingPhaseToFightingPhase()
    {
        
    }


}
