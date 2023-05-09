import 'dart:developer';

class Handler {
  static catchError({required Object exception, String methodName = ''}) {
    log('$exception', name: methodName);
  }
}
