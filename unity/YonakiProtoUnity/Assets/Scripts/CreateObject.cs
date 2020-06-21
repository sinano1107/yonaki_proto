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
    GameObject panel;

    void DropOtosimono(float y)
    {
        float x = Random.Range(-1.0f, 1.0f);
        float z = Random.Range(-1.0f, 1.0f);

        FadeController fadeController = this.panel.GetComponent<FadeController>();

        // フェードアウト後のアクションを定義
        fadeController.action = () => {
            // 設置する座標をUIに表示
            this.director.GetComponent<GameDirector>().EditText(
                $"{x.ToString("F1")}, {y.ToString("F1")}, {z.ToString("F1")}");
            
            // オトシモノの生成
            Instantiate(objectPrefab, new Vector3(x, y, z), Quaternion.identity);
        };

        // フェードアウト
        fadeController.isFadeOut = true;
    }

    // 初期化
    void Awake()
    {
        raycastManager = GetComponent<ARRaycastManager>();
    }

    void Start()
    {
        this.director = GameObject.Find("GameDirector");
        this.panel = GameObject.Find("Panel");
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
                DropOtosimono(hitResults[0].pose.position.y);
            }
        }
    }
}
