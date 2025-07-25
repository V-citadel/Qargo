import 'package:flutter/material.dart';

class ShipmentConfirmationPage extends StatelessWidget {
  const ShipmentConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shipment = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (shipment == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('No shipment details found.', style: TextStyle(color: Colors.black54)),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Color(0xFF1CC6AE), size: 80),
                const SizedBox(height: 24),
                Text(
                  'Shipment Posted!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1CC6AE),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your shipment has been successfully posted. Here are the details:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 32),
                _DetailRow(label: 'Pickup', value: shipment['pickup'] ?? ''),
                _DetailRow(label: 'Drop-off', value: shipment['dropoff'] ?? ''),
                _DetailRow(label: 'Weight', value: (shipment['weight'] ?? '') + ' kg'),
                _DetailRow(label: 'Type', value: shipment['type'] ?? ''),
                _DetailRow(label: 'Dimensions', value: (shipment['dimensions'] ?? '') + ' cm'),
                _DetailRow(label: 'Date', value: shipment['date'] ?? ''),
                _DetailRow(label: 'Time', value: shipment['time'] ?? ''),
                _DetailRow(label: 'Price', value: shipment['price'] ?? ''),
                if ((shipment['details'] ?? '').trim().isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Shipment Details:', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54)),
                        const SizedBox(height: 2),
                        Text(
                          (shipment['details'] as String).trim().split(RegExp(r'\s+')).take(100).join(' '),
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1CC6AE),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    child: const Text('Go to Dashboard', style: TextStyle(fontSize: 18)),
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label + ':', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }
} 