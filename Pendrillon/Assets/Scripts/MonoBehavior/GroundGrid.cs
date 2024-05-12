using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundGrid : MonoBehaviour
{
    [SerializeField] public Grid _grid;
    
    [Range(1, 100)] public int width = 1;
    //[Range(1, 5)] public int height = 1;
    [Range(1, 100)] public int depth = 1;

    public Vector2Int _playerPosition;
    public Vector2Int _enemyPosition;


    #region UnityAPI

    void Awake()
    {
        _grid = GetComponent<Grid>();
    }
    

    #endregion

    public Vector3 GetWorldPositon(Vector2Int coords)
    {
        Vector3 worldPos = _grid.GetCellCenterWorld(new Vector3Int(coords.x, 0, coords.y));
        worldPos.y = transform.position.y;
        return worldPos;
    }
    
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
        
        Gizmos.color = Color.red;
        Vector3 playerOrigin = _grid.GetCellCenterWorld(new Vector3Int(_playerPosition.x, 0, _playerPosition.y));
        playerOrigin.y = transform.position.y;
        Gizmos.DrawLine(playerOrigin, playerOrigin + new Vector3(0.0f, 2.0f, 0.0f));
        
        Gizmos.color = Color.yellow;
        Vector3 enemyOrigin = _grid.GetCellCenterWorld(new Vector3Int(_enemyPosition.x, 0, _enemyPosition.y));
        enemyOrigin.y = transform.position.y;
        Gizmos.DrawLine(enemyOrigin, enemyOrigin + new Vector3(0.0f, 2.0f, 0.0f));
    }
    

    #endregion
    
}

public class GroundCell
{
    public bool isOccupied;
    public Vector3 position { get; private set; }

    public GroundCell(Vector3 position)
    {
        isOccupied = false;
        this.position = position;
    }
}