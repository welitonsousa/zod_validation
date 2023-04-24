import 'package:test/test.dart';
import 'package:zod_validation/src/locales/i_locale.dart';
import 'package:zod_validation/src/locales/locale_en.dart';

void main() {
  group('locale en-us test', () {
    ILocaleZod locale = LocaleEN();
    test('required', () {
      expect(locale.required, TypeMatcher<String>());
    });
    test('cnpj', () {
      expect(locale.cnpj, TypeMatcher<String>());
    });
    test('cpf', () {
      expect(locale.cpf, TypeMatcher<String>());
    });
    test('cpfCnpj', () {
      expect(locale.cpfCnpj, TypeMatcher<String>());
    });
    test('email', () {
      expect(locale.email, TypeMatcher<String>());
    });
    test('isDate', () {
      expect(locale.isDate, TypeMatcher<String>());
    });
    test('isMoney', () {
      expect(locale.isMoney, TypeMatcher<String>());
    });
    test('password', () {
      expect(locale.password, TypeMatcher<String>());
    });
    test('phone', () {
      expect(locale.phone, TypeMatcher<String>());
    });
    test('max', () {
      expect(locale.max(2), TypeMatcher<String>());
    });
    test('min', () {
      expect(locale.min(2), TypeMatcher<String>());
    });
    test('type', () {
      expect(locale.type<int>(), TypeMatcher<String>());
    });
  });
}
