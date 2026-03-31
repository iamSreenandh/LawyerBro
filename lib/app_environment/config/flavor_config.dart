import 'package:lawyer_bro/enum/environment_enum.dart';

class FlavorConfig {
  Environment environment;

  static FlavorConfig? _instance;
  

  FlavorConfig._({required this.environment});

  factory FlavorConfig({required Environment environment}){
    return _instance ??= FlavorConfig._(environment: environment);
  }

  static FlavorConfig get instance {
    if(_instance == null){
      throw Exception('FlavorConfig not initialized');
    }
    return _instance!;
  }

  static bool get isDevelopment => instance.environment == Environment.development;
  static bool get isStaging => instance.environment == Environment.staging;
  static bool get isProduction => instance.environment == Environment.production;

  
}
