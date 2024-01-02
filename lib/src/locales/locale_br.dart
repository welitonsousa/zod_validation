import 'package:zod_validation/src/locales/i_locale.dart';

///
/// this is the class responsible for the brazilian locale
/// it is responsible for returning the error messages in brazilian portuguese
///
class LocaleBR implements ILocaleZod {
  @override
  String get email => 'Email inválido';

  @override
  String get emails => 'Emails inválidos';

  @override
  String get equals => 'Valores diferentes';

  @override
  String get phone => 'Número de telefone inválido';

  @override
  String type<T>() => 'O parâmetro precisa ser do tipo ${T.toString()}';

  @override
  String min(int v) => 'No mínimo $v caracteres';

  @override
  String max(int v) => 'No máximo $v caracteres';

  @override
  String get cnpj => 'CNPJ inválido';

  @override
  String get cpf => 'CPF inválido';

  @override
  String get cpfCnpj => 'CPF ou CNPJ inválido';

  @override
  String get isDate => 'A data informada é inválida';

  @override
  String get isMoney => 'Valor inválido';

  @override
  String get required => 'Campo obrigatório';

  @override
  String get password => 'Senha inválida';

  @override
  String get custom => 'Valor inválido';
}
