import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/enums.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class AddServiceScreen extends ConsumerStatefulWidget {
  const AddServiceScreen({super.key});

  @override
  ConsumerState<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends ConsumerState<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _destinationStart = '';
  var _destinationEnd = '';
  var _tripNote = '';
  TransportType _selected = TransportType.car;
  var _spotsAvailable = 1;

  final List<String> _restrictedItems = [
    "Pets",
    "Breaking Glass",
    "Flammable materials",
    "Alcohol",
  ];

  final List<String> _selectedRestrictedItems = [];

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
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
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
        _selectedRestrictedItems,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.read(languageProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.translate('addService'),
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
                  lang.translate('shareRouteHelpSomeone'),
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  lang.translate('transportType'),
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
                      lang.translate('car'),
                      Icons.directions_car_outlined,
                      TransportType.car,
                    ),
                    typeTile(
                      lang.translate('plane'),
                      Icons.flight_outlined,
                      TransportType.plane,
                    ),
                    typeTile(
                      lang.translate('ship'),
                      Icons.directions_boat_outlined,
                      TransportType.ship,
                    ),
                    typeTile(
                      lang.translate('truck'),
                      Icons.local_shipping_outlined,
                      TransportType.truck,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  lang.translate('route'),
                  style: TextStyle(
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  lang.translate('inputStartLocation'),
                  style: TextStyle(fontSize: context.sp(12)),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      lang.translate('e.gBelgrade'),
                      style: TextStyle(
                        fontSize: context.sp(14),
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
                      return lang.translate('inputNullError');
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _destinationStart = value!;
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  lang.translate('inputEndLocation'),
                  style: TextStyle(fontSize: context.sp(12)),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text(
                      lang.translate('e.gRotterdam'),
                      style: TextStyle(
                        fontSize: context.sp(14),
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
                      return lang.translate('inputNullError');
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _destinationEnd = value!;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  lang.translate('dateAndTime'),
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
                      lang.translate('selectDate'),
                      style: TextStyle(
                        fontSize: context.sp(14),
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
                      return lang.translate('inputNullError');
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
                      lang.translate('selectTime'),
                      style: TextStyle(
                        fontSize: context.sp(14),
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
                      return lang.translate('inputNullError');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  lang.translate('serviceDetails'),
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
                      lang.translate('writeAdditionalInformation'),
                      style: TextStyle(
                        fontSize: context.sp(14),
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return lang.translate('inputNullError');
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
                    Text(
                      'What you will NOT transport',
                      style: TextStyle(
                        fontSize: context.sp(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Opcionalno',
                        style: TextStyle(
                          fontSize: context.sp(11),
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in _restrictedItems)
                      GestureDetector(
                        onTap: () => setState(() {
                          _selectedRestrictedItems.contains(item)
                              ? _selectedRestrictedItems.remove(item)
                              : _selectedRestrictedItems.add(item);
                        }),
                        behavior: HitTestBehavior
                            .opaque, // bitno! da i prazan prostor bude klikljiv
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity.compact,
                              value: _selectedRestrictedItems.contains(item),
                              side: BorderSide(
                                color: AppColors.primary,
                                width: 1,
                              ),
                              onChanged: (checked) => setState(() {
                                checked == true
                                    ? _selectedRestrictedItems.add(item)
                                    : _selectedRestrictedItems.remove(item);
                              }),
                            ),
                            Text(
                              item,
                              style: TextStyle(fontSize: context.sp(14)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        lang.translate('freeSpace'),
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
                    lang.translate('publishService'),
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
