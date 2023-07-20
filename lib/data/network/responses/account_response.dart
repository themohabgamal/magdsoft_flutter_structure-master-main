class AccountResponse {
  AccountResponse({
    this.status,
    this.message,
    this.code,
  });

  AccountResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
  }
  num? status;
  String? message;
  String? code;
  AccountResponse copyWith({
    num? status,
    String? message,
    String? code,
  }) =>
      AccountResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        code: code ?? this.code,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['code'] = code;
    return map;
  }
}
