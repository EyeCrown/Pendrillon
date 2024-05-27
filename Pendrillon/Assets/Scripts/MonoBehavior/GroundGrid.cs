using System.Collections;
using System.Collections.Generic;
using Ink.Parsed;
using UnityEngine;

public class GroundGrid : MonoBehaviour
{
    [SerializeField] public Grid _grid;
    
    [Header("=== Visualizer ===")]
    [Range(1, 100)] public int width = 1;
    //[Range(1, 5)] public int height = 1;
    [Range(1, 100)] public int depth = 1;

    [Header("=== Colors ===")] 
    [SerializeField] Color _playerColor;
    [SerializeField] Color _agatheColor;
    [SerializeField] Color _arleColor;
    [SerializeField] Color _capucineColor;
    [SerializeField] Color _judgeColor;
    [SerializeField] Color _marcelloColor;
    [SerializeField] Color _naidaColor;
    [SerializeField] Color _passeurColor;
    [SerializeField] Color _prompterColor;

    [Header("=== Barge scene 1 ===")] 
    [SerializeField] private bool _visualizerBargeScene1;

    [SerializeField] private Positions _scenePos;
    
    
    public Vector2Int _playerPosition;
    public Vector2Int _enemyPosition;


    #region UnityAPI

    void Awake()
    {
        _grid = GetComponent<Grid>();
    }
    

    #endregion

    #region Methods

    public Vector3 GetWorldPositon(Vector2Int coords)
    {
        Vector3 worldPos = _grid.GetCellCenterWorld(new Vector3Int(coords.x, 0, coords.y));
        worldPos.y = transform.position.y;
        
        //Debug.Log($"WorldPos : {worldPos}");
        return worldPos;
    }

    Color GetColor(string name)
    {
        var color = Color.white;

        switch (name.ToLower())
        {
            case "player":
                color = _playerColor;
                break;
            case "agathe":
                color = _agatheColor;
                break;
            case "arle":
                color = _arleColor;
                break;
            case "capucine":
                color = _capucineColor;
                break;
            case "judge":
                color = _judgeColor;
                break;
            case "marcello":
                color = _marcelloColor;
                break;
            case "naïda":
                color = _naidaColor;
                break;
            case "passeur":
                color = _passeurColor;
                break;
            case "prompter":
                color = _prompterColor;
                break;
        }

        return color;
    }
    

    #endregion
    
    #region Gizmos
    /*void OnDrawGizmosSelected()
    {
        Vector3 botLeft = transform.position, topRight = transform.position ;
        topRight.x += _grid.cellSize.x * width + _grid.cellGap.x * width;
        //topRight.y += _grid.cellSize.y * height + _grid.cellGap.y * height;
        topRight.z += _grid.cellSize.z * depth + _grid.cellGap.z * depth;
        
        Gizmos.color = Color.green;
        Gizmos.DrawLine(botLeft, new Vector3(botLeft.x, transform.position.y, topRight.z));
        Gizmos.DrawLine(botLeft, new Vector3(topRight.x, transform.position.y, botLeft.z));
        Gizmos.DrawLine(topRight, new Vector3(botLeft.x, transform.position.y, topRight.z));
        Gizmos.DrawLine(topRight, new Vector3(topRight.x, transform.position.y, botLeft.z));
        
        Gizmos.color = Color.blue;
        for (int x = 0; x < width; x++)
        {
            for (int z = 0; z < depth; z++)
            {
                var worldPos = _grid.GetCellCenterWorld(new Vector3Int(x, 0, z));
                worldPos.y = transform.position.y;
                Gizmos.DrawLine(new Vector3(worldPos.x - 0.3f, worldPos.y, worldPos.z),
                                new Vector3(worldPos.x + 0.3f, worldPos.y, worldPos.z));
                Gizmos.DrawLine(new Vector3(worldPos.x, worldPos.y, worldPos.z - 0.3f),
                                new Vector3(worldPos.x, worldPos.y, worldPos.z + 0.3f));
            }
        }
    }*/

    void DrawCharacterPosition(Vector2Int coords, Color color)
    {
        Gizmos.color = color;
        Vector3 position = _grid.GetCellCenterWorld(new Vector3Int(coords.x, 0, coords.y));
        position.y = transform.position.y;
        Gizmos.DrawLine(position, position + new Vector3(0.0f, 2.0f, 0.0f));
    }
    
    void OnDrawGizmosSelected()
    {
        /*Vector3 botLeft = transform.position, topRight = transform.position ;
        topRight.x += _grid.cellSize.x * width + _grid.cellGap.x * width;
        //topRight.y += _grid.cellSize.y * height + _grid.cellGap.y * height;
        topRight.z += _grid.cellSize.z * depth + _grid.cellGap.z * depth;*/
        
        // Gizmos.color = Color.green;
        // Gizmos.DrawLine(botLeft, new Vector3(botLeft.x, transform.position.y, topRight.z));
        // Gizmos.DrawLine(botLeft, new Vector3(topRight.x, transform.position.y, botLeft.z));
        // Gizmos.DrawLine(topRight, new Vector3(botLeft.x, transform.position.y, topRight.z));
        // Gizmos.DrawLine(topRight, new Vector3(topRight.x, transform.position.y, botLeft.z));
        
        Gizmos.color = Color.blue;
        for (int x = 0; x < width; x++)
        {
            for (int z = 0; z < depth; z++)
            {
                var worldPos = _grid.GetCellCenterWorld(new Vector3Int(x, 0, z));
                worldPos.y = transform.position.y;
                Gizmos.DrawLine(new Vector3(worldPos.x - 0.3f, worldPos.y, worldPos.z),
                    new Vector3(worldPos.x + 0.3f, worldPos.y, worldPos.z));
                Gizmos.DrawLine(new Vector3(worldPos.x, worldPos.y, worldPos.z - 0.3f),
                    new Vector3(worldPos.x, worldPos.y, worldPos.z + 0.3f));
            }
        }

        var playerColor = Color.red;
        DrawCharacterPosition(_playerPosition, playerColor);
        
        var enemyColor = Color.yellow;
        DrawCharacterPosition(_enemyPosition, enemyColor);

        if (_visualizerBargeScene1 && _scenePos._characters.Count == _scenePos._positions.Count)
        {
            for (int i = 0; i < _scenePos._characters.Count; i++)
            {
                var color = GetColor(_scenePos._characters[i]);
                DrawCharacterPosition(_scenePos._positions[i], color);
            }
        }

    }
    

    #endregion
    
}