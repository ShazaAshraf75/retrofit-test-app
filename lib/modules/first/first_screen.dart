// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_test/networking/models/responses/data.dart';
import '../../networking/client/client.dart';
import '../../themes/themes.dart';

String token =
    "60da208f74e9eceedeaca82f8550923594bc23a561c0759c97e0de6d16c537be";

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  // var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: _appBarTheme(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                            child: _customTextField(
                                labelName: "Full Name",
                                controller: nameController))),
                    Expanded(
                        child: SizedBox(
                            child: _customTextField(
                                labelName: "Email Address",
                                controller: emailController))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                          child: _customTextField(
                              labelName: "Gender",
                              controller: genderController)),
                    ),
                    Expanded(
                        child: SizedBox(
                            child: _customTextField(
                                labelName: "Status",
                                controller: statusController))),
                  ],
                ),
                _customButton(
                    labelName: "Create User",
                    function: () {
                      Dio dio = Dio();
                      dio.options.headers = {
                        "Authorization": "Bearer $token",
                        "Content-Type": "application/json"
                      };
                      var client = APIClient(dio);
                      var user = User(
                          id: 0,
                          name: nameController.text,
                          email: emailController.text,
                          gender: genderController.text,
                          status: statusController.text);

                      client
                          .createUser(user)
                          .then((value) => print(value.toJson().toString()));
                      setState(() {});
                    }),
                Expanded(child: _buildBody(context)),
              ],
            ),
          ),
        ));
  }
}

FutureBuilder<List<User>> _buildBody(BuildContext context) {
  Dio dio = Dio();
  dio.options.headers = {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json"
  };
  var client = APIClient(dio);

  return FutureBuilder<List<User>>(
    future: client.getUsers(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final data = snapshot.data;
        if (data != null) {
          return _buildPosts(context, data);
        } else {
          return Container(
            color: gradientColor4,
          );
        }
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: gradientColor2,
          ),
        );
      }
    },
  );
}

Widget _buildPosts(BuildContext context, List<User> user) {
  return ListView.builder(
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 1,
        margin: EdgeInsets.symmetric(vertical: 3),
        child: ListTile(
          leading: Icon(
            Icons.person_pin,
            color: gradientColor2,
            size: 50,
          ),
          title: Text(
            user[index].name!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            user[index].email!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
          isThreeLine: false,
          trailing: Text(user[index].id.toString()),
        ),
      );
    },
    itemCount: user.length,
  );
}

AppBar _appBarTheme() => AppBar(
      title: Text("Home Screen"),
      elevation: 1,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              gradientColor3!,
              gradientColor2!,
              gradientColor2!,
              gradientColor1!,
            ])),
      ),
    );

Widget _customTextField({
  required String labelName,
  required TextEditingController controller,
}) =>
    SizedBox(
      height: 50,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: TextFormField(
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return "Error";
          //   }
          //   return null;
          // },
          style: TextStyle(color: gradientColor2, fontSize: 12),
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              label: Text(
                labelName,
                style: TextStyle(
                  color: gradientColor2,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              fillColor: gradientColor4,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: gradientColor4!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: gradientColor2!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: gradientColor4!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              )),
        ),
      ),
    );

Widget _customButton({
  required Function function,
  required String labelName,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: gradientColor2, borderRadius: BorderRadius.circular(30)),
        child: MaterialButton(
          textColor: Colors.white,
          child: Text(labelName),
          onPressed: () {
            function();
          },
        ),
      ),
    );
