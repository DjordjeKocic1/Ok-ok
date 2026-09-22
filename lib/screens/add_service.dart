import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/enums.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _destinationStart = '';
  var _destinationEnd = '';
  var _tripNote = '';
  TransportType _selected = TransportType.car;
  var _spotsAvailable = 1;

  DateTime? _date;
  TimeOfDay? _time;
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Widget typeTile(String label, IconData icon, TransportType value) {
    final selected = _selected == value;

    return GestureDetector(
      onTap: () => setState(() => _selected = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.mainColor : AppColors.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(child: Text(label, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _date = picked);
      _dateController.text = DateFormat('dd.MM.yyyy.').format(picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _time = picked);
      _timeController.text = DateFormat(
        'HH:mm',
      ).format(DateTime(0, 1, 1, picked.hour, picked.minute));
    }
  }

  void _onAddService() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final departure = DateTime(
        _date!.year,
        _date!.month,
        _date!.day,
        _time!.hour,
        _time!.minute,
      );

      final departureTime = DateFormat(
        "yyyy-MM-dd'T'HH:mm:ss",
      ).format(departure);

      print({
        departureTime,
        _selected,
        _destinationStart,
        _destinationEnd,
        _tripNote,
        _spotsAvailable,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dodaj uslugu',
          style: TextStyle(
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ScreenPadding(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Podeli svoju rutu i pomogni nekome da posalje paket',
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Tip transporta',
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 60,
                  ),
                  children: [
                    typeTile(
                      'Automobil',
                      Icons.directions_car_outlined,
                      TransportType.car,
                    ),
                    typeTile(
                      'Avion',
                      Icons.flight_outlined,
                      TransportType.plane,
                    ),
                    typeTile(
                      'Brod',
                      Icons.directions_boat_outlined,
                      TransportType.ship,
                    ),
                    typeTile(
                      'Kamion',
                      Icons.local_shipping_outlined,
                      TransportType.truck,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Ruta',
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Polazna lokacija',
                  style: TextStyle(fontSize: context.sp(12)),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      'npr. Beograd',
                      style: TextStyle(
                        fontSize: context.sp(12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.place_outlined,
                      size: context.w(20),
                      color: AppColors.primary,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ne može da bude prazno';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _destinationStart = value!;
                  },
                ),
                const SizedBox(height: 10),
                Text('Odrediste', style: TextStyle(fontSize: context.sp(12))),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      'npr. Rotterdam',
                      style: TextStyle(
                        fontSize: context.sp(12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.gps_fixed_outlined,
                      size: context.w(20),
                      color: AppColors.primary,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ne može da bude prazno';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _destinationEnd = value!;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Datum i vreme',
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: _pickDate,
                  decoration: InputDecoration(
                    label: Text(
                      'Izaberi datum',
                      style: TextStyle(
                        fontSize: context.sp(12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.primary,
                    ),
                    suffixIcon: Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ne može da bude prazno';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _timeController,
                  readOnly: true,
                  onTap: _pickTime,
                  decoration: InputDecoration(
                    label: Text(
                      'Izaberi vreme',
                      style: TextStyle(
                        fontSize: context.sp(12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.access_time,
                      color: AppColors.primary,
                    ),
                    suffixIcon: Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ne može da bude prazno';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Detalji usluge',
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 2,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    label: Text(
                      'Napisi dodatne informacije',
                      style: TextStyle(
                        fontSize: context.sp(12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ne može da bude prazno';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _tripNote = value!;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Slobodno mesta za paket(e)',
                        style: TextStyle(fontSize: context.sp(14)),
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: _spotsAvailable > 1
                          ? () => setState(() => _spotsAvailable--)
                          : null,
                      icon: const Icon(Icons.remove),
                      color: AppColors.primary,
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        '$_spotsAvailable',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.sp(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: _spotsAvailable < 20
                          ? () => setState(() => _spotsAvailable++)
                          : null,
                      icon: const Icon(Icons.add),
                      color: AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _onAddService,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: context.h(10)),
                  ),
                  child: Text(
                    'Objavi uslugu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
