import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'signup_event.dart';
part 'signup_state.dart';



class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<SignupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
