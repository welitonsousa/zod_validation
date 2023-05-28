import 'dart:math';

class Validations {
  /// verify email validate
  static bool isEmail(String? email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email?.trim() ?? '');
  }

  /// verify phone validate
  static bool isPhone(String? phone) {
    final number = (phone ?? "").replaceAll(RegExp(r'[^0-9]'), '');
    if (number.trim().length >= 10) return true;
    return false;
  }

  /// verify required validate
  static bool required(dynamic value) {
    if (value != null) {
      if (value is String) return value.trim().isNotEmpty;
      return true;
    }
    return false;
  }

  /// verify type validate
  static bool matchTypes<T>(v) {
    return v is T;
  }

  /// verify min validate
  static bool minCharacters(String? value, int min) {
    return (value?.trim().length ?? 0) >= min;
  }

  /// verify max validate
  static bool maxCharacters(String? value, int max) {
    return (value?.trim().length ?? 0) <= max;
  }

  static bool isValidPassword(
    String value, {
    required bool number,
    required bool special,
    required bool upper,
    required bool lower,
    required int minLength,
  }) {
    final hasNumber = RegExp(r"\d").hasMatch(value);
    final hasSpecialCharacters =
        RegExp(r"[!@#$%^&*(),.?:{}|<>]").hasMatch(value);
    final hasUpperCase = RegExp(r"[A-Z]").hasMatch(value);
    final hasLowerCase = RegExp(r"[a-z]").hasMatch(value);
    final hasMinLength = value.trim().length >= 8;

    if (number && !hasNumber) return false;
    if (special && !hasSpecialCharacters) return false;
    if (upper && !hasUpperCase) return false;
    if (lower && !hasLowerCase) return false;
    if (minLength > 0 && !hasMinLength) return false;

    return true;
  }

  /// verify cpf validate
  static bool validateCPF(String? value) {
    if (value == null || value == '123.456.789-09') return false;
    value = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (value.length != 11) return false;
    if (value.split('').every((e) => e == value![0])) return false;

    String n;
    n = value.substring(0, 9);
    n += _verifierDigit(n).toString();
    n += _verifierDigit(n).toString();

    return n.substring(n.length - 2) == value.substring(value.length - 2);
  }

  /// verify cnpj validate
  static bool validateCNPJ(String? value) {
    if (value == null) return false;
    value = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (value.length != 14) return false;
    if (value.split('').every((e) => e == value![0])) return false;

    String n;
    n = value.substring(0, 12);
    n += _verifierDigit(n).toString();
    n += _verifierDigit(n).toString();

    return n.substring(n.length - 2) == value.substring(value.length - 2);
  }

  /// verify money validate
  static bool money(String? v,
      {double min = 1, double? max, int decimalLength = 2}) {
    String formatted = (v ?? "").replaceAll(RegExp(r'\D'), '');
    double moneyValue = double.tryParse(formatted) ?? 0;
    double money = moneyValue / pow(10, decimalLength);

    return money >= min && (max == null || money <= max);
  }

  /// verify date validate
  static bool date(String? value, {DateTime? maxDate, DateTime? minDate}) {
    if (value?.trim().length != 10) return false;
    final str = value!.replaceAll(RegExp(r'[0-9]'), '');

    if (str.length != 2) return false;
    final special = str[0];
    final dateInt = value.split(special).map(int.parse).toList();
    final year = '${max(dateInt[0], dateInt[2])}'.padLeft(4, '0');
    final month = '${dateInt[1]}'.padLeft(2, '0');
    final day = '${min(dateInt[0], dateInt[2])}'.padLeft(2, '0');

    final date = DateTime.tryParse('$year$month$day');
    if (date == null) return false;

    final rangeMin = (minDate?.compareTo(date) ?? -2) >= 0;
    final rangeMax = (maxDate?.compareTo(date) ?? 2) <= 0;
    if (rangeMax && maxDate != null) return false;
    if (rangeMin && minDate != null) return false;

    return true;
  }

  static int _verifierDigit(String cpf) {
    final n = cpf.split('').map((n) => int.parse(n)).toList();
    final modulus = n.length + 1;
    final multi = <int>[];
    for (var i = 0; i < n.length; i++) {
      multi.add(n[i] * (modulus - i));
    }
    int mod = multi.reduce((a, b) => a + b) % 11;
    return (mod < 2 ? 0 : 11 - mod);
  }
}
