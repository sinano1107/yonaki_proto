using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

public class GameDirector : MonoBehaviour
{
    GameObject text;
    ARPlaneManager planeManager;

    public void EditText(string newText) {
        this.text.GetComponent<Text>().text = newText;
        
        // Flutterにもメッセージを送信
        UnityMessageManager.Instance.SendMessageToFlutter(newText);
    }

    public void Restart() {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }

    void Start() {
        text = GameObject.Find("Text");
        planeManager = GameObject.Find("AR Session Origin").GetComponent<ARPlaneManager>();
        // 平面検知を開始
        planeManager.detectionMode = PlaneDetectionMode.Horizontal;

        // planeManagerをアクティブ化
        planeManager.SetTrackablesActive(true);

        // 平面のプレハブをアクティブ化
        planeManager.planePrefab.SetActive(true);
    }
}
