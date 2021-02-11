import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:productivity_contruction/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToSignInPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GoToFormDataWorkPage) {
      yield OnFormDataWorkPage(event.workModel, event.isEdit);
    } else if (event is GoToFormDataWorkSecondPage) {
      yield OnFormDataWorkSecondPage(event.workModel, event.isEdit);
    } else if (event is GoToFormProjectPage) {
      yield OnFormProjectPage();
    } else if (event is GoToChooseTypeWorkPage) {
      yield OnChooseTypeWorkPage(event.workModel);
    } else if (event is GoToListDataProjectPage) {
      yield OnListDataProjectPage(
          event.workModel, event.idProject, event.title);
    } else if (event is GoToDetailProjectPage) {
      yield OnDetailProjectPage(event.typeWork, event.title);
    } else if (event is GoToDetailProjectSinglePage) {
      yield OnDetailProjectSinglePage(event.workModel);
    } else if (event is GoToChartPage) {
      yield OnChartPage(event.chartModel, event.weatherGraphicModel);
    } else if (event is GoToLurPage) {
      yield OnLurPage(event.effective, event.contributory, event.ineffective);
    }
  }
}
