import 'dart:convert';

MeetingDetail meetingDetailFromJson(String str) => MeetingDetail.fromJson(json.decode(str));

String meetingDetailToJson(MeetingDetail data) => json.encode(data.toJson());

class MeetingDetail {
    MeetingDetail({
        this.id,
        this.hostId,
        this.hostName,
    });

    String? id;
    String? hostId;
    String? hostName;

    factory MeetingDetail.fromJson(Map<String, dynamic> json) => MeetingDetail(
        id: json["_id"],
        hostId: json["hostId"],
        hostName: json["hostName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "hostId": hostId,
        "hostName": hostName,
    };
}