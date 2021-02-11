part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class GoToSplashPage extends PageEvent {}

class GoToSignInPage extends PageEvent {}

class GoToMainPage extends PageEvent {}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;
  GoToRegistrationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;
  GoToAccountConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToFormDataWorkPage extends PageEvent {
  final WorkModel workModel;
  final bool isEdit;
  GoToFormDataWorkPage(this.workModel, this.isEdit);

  @override
  List<Object> get props => [];
}

class GoToFormDataWorkSecondPage extends PageEvent {
  final WorkModel workModel;
  final bool isEdit;
  GoToFormDataWorkSecondPage(this.workModel, this.isEdit);

  @override
  List<Object> get props => [];
}

class GoToFormProjectPage extends PageEvent {}

class GoToChooseTypeWorkPage extends PageEvent {
  final WorkModel workModel;
  GoToChooseTypeWorkPage(this.workModel);

  @override
  List<Object> get props => [];
}

class GoToListDataProjectPage extends PageEvent {
  final WorkModel workModel;
  final String idProject;
  final String title;

  GoToListDataProjectPage(this.workModel, this.idProject, this.title);

  @override
  List<Object> get props => [];
}

class GoToDetailProjectPage extends PageEvent {
  final int typeWork;
  final String title;

  GoToDetailProjectPage(this.typeWork, this.title);

  @override
  List<Object> get props => [];
}

class GoToDetailProjectSinglePage extends PageEvent {
  final WorkModel workModel;

  GoToDetailProjectSinglePage(this.workModel);

  @override
  List<Object> get props => [];
}

class GoToChartPage extends PageEvent {
  final List<ChartModel> chartModel;
  final List<WeatherGraphicModel> weatherGraphicModel;

  GoToChartPage(this.chartModel, this.weatherGraphicModel);

  @override
  List<Object> get props => [];
}

class GoToLurPage extends PageEvent {
  final int effective;
  final int contributory;
  final int ineffective;

  GoToLurPage(this.effective, this.contributory, this.ineffective);

  @override
  List<Object> get props => [];
}
