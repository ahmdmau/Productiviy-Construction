part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    if (user == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        BlocProvider.of<PageBloc>(context).add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        BlocProvider.of<UserBloc>(context).add(LoadUser(user.uid));
        BlocProvider.of<CategoryProjectBloc>(context)
            .add(FetchCategoryProject());
        prevPageEvent = GoToMainPage();
        BlocProvider.of<PageBloc>(context).add(GoToMainPage());
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : (pageState is OnRegistrationPage)
                    ? SignUpPage(pageState.registrationData)
                    : (pageState is OnAccountConfirmationPage)
                        ? AccountConfirmationPage(pageState.registrationData)
                        : (pageState is OnFormDataWorkPage)
                            ? FormDataWork(
                                pageState.workModel, pageState.isEdit)
                            : (pageState is OnFormDataWorkSecondPage)
                                ? FormDataWorkSecondPage(
                                    pageState.workModel, pageState.isEdit)
                                : (pageState is OnFormProjectPage)
                                    ? FormProjectPage()
                                    : (pageState is OnChooseTypeWorkPage)
                                        ? ChooseTypeWorkPage(
                                            pageState.workModel)
                                        : (pageState is OnListDataProjectPage)
                                            ? ListDataProject(
                                                pageState.workModel,
                                                pageState.idProject,
                                                false,
                                                pageState.title,
                                              )
                                            : (pageState is OnDetailProjectPage)
                                                ? DetailProjectPage(
                                                    pageState.typeWork,
                                                    pageState.title)
                                                : (pageState
                                                        is OnDetailProjectSinglePage)
                                                    ? DetailProjectSinglePage(
                                                        pageState.workModel)
                                                    : (pageState is OnChartPage)
                                                        ? ChartPage(
                                                            pageState
                                                                .chartModel,
                                                            pageState
                                                                .weatherGraphicModel)
                                                        : (pageState
                                                                is OnLurPage)
                                                            ? LurPages(
                                                                pageState
                                                                    .effective,
                                                                pageState
                                                                    .contributory,
                                                                pageState
                                                                    .ineffective)
                                                            : MainPage());
  }
}
