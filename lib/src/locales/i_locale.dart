///
/// Interface for all locales
///
/// example:
/// ```dart
/// class LocaleBR implements ILocaleZod {
///   @override
///   String get email => 'Email inválido';
///
///   ...
/// }
///
/// ```
///
abstract class ILocaleZod {
  String get email;
  String get phone;
  String get required;
  String get isMoney;
  String get cpf;
  String get cnpj;
  String get isDate;
  String get cpfCnpj;
  String get password;
  String get custom;
  String min(int v);
  String max(int v);
  String type<T>();
}
