








import 'package:group_chat/features/domain/entities/user_entity.dart';
import 'package:group_chat/features/domain/repositories/firebase_repository.dart';

class SignUpUseCase{
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user){
    return repository.signUp(user);
  }
}