abstract class AsyncUseCase<Type, Param> {
  Future<Type> call(Param param);
}

abstract class UseCase<Type, Param> {
  Type call(Param param);
}

class NoParam {}
