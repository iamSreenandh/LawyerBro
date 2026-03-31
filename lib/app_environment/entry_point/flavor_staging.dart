import 'package:lawyer_bro/enum/environment_enum.dart';
import 'package:lawyer_bro/main.dart';

Future<void> main() async {
  await flavorMain(Environment.staging);
}