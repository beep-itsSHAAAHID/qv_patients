import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qv_patient/constants/colors.dart';

const appId = "290a069aad86412da21bc6ab4c889a33";
const token =
    "007eJxTYEh8cahqi9v1pSX/vFdcuclwcf+kusI18QxMh9etv9YosppTgcHI0iDRwMwyMTHFwszE0Cgl0cgwKdksMckk2cLCMtHY+Iv+8rSGQEaGc0sXMjIyQCCIz81QWBZfkFiSmZpXUszAAAAI4iUE";
const channel = "qv_patients";

class VoiceCall extends StatefulWidget {
  const VoiceCall({Key? key}) : super(key: key);

  @override
  State<VoiceCall> createState() => _VoiceCallState();
}

class _VoiceCallState extends State<VoiceCall> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool _muted = false;
  bool _speakerOn = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // Retrieve permissions
    await [Permission.microphone].request();

    // Create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
          _playRingingSound();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
          _stopRingingSound();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _playRingingSound() async {
    await _audioPlayer.setSource(AssetSource('ringing.mp3'));
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.resume();
  }

  Future<void> _stopRingingSound() async {
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
    await _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(
        backgroundColor: TColors.primary,
        title: const Text('Voice Call with Dr. Shahinsh'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVoice(),
          ),
          _toolbar(),
        ],
      ),
    );
  }

  Widget _remoteVoice() {
    if (_remoteUid != null) {
      return const Text(
        'Connected to remote user',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      );
    }
  }

  Widget _toolbar() {
    if (_localUserJoined) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RawMaterialButton(
                onPressed: _onToggleMute,
                shape: const CircleBorder(),
                elevation: 2.0,
                fillColor: _muted ? Colors.blueAccent : Colors.white,
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  _muted ? Icons.mic_off : Icons.mic,
                  color: _muted ? Colors.white : Colors.blueAccent,
                  size: 20.0,
                ),
              ),
              RawMaterialButton(
                onPressed: () => _onCallEnd(context),
                shape: const CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.redAccent,
                padding: const EdgeInsets.all(15.0),
                child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
              RawMaterialButton(
                onPressed: _onToggleSpeaker,
                shape: const CircleBorder(),
                elevation: 2.0,
                fillColor: _speakerOn ? Colors.blueAccent : Colors.white,
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  _speakerOn ? Icons.volume_up : Icons.volume_off,
                  color: _speakerOn ? Colors.white : Colors.blueAccent,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      _muted = !_muted;
    });
    _engine.muteLocalAudioStream(_muted);
  }

  void _onToggleSpeaker() {
    setState(() {
      _speakerOn = !_speakerOn;
    });
    _engine.setEnableSpeakerphone(_speakerOn);
  }
}
