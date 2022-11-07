class DataResponse {
  Data? data;

  DataResponse({this.data});

  DataResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Users>? users;

  Data({this.users});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? name;
  List<Details>? details;

  Users({this.name, this.details});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? id;
  Null? status;
  String? legId;
  String? pickupDateTime;
  String? pickupAddress;
  String? details;
  String? pickupLatlong;
  String? dropoffAddress;
  String? dropoffLatlong;
  String? mileage;
  String? mdNumber;
  String? driverName;

  Details(
      {this.id,
      this.status,
      this.legId,
      this.pickupDateTime,
      this.pickupAddress,
      this.details,
      this.pickupLatlong,
      this.dropoffAddress,
      this.dropoffLatlong,
      this.mileage,
      this.mdNumber,
      this.driverName});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    legId = json['leg_id'];
    pickupDateTime = json['pickup_date_time'];
    pickupAddress = json['pickup_address'];
    details = json['details'];
    pickupLatlong = json['pickup_latlong'];
    dropoffAddress = json['dropoff_address'];
    dropoffLatlong = json['dropoff_latlong'];
    mileage = json['mileage'];
    mdNumber = json['md_number'];
    driverName = json['driver_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['leg_id'] = this.legId;
    data['pickup_date_time'] = this.pickupDateTime;
    data['pickup_address'] = this.pickupAddress;
    data['details'] = this.details;
    data['pickup_latlong'] = this.pickupLatlong;
    data['dropoff_address'] = this.dropoffAddress;
    data['dropoff_latlong'] = this.dropoffLatlong;
    data['mileage'] = this.mileage;
    data['md_number'] = this.mdNumber;
    data['driver_name'] = this.driverName;
    return data;
  }
}