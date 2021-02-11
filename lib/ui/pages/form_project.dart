part of 'pages.dart';

class FormProjectPage extends StatefulWidget {
  @override
  _FormProjectPageState createState() => _FormProjectPageState();
}

class _FormProjectPageState extends State<FormProjectPage> {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectLocationController = TextEditingController();
  bool isSubmit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context)
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
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
                                "Tambah Proyek",
                                style: blackTextFont.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: projectNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Nama Proyek",
                            hintText: "Nama Proyek"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: projectLocationController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Lokasi Proyek",
                            hintText: "Lokasi Proyek"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (isSubmit)
                          ? SpinKitCircle(color: Color(0xFF3E9D9D), size: 45)
                          : SizedBox(
                              width: MediaQuery.of(context).size.width - 48,
                              height: 45,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  color: Color(0xFF3E9D9D),
                                  child: Text(
                                    "Submit Data",
                                    style: whiteTextFont.copyWith(fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      isSubmit = true;
                                    });
                                    var uuid = Uuid();
                                    CategoryProjectModel categoryProjectModel =
                                        CategoryProjectModel(
                                            id: uuid.v4(),
                                            projectName:
                                                projectNameController.text,
                                            projectLocation:
                                                projectLocationController.text);
                                    var result = CategoryProjectServices
                                        .addCategoryProject(
                                            categoryProjectModel);
                                    result
                                        .then((doc) {
                                          BlocProvider.of<PageBloc>(context)
                                              .add(GoToMainPage());
                                        })
                                        .timeout(Duration(seconds: 10))
                                        .catchError((error) {
                                          setState(() {
                                            isSubmit = false;
                                          });
                                        });
                                  }),
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
        ));
  }
}
