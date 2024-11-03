import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_chat/features/domain/entities/my_chat_entity.dart';

class MyChatModel extends MyChatEntity {
  MyChatModel({
    super.senderName,
    super.recipientName,
    super.channelId,
    super.recipientUID,
    super.senderUID,
    super.profileUrl,
    super.recentTextMessage,
    super.isRead,
    super.time,
    super.isArchived,
    super.recipientPhoneNumber,
    super.senderPhoneNumber,
    super.subjectName,
    super.communicationType,
  });

factory MyChatModel.fromSnapshot(DocumentSnapshot snapshot) {
  return MyChatModel(
    senderName: snapshot.get('senderName'),
    recipientName: snapshot.get('recipientName'),
    channelId: snapshot.get('channelId'),
    recipientUID: snapshot.get('recipientUID'),
    senderUID: snapshot.get('senderUID'),
    profileUrl: snapshot.get('profileUrl'),
    recentTextMessage: snapshot.get('recentTextMessage'),
    isRead: snapshot.get('isRead'),
    time: snapshot.get('time'),
    isArchived: snapshot.get('isArchived'),
    recipientPhoneNumber: snapshot.get('recipientPhoneNumber'),
    senderPhoneNumber: snapshot.get('senderPhoneNumber'),
    subjectName: snapshot.get('subjectName'),
    communicationType: snapshot.get('communicationType'),
  );
}

Map<String, dynamic> toDocument() {
  return {
    "senderName": senderName,
    "recipientName": recipientName,
    "channelId": channelId,
    "recipientUID": recipientUID,
    "senderUID": senderUID,
    "profileUrl": profileUrl,
    "recentTextMessage": recentTextMessage,
    "isRead": isRead,
    "time": time,
    "isArchived": isArchived,
    "recipientPhoneNumber": recipientPhoneNumber,
    "senderPhoneNumber": senderPhoneNumber,
    "subjectName":subjectName,
    "communicationType":communicationType
  };
}
}
