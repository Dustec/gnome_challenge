import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnome_challenge/app.dart';
import 'package:gnome_challenge/core/config/app_env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppEnv.load();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
