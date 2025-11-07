import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_task/features/auth/domain/entities/github_user_entity.dart';
import 'package:github_task/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());

  final AuthRepository authRepository;

  Future<void> loginWithGithubUsername({required String username}) async {
    emit(AuthLoading());

    final result =
        await authRepository.loginWithGithubUsername(username: username);

    result.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (githubUser) => emit(AuthSuccess(githubUser: githubUser)),
    );
  }
}
