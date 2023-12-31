import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';
import 'package:video_calling_app/widget/remote_connection.dart';


import '../models/meeting_details.dart';
import '../utils/user.utils.dart';
import '../widget/control_panel.dart';
import 'home_screen.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key,this.meetingId,this.name, required this.meetingDetail});
  final String? meetingId;
  final String? name;
  final MeetingDetail meetingDetail;

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  final localRender = RTCVideoRenderer();
  final Map<String, dynamic> mediaConstraints = {
    'audio': true,
    'video':true
  };
  bool isConnectionFailed = false;
  WebRTCMeetingHelper? meetingHelper;

  @override
  void initState() {
    super.initState();
    initRenderers();
    startMeeting();
  }

  @override
  void deactivate() {
    super.deactivate();
    localRender.dispose();
    if(meetingHelper != null){
      meetingHelper!.destroy();
      meetingHelper = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: buildMeetingRoom(),
      bottomNavigationBar: ControlPanel(
        onAudioToggle: onAudioToggle,
        onVideoToggle: onVideoToggle,
        videoEnabled: isVideoEnable(),
        audioEnabled: isAudioEnable(),
        isConnectionFailed: isConnectionFailed,
        onReconnect: handleReconnect,
        onMeetingEnd: onMeetingEnd,
      ),
    );
  }

  void startMeeting() async{
    final String userId = await loadUserId();
    meetingHelper = WebRTCMeetingHelper(
      url: 'https://e51f-49-156-94-68.ngrok-free.app',
      meetingId: widget.meetingDetail.id,
      userId: userId,
      name:widget.name
    );

    MediaStream localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    localRender.srcObject = localStream;
    meetingHelper!.stream = localStream;
    if (context.mounted){
      meetingHelper!.on(
        'open', 
        context, 
        (ev, context) { 
          setState(() {
            isConnectionFailed = false;
          });
        }
      );
      meetingHelper!.on(
        'connection', 
        context, 
        (ev, context) { 
          setState(() {
            isConnectionFailed = false;
          });
        }
      );
      meetingHelper!.on(
        'user-left', 
        context, 
        (ev, context) { 
          setState(() {
            isConnectionFailed = false;
          });
        }
      );
      meetingHelper!.on(
        'video-toggle', 
        context, 
        (ev, context) { 
          setState(() { });
        }
      );
      meetingHelper!.on(
        'audio-toggle', 
        context, 
        (ev, context) { 
          setState(() { });
        }
      );
      meetingHelper!.on(
        'meeting-ended', 
        context, 
        (ev, context) { 
          onMeetingEnd();
        }
      );
      meetingHelper!.on(
        'connection-setting-changed', 
        context, 
        (ev, context) { 
          isConnectionFailed = false; 
        }
      );
      meetingHelper!.on(
        'stream-change', 
        context, 
        (ev, context) { 
          isConnectionFailed = false; 
        }
      );
      setState(() {
        
      });
    }
  }
  void initRenderers()async {
    await localRender.initialize();
  }
  void onMeetingEnd()async {
    if(meetingHelper != null){
      meetingHelper!.endMeeting();
      goToHomePage();
    }
  }
  buildMeetingRoom(){
    return Stack(
      children: [
        meetingHelper != null && meetingHelper!.connections.isNotEmpty ? GridView.count(
          crossAxisCount: meetingHelper!.connections.length < 3 ? 1 : 2,
          children: List.generate(
            meetingHelper!.connections.length, 
            (index) {
              return Padding(
                padding: const EdgeInsets.all(1),
                child: RemoteConnection(
                  renderer: meetingHelper!.connections[index].renderer, 
                  connection: meetingHelper!.connections[index]
                ),
              );
            }
          )
        ) : Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'waiting for participates to join the meeting ${meetingHelper != null ? meetingHelper!.connections.length : 'null'}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 25
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 0,
          child: SizedBox(
            width: 150,
            height: 200,
            child: RTCVideoView(localRender),
          )
        )
      ],
    );
  }

  void onAudioToggle() {
    if(meetingHelper != null){
      setState(() {
        meetingHelper!.toggleAudio();
      });
    }
  }

  void onVideoToggle() {
    if(meetingHelper != null){
      setState(() {
        meetingHelper!.toggleVideo();
      });
    }
  }
  bool isVideoEnable() {
    return meetingHelper != null ? meetingHelper!.videoEnabled! : false;
  }
  bool isAudioEnable() {
    return meetingHelper != null ? meetingHelper!.audioEnabled! : false;
  }
  void handleReconnect() {
    if(meetingHelper != null){
      meetingHelper!.reconnect();
    }
  }
  
  void goToHomePage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
  }
}



