import 'package:ayna_machine_test/core/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
	final UserRepository _userRepository;
	
  SignInBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
		super(SignInInitial()) {
		on<SignInRequired>((event, emit) async {
			emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
				emit(SignInSuccess());
      } on FirebaseException catch (exc, stack) {
				debugPrint('ExceptionCaughtWhileUserLogin $exc\n $stack');
				final errorMessage = getErrorMessageFromErrorCode(exc.code);
				emit(SignInFailure(message: errorMessage));
			} catch (e) {
				emit(const SignInFailure());
      }
    });
		on<SignOutRequired>((event, emit) async {
			await _userRepository.logOut();
    });
  }
}
