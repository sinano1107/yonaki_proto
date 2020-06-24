using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CenterRay : MonoBehaviour
{
    GameDirector director;
    PickUpObject pickUpObject;

    string state = ""; // 情報保存用の変数
    Vector3 center = new Vector3(Screen.width/2, Screen.height/2);
    RaycastHit hit;
    int distance = 3;

    void Start() {
        director = GameObject.Find("GameDirector").GetComponent<GameDirector>();
        pickUpObject = transform.parent.gameObject.GetComponent<PickUpObject>();
    }

    void Update() {
        Ray ray = Camera.main.ScreenPointToRay(center);

        if (Physics.Raycast(ray,out hit,distance)) {
            // オブジェクトと当たった場合
            string tag = hit.collider.tag;

            // 状態が変わった時
            if (state != tag && tag != "Plane") {
                state = tag;
                director.EditText($"{tag}を見つけました");
                pickUpObject.TogglePickUpButton(true);
                pickUpObject.EditPickUpButtonText($"{tag}を拾う");
                pickUpObject.EditTarget(tag);
            }
        } else {
            // オブジェクトと当たらなかった時
            if (state != "") {
                state = "";
                director.EditText("オブジェクトを見失いました");
                pickUpObject.TogglePickUpButton(false);
            }
        }
    }
}
