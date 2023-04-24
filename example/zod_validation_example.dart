import 'package:zod_validation/zod_validation.dart';

void main() {
  final params = {
    'user': {
      'platform': Zod().required(),
      'data': {
        'id': Zod().type<int>(),
        'name': Zod().min(3).max(10),
        'email': Zod().email(),
        'phone': Zod().phone(),
      },
    }
  };

  /// the received params from the request
  final requestParams = <String, dynamic>{};

  final result = Zod.validate(params: params, data: requestParams);
  if (result.isNotValid) print(result.result);
}
