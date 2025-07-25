import 'package:flutter/material.dart';
import 'shipment_repository.dart';
import 'price_estimate_page.dart';

class TruckRequestPage extends StatefulWidget {
  const TruckRequestPage({Key? key}) : super(key: key);

  @override
  State<TruckRequestPage> createState() => _TruckRequestPageState();
}

class _TruckRequestPageState extends State<TruckRequestPage> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _goodsTypeController = TextEditingController();
  String? _selectedTruckSize;

  final List<String> _truckSizes = [
    'Small Van',
    'Medium Truck',
    'Large Truck',
    'Container',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1CC6AE),
        elevation: 0,
        title: const Text('Request a Truck', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: _pickupController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on, color: Color(0xFF1CC6AE)),
                  hintText: 'Pickup Location',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _destinationController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.flag, color: Color(0xFF1CC6AE)),
                  hintText: 'Destination',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _goodsTypeController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.inventory_2, color: Color(0xFF1CC6AE)),
                  hintText: 'Type of Goods',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedTruckSize,
                items: _truckSizes
                    .map((size) => DropdownMenuItem(
                          value: size,
                          child: Text(size),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTruckSize = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.local_shipping, color: Color(0xFF1CC6AE)),
                  hintText: 'Truck Size',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1CC6AE),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    final pickup = _pickupController.text.trim();
                    final destination = _destinationController.text.trim();
                    final goodsType = _goodsTypeController.text.trim();
                    final truckSize = _selectedTruckSize ?? '';
                    if (pickup.isEmpty || destination.isEmpty || goodsType.isEmpty || truckSize.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields.')),
                      );
                      return;
                    }
                    // Show price estimate page before saving
                    final price = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PriceEstimatePage(
                          pickup: pickup,
                          destination: destination,
                          goodsType: goodsType,
                          truckSize: truckSize,
                        ),
                      ),
                    );
                    if (price != null) {
                      final shipment = {
                        'pickup': pickup,
                        'dropoff': destination,
                        'goodsType': goodsType,
                        'truckSize': truckSize,
                        'date': DateTime.now().toString().substring(0, 16),
                        'status': 'Pending',
                        'price': price,
                      };
                      ShipmentRepository.instance.addShipment(shipment);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: const Text('Request Submitted', style: TextStyle(color: Color(0xFF1CC6AE))),
                          content: const Text('Your truck request has been submitted successfully!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK', style: TextStyle(color: Color(0xFF1CC6AE), fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Submit Request', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
