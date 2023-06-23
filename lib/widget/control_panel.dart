import 'package:flutter/material.dart';
import 'package:video_calling_app/widget/button.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key, this.audioEnabled, this.videoEnabled, this.isConnectionFailed, this.onVideoToggle,this.onAudioToggle, this.onMeetingEnd, this.onReconnect});

  final bool? videoEnabled;
  final bool? audioEnabled;
  final bool? isConnectionFailed;
  final VoidCallback? onVideoToggle;
  final VoidCallback? onAudioToggle;
  final VoidCallback? onReconnect;
  final VoidCallback? onMeetingEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buildControls(),
      ),
    );
  }

  List<Widget> buildControls() {
    if(!isConnectionFailed!){
      return <Widget>[
        IconButton(
          onPressed: onVideoToggle, 
          icon: Icon(audioEnabled! ? Icons.videocam : Icons.videocam_off),
          color: Colors.white,
          iconSize: 32,
        ),
        IconButton(
          onPressed: onAudioToggle, 
          icon: Icon(audioEnabled! ? Icons.mic : Icons.mic_off),
          color: Colors.white,
          iconSize: 32,
        ),
        const SizedBox(width: 25,),
        Container(
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red
          ),
          child: IconButton(
            onPressed: onMeetingEnd, 
            icon: const Icon(Icons.call_end),
            color: Colors.white,
          ),
        )
      ];
    }
    return <Widget>[
      Button(title: 'Reconnect', onTap: onReconnect)
    ];
  }
}