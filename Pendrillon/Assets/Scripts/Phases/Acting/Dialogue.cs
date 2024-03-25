using System;

public class Dialogue
{
    public String _dialogue { get; }
    public String _character { get; }
    public String _tone { get; }

    //TODO: Make constructor that take JSON file
    public Dialogue(String text, String autor, String tone)
    {
        _dialogue = text;
        _character = autor;
        _tone = tone;
    }

    public String To_String()
    {
        String to_string = "[" + _character + "] //" + _tone + "\n";
        to_string += ">" + _dialogue;

        return to_string;
    }
}
