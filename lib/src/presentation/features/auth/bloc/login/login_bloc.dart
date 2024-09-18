import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:users_app/src/domain/usecase/login.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Login login;
  LoginBloc(this.login) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const LoginState.loading());
      var result = await login.execute(event.email, event.password);
      return result.fold(
        (l) {
          emit(LoginState.error(l));
        },
        (r) {
          emit(LoginState.loaded(r));
        },
      );
    });
  }
}
