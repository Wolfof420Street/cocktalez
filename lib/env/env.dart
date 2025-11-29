import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
  static final String sentryDsn = _Env.sentryDsn;

  @EnviedField(varName: 'COCKTAIL_DB_KEY', obfuscate: true)
  static final String cocktailDbKey = _Env.cocktailDbKey;
}
