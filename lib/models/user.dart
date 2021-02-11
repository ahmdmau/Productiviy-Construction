part of 'models.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;

  UserModel(this.id, this.email, {this.name, this.profilePicture});

  UserModel copyWith({String name, String profileImage, int balance}) =>
      UserModel(this.id, this.email,
          name: name ?? this.name,
          profilePicture: profileImage ?? this.profilePicture);

  @override
  List<Object> get props => [id, email, name, profilePicture];

  @override
  String toString() {
    return "$id - $name - $email";
  }
}
