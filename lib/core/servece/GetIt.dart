// import 'package:get_it/get_it.dart';
// import 'package:my_app/Fetures/user/Data/DataSource.dart';
// import 'package:my_app/Fetures/user/Data/UserreposotryImpl.dart';
// import 'package:my_app/Fetures/user/Presentation/cubit.dart';
// import 'package:my_app/Fetures/user/domain/userReposotry.dart';
// import 'package:my_app/Fetures/user/domain/useruseCase.dart';



// final sl = GetIt.instance;

// void setup() {
//   // 1️⃣ DataSource
//   sl.registerLazySingleton<userDatasource>(() => userDatasource());

//   // 2️⃣ Repository
//   sl.registerLazySingleton<UserRepository>(
//     () => Userreposotryimpl(sl<userDatasource>()),
//   );

//   // 3️⃣ UseCase
//   sl.registerLazySingleton<Userusecase>(
//     () => Userusecase(sl<UserRepository>()),
//   );

//   sl.registerFactory<UserCubit>(
//     () => UserCubit(sl<Userusecase>())
//   );

// }
