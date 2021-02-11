part of 'project_bloc.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

class ProjectInitial extends ProjectState {
  const ProjectInitial();
  @override
  List<Object> get props => [];
}

class ProjectLoading extends ProjectState {
  const ProjectLoading();
  @override
  List<Object> get props => null;
}

class ProjectLoaded extends ProjectState {
  final List<WorkModel> workModel;

  const ProjectLoaded(this.workModel);

  @override
  List<Object> get props => [workModel];
}

class ProjectError extends ProjectState {
  final String message;
  const ProjectError(this.message);
  @override
  List<Object> get props => [message];
}
