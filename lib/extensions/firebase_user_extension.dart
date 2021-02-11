part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserModel convertToUser({String name = "No Name"}) =>
      UserModel(this.uid, this.email, name: name);

  Future<UserModel> fromFirestore() async =>
      await UserServices.getUser(this.uid);
}
