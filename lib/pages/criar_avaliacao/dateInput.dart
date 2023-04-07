import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ontrack_backoffice/controllers/criar_avaliacao/controllers.dart';
import 'package:ontrack_backoffice/static/colors.dart';

class DateTimeInput extends StatefulWidget {
  final DateTime? initialDateTime;

  const DateTimeInput({Key? key, this.initialDateTime}) : super(key: key);

  @override
  _DateTimeInputState createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = widget.initialDateTime ?? DateTime.now();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_dateTime),
      );
      if (time != null) {
        setState(() {
          _dateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    dataController = TextEditingController(text: formatter.format(_dateTime));
    return Container(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(text: 'Data e hora: '),
                TextSpan(text: '*', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          SizedBox(height: 10),
          TextField(
            readOnly: true,
            controller: dataController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black, fontSize: 20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4)
              ),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () => _selectDateTime(context),
          ),
        ],
      ),
    );
  }
}