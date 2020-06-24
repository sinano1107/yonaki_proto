using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PickUpObject : MonoBehaviour
{
    GameObject pickUpButton;
    GameObject pickUpButtonText;

    string targetTag; // 拾う対象のオブジェクトのタグ

    void Start() {
        pickUpButton = GameObject.Find("PickUpButton");
        pickUpButton.SetActive(false);
        pickUpButtonText = pickUpButton.transform.Find("PickUpButtonText").gameObject;
    }

    public void TogglePickUpButton(bool active) {
        pickUpButton.SetActive(active);
    }

    public void EditPickUpButtonText(string newText) {
        pickUpButtonText.GetComponent<Text>().text = newText;
    }

    public void EditTarget(string newTargetTag) {
        targetTag = newTargetTag;
    }

    public void PickUp() {
        Destroy(GameObject.FindGameObjectWithTag(targetTag));
    }
}
