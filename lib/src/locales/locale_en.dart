import 'package:zod_validation/src/locales/i_locale.dart';

///
/// this is the class responsible for the english locale
/// it is responsible for returning the error messages in english
///
class LocaleEN implements ILocaleZod {
  @override
  String get email => 'Invalid email';

  @override
  String get phone => 'Invalid phone number';

  @override
  String type<T>() => 'The parameter must be of type ${T.toString()}';

  @override
  String min(int v) => 'At least $v characters';

  @override
  String max(int v) => 'At most $v characters';

  @override
  String get cnpj => 'Invalid CNPJ';

  @override
  String get cpf => 'Invalid CPF';

  @override
  String get cpfCnpj => 'Invalid CPF or CNPJ';

  @override
  String get isDate => 'The date entered is invalid';

  @override
  String get isMoney => 'Invalid value';

  @override
  String get required => 'Required field';

  @override
  String get password => 'Invalid password';

  @override
  String get custom => 'Invalid value';
}
