import 'package:flutter/material.dart';

class PriceEstimatePage extends StatelessWidget {
  final String pickup;
  final String destination;
  final String goodsType;
  final String truckSize;
  final void Function()? onConfirm;

  const PriceEstimatePage({
    Key? key,
    required this.pickup,
    required this.destination,
    required this.goodsType,
    required this.truckSize,
    this.onConfirm,
  }) : super(key: key);

  int _calculatePrice() {
    // Simple estimation logic for demo
    int base = 1500;
    int distance = pickup.length + destination.length; // Fake proxy for distance
    int truckMultiplier = 1;
    switch (truckSize) {
      case 'Small Van':
        truckMultiplier = 1;
        break;
      case 'Medium Truck':
        truckMultiplier = 2;
        break;
      case 'Large Truck':
        truckMultiplier = 3;
        break;
      case 'Container':
        truckMultiplier = 4;
        break;
      default:
        truckMultiplier = 1;
    }
    return base + (distance * 100) * truckMultiplier;
  }

  @override
  Widget build(BuildContext context) {
    final price = _calculatePrice();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1CC6AE),
        elevation: 0,
        title: const Text('Price Estimate', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            Text('Pickup: $pickup', style: TextStyle(fontSize: 16)),
            Text('Destination: $destination', style: TextStyle(fontSize: 16)),
            Text('Goods: $goodsType', style: TextStyle(fontSize: 16)),
            Text('Truck Size: $truckSize', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xFF1CC6AE).withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('Estimated Price', style: TextStyle(fontSize: 18, color: Color(0xFF1CC6AE), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text('Ksh $price', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF1CC6AE))),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1CC6AE),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onConfirm ?? () => Navigator.pop(context, price),
              child: const Text('Confirm & Request Truck', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
