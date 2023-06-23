import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_wrapper/flutter_webrtc_wrapper.dart';

class RemoteConnection extends StatefulWidget {
  const RemoteConnection({super.key, required this.renderer, required this.connection});
  final RTCVideoRenderer renderer;
  final Connection connection;
  @override
  State<RemoteConnection> createState() => _RemoteConnectionState();
}

class _RemoteConnectionState extends State<RemoteConnection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: RTCVideoView(
            widget.renderer,
            mirror: false,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          ),
        ),
        Container(
          color: widget.connection.videoEnabled! ? Colors.transparent : Colors.blue,
          child: Center(
            child: Text(
              widget.connection.videoEnabled!? '' : widget.connection.name!
            ),
          ),
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.all(5),
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.connection.name!,),
                Icon(
                  widget.connection.audioEnabled! ? Icons.mic : Icons.macro_off,
                  color: Colors.white,
                  size: 15,
                )
              ],
            ),
          )
        )
      ],
    );
  }
}