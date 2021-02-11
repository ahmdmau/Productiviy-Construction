part of 'pages.dart';

class LurPages extends StatefulWidget {
  final int effective;
  final int contributory;
  final int ineffective;

  LurPages(this.effective, this.contributory, this.ineffective);

  @override
  _LurPagesState createState() => _LurPagesState();
}

class _LurPagesState extends State<LurPages> {
  int total;
  double effectiveProposal;
  double effectiveTotal;

  double contributoryProposal;
  double contributoryTotal;

  double ineffectiveProposal;
  double ineffectiveTotal;

  double lur;

  @override
  void initState() {
    super.initState();
    total = widget.effective + widget.contributory + widget.ineffective;
    effectiveProposal = widget.effective / total * 100;
    effectiveTotal = effectiveProposal;

    contributoryProposal = widget.contributory / total * 100;
    contributoryTotal = effectiveProposal + contributoryProposal;

    ineffectiveProposal = widget.ineffective / total * 100;
    ineffectiveTotal =
        effectiveProposal + contributoryProposal + ineffectiveProposal;

    lur = ((effectiveProposal + (0.25 * contributoryProposal)) / 100) * 100;
  }

  @override
  Widget build(BuildContext context) {
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
                                BlocProvider.of<PageBloc>(context)
                                    .add(GoToMainPage());
                              },
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Perhitungan\nLabor Utilization Rate",
                              style: blackTextFont.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jenis Kegiatan",
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            Text(
                              "Effective",
                              style: whiteNumberFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )),

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
                                Text("Jumlah Pengamatan",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "${widget.effective}",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Proporsi",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "$effectiveProposal%",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "$effectiveTotal%",
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
                    Container(
                        margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jenis Kegiatan",
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            Text(
                              "Essential Contributory",
                              style: whiteNumberFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )),

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
                                Text("Jumlah Pengamatan",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "${widget.contributory}",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Proporsi",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "${contributoryProposal.toStringAsFixed(2)}%",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "${contributoryTotal.toStringAsFixed(2)}%",
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
                    Container(
                        margin: EdgeInsets.only(top: 24, left: 24, right: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jenis Kegiatan",
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            Text(
                              "InEffective",
                              style: whiteNumberFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )),

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
                                Text("Jumlah Pengamatan",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "${widget.ineffective}",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Proporsi",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "${ineffectiveProposal.toStringAsFixed(2)}%",
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Total",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "${ineffectiveTotal.toStringAsFixed(2)}%",
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
                                Text("LUR (%)",
                                    style: greyTextFont.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  "${lur.toStringAsFixed(2)}%",
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
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
