class ErrorData {
  final int statusCode;
  final String errorMessage;

  ErrorData({
    this.statusCode,
    this.errorMessage,
  });

  factory ErrorData.fromJson(Map<String, dynamic> json, int statusCode) {
    return ErrorData(
      statusCode: statusCode,
      errorMessage: json['message'],

    );
  }
}
