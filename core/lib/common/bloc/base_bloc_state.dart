abstract class BaseBlocState {}

class LoadingState extends BaseBlocState {}

class FailureState extends BaseBlocState {
  String code;
  String message;

  FailureState(this.code, this.message);
}

class InitialState extends BaseBlocState {}

class SuccessState extends BaseBlocState {}