import 'package:test/test.dart';
import 'package:zod_validation/src/zod_validation.dart';

void main() {
  group('A group of validations', () {
    test('check invalid param', () {
      final res = Zod.validate(
        params: {'user': Zod().required()},
        data: {},
      );
      expect(res.isNotValid, true);
    });

    test('check invalid param - locale en-us', () {
      final res = Zod.validate(
        params: {'user': Zod(localeEnum: Locale.en_US).required()},
        data: {},
      );
      expect(res.result['user'], 'Required field');
      expect(res.isNotValid, true);
    });

    test('check content response ', () {
      final res = Zod.validate(
        params: {'user': Zod().required()},
        data: {'user': ''},
      );
      expect(res.result['user'], TypeMatcher<String>());
    });

    test('check content response string', () {
      final res = Zod.validate(
        params: {'user': Zod().required()},
        data: {'user': ''},
      );
      expect(res.resultSTR.length, 1);
      expect(res.resultSTR, TypeMatcher<List<String>>());
      expect(res.resultSTR[0], contains('user'));
    });

    test('check content response ', () {
      final res = Zod.validate(
        params: {'user': Zod().required()},
        data: {'user': ''},
      );
      expect(res.result['user'], TypeMatcher<String>());
    });
  });
}
