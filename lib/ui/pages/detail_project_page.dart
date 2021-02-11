part of 'pages.dart';

class DetailProjectPage extends StatefulWidget {
  final int typeWork;
  final String title;

  DetailProjectPage(this.typeWork, this.title);

  @override
  _DetailProjectPageState createState() => _DetailProjectPageState();
}

class _DetailProjectPageState extends State<DetailProjectPage> {
  List<WorkModel> workModel;

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
                color: Color(0xFFF6F7F9),
              ),
            ),
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // note: BACK BUTTON
                    Container(
                      margin: EdgeInsets.only(
                          top: defaultMargin,
                          right: defaultMargin,
                          left: defaultMargin,
                          bottom: 0),
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
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Detail\nProyek ${widget.title}",
                              style: blackTextFont.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 48,
                      height: 46,
                      margin: EdgeInsets.only(top: 36, bottom: 20),
                      child: RaisedButton(
                        elevation: 0,
                        color: mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Lihat Grafik",
                          style: whiteTextFont.copyWith(fontSize: 16),
                        ),
                        onPressed: () {
                          List<ChartModel> chartModel = List<ChartModel>();
                          List<WeatherGraphicModel> weatherGraphicModel =
                              List<WeatherGraphicModel>();
                          double resultHujan = 0;
                          double resultNormal = 0;
                          for (var i = 0; i < workModel.length; i++) {
                            var chart = ChartModel(
                                workModel[i].productivityResult,
                                (i + 1).toDouble());
                            print(workModel[i].productivityResult);
                            print(i + 1);
                            chartModel.add(chart);
                          }

                          var productivityResultNormal = workModel.where(
                              (element) => element.weather.contains("Normal"));

                          if (productivityResultNormal.length > 0) {
                            resultNormal = productivityResultNormal
                                    .map((e) => e.productivityResult)
                                    .reduce(
                                        (value, element) => value + element) /
                                productivityResultNormal
                                    .where((element) =>
                                        element.weather == "Normal")
                                    .length;
                          }

                          var productivityResultHujan = workModel.where(
                              (element) => element.weather.contains("Hujan"));

                          if (productivityResultHujan.length > 0) {
                            resultHujan = productivityResultHujan
                                    .map((e) => e.productivityResult)
                                    .reduce(
                                        (value, element) => value + element) /
                                productivityResultHujan
                                    .where(
                                        (element) => element.weather == "Hujan")
                                    .length;
                          }

                          weatherGraphicModel.add(
                              WeatherGraphicModel("Cuaca Cerah", resultNormal));
                          weatherGraphicModel.add(
                              WeatherGraphicModel("Cuaca Hujan", resultHujan));

                          BlocProvider.of<PageBloc>(context).add(
                              GoToChartPage(chartModel, weatherGraphicModel));
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 48,
                      height: 46,
                      child: RaisedButton(
                          elevation: 0,
                          color: mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Lihat Labor Utilization Rate",
                            style: whiteTextFont.copyWith(fontSize: 16),
                          ),
                          onPressed: () {
                            var effective = workModel
                                .map((e) => e.effective)
                                .reduce((a, b) => a + b);

                            var contributory = workModel
                                .map((e) => e.contributory)
                                .reduce((a, b) => a + b);

                            var ineffective = workModel
                                .map((e) => e.ineffective)
                                .reduce((a, b) => a + b);

                            BlocProvider.of<PageBloc>(context).add(GoToLurPage(
                                effective, contributory, ineffective));
                          }),
                    ),
                    BlocBuilder<ProjectBloc, ProjectState>(
                      builder: (context, ProjectState state) {
                        if (state is ProjectLoaded) {
                          var tempWorkModel = state.workModel
                              .where((ticket) =>
                                  ticket.idTypeWork == widget.typeWork)
                              .toList();
                          WorkModel.sortPosts(tempWorkModel);
                          workModel = tempWorkModel;
                          return Container(
                            child: ItemDetailCard(tempWorkModel),
                          );
                        } else {
                          return SpinKitCircle(
                            color: mainColor,
                            size: 50,
                          );
                        }
                      },
                    ),

                    SizedBox(
                      height: 40,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Future<List<WorkModel>> getData() async {
  //   var result = await ProjectServies.getWork(widget.idProject);
  //   return result
  //       .where((ticket) => ticket.idTypeWork == widget.typeWork)
  //       .toList();
  // }
}
