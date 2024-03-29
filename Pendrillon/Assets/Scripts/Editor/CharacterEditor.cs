using UnityEditor;

[CustomEditor(typeof(Character))]
public class CharacterEditor : Editor
{
    public override void OnInspectorGUI()
    {
        Character character = target as Character;
        
        base.OnInspectorGUI();



    }
    
    
    
}
