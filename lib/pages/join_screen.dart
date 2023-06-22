import 'package:flutter/material.dart';
import 'package:video_calling_app/models/meeting_details.dart';

import '../widget/button.dart';
import '../widget/input_field.dart';

class JoinScreen extends StatefulWidget {
  final MeetingDetail? meetingDetail;
  const JoinScreen({super.key, this.meetingDetail});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String meetingId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Meeting'),
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
                InputField(
                  label: 'UserId', 
                  hintText: 'Enter your name',
                  validator: (val){
                    if(val!.isEmpty){
                      return 'name cant be empty';
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
                          // validateMeeting(meetingId);
                        }
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
  bool validateAndSave(){
    final form = globalKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }
}