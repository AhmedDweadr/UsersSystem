import 'package:get_it/get_it.dart';
import 'package:my_app/Fetures/Content/Data/ContentRepoImpl.dart';
import 'package:my_app/Fetures/Content/Data/DataSource.dart';
import 'package:my_app/Fetures/Content/Domain/ContentRepo.dart';
import 'package:my_app/Fetures/Content/Domain/Usecases/AddContentUserCase.dart';
import 'package:my_app/Fetures/Content/Domain/Usecases/deleteContentUseCase.dart';
import 'package:my_app/Fetures/Content/Domain/Usecases/updateContentusecase.dart';
import 'package:my_app/Fetures/Content/Presentarion/ContentCubit.dart';
import 'package:my_app/Fetures/Users/DataLayer/RemoteDataSource.dart';
import 'package:my_app/Fetures/Users/DataLayer/UserRepoImpl.dart';
import 'package:my_app/Fetures/Users/Domain/UseCases/AddUser.dart';
import 'package:my_app/Fetures/Users/Domain/UseCases/DeleteUser.dart';
import 'package:my_app/Fetures/Users/Domain/UseCases/GetAllUser.dart';
import 'package:my_app/Fetures/Content/Domain/Usecases/GetContentUsecase.dart';
import 'package:my_app/Fetures/Users/Domain/UserRepo.dart';
import 'package:my_app/Fetures/Users/Presentation/UserCubit/Cubit.dart';


final sl = GetIt.instance;

void setup() {





  // 1️⃣ DataSource
  sl.registerLazySingleton<UserDataSource>(() => UserDataSource());

  // 2️⃣ Repository
  sl.registerLazySingleton<Userrepo>(() => UserRepoImpl(userDataSource: sl()));

  // 3️⃣ UseCase
  sl.registerLazySingleton<GetalluseruserCase>(
    () => GetalluseruserCase(userrepo: sl()),
  );

  sl.registerLazySingleton<DeleteuserUsecase>(
    () => DeleteuserUsecase(userrepo: sl()),
  );




  sl.registerLazySingleton(() => AddUserUseCase(sl()));


  // 4 cubit

  sl.registerFactory<userCubit>(
    () => userCubit(
      getalluseruserCase: sl(),
      adduserUserCase: sl(),
      deleteuserUsecase: sl(),

      getcontentusecase: sl(),
    ),
  );

  // Content



// 1️⃣ DataSource

   sl.registerLazySingleton(
    () => ContentDataSource(),
  );

  // 2️⃣ Repository
  sl.registerLazySingleton<Contentrepo>(() => Contentrepoimpl(contentDataSource: sl()));

  /// UseCasea
   sl.registerLazySingleton(
    () => Getcontentusecase(contentrepo: sl()),

  );

sl.registerLazySingleton(
    () => Addcontentusercase(contentrepo: sl()),

  );



sl.registerLazySingleton(
    () => Updatecontentusecase(contentrepo: sl()),

  );


  sl.registerLazySingleton(
    () => Deletecontentusecase(contentrepo: sl()),

  );
// 4 cubit

  sl.registerFactory(() =>ContentCubit(getcontentusecase: sl(), addcontentusercase: sl(), updatecontentusecase: sl(), deletecontentusecase: sl()) );
}









