part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("users");

  static Future<void> updateUser(UserModel userModel) async {
    _userCollection.doc(userModel.id).set({
      'email': userModel.email,
      'name': userModel.name,
      'profilePicture': userModel.profilePicture ?? ""
    });
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();
    Map<String, dynamic> data = snapshot.data();
    return UserModel(id, data['email'],
        name: data['name'], profilePicture: data['profilePicture']);
  }
}
