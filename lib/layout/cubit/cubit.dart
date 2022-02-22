// // ignore_for_file: avoid_print

// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:retrofit_test/layout/cubit/states.dart';

// import '../../networking/client/client.dart';
// import '../../networking/models/responses/data.dart';

// class RetrofitCubit extends Cubit<RetrofitStates> {
//   RetrofitCubit() : super(RetrofitInitialState());

//  dynamic user;
//   getData() {
//     emit(RetrofitLoadingHomeDataState());
//     var data = APIClient(Dio(BaseOptions(
//         contentType: "application/json",
//         baseUrl: "https://gorest.co.in/public/v2/")));
//     data.getUsers().then((value) {
//       user = User.fromJson(value);
//       emit(RetrofitSuccessHomeDataState());
//     }).catchError((error) {
//       print(error.toString());
//       emit(RetrofitErrorHomeDataState());
//     });
//   }
// }
