import 'package:zod_validation/src/locales/i_locale.dart';
import 'package:zod_validation/src/models/validade_model.dart';
import 'package:zod_validation/src/validations.dart';

import 'locales/locale_br.dart';
export 'package:zod_validation/src/locales/enum_locale.dart';

/// type of return of the validation
typedef CallBack = String? Function(dynamic value);

/// this is the main class of the package
/// it is responsible for validating the data
/// and returning the error message
class Zod {
  /// this is the default locale
  static ILocaleZod zodLocaleInstance = LocaleBR();

  /// parameter responsible for receiving the locale
  ///
  /// ```dart
  /// localeZod: Zod(localeZod: LocaleEN())
  /// ```
  final ILocaleZod? localeZod;

  /// list of validations
  final List<CallBack> _validations = [];

  ILocaleZod get _zod => localeZod ?? zodLocaleInstance;

  Zod({this.localeZod});

  /// this method is responsible for email validation
  Zod email([String? message]) {
    return _add((v) {
      return Validations.isEmail(v) ? null : message ?? _zod.email;
    });
  }

  /// this method is responsible for phone validation
  Zod phone([String? message]) {
    return _add((v) {
      return Validations.isPhone(v) ? null : message ?? _zod.phone;
    });
  }

  /// this method is responsible for password validation
  ///
  /// number = true
  /// special = true
  /// upper = true
  /// lower = true
  /// minLength = 8
  Zod password({
    String? message,
    bool number = true,
    bool special = true,
    bool upper = true,
    bool lower = true,
    int minLength = 8,
  }) {
    return _add((v) {
      return Validations.isValidPassword(v,
              lower: lower,
              minLength: minLength,
              number: number,
              special: special,
              upper: upper)
          ? null
          : message ?? _zod.password;
    });
  }

  /// this method is responsible for type validation
  ///
  /// example:
  /// ```dart
  /// Zod().type<int>()
  /// ```
  ///
  Zod type<T>([String? message]) {
    return _add((v) {
      return Validations.matchTypes<T>(v) ? null : message ?? _zod.type<T>();
    });
  }

  /// verify emails validate separated by comma
  /// example: email1@gmail,com,email2@gmail,com
  Zod isEmails([String? message]) {
    return _add((v) {
      return Validations.required(v) ? null : message ?? _zod.emails;
    });
  }

  /// verify equals validate
  Zod equals(value, [String? message]) {
    return _add((v) {
      return Validations.equals(value, v) ? null : message ?? _zod.equals;
    });
  }

  /// this method is responsible for validation if the param existe
  Zod required([String? message]) {
    return _add((v) {
      return Validations.required(v) ? null : message ?? _zod.required;
    });
  }

  /// this method is responsible for min validation
  Zod min(int min, [String? message]) {
    return _add((v) {
      return Validations.minCharacters(v, min)
          ? null
          : message ?? _zod.min(min);
    });
  }

  /// this method is responsible for max validation
  Zod max(int max, [String? message]) {
    return _add((v) {
      return Validations.maxCharacters(v, max)
          ? null
          : message ?? _zod.max(max);
    });
  }

  /// this method is responsible for cpf validation
  Zod cpf([String? message]) {
    return _add((v) {
      return Validations.validateCPF(v) ? null : message ?? _zod.cpf;
    });
  }

  /// this method is responsible for cnpj validation
  Zod cnpj([String? message]) {
    return _add((v) {
      return Validations.validateCNPJ(v) ? null : message ?? _zod.cnpj;
    });
  }

  Zod cpfCnpj([String? message]) {
    return _add((v) {
      return Validations.validateCPF(v) || Validations.validateCNPJ(v)
          ? null
          : message ?? _zod.cpfCnpj;
    });
  }

  Zod isDate(String? message, {DateTime? max, DateTime? min}) {
    return _add((v) {
      return Validations.date(v, maxDate: max, minDate: min)
          ? null
          : message ?? _zod.isDate;
    });
  }

  Zod optional({bool isValidWhenEmpty = true}) {
    return _add((v) {
      if (v == null) return 'opt';
      if (isValidWhenEmpty && v is String && v.isEmpty) return 'opt';
      return null;
    });
  }

  Zod custom(bool Function(dynamic) validate, {String? errorMessage}) {
    return _add((v) {
      if (validate(v)) return null;
      return errorMessage ?? _zod.custom;
    });
  }

  Zod _add(CallBack validator) {
    _validations.add(validator);
    return this;
  }

  String? build(dynamic value) {
    for (var validate in _validations) {
      final result = validate(value);
      if (result != null) {
        if (result == 'opt') return null;
        return result;
      }
    }
    return null;
  }

  ///
  /// The return id a Map<String, dynamic> with the errors
  /// or
  /// The return id a List<String> with the errors
  ///
  static ValidateModel validate({
    required Map<String, dynamic> data,
    required Map<String, dynamic> params,
    bool returnString = false,
  }) {
    final str = _validateString(data: data, params: params);
    final map = _validateMapping(data: data, params: params);
    return ValidateModel(isValid: map.isEmpty, resultSTR: str, result: map);
  }

  static List<String> _validateString({
    required Map<String, dynamic> data,
    required Map<String, dynamic> params,
  }) {
    final errors = <String>[];

    params.forEach((key, value) {
      if (value is Zod) {
        final valid = value.build(data[key] ?? '');
        if (valid != null) errors.add('$key: $valid');
      } else if (value is Map) {
        final res = _validateString(
          data: data[key] ?? {},
          params: value as Map<String, dynamic>,
        );
        res.forEach((e) => errors.add('$key.$e'));
      }
    });
    return errors;
  }

  static Map<String, dynamic> _validateMapping({
    required Map<String, dynamic> data,
    required Map<String, dynamic> params,
  }) {
    final errors = <String, dynamic>{};

    params.forEach((key, value) {
      if (value is Zod) {
        final valid = value.build(data[key] ?? '');
        if (valid != null) errors.addAll({key: valid});
      } else if (value is Map) {
        final res = _validateMapping(
          data: data[key] ?? {},
          params: value as Map<String, dynamic>,
        );
        if (res.isNotEmpty) errors.addAll({key: res});
      }
    });
    return errors;
  }
}
