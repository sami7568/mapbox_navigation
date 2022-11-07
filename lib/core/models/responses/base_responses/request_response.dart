class RequestResponse {
  late bool success;
  dynamic error;
  late Map<String, dynamic> data;

  RequestResponse(this.success, {this.error});

  RequestResponse.fromJson(json) {
    data = json;
    success = json['success'];
    error = json['error'];
  }

  toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    data['body'] = data;
    return data;
  }
}
