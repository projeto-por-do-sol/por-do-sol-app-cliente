import 'package:client_app/MyApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
Pacotes:
  * Material Icons: flutter pub add material_symbols_icons
  * go_router: flutter pub add go_router
  * Riverpod: flutter pub add flutter_riverpod
              flutter pub add riverpod_annotation
              flutter pub add dev:riverpod_generator
              flutter pub add dev:build_runner
*/

void main() {
  runApp(ProviderScope(child: const MyApp()));
}