import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_chat/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:group_chat/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:group_chat/features/presentation/widgets/common.dart';
import 'package:group_chat/features/presentation/widgets/theme/style.dart';
import '../../../page_const.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isShowPassword=true;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: BlocConsumer<CredentialCubit,CredentialState>(
        listener: (context,credentialState){
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure){
            snackBarNetwork(msg: "wrong email please check",scaffoldState: _scaffoldState);
          }
        },
        builder: (context,credentialState){
          if (credentialState is CredentialLoading) {
            return Scaffold(
              body: loadingIndicatorProgressBar(),
            );
          }
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(uid: authState.uid,);
                } else {
                  print("Unauthenticated");
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
      ),
    );
  }
  _bodyWidget(){
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20,),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: greenColor),
                )),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            // Container(
            //   child: SvgPicture.asset('assets/login_image.svg'),
            // ),
            const SizedBox(
              height: 17,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color747480.withOpacity(.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color747480.withOpacity(.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                obscureText: _isShowPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  suffixIcon: InkWell(onTap: (){
                    setState(() {
                      _isShowPassword=_isShowPassword==false?true:false;
                    });
                  },child: Icon(_isShowPassword==false?Icons.remove_red_eye:Icons.panorama_fish_eye)),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, PageConst.forgotPage);
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                      color: greenColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _submitLogin();
              },
              child: Container(
                alignment: Alignment.center,
                height: 44,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topRight,
              child: Row(
                children: <Widget>[
                  const Text(
                    "don't have an Account",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: (){
                      //Navigator.pushNamedAndRemoveUntil(context, "/registration", (route) => false);
                      Navigator.pushNamed(context, PageConst.registrationPage);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: greenColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    BlocProvider.of<CredentialCubit>(context).googleAuthSubmit();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.2),
                            offset: const Offset(1.0,1.0),
                            spreadRadius: 1,
                            blurRadius: 1,
                          )
                        ]
                    ),
                    child: const Icon(Icons.g_mobiledata,color: Colors.white,),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  void _submitLogin(){
    if (_emailController.text.isEmpty) {
      toast('enter your email');
      return;
    }
    if (_passwordController.text.isEmpty) {
      toast('enter your password');
      return;
    }
    BlocProvider.of<CredentialCubit>(context).signInSubmit(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }
}