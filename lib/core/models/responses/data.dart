class Data{

  List<Legs>? legs;

  Data.fromJson(Map<String,dynamic> json){
    
  }
}

class Legs{
  dynamic status;
  int? legId;
  DateTime? pickupDate;
  String? pickupAddress;
  String? detail;
  String? pickupLatLng;
  String? dropOffAddress;
  String? dropOffLatLng;
  double? mileage;
  String? mdNumber;
  String? driverName;

  Legs.fromJson(Map<String,dynamic> json){
    status = json['status'];
    legId = json['leg_id'];
    pickupDate = json['pickup_date_time'];
    pickupAddress = json['pickup_address'];
    detail = json['details'];
    pickupLatLng = json['pickup_latlong'];
    dropOffAddress = json['dropoff_address'];
    dropOffLatLng = json['dropoff_latlong'];
    mileage = json['mileage'];
    mdNumber = json['md_number'];
    driverName = json['driver_name'];
  }
}