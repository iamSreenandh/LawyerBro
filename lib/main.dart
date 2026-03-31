import 'package:flutter/material.dart';
import 'package:lawyer_bro/app_environment/config/flavor_config.dart';
import 'package:lawyer_bro/enum/environment_enum.dart';
import 'package:lawyer_bro/lawyer_bro.dart';

Future<void> flavorMain(Environment environment) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    FlavorConfig(environment: environment); 
    await FlavorConfig.instance.init();
    runApp(LawyerBroApp());
  } catch (e) {
    throw Exception('Error initializing app: $e');
  }
}
