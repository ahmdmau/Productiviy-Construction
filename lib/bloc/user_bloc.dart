import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:productivity_contruction/models/models.dart';
import 'package:productivity_contruction/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      UserModel user = await UserServices.getUser(event.id);
      yield UserLoaded(user);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      UserModel updatedUser = (state as UserLoaded)
          .model
          .copyWith(name: event.name, profileImage: event.profileImage);
      await UserServices.updateUser(updatedUser);
      yield UserLoaded(updatedUser);
    }
  }
}
