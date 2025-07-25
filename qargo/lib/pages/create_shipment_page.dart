import 'package:flutter/material.dart';
import 'shipment_repository.dart';

class CreateShipmentPage extends StatefulWidget {
  const CreateShipmentPage({Key? key}) : super(key: key);

  @override
  State<CreateShipmentPage> createState() => _CreateShipmentPageState();
}

class _CreateShipmentPageState extends State<CreateShipmentPage> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _dimensionsController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1CC6AE)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Create Shipment', style: TextStyle(color: Color(0xFF1CC6AE), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader('Locations'),
            const SizedBox(height: 8),
            _CustomTextField(
              controller: _pickupController,
              label: 'Pickup Location',
              icon: Icons.location_on_outlined,
              color: Color(0xFF1CC6AE),
            ),
            const SizedBox(height: 16),
            _CustomTextField(
              controller: _dropoffController,
              label: 'Drop-off Location',
              icon: Icons.flag_outlined,
              color: Color(0xFF1CC6AE),
            ),
            const SizedBox(height: 24),
            _SectionHeader('Load Details'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _CustomTextField(
                    controller: _weightController,
                    label: 'Weight (kg)',
                    icon: Icons.scale_outlined,
                    color: Color(0xFF1CC6AE),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CustomTextField(
                    controller: _typeController,
                    label: 'Type',
                    icon: Icons.category_outlined,
                    color: Color(0xFF1CC6AE),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _CustomTextField(
              controller: _dimensionsController,
              label: 'Dimensions (LxWxH, cm)',
              icon: Icons.straighten_outlined,
              color: Color(0xFF1CC6AE),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _detailsController,
              maxLines: 4,
              maxLength: 1000, // safeguard for long input
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.description_outlined, color: Color(0xFF1CC6AE)),
                hintText: 'Shipment Details (max 100 words)',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                counterText: '',
              ),
              onChanged: (value) {
                final words = value.trim().split(RegExp(r'\s+'));
                if (words.length > 100) {
                  final limited = words.take(100).join(' ');
                  _detailsController.text = limited;
                  _detailsController.selection = TextSelection.fromPosition(
                    TextPosition(offset: limited.length),
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            _SectionHeader('Schedule'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (picked != null) setState(() => _selectedDate = picked);
                    },
                    child: AbsorbPointer(
                      child: _CustomTextField(
                        controller: TextEditingController(
                          text: _selectedDate == null ? '' : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
                        ),
                        label: 'Preferred Date',
                        icon: Icons.date_range_outlined,
                        color: Color(0xFF1CC6AE),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) setState(() => _selectedTime = picked);
                    },
                    child: AbsorbPointer(
                      child: _CustomTextField(
                        controller: TextEditingController(
                          text: _selectedTime == null ? '' : _selectedTime!.format(context),
                        ),
                        label: 'Preferred Time',
                        icon: Icons.access_time_outlined,
                        color: Color(0xFF1CC6AE),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SectionHeader('Price Estimate'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_money, color: Color(0xFF1CC6AE)),
                  const SizedBox(width: 8),
                  Text('To be calculated', style: TextStyle(fontSize: 16, color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1CC6AE),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  final shipment = {
                    'pickup': _pickupController.text,
                    'dropoff': _dropoffController.text,
                    'weight': _weightController.text,
                    'type': _typeController.text,
                    'dimensions': _dimensionsController.text,
                    'details': _detailsController.text,
                    'date': _selectedDate == null ? '' : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
                    'time': _selectedTime == null ? '' : _selectedTime!.format(context),
                    'price': 'To be calculated',
                    'status': 'Pending',
                  };
                  ShipmentRepository.instance.addShipment(shipment);
                  Navigator.pushReplacementNamed(context, '/shipment-confirmation', arguments: shipment);
                },
                child: const Text('Post Shipment', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1CC6AE),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color color;
  const _CustomTextField({required this.controller, required this.label, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: color),
        hintText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
} 