part of 'pages.dart';

class FormDataWorkSecondPage extends StatefulWidget {
  final WorkModel workModel;
  final bool isEdit;

  FormDataWorkSecondPage(this.workModel, this.isEdit);

  @override
  _FormDataWorkSecondPageState createState() => _FormDataWorkSecondPageState();
}

class _FormDataWorkSecondPageState extends State<FormDataWorkSecondPage> {
  double productivityResult;
  bool isSubmit = false;

  TextEditingController workProductivityController = TextEditingController();
  TextEditingController directWorkController = TextEditingController();
  TextEditingController prepareMaterialController = TextEditingController();
  TextEditingController unemployedController = TextEditingController();

  @override
  void initState() {
    super.initState();

    productivityResult =
        (widget.workModel.workResult / widget.workModel.totalWorker) /
            widget.workModel.durationTime;
    workProductivityController.text = productivityResult.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          BlocProvider.of<PageBloc>(context)
              .add(GoToFormDataWorkPage(widget.workModel, widget.isEdit));
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PageBloc>(context).add(
                                      GoToFormDataWorkPage(
                                          widget.workModel, widget.isEdit));
                                },
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
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
                      TextField(
                        controller: workProductivityController,
                        readOnly: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Produktivitas",
                            suffixText: (widget.workModel.idTypeWork == 2)
                                ? "m3/orang-jam"
                                : "Kg/orang-jam",
                            hintText: "Produktivitas"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Effective",
                          style: blackTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: directWorkController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Pekerjaan Langsung",
                            hintText: "Pekerjaan Langsung"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Contributory",
                          style: blackTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: prepareMaterialController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Mempersiapkan Material",
                            hintText: "Mempersiapkan Material"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Ineffective",
                          style: blackTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: unemployedController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Menganggur",
                            hintText: "Menganggur"),
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
                                    if (!(workProductivityController.text
                                                .trim() !=
                                            "" &&
                                        directWorkController.text.trim() !=
                                            "" &&
                                        prepareMaterialController.text.trim() !=
                                            "" &&
                                        unemployedController.text.trim() !=
                                            "")) {
                                      Flushbar(
                                        duration: Duration(milliseconds: 1500),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        message: "Please fill all the fields",
                                        backgroundColor: Color(0xFFFF5C83),
                                      ).show(context);
                                    } else {
                                      var uuid = Uuid();
                                      widget.workModel.id = uuid.v4();
                                      widget.workModel.effective =
                                          int.parse(directWorkController.text);
                                      widget.workModel.contributory = int.parse(
                                          prepareMaterialController.text);
                                      widget.workModel.ineffective =
                                          int.parse(unemployedController.text);
                                      widget.workModel.productivityResult =
                                          productivityResult;
                                      var result = ProjectServies.addProject(
                                          widget.workModel);
                                      result
                                          .then((doc) {
                                            BlocProvider.of<ProjectBloc>(
                                                    context)
                                                .add(
                                                    GetWork(dummyIdProject, 0));
                                            BlocProvider.of<PageBloc>(context)
                                                .add(GoToListDataProjectPage(
                                                    dummyWorkModel,
                                                    dummyIdProject,
                                                    dummyTitle));
                                          })
                                          .timeout(Duration(seconds: 10))
                                          .catchError((error) {
                                            setState(() {
                                              isSubmit = false;
                                            });
                                          });
                                    }
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
