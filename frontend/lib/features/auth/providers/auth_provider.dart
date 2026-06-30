import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth_request.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

// A simple state class to hold the authenticated user
class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(secureStorageProvider),
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final FlutterSecureStorage _storage;

  AuthNotifier(this._repository, this._storage) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final token = await _storage.read(key: 'jwt_token');
      if (token != null) {
        // Ideally, we would fetch the user profile here using the token
        // For now, we just assume they are authenticated if the token exists.
        // We will mock the user model here since we don't have a /me endpoint yet,
        // or we can just leave it as null but set a flag. Let's just create a dummy user
        // to pass the state checks if they have a token.
        state = state.copyWith(
          user: const UserModel(
            id: 0,
            firstName: 'Current',
            lastName: 'User',
            email: 'user@startupconnect.com',
            role: 'STUDENT',
          ),
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final response = await _repository.login(LoginRequest(email: email, password: password));
      await _storage.write(key: 'jwt_token', value: response.token);
      
      state = state.copyWith(user: response.user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }

  Future<bool> register(RegisterRequest request) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final response = await _repository.register(request);
      await _storage.write(key: 'jwt_token', value: response.token);
      
      state = state.copyWith(user: response.user, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
    state = AuthState(); // Reset to initial empty state
  }
}
