part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class OnInitialPage extends PageState {}

class OnLoginPage extends PageState {}

class OnSplashPage extends PageState {}

class OnMainPage extends PageState {}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;
  OnRegistrationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationData registrationData;
  OnAccountConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class OnFormDataWorkPage extends PageState {
  final WorkModel workModel;
  final bool isEdit;
  OnFormDataWorkPage(this.workModel, this.isEdit);

  @override
  List<Object> get props => [];
}

class OnFormDataWorkSecondPage extends PageState {
  final WorkModel workModel;
  final bool isEdit;
  OnFormDataWorkSecondPage(this.workModel, this.isEdit);

  @override
  List<Object> get props => [];
}

class OnFormProjectPage extends PageState {}

class OnChooseTypeWorkPage extends PageState {
  final WorkModel workModel;
  OnChooseTypeWorkPage(this.workModel);

  @override
  List<Object> get props => [];
}

class OnListDataProjectPage extends PageState {
  final WorkModel workModel;
  final String idProject;
  final String title;
  OnListDataProjectPage(this.workModel, this.idProject, this.title);

  @override
  List<Object> get props => [];
}

class OnDetailProjectPage extends PageState {
  final int typeWork;
  final String title;

  OnDetailProjectPage(this.typeWork, this.title);

  @override
  List<Object> get props => [];
}

class OnDetailProjectSinglePage extends PageState {
  final WorkModel workModel;

  OnDetailProjectSinglePage(this.workModel);

  @override
  List<Object> get props => [];
}

class OnChartPage extends PageState {
  final List<ChartModel> chartModel;
  final List<WeatherGraphicModel> weatherGraphicModel;

  OnChartPage(this.chartModel, this.weatherGraphicModel);

  @override
  List<Object> get props => [];
}

class OnLurPage extends PageState {
  final int effective;
  final int contributory;
  final int ineffective;

  OnLurPage(this.effective, this.contributory, this.ineffective);

  @override
  List<Object> get props => [];
}
