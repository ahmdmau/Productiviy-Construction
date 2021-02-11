part of 'pages.dart';

class FormDataWork extends StatefulWidget {
  final WorkModel workModel;
  final bool isEdit;

  FormDataWork(this.workModel, this.isEdit);

  @override
  _FormDataWorkState createState() => _FormDataWorkState();
}

class _FormDataWorkState extends State<FormDataWork> {
  int _radioValue = 0;

  TextEditingController workNameController = TextEditingController();
  TextEditingController workLocationController = TextEditingController();
  TextEditingController workDurationController = TextEditingController();
  TextEditingController workCountController = TextEditingController();
  TextEditingController workResultController = TextEditingController();
  TextEditingController _controllerStartTime = TextEditingController();
  TextEditingController _controllerEndTime = TextEditingController();

  int startDate = 0;
  int endDate = 0;
  TimeOfDay startTime;
  TimeOfDay endTime;
  double startTimeDouble;
  double endTimeDouble;
  DateTime selectedDate;
  String selectedWeather = "Normal";

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      selectedDate = DateTime.fromMicrosecondsSinceEpoch(
          widget.workModel.workDate.microsecondsSinceEpoch);
      workNameController.text = widget.workModel.workName;
      workLocationController.text = widget.workModel.workLocation;
      workDurationController.text = "${widget.workModel.durationTime}";
      workCountController.text = "${widget.workModel.totalWorker}";
      workResultController.text = "${widget.workModel.workResult}";

      startTime = timeConvert(widget.workModel.startTime);
      endTime = timeConvert(widget.workModel.endTime);
    } else {
      selectedDate = DateTime.now();
      startTime = TimeOfDay.now();
      endTime = TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(ThemeData().copyWith(
      primaryColor: accentColor1,
      unselectedWidgetColor: Colors.grey,
    )));
    return WillPopScope(
      onWillPop: () {
        widget.workModel.idTypeWork = null;
        BlocProvider.of<PageBloc>(context)
            .add(GoToChooseTypeWorkPage(widget.workModel));
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
                                widget.workModel.idTypeWork = null;
                                BlocProvider.of<PageBloc>(context).add(
                                    GoToChooseTypeWorkPage(widget.workModel));
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
                      controller: workNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Nama Pekerjaan",
                          hintText: "Nama Pekerjaan"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFieldDatePicker(
                      labelText: "Tanggal",
                      suffixIcon: Icon(Icons.date_range),
                      lastDate: DateTime.now().add(Duration(days: 366)),
                      firstDate: DateTime(1900),
                      initialDate: selectedDate,
                      onDateChanged: (selectedDate) {
                        this.selectedDate = selectedDate;
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: workLocationController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Lokasi Pekerjaan",
                          hintText: "Lokasi Pekerjaan"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: _controllerStartTime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Jam Mulai",
                        suffixIcon: Icon(Icons.watch_later),
                      ),
                      onTap: () => _selectStartTime(
                        context,
                        startTime,
                        (selectedTime) {
                          _controllerStartTime.text =
                              selectedTime.format(context);
                          startTime = selectedTime;
                          startTimeDouble =
                              selectedTime.hour + selectedTime.minute / 60.0;
                          setState(() {});
                        },
                      ),
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: _controllerEndTime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Jam Selesai",
                        suffixIcon: Icon(Icons.watch_later),
                      ),
                      onTap: () => _selectStartTime(
                        context,
                        endTime,
                        (selectedTime) {
                          _controllerEndTime.text =
                              selectedTime.format(context);
                          endTime = selectedTime;
                          endTimeDouble =
                              selectedTime.hour + selectedTime.minute / 60.0;
                          workDurationController.text =
                              "${(endTimeDouble - startTimeDouble)}";
                          setState(() {});
                        },
                      ),
                      readOnly: true,
                    ),
                    // TextFieldTimePicker(
                    //   labelText: "Jam Selesai",
                    //   initialTime: endTime,
                    //   prevTime: startTimeDouble,
                    //   suffixIcon: Icon(Icons.access_time),
                    //   onDateChanged: (selectedDate) {
                    // endTime = selectedDate;
                    // endTimeDouble =
                    //     selectedDate.hour + selectedDate.minute / 60.0;
                    // workDurationController.text =
                    //     "${(endTimeDouble - startTimeDouble)}";
                    // setState(() {});
                    //   },
                    // ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: workDurationController,
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Durasi",
                          hintText: "Durasi"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: workCountController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Jumlah Pekerja",
                          hintText: "Jumlah Pekerja"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: workResultController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Hasil",
                          suffixText:
                              (widget.workModel.idTypeWork == 2) ? "m3" : "Kg",
                          hintText: "Hasil"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cuaca",
                          style: greyTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            new Radio(
                              value: 0,
                              groupValue: _radioValue,
                              activeColor: mainColor,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text(
                              'Normal',
                              style: greyTextFont.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            new Radio(
                              value: 1,
                              groupValue: _radioValue,
                              activeColor: mainColor,
                              onChanged: _handleRadioValueChange,
                            ),
                            new Text(
                              'Hujan',
                              style: greyTextFont.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.arrow_forward),
                      backgroundColor: mainColor,
                      elevation: 0,
                      onPressed: () {
                        if (!(workNameController.text.trim() != "" &&
                            workLocationController.text.trim() != "" &&
                            workDurationController.text.trim() != "" &&
                            workCountController.text.trim() != "" &&
                            workResultController.text.trim() != "")) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            message: "Please fill all the fields",
                            backgroundColor: Color(0xFFFF5C83),
                          ).show(context);
                        } else {
                          final localizations =
                              MaterialLocalizations.of(context);
                          final finalStartTime =
                              localizations.formatTimeOfDay(startTime);
                          final finalEndTime =
                              localizations.formatTimeOfDay(endTime);
                          widget.workModel.workName = workNameController.text;
                          widget.workModel.workLocation =
                              workLocationController.text;
                          widget.workModel.workDate =
                              Timestamp.fromMicrosecondsSinceEpoch(
                                  selectedDate.microsecondsSinceEpoch);
                          widget.workModel.workLocation =
                              workLocationController.text;
                          widget.workModel.startTime = finalStartTime;
                          widget.workModel.endTime = finalEndTime;
                          widget.workModel.durationTime =
                              endTimeDouble - startTimeDouble;
                          widget.workModel.totalWorker =
                              int.parse(workCountController.text);
                          widget.workModel.workResult =
                              double.parse(workResultController.text);
                          widget.workModel.weather = selectedWeather;

                          BlocProvider.of<PageBloc>(context).add(
                              GoToFormDataWorkSecondPage(
                                  widget.workModel, widget.isEdit));
                        }
                      },
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

  Future<Null> _selectStartTime(BuildContext context, TimeOfDay selectedTime,
      ValueChanged<TimeOfDay> onTimeChanged) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      onTimeChanged(pickedTime);
    }
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          selectedWeather = "Normal";
          break;
        case 1:
          selectedWeather = "Hujan";
          break;
      }
    });
  }

  // String getTimeStringFromDouble(double value) {
  //   if (value < 0) return 'Invalid Value';
  //   int flooredValue = value.floor();
  //   double decimalValue = value - flooredValue;
  //   String hourValue = getHourString(flooredValue);
  //   String minuteString = getMinuteString(decimalValue);

  //   return '$hourValue:$minuteString';
  // }

  // String getMinuteString(double decimalValue) {
  //   return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
  // }

  // String getHourString(int flooredValue) {
  //   return '${flooredValue % 24}'.padLeft(2, '0');
  // }
}

TextStyle boldTextStyle({
  int size = 16,
  Color color,
  FontWeight weight = FontWeight.bold,
  String fontFamily,
  double letterSpacing,
}) {
  return TextStyle(
    fontSize: size.toDouble(),
    color: color,
    fontWeight: weight,
    fontFamily: fontFamily,
    letterSpacing: letterSpacing,
  );
}
