import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:group_chat/features/data/remote/data_sources/storage_provider.dart';
import 'package:group_chat/features/domain/entities/user_entity.dart';
import 'package:group_chat/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:group_chat/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:group_chat/features/presentation/widgets/common.dart';
import 'package:group_chat/features/presentation/widgets/profile_widget.dart';
import 'package:group_chat/features/presentation/widgets/textfield_container.dart';
import 'package:group_chat/features/presentation/widgets/theme/style.dart';

import '../../../page_const.dart';
import 'home_page.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _examTypeController = TextEditingController();
  final TextEditingController _passwordAgainController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();


  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();


  int _selectGender = -1;
  int _selectExamType = -1;
  bool _isShowPassword=true;

  File? _image;
  String? _profileUrl;

  Future getImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          StorageProviderRemoteDataSource.uploadFile(file: _image!).then((value) {

            print("profileUrl");
            setState(() {
              _profileUrl=value;
            });

          });
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }

  @override
  void dispose() {
    _examTypeController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _passwordAgainController.dispose();
    _usernameController.dispose();
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
  Widget _bodyWidget(){
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 35),
        child: Column(
          children: <Widget>[
           const SizedBox(height: 10,),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Registration',
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
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async{
                getImage();

              },
              child: Column(
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    decoration: BoxDecoration(
                      color: color747480,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        child: profileWidget(image: _image)
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Add profile photo',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: greenColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            TextFieldContainer(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              hintText: 'Username',
              prefixIcon: Icons.person,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldContainer(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Email',
              prefixIcon: Icons.mail,
            ),
            const SizedBox(
              height: 17,
            ),
            const Divider(
              thickness: 2,
              indent: 120,
              endIndent: 120,
            ),
            const SizedBox(
              height: 17,
            ),
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextField(
                obscureText: _isShowPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(onTap: (){
                      setState(() {
                        _isShowPassword=_isShowPassword==false?true:false;
                      });
                    },child: Icon(_isShowPassword==false?Icons.remove_red_eye:Icons.panorama_fish_eye))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: color747480.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: TextField(
                obscureText: _isShowPassword,
                controller: _passwordAgainController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                    hintText: 'Password (Again)',
                    hintStyle:
                    TextStyle(color: Colors.black.withOpacity(0.3)),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(onTap: (){
                      setState(() {
                        _isShowPassword=_isShowPassword==false?true:false;
                      });
                    },child: Icon(_isShowPassword==false?Icons.remove_red_eye:Icons.panorama_fish_eye))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: _modalBottomSheetDate,
              child: Container(
                height: 45,
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: color747480.withOpacity(.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      hintText: 'Date of birth',
                      suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: _genderModalBottomSheetMenu,
              child: Container(
                height: 45,
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: color747480.withOpacity(.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _genderController,
                    decoration: const InputDecoration(
                      hintText: 'Gender',
                      suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                _submitSignUp();
              },
              child: Container(
                alignment: Alignment.center,
                height: 44,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: greenColor,
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white,fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Do you have already an account?',
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, PageConst.loginPage, (route) => false);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: greenColor),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'By clicking register, you agree to the ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colorC1C1C1),
                ),
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                      color: greenColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'and ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colorC1C1C1),
                ),
                Text(
                  'terms ',
                  style: TextStyle(
                      color: greenColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'of use',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colorC1C1C1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  void _genderModalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: 300.0,
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close)),
                          const Text(
                            'Gender',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          const Text('')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectGender = 0;
                          _genderController.value =
                              const TextEditingValue(text: "Woman");
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10,top: 18,bottom: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Woman',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                color: _selectGender == 0
                                    ? Colors.orange
                                    : Colors.transparent,
                                border: Border.all(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectGender = 1;
                          _genderController.value =
                              const TextEditingValue(text: "Man");
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10,top: 18,bottom: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Man',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                color: _selectGender == 1
                                    ? Colors.orange
                                    : Colors.transparent,
                                border: Border.all(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                    ),

                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectGender = 2;
                          _genderController.value =
                              const TextEditingValue(text: "I dont want to specify");
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10,top: 18,bottom: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('I dont want to specify',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                )),
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                color: _selectGender == 2
                                    ? Colors.orange
                                    : Colors.transparent,
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void _modalBottomSheetDate() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              height: 300.0,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close)),
                        const Text(
                          'Date of birth',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.done)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      use24hFormat: false,
                      mode: CupertinoDatePickerMode.date,
                      maximumDate: DateTime(DateTime.now().year+1, 1, 1),
                      minimumDate: DateTime(1950, 1, 1),
                      onDateTimeChanged: (dateTime) {
                        print(dateTime);
                        setState(() {
                          _dobController.value = TextEditingValue(
                              text: DateFormat.yMMMMEEEEd().format(dateTime));
                        });
                      },
                    ),
                  ),
                ],
              ));
        });
  }

  _submitSignUp() {
    if (_usernameController.text.isEmpty) {
      toast('enter your username');
      return;
    }
    if (_emailController.text.isEmpty) {
      toast('enter your email');
      return;
    }
    if (_passwordController.text.isEmpty) {
      toast('enter your password');
      return;
    }
    if (_passwordAgainController.text.isEmpty) {
      toast('enter your again password');
      return;
    }

    if (_passwordController.text==_passwordAgainController.text){

    }else{
      toast("both password must be same");
      return;
    }

    BlocProvider.of<CredentialCubit>(context).signUpSubmit(
      user: UserEntity(
        email: _emailController.text,
        phoneNumber: _numberController.text,
        name: _usernameController.text,
        profileUrl: _profileUrl!,
        gender: _genderController.text,
        dob: _dobController.text,
        password: _passwordController.text,
        isOnline: false,
        status:  "Hi! there i'm using this app",
      ),
    );
  }

}

