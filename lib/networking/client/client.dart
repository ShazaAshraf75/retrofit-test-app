// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../models/responses/data.dart';
part 'client.g.dart';

@RestApi(baseUrl: "https://gorest.co.in/public/v2/")
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @GET("users")
  Future<List<User>> getUsers();

  @POST("users")
  Future<User> createUser(@Body() User user);
}
