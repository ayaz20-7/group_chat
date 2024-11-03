import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_chat/features/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {

  GroupModel({
    super.groupName,
    super.groupProfileImage,
    super.joinUsers,
    super.limitUsers,
    super.uid,
    super.creationTime,
    super.groupId,
    super.lastMessage,
  });


  factory GroupModel.fromSnapshot(DocumentSnapshot snapshot) {
    return GroupModel(
      groupName: snapshot.get('groupName'),
      creationTime: snapshot.get('creationTime'),
      groupId: snapshot.get('groupId'),
      groupProfileImage: snapshot.get('groupProfileImage'),
      joinUsers: snapshot.get('joinUsers'),
      limitUsers: snapshot.get('limitUsers'),
      lastMessage: snapshot.get('lastMessage'),
      uid: snapshot.get('uid'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "groupName": groupName,
      "creationTime": creationTime,
      "groupId": groupId,
      "groupProfileImage": groupProfileImage,
      "joinUsers": joinUsers,
      "limitUsers": limitUsers,
      "lastMessage": lastMessage,
      "uid": uid,
    };
  }
}
