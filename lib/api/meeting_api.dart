import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/user.utils.dart';
String meetingApiUrl = 'https://icy-lizards-drum.loca.lt/api/meeting';
var client = http.Client();

Future<http.Response?> startMeeting() async{
  Map<String,String> requestHeader = {
    'content-Type':'application/json'
  };
  var userId = await loadUserId();
  String body = jsonEncode({
    'hostId':userId,
    'hostName':'',
  });
  var response = await client.post(Uri.parse('$meetingApiUrl/start'),headers: requestHeader,body: body);
  if(response.statusCode == 200){
    return response;
  }else {
    null;
  }
  return null;
}

Future<http.Response?> joinMeeting(String meetingId) async{
  Map<String,String> requestHeader = {
    'content-Type':'application/json'
  };
  var response = await client.get(Uri.parse('$meetingApiUrl/join?meetingId=$meetingId'),headers: requestHeader);
  if(response.statusCode >= 200 && response.statusCode >= 400){
    return response;
  }
  throw UnsupportedError('Not Found meeting');
}