import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipehut/data/repositories/auth_repository.dart';
import 'package:recipehut/services/storage_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;
  final StorageService storage;

  AuthBloc({required this.authRepo, required this.storage})
      : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepo.login(event.email, event.password);
        await storage.saveToken(user.token);
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
    on<SignupRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepo.signup(event.userName, event.email, event.password);

        final user = await authRepo.login(event.email, event.password);
        await storage.saveToken(user.token);
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await storage.clearToken();
      emit(AuthInitial());
    });
  }
}
