using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundGrid : MonoBehaviour
{
    [SerializeField] public Grid _grid;
    
    [Range(1, 20)] public int width = 1;
    //[Range(1, 5)] public int height = 1;
    [Range(1, 50)] public int depth = 1;

    private GroundCell[] cells;
    
    void Awake()
    {
        _grid = GetComponent<Grid>();
    }
    
    void Start()
    {
        cells = new GroundCell[width * depth];

        for (int x = 0; x < width; x++)
        {
            for (int z = 0; z < depth; z++)
            {
                cells[width * x + z] = new GroundCell(_grid.GetCellCenterWorld(new Vector3Int(x, 0, z)));
            }
        }
    }

    public GroundCell GetCell(Vector2Int coords) => cells[width * coords.x + coords.y];
    
    
    #region Gizmos
    void OnDrawGizmosSelected()
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