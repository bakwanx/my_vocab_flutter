extension DoubleOrEmpty on double? {
  double orEmpty({double defaultValue = 0.0}) {
    return this ?? defaultValue;
  }
}

extension StringOrEmpty on String? {
  bool get isFilled => this != null && this!.isNotEmpty;

  bool get isNullOrEmpty => this == null || this!.isEmpty;

  String orEmpty({String defaultValue = ''}) {
    return this ?? defaultValue;
  }

  String orDefault(String defaultValue) {
    return isNullOrEmpty ? defaultValue : this!;
  }

  String? nullWhenEmpty() {
    return isNullOrEmpty ? null : this!;
  }

  List<String> toList() {
    return orEmpty().split(',');
  }
}

extension StringExtension on String {
  String get png => 'assets/images/$this.png';
}

extension BooleanOrEmpty on bool? {
  bool orEmpty({bool defaultValue = false}) {
    return this ?? defaultValue;
  }

  bool orFalse() => this ?? false;
}

extension IntegerOrEmpty on int? {
  int orEmpty({int defaultValue = 0}) {
    return this ?? defaultValue;
  }
}

extension ListOrEmpty<T> on List<T>? {
  List<T> orEmpty({List<T> defaultValue = const []}) {
    return this ?? defaultValue;
  }

  bool get isFilled => this != null && this!.isNotEmpty;
}

extension MapOrNull<KEY, ENTRY> on Map<KEY, ENTRY> {
  ENTRY? orNull(KEY key) {
    return containsKey(key) ? this[key] : null;
  }
}

extension SafeParse on String {
  int parseInt({int defaultValue = 0}) {
    return int.tryParse(this) ?? defaultValue;
  }

  double parseDouble({double defaultValue = 0}) {
    return double.tryParse(this) ?? defaultValue;
  }
}
