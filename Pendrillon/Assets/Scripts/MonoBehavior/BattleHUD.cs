using System.Collections;
using MonoBehavior.Managers;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class BattleHUD : MonoBehaviour
{
    #region Attributes

    private Animator _anim; 
    
    private GameObject _actionPointsPanel;
    private TextMeshProUGUI _actionPointsText;
    
    private Slider _hpPlayer;
    private Slider _hpBoss;

    private const int _maxHpPlayer = 20;
    private const int _maxHpBoss = 120;

    #endregion

    #region Events

    public UnityEvent BattleBegin;
    public UnityEvent BattleEnded;

    #endregion

    #region Unity API

    void Awake()
    {
        ConnectAttributes();
        SetupAttributes();
    }

    void Start()
    {
        MakeObservables();
        InitializeValues();
    }

    #endregion


    #region Methods

    #region Setup

    void ConnectAttributes()
    {
        // Events
        BattleBegin.AddListener(OnBattleBegin);
        BattleEnded.AddListener(OnBattleEnded);
        
        _anim = GetComponent<Animator>();

        _actionPointsPanel = transform.Find("ActionPointsPanel").gameObject;
        _actionPointsText = _actionPointsPanel.transform.Find("Text").GetComponent<TextMeshProUGUI>();
        
        _hpPlayer = transform.Find("PlayerHP/Bar").GetComponent<Slider>();
        _hpBoss   = transform.Find("BossHP/Bar").GetComponent<Slider>();
    }

    void SetupAttributes()
    {
        _hpPlayer.minValue = _hpBoss.minValue = 0.0f;
        _hpPlayer.maxValue = _hpBoss.maxValue = 1.0f;
        _hpPlayer.wholeNumbers = _hpBoss.wholeNumbers = false;
    }

    void MakeObservables()
    {
        GameManager.Instance._story.ObserveVariable ("b_player_AP", (string varName, object newValue) => {
            UpdateActionPoints((int)newValue); });
        
        GameManager.Instance._story.ObserveVariable ("b_player_hp", (string varName, object newValue) => {
            UpdateHpPlayer((int) newValue); });

        GameManager.Instance._story.ObserveVariable ("b_boss_hp", (string varName, object newValue) => {
            UpdateHpBoss((int) newValue); });
    }

    void InitializeValues()
    {
        _actionPointsText.text = ((int)GameManager.Instance._story.variablesState["b_player_AP"]).ToString();
        
        _hpPlayer.value = _maxHpPlayer;
        _hpBoss.value = _maxHpBoss;
    }
    
    #endregion

    void UpdateActionPoints(int newValue)
    {
        _actionPointsText.text = newValue.ToString();
    }

    void UpdateHpPlayer(int newValue)
    {
        StartCoroutine(SliderTakeDamage(_hpPlayer, _maxHpPlayer, newValue));
    }
    
    void UpdateHpBoss(int newValue)
    {
        StartCoroutine(SliderTakeDamage(_hpBoss, _maxHpBoss, newValue));
    }
    
    #endregion

    #region Event Handlers

    void OnBattleBegin()
    {
        _anim.SetBool("InOut", true);
    }

    void OnBattleEnded()
    {
        _anim.SetBool("InOut", false);
    }

    #endregion

    #region Coroutines

    IEnumerator SliderTakeDamage(Slider slider, int max, int newValue)
    {
        float time = 0.0f, duration = 0.2f;

        float startValue = slider.value;
        float endValue = (float)newValue / (float)max;

        while (time < duration)
        {
            slider.value = Mathf.Lerp(startValue, endValue, time / duration);
            time += Time.deltaTime;
            yield return null;
        }
    }


    #endregion
    
}
