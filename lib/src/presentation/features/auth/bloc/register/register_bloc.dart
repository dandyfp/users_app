import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:users_app/src/domain/usecase/register.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  Register register;
  RegisterBloc(this.register) : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const RegisterState.loading());
      var result = await register.execute(
        email: event.email,
        password: event.password,
        username: event.username,
      );

      return result.fold(
        (l) {
          emit(RegisterState.error(l));
        },
        (r) {
          emit(RegisterState.loaded(r));
        },
      );
    });
  }
}
