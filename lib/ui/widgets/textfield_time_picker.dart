part of 'widgets.dart';

class TextFieldTimePicker extends StatefulWidget {
  final ValueChanged<TimeOfDay> onDateChanged;
  final FocusNode focusNode;
  final TimeOfDay initialTime;
  final String labelText;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final double prevTime;

  TextFieldTimePicker({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    @required this.onDateChanged,
    @required this.initialTime,
    this.prevTime,
  })  : assert(onDateChanged != null, 'selectedTime must not be null'),
        super(key: key);

  @override
  _TextFieldTimePickerState createState() => _TextFieldTimePickerState();
}

class _TextFieldTimePickerState extends State<TextFieldTimePicker> {
  TextEditingController _controllerTime;
  TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;

    _controllerTime = TextEditingController();
    _controllerTime.text = _selectedTime.format(context);
    widget.onDateChanged(_selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: _controllerTime,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
      ),
      onTap: () => _selectTime(context),
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controllerTime.dispose();
    super.dispose();
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (pickedTime != null) {
      if ((widget.prevTime != null)) {
        double resultTime =
            (pickedTime.hour + pickedTime.minute / 60.0) - widget.prevTime;
        if (resultTime < 0) {
          Flushbar(
            duration: Duration(milliseconds: 1500),
            flushbarPosition: FlushbarPosition.TOP,
            message: "Masukkan waktu dengan benar!",
            backgroundColor: Color(0xFFFF5C83),
          ).show(context);
        } else {
          _selectedTime = pickedTime;
          _controllerTime.text = _selectedTime.format(context);
          widget.onDateChanged(_selectedTime);
        }
      } else {
        _selectedTime = pickedTime;
        _controllerTime.text = _selectedTime.format(context);
        widget.onDateChanged(_selectedTime);
      }
      // if (resultTime < 0) {
      //   Flushbar(
      //     duration: Duration(milliseconds: 1500),
      //     flushbarPosition: FlushbarPosition.TOP,
      //     message: "Please fill all the fields",
      //     backgroundColor: Color(0xFFFF5C83),
      //   ).show(context);
      // } else {
      //   _selectedTime = pickedTime;
      //   _controllerTime.text = _selectedTime.format(context);
      //   widget.onDateChanged(_selectedTime);
      // }
    }

    if (widget.focusNode != null) {
      widget.focusNode.nextFocus();
    }
  }
}
