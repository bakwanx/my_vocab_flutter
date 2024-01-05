import 'package:utils_app/extension/safe_null_object.dart';
class ErrorExtra {
  final ErrorType errorType;
  final bool hardReset;

  ErrorExtra({required this.errorType, this.hardReset = false});

  factory ErrorExtra.fromExtras(Map<String, String> json) {
    return ErrorExtra(
      errorType: json['errorType'].orEmpty().toErrorType(),
      hardReset: json['hardReset']?.toLowerCase() == 'true',
    );
  }

  Map<String, String> toExtras() {
    return {
      'errorType': errorType.name,
      'hardReset': hardReset.toString(),
    };
  }

  @override
  bool operator ==(Object other) {
    return other is ErrorExtra && other.errorType == errorType;
  }

  @override
  int get hashCode {
    return errorType.hashCode;
  }


}

enum ErrorType {
  errorGeneral,
  errorMaintenance,
  errorConnection,
  errorLimitOtp
}

extension _ErrorTypeExtension on String {
  ErrorType toErrorType() {
    if (this == ErrorType.errorConnection.name) {
      return ErrorType.errorConnection;
    }
    if (this == ErrorType.errorGeneral.name) {
      return ErrorType.errorGeneral;
    }
    if (this == ErrorType.errorMaintenance.name) {
      return ErrorType.errorMaintenance;
    }
    return ErrorType.errorLimitOtp;
  }
}
