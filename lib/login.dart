import 'package:final_proj_todo/function.dart';
import 'package:final_proj_todo/home.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    String hardcodedUsername = "user";
    String hardcodedPassword = "Password";

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      // ignore: prefer_const_literals_to_create_immutables
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwu-PoDKsazxzc3IUxcx17ZpOy0EARw7M60Q&s",
            width: 150,
            height: 70,
          ),
          // SizedBox(height: 50,),    
          Padding(
            padding: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), label: Text("Username")),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: TextField(
              obscureText: passwordVisible,
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                label: Text("Password"),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility_off 
                      : Icons.visibility,
                      semanticLabel: passwordVisible ? 'hide password' : 'show password',),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
                alignLabelWithHint: false,
                //filled: true,
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: MaterialButton(
              color: Color.fromARGB(255, 143, 189, 70),
              onPressed: () async{
                if (hardcodedUsername == usernameController.text &&
                    hardcodedPassword == passwordController.text) {
                  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 3),
                  // content: Row(
                  //   children: const [
                  //     Icon(Icons.check),
                  //     Text("Logged In Successfully"),
                  //   ],
                  // ),
                  // ));
                  await storingDatatoPreff(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>Firstpage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 3),
                    content: Row(
                      children: const [
                        Icon(Icons.warning),
                        Text("Invalid Credentials !"),
                      ],
                    ),
                  ));
                }
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              height: 50,
              minWidth: 200,
            ),
          ),
        ],
      ),
    );
  }


}