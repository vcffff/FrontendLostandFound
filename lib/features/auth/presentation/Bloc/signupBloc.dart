import 'package:bloc/bloc.dart';
import 'package:solaifrontend/features/auth/domain/repositories/user_repo.dart';
import 'package:solaifrontend/features/auth/presentation/Bloc/signupEvent.dart';
import 'package:solaifrontend/features/auth/presentation/Bloc/signupState.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  final UserRepository userRepository;
  AuthBloc(this.userRepository):super(InitialState()){
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLoginRequested>(_onLogin);
    on<AuthLogOut>(_onlogout);
  }
 Future<void> _onRegister(
      AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await userRepository.register(event.email, event.password);
    result.fold(
      (failure) => emit(AuthFailed(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

Future<void>_onLogin(AuthLoginRequested event,Emitter<AuthState>emit)async{
  emit(AuthLoading());
  final result=await userRepository.login(event.email,event.password);
  result.fold((failure)=>emit(AuthFailed(failure.message)), (success)=>emit(AuthSuccess(success)));
}

Future<void>_onlogout(AuthLogOut event,Emitter<AuthState> emit)async{
  emit(AuthLoading());
  final result=await userRepository.logout();
  result.fold((failure)=>emit(AuthFailed(failure.message)),(_)=>emit(Unauthenticated()));
}
}