import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class Callable {
  final String name;

  const Callable(this.name);

  Future<HttpsCallableResult<T>> invoke<T>([dynamic parameters]) async {
    final HttpsCallable callable = CallableConfig.functions.httpsCallable(name);

    return callable.call(parameters);
  }
}

class CallableConfig {
  static FirebaseFunctions? _functions;

  static FirebaseFunctions get functions {
    _functions ??= FirebaseFunctions.instanceFor(
      app: Firebase.app(),
      region: 'europe-west6',
    );

    return _functions!;
  }
}
