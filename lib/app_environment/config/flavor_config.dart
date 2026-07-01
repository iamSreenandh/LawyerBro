import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:lawyer_bro/enum/environment_enum.dart';
import 'package:lawyer_bro/firebase_options_dev.dart' as dev;
import 'package:lawyer_bro/firebase_options_prod.dart' as prod;
class FlavorConfig {
  Environment environment;

  static FlavorConfig? _instance;

  FlavorConfig._({required this.environment});

  factory FlavorConfig({required Environment environment}) {
    return _instance ??= FlavorConfig._(environment: environment);
  }

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig not initialized');
    }
    return _instance!;
  }

  Future<void> init() async {
    switch (environment) {
      case Environment.development:
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          options: dev.DefaultFirebaseOptions.currentPlatform,
        );
        break;
      case Environment.staging:
        break;
      case Environment.production:
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          options: prod.DefaultFirebaseOptions.currentPlatform,
        );
        break;
    }
  }
}
