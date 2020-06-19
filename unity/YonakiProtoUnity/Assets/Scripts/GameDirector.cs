using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameDirector : MonoBehaviour
{
    GameObject text;

    public void EditText(string newText)
    {
        this.text.GetComponent<Text>().text = newText;
        
        // Flutterにも座標を送信
        UnityMessageManager.Instance.SendMessageToFlutter(newText);
    }

    void Start()
    {
        this.text = GameObject.Find("Text");
    }
}
