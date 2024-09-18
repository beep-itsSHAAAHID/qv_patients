import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qv_patient/controllers/auth_controller.dart';
import 'package:qv_patient/repository/auth_repository.dart';

// AuthRepository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// AuthController Provider (already defined in auth_controller.dart)
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthController(authRepository);
});
