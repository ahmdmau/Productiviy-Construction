import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_contruction/models/models.dart';
import 'package:productivity_contruction/services/services.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitial());

  @override
  Stream<ProjectState> mapEventToState(
    ProjectEvent event,
  ) async* {
    // if (event is GetWork) {
    //   List<WorkModel> workModel = await ProjectServies.getWork(event.projectID);

    //   yield ProjectLoaded(workModel);
    // } else if (event is DeleteWork) {
    //   ProjectServies.updateData(event.id);
    //   List<WorkModel> workModel = await ProjectServies.getWork(event.projectId);

    //   yield ProjectLoaded(workModel);
    // }

    if (event is GetWork) {
      try {
        yield ProjectLoading();
        List<WorkModel> workModel =
            await ProjectServies.getWork(event.projectID);
        yield ProjectLoaded(workModel);
      } on FirebaseAuthException {
        yield ProjectError("Failed to fetch data. is your device online?");
      }
    }
  }
}
