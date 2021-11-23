import 'package:hairdresser/data/models/Product.dart';
import 'package:hairdresser/data/models/time_slot.dart';

class Appointment{
  String? id;
  TimeSlot? timeSlot;
  Product? product;
  bool? atHome;
  String? status;

  Appointment({
    this.id,
    this.product,
    this.atHome,
    this.timeSlot,
    this.status
  });
}