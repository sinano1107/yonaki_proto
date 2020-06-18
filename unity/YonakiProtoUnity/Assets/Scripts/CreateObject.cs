using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

[RequireComponent(typeof(ARRaycastManager))]
public class CreateObject : MonoBehaviour
{
    [SerializeField]
    GameObject objectPrefab;

    ARRaycastManager raycastManager;
    List<ARRaycastHit> hitResults = new List<ARRaycastHit>();

    GameObject director;

    // 初期化
    void Awake()
    {
        raycastManager = GetComponent<ARRaycastManager>();
    }

    void Start()
    {
        this.director = GameObject.Find("GameDirector");
    }

    // 更新毎に呼ばれる
    void Update()
    {
        // タッチ時
        if (Input.GetMouseButtonDown(0))
        {
            // 衝突時
            if (raycastManager.Raycast(Input.GetTouch(0).position, hitResults, TrackableType.PlaneWithinPolygon))
            {
                // 座標をUIに表示
                this.director.GetComponent<GameDirector>().EditText(hitResults[0].pose.position.ToString());

                // 3Dオブジェクトの生成
                Instantiate(objectPrefab, hitResults[0].pose.position, Quaternion.identity);
            }
        }
    }
}
