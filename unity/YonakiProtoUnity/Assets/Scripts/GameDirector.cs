using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class GameDirector : MonoBehaviour
{
    GameObject text;

    public void EditText(string newText)
    {
        this.text.GetComponent<Text>().text = newText;
        
        // Flutterにも座標を送信
        UnityMessageManager.Instance.SendMessageToFlutter(newText);
    }

    public void Restart()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }

    void Start()
    {
        this.text = GameObject.Find("Text");
    }
}
