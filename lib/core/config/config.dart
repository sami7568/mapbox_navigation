import '../enums/env.dart';

class Config {
  final Env _env;
  final String _devBaseUrl = 'http://192.168.18.5:3001';
  final String _testBaseUrl = 'http://192.168.18.5:3001';
  final String _productionBaseUrl = '';
  late String _baseUrl;

  /// Getters
  Env get env => _env;
  String get baseUrl => _baseUrl;

  /// Constructor
  Config(this._env) {
    _setupBaseUrl();
  }

  _setupBaseUrl() {
    if (_env == Env.production) {
      _baseUrl = _productionBaseUrl;
    } else if (_env == Env.test) {
      _baseUrl = _testBaseUrl;
    } else if (_env == Env.dev) {
      _baseUrl = _devBaseUrl;
    }
  }
}
