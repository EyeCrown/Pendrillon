using System.Collections;
using System.Collections.Generic;
using Ink.Parsed;
using UnityEngine;

[CreateAssetMenu(fileName = "Positions", menuName = "Pendrillon/Positions")]
public class Positions : ScriptableObject
{
    public List<string> _characters;
    public List<Vector2Int> _positions;

}
