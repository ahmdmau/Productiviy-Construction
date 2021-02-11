part of 'pages.dart';

class ChartPage extends StatefulWidget {
  final List<ChartModel> chartModel;
  final List<WeatherGraphicModel> weatherGraphicModel;

  ChartPage(this.chartModel, this.weatherGraphicModel);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  double totalAverage;

  @override
  void initState() {
    super.initState();
    totalAverage =
        widget.chartModel.map((e) => e.productivity).reduce((a, b) => a + b) /
            widget.chartModel.length;
    // var totalProductivity =
    //     widget.chartModel.map((e) => e.productivity).reduce((a, b) => a + b);
  }

  // final List<SalesData> chartData = [
  //   SalesData('Jan', 35),
  //   SalesData('Feb', 28),
  //   SalesData('Mar', 34),
  //   SalesData('Apr', 32),
  //   SalesData('May', 40)
  // ];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(ThemeData().copyWith(
      primaryColor: accentColor1,
      unselectedWidgetColor: Colors.grey,
    )));
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<PageBloc>(context).add(GoToMainPage());
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
                Column(
                  children: [
                    Container(
                      height: 56,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<PageBloc>(context)
                                    .add(GoToMainPage());
                              },
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Grafik\nData Proyek",
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
                    SfCartesianChart(
                      primaryYAxis: NumericAxis(plotBands: <PlotBand>[
                        PlotBand(
                            verticalTextPadding: '5%',
                            horizontalTextPadding: '5%',
                            verticalTextAlignment: TextAnchor.middle,
                            horizontalTextAlignment: TextAnchor.start,
                            text: "${totalAverage.toStringAsFixed(2)}",
                            textAngle: 0,
                            start: totalAverage,
                            end: totalAverage,
                            textStyle: TextStyle(
                                color: Colors.deepOrange, fontSize: 16),
                            borderColor: Colors.red,
                            borderWidth: 2)
                      ]),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      legend: Legend(
                          isVisible: true, position: LegendPosition.bottom),
                      series: <ChartSeries>[
                        FastLineSeries<ChartModel, double>(
                            name: 'Produktivitas',
                            markerSettings: MarkerSettings(isVisible: false),
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            dataSource: widget.chartModel,
                            xValueMapper: (ChartModel sales, _) => sales.count,
                            yValueMapper: (ChartModel sales, _) =>
                                sales.productivity)
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Card(
                      margin: EdgeInsets.only(
                          top: 8, left: defaultMargin, right: defaultMargin),
                      elevation:
                          1.0, // this field changes the shadow of the card 1.0 is default
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Rata rata:",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "${totalAverage.toStringAsFixed(2)}",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(
                          text:
                              'Perbandingan Produktivitas Pekerjaan Pada Saat Hujan Dan Cerah',
                          textStyle: blackTextFont),
                      // Enable legend
                      legend: Legend(
                          isVisible: true, position: LegendPosition.bottom),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ColumnSeries<WeatherGraphicModel, String>>[
                        ColumnSeries<WeatherGraphicModel, String>(
                            name: 'Rata-Rata Produktivitas',
                            dataSource: widget.weatherGraphicModel,
                            xValueMapper: (WeatherGraphicModel sales, _) =>
                                sales.weather,
                            yValueMapper: (WeatherGraphicModel sales, _) =>
                                sales.average,
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
