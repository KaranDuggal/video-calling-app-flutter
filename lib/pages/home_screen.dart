import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:video_calling_app/pages/join_screen.dart';

import '../api/meeting_api.dart';
import '../models/meeting_details.dart';
import '../widget/button.dart';
import '../widget/input_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String meetingId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: globalKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Welcome To Meeting App"),
                const SizedBox(height: 20,),
                InputField(
                  label: 'MeetingId', 
                  hintText: 'Enter meetingId',
                  validator: (val){
                    if(val!.isEmpty){
                      return 'Meeting id cant be empty';
                    }
                    return null;
                  },
                  onChanged: (val){
                    meetingId = val;
                  },
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Flexible(
                      child: Button(title: 'Join meting', onTap: (){
                        if(validateAndSave()){
                          validateMeeting(meetingId);
                        }
                      })
                    ),
                    const SizedBox(width: 10,),
                    Flexible(
                      child: Button(title: 'Start meting', onTap: () async{
                        var response = await startMeeting();
                        final body = json.decode(response!.body);
                        final meetingId = body['data'];
                        validateMeeting(meetingId['_id']);
                      })
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void validateMeeting(String meetingId) async{
    try {
      Response? response = await joinMeeting(meetingId);
      var data = json.decode(response!.body);
      var meetingDetails = MeetingDetail.fromJson(data['data']);
      if(meetingDetails.id!.isNotEmpty){
        goToJoinScreen(meetingDetails);

      }
    } catch (err) {
    }
  }
  void goToJoinScreen(MeetingDetail meetingDetail) async{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> JoinScreen(meetingDetail: meetingDetail)));
  }
  bool validateAndSave(){
    final form = globalKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }
}