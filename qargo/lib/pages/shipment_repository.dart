class ShipmentRepository {
  ShipmentRepository._privateConstructor();
  static final ShipmentRepository instance = ShipmentRepository._privateConstructor();

  final List<Map<String, dynamic>> shipments = [];

  void addShipment(Map<String, dynamic> shipment) {
    shipments.add(shipment);
  }
} 