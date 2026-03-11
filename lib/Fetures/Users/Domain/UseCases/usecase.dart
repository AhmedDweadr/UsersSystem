abstract class UseCasewithparams<T, Params> {
  Future<T> call(Params params);
}
