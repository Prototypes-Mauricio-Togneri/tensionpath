import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tensionpath/environments/environment.dart';

abstract class Callable {
  final String name;

  const Callable(this.name);

  Future<HttpsCallableResult<T>> invoke<T>([dynamic parameters]) async {
    final HttpsCallable callable = _callable(name: name);

    return callable.call(parameters);
  }

  HttpsCallable _callable({
    required String name,
  }) {
    if (Environment.get.isLocal) {
      return CallableConfig.functions().httpsCallableFromUrl(
        'http://${Environment.get.host}:5001/tension-path/europe-west6/$name',
      );
    } else {
      return CallableConfig.functions().httpsCallable(name);
    }
  }
}

class CallableConfig {
  static FirebaseFunctions? _functions;

  static FirebaseFunctions functions() {
    if (_functions == null) {
      _functions = FirebaseFunctions.instanceFor(
        app: Firebase.app(),
        region: 'europe-west6',
      );

      if (Environment.get.isLocal) {
        _functions!.useFunctionsEmulator(Environment.get.host, 5001);
      }
    }

    return _functions!;
  }
}
