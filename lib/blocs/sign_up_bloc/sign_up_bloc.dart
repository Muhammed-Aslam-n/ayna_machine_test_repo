import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';

import '../../core/validators.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
	final UserRepository _userRepository;

  SignUpBloc({
		required UserRepository userRepository
	}) : _userRepository = userRepository,
		super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
			emit(SignUpProcess());
			try {
        MyUser user = await _userRepository.signUp(event.user, event.password);
				await _userRepository.setUserData(user);
				emit(SignUpSuccess());
      } on FirebaseException catch (exc, stack) {
				debugPrint('ExceptionCaughtWhileUserLogin $exc\n $stack');
				final errorMessage = getErrorMessageFromErrorCode(exc.code);
				emit(SignUpFailure(errorMessage));
			}catch (e) {
				debugPrint('ExceptionCaughtWhileSigningUp $e');
				emit(const SignUpFailure('Something unexpected occurred!'));
      }
    });
  }
}
