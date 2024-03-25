
# Zod


### Usage with Flutter
```dart
TextFormField(
  validator: Zod().required().min(3).email().build,
)
```


### All Validations
```dart
password
email
isEmails
min
max
equals
type<T>
required
cpf
cpnj
cpfCnpj
isDate
optional
custom
```

<hr>

## Usage with Shelf 


```dart
// register user route

@Route.post('/register')
Future<Response> register (Request req) async {
  final data = jsonDecode(await req.readAsString());
  
  final requiredParams = {
    'email': Zod().email(),
    'password': Zod().password(),
    'data': {
      'user_name': Zod().min(8).max(20)
      'platform': Zod().type<String>(),
    },
  };

  final zod = Zod.validate(data: data, params: requiredParams);
  if (zod.isNotValid) {
    return Response(400, body: jsonEncode({
      'message': 'invalid params',
      'params': zod.result
    }))
  }

  // zod.result is a Map that contains the invalid parameters key, and a message
  
  // example: 
  // {
  //    'data': {
  //      'user_name': 'At least 8 characters'
  //    }
  // }

  ...
}

```

<hr>

### How change locale
```dart
Zod(localeZod: LocaleEN()).required().build,

// or

Zod.zodLocaleInstance = LocaleEN() // apply in all system
```


### Create your Locale
```dart
class MyLocale implements ILocaleZod {
  // implement the required methods in ILocaleZod
}

Zod(localeZod: MyLocale()).required().build
```


<br>
<p align="center">
   Feito com ❤️ by <a target="_blank" href="https://welitonsousa.shop"><b>Weliton Sousa</b></a>
</p>
