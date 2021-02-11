part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class GetWork extends ProjectEvent {
  final String projectID;
  final int type;

  GetWork(this.projectID, this.type);

  @override
  List<Object> get props => [projectID, type];
}

class DeleteWork extends ProjectEvent {
  final String id;
  final String projectId;

  DeleteWork(this.id, this.projectId);

  @override
  List<Object> get props => [id, projectId];
}
