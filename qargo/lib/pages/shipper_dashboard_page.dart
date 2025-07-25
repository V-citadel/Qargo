import 'package:flutter/material.dart';
import 'shipment_repository.dart';
import 'bottom_nav_bar.dart';
import 'home_page.dart';
import 'settings_page.dart';

class ShipperDashboardPage extends StatefulWidget {
  const ShipperDashboardPage({Key? key}) : super(key: key);

  @override
  State<ShipperDashboardPage> createState() => _ShipperDashboardPageState();
}

class _ShipperDashboardPageState extends State<ShipperDashboardPage> {
  int _selectedIndex = 1;
  String _dashboardType = 'Shipper';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['initialTab'] != null) {
      _selectedIndex = args['initialTab'] as int;
    }
    if (args != null && args['dashboardType'] != null) {
      _dashboardType = args['dashboardType'] as String;
    }
  }

  Color get _appBarColor {
    switch (_selectedIndex) {
      case 0:
        return const Color(0xFF1CC6AE);
      case 1:
        return const Color(0xFF1976D2); // Blue for shipper dashboard
      case 2:
        return const Color(0xFF7B2FF2);
      case 3:
        return const Color(0xFFE94F37);
      default:
        return const Color(0xFF1CC6AE);
    }
  }

  String get _appBarTitle {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Shipper Dashboard';
      case 2:
        return 'Analytics';
      case 3:
        return 'Settings';
      default:
        return 'Qargo';
    }
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        final shipments = ShipmentRepository.instance.shipments;
        return Container(
          color: Colors.white,
          child: shipments.isEmpty
              ? Center(
                  child: Text(
                    'No shipments yet. Tap + to create your first shipment.',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: shipments.length,
                  itemBuilder: (context, index) {
                    final shipment = shipments[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.local_shipping, color: Color(0xFF1CC6AE)),
                                const SizedBox(width: 8),
                                Text(
                                  '${shipment['pickup']} → ${shipment['dropoff']}',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1CC6AE)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.date_range, size: 18, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(shipment['date'] ?? '', style: TextStyle(color: Colors.grey[700])),
                                const Spacer(),
                                _StatusChip(status: shipment['status'] ?? 'Pending'),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                style: TextButton.styleFrom(foregroundColor: Color(0xFF1CC6AE)),
                                onPressed: () {
                                  // TODO: Show shipment details
                                },
                                child: const Text('Details'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      case 2:
        return Center(child: Text('Analytics coming soon...', style: TextStyle(color: Colors.black54, fontSize: 18)));
      case 3:
        return const SettingsPage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(_appBarTitle, style: const TextStyle(color: Color(0xFF1CC6AE), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [],
      ),
      body: _buildBody(),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF1CC6AE),
              foregroundColor: Colors.white,
              onPressed: () async {
                await Navigator.pushNamed(context, '/truck-request');
                setState(() {}); // Refresh after returning
              },
              child: const Icon(Icons.add),
              tooltip: 'Create New Shipment',
            )
          : null,
      bottomNavigationBar: QargoBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});
  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'Pending':
        color = Colors.orange;
        break;
      case 'In Transit':
        color = Colors.blue;
        break;
      case 'Delivered':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }
} 