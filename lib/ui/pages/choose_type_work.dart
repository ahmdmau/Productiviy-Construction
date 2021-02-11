part of 'pages.dart';

class ChooseTypeWorkPage extends StatefulWidget {
  final WorkModel workModel;
  ChooseTypeWorkPage(this.workModel);

  @override
  _ChooseTypeWorkPageState createState() => _ChooseTypeWorkPageState();
}

class _ChooseTypeWorkPageState extends State<ChooseTypeWorkPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<ProjectBloc>(context).add(GetWork(dummyIdProject, 0));
        BlocProvider.of<PageBloc>(context).add(GoToListDataProjectPage(
            dummyWorkModel, dummyIdProject, dummyTitle));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: accentColor1,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
              ),
            ),
            ListView(
              padding: EdgeInsets.only(
                  top: 40, left: defaultMargin, right: defaultMargin),
              children: [
                Container(
                  height: 56,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<ProjectBloc>(context)
                                .add(GetWork(dummyIdProject, 0));
                            BlocProvider.of<PageBloc>(context).add(
                                GoToListDataProjectPage(dummyWorkModel,
                                    dummyIdProject, dummyTitle));
                          },
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Form\nPengambilan Data",
                          style: blackTextFont.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: dummyCategoryWorks
                      .map(
                        (e) => Card(
                          color: appWhite,
                          margin: EdgeInsets.only(top: 16),
                          elevation: 2,
                          child: ListTile(
                            onTap: () {
                              widget.workModel.idTypeWork = e.id;
                              BlocProvider.of<PageBloc>(context).add(
                                  GoToFormDataWorkPage(
                                      widget.workModel, false));
                            },
                            title: Text(
                              e.title,
                              style: boldTextStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Container(
                              margin: EdgeInsets.only(top: 4),
                              child:
                                  Text(e.subtitle, style: secondaryTextStyle()),
                            ),
                            trailing: Container(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(Icons.chevron_right,
                                  color: iconColorPrimaryDark),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
