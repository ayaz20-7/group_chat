




import 'package:group_chat/features/domain/entities/text_messsage_entity.dart';
import 'package:group_chat/features/domain/repositories/firebase_repository.dart';

class GetMessageUseCase{
  final FirebaseRepository repository;

  GetMessageUseCase({required this.repository});

 Stream<List<TextMessageEntity>> call(String channelId){
  return repository.getMessages(channelId);
 }
}