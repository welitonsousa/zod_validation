import 'package:test/test.dart';
import 'package:zod_validation/src/locales/locale_en.dart';
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
        params: {'user': Zod(localeZod: LocaleEN()).required()},
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
    test('check option with phone -> null value', () {
      final res = Zod.validate(
        params: {'phone': Zod().optional().phone()},
        data: {'phone': null},
      );
      expect(res.isValid, true);
    });
    test('check option with phone -> invalid phone', () {
      final res = Zod.validate(
        params: {'phone': Zod().optional().phone()},
        data: {'phone': '123'},
      );
      expect(res.isValid, false);
    });
    test('check option with phone -> valid phone', () {
      final res = Zod.validate(
        params: {'phone': Zod().optional().phone()},
        data: {'phone': '89988187280'},
      );
      expect(res.isValid, true);
    });
    test('check custom validation -> valid param', () {
      final res = Zod.validate(
        params: {
          'platform': Zod().type<String>().custom((v) {
            return (v == 'web' || v == 'mobile');
          })
        },
        data: {'platform': 'web'},
      );
      expect(res.isValid, true);
    });
    test('check custom validation -> invalid param', () {
      final res = Zod.validate(
        params: {
          'platform': Zod().type<String>().custom((v) {
            return (v == 'web' || v == 'mobile');
          })
        },
        data: {'platform': 'desktop'},
      );
      expect(res.isValid, false);
    });
  });
}
