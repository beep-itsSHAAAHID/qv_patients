import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qv_patient/provider/auth_provider.dart';
import 'package:qv_patient/repository/auth_repository.dart';

// Define a state for the authentication process
class AuthState {
  final bool isLoading;
  final User? user;
  final String? errorMessage;

  AuthState({
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// The AuthController manages the authentication process
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthController(this._authRepository) : super(AuthState());

  // Method to handle Google Sign-In
  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authRepository.signInWithGoogle();
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, errorMessage: 'Google Sign-In failed: $e');
    }
  }

  // Method to handle Facebook Sign-In (if implemented)
  Future<void> signInWithFacebook() async {
    // Implement similar logic for Facebook login
  }

  // Sign Out
  Future<void> signOut() async {
    await _authRepository.signOut();
    state = state.copyWith(user: null);
  }

  // Check current user
  User? getCurrentUser() {
    return _authRepository.getCurrentUser();
  }
}

// Provide the AuthController through Riverpod
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthController(authRepository);
});
