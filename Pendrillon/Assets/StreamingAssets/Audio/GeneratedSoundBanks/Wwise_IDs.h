/////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Audiokinetic Wwise generated include file. Do not edit.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __WWISE_IDS_H__
#define __WWISE_IDS_H__

#include <AK/SoundEngine/Common/AkTypes.h>

namespace AK
{
    namespace EVENTS
    {
        static const AkUniqueID GAMESTART = 4058101365U;
        static const AkUniqueID PLAY_AMB_SC_PONT = 4193452235U;
        static const AkUniqueID PLAY_CROWDHYPE = 3360090021U;
        static const AkUniqueID PLAY_FOL_HUMANOID_HURT = 786277887U;
        static const AkUniqueID PLAY_SFX_COMBAT_NPC_BOUFFON_ATTACK1 = 3286192894U;
        static const AkUniqueID PLAY_SFX_COMBAT_NPC_BOUFFON_HURT = 1514626058U;
        static const AkUniqueID PLAY_SFX_COMBAT_NPC_ROYALGUARD_ATTACK1 = 37105197U;
        static const AkUniqueID PLAY_SFX_COMBAT_NPC_ROYALGUARD_HURT = 1900933419U;
        static const AkUniqueID PLAY_SFX_COMBAT_PLAYER_BASICATTACK1 = 3845829926U;
        static const AkUniqueID PLAY_SFX_COMBAT_PLAYER_BASICATTACK1_HURT = 1280387290U;
        static const AkUniqueID PLAY_SFX_SC_CALE_AMBIANCE = 1004562353U;
        static const AkUniqueID PLAY_SFX_SC_THEATER_CROWDCHATTER = 2433984191U;
        static const AkUniqueID PLAY_SINE1KHZ = 3733116919U;
        static const AkUniqueID PLAY_UI_COMBAT_BUFF = 3928347901U;
        static const AkUniqueID PLAY_UI_COMBAT_CONFIRMATTACKS = 3834997573U;
        static const AkUniqueID PLAY_UI_COMBAT_DEBUFF = 3013650276U;
        static const AkUniqueID PLAY_UI_COMBAT_ENDTURN = 3127083572U;
        static const AkUniqueID PLAY_UI_COMBAT_HOVER = 1992368636U;
        static const AkUniqueID PLAY_UI_COMBAT_REMOVEATTACK = 1534142422U;
        static const AkUniqueID PLAY_UI_COMBAT_SELECT_ATTACK = 3468982525U;
        static const AkUniqueID PLAY_UI_COMBAT_SELECTCHARACTER = 3474027887U;
        static const AkUniqueID PLAY_UI_HUD_CHOICEBUBBLE_APPEARS = 3153536941U;
        static const AkUniqueID PLAY_UI_HUD_CHOICEBUBBLE_BURST3APPEARS = 785419406U;
        static const AkUniqueID PLAY_UI_HUD_SPEECHBUBBLE_APPEARS = 3687899778U;
        static const AkUniqueID PLAY_UI_HUD_SPEECHBUBBLESKIP = 2637491412U;
        static const AkUniqueID SETALLVOLUMESTO75 = 902787362U;
        static const AkUniqueID SETHYPERACUSISOFF = 3797495750U;
        static const AkUniqueID SETHYPERACUSISON = 3794163176U;
        static const AkUniqueID STOP_AMB_SC_PONT = 32026905U;
        static const AkUniqueID STOP_SFX_SC_CALE_AMBIANCE = 3189791475U;
        static const AkUniqueID STOP_SFX_SC_THEATER_CROWDCHATTER = 1577954137U;
    } // namespace EVENTS

    namespace STATES
    {
        namespace HYPERACUSISMODE
        {
            static const AkUniqueID GROUP = 1672502660U;

            namespace STATE
            {
                static const AkUniqueID HYPERACUSISMODEOFF = 3527522059U;
                static const AkUniqueID HYPERACUSISMODEON = 435094263U;
                static const AkUniqueID NONE = 748895195U;
            } // namespace STATE
        } // namespace HYPERACUSISMODE

    } // namespace STATES

    namespace SWITCHES
    {
        namespace CROWDREACTION
        {
            static const AkUniqueID GROUP = 2134499837U;

            namespace SWITCH
            {
                static const AkUniqueID HYPE_01 = 486820069U;
                static const AkUniqueID HYPE_02 = 486820070U;
                static const AkUniqueID HYPE_03 = 486820071U;
                static const AkUniqueID HYPE_04 = 486820064U;
                static const AkUniqueID HYPE_05 = 486820065U;
                static const AkUniqueID HYPE_06 = 486820066U;
                static const AkUniqueID HYPE_07 = 486820067U;
                static const AkUniqueID HYPE_08 = 486820076U;
                static const AkUniqueID HYPE_09 = 486820077U;
            } // namespace SWITCH
        } // namespace CROWDREACTION

    } // namespace SWITCHES

    namespace GAME_PARAMETERS
    {
        static const AkUniqueID CROWDBOREDOM = 2888587878U;
        static const AkUniqueID CROWDREACTION = 2134499837U;
        static const AkUniqueID ENVIRONMENT_VOLUME = 2054307141U;
        static const AkUniqueID MAIN_VOLUME = 2312172015U;
        static const AkUniqueID MUSIC_VOLUME = 1006694123U;
        static const AkUniqueID SFX_VOLUME = 1564184899U;
        static const AkUniqueID UI_VOLUME = 1719345792U;
        static const AkUniqueID VOICES_VOLUME = 3440409837U;
    } // namespace GAME_PARAMETERS

    namespace BANKS
    {
        static const AkUniqueID INIT = 1355168291U;
        static const AkUniqueID MAIN_SOUNDBANK = 2228651116U;
    } // namespace BANKS

    namespace BUSSES
    {
        static const AkUniqueID DRY_ENVIRONMENT = 3848410326U;
        static const AkUniqueID DRY_MUSIC = 4010064756U;
        static const AkUniqueID DRY_SFX = 3872602748U;
        static const AkUniqueID DRY_UI = 96282353U;
        static const AkUniqueID DRY_VOICES = 318808210U;
        static const AkUniqueID MAINDRY = 2800544509U;
        static const AkUniqueID MAINHYPERACUSIS = 3852188084U;
        static const AkUniqueID MAINREVERB = 1636724294U;
        static const AkUniqueID MASTER_AUDIO_BUS = 3803692087U;
        static const AkUniqueID REVERB_ENVIRONMENT_01 = 603598863U;
        static const AkUniqueID REVERB_MUSIC_01 = 4073358989U;
        static const AkUniqueID REVERB_SFX_01 = 744331921U;
        static const AkUniqueID REVERB_UI_01 = 189108676U;
        static const AkUniqueID REVERB_VOICES_01 = 3299242565U;
    } // namespace BUSSES

    namespace AUDIO_DEVICES
    {
        static const AkUniqueID NO_OUTPUT = 2317455096U;
        static const AkUniqueID SYSTEM = 3859886410U;
    } // namespace AUDIO_DEVICES

}// namespace AK

#endif // __WWISE_IDS_H__
