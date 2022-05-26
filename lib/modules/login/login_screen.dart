import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tadeer_recycling_shop/layout/shop_layout/shop_layout.dart';
import 'package:tadeer_recycling_shop/modules/login/cubit/cubit.dart';
import 'package:tadeer_recycling_shop/shared/Functions.dart';
import 'package:tadeer_recycling_shop/shared/components/FlutterToast.dart';

import 'package:tadeer_recycling_shop/shared/components/TextFormFields.dart';
import 'package:tadeer_recycling_shop/shared/components/login_buttons.dart';
import 'package:tadeer_recycling_shop/shared/custom_widgets/TextFormFieldWidget.dart';
import 'package:tadeer_recycling_shop/shared/network/local/cache_helper.dart';

import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey =  GlobalKey<FormState>();

  //final formKey =  GlobalKey<FormState>();
  bool _passwordVisible = false;

  Color greenColor = const Color(0xFF00AF19);

  Color blueColor = const Color(0x005890ff);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState)
            {
              if(state.loginModel.status == true)
                {
                  print(state.loginModel.message);
                  print(state.loginModel.data?.token);
                  CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) => navigateAndReplaceTo(const ShopLayout(), context),);
                }
              else
                {
                  print(state.loginModel.message);
                  showToast(
                      text: state.loginModel.message!,
                      state: ToastStates.error,
                  );
                }
            }
        },
        builder: (context,state) 
        {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            body: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 140.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 125.0,
                              width: 200.0,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 2.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Login',
                                            style:
                                            TextStyle(
                                              fontFamily: 'Trueno',
                                              fontSize: 60.0,
                                              color: greenColor,
                                            )),
                                        Text(
                                          'Save the world.',
                                          style: Theme.of(context).textTheme.headline6!.copyWith(
                                              color: Colors.black54
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                ],
                              )),
                          TextFormFieldWidget(
                            controller: emailController,
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            label: 'Email Address',
                            labelFontFamily: 'Trueno',
                            labelFontSize: 12.0,
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                              width: 10.0,
                            ),
                            focusBorderSide: BorderSide(color: greenColor),
                            focusBorderRadius: BorderRadius.circular(50.0),
                            obsecureText: false,
                            validation: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Please enter an Email';
                              }
                              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                return 'Please enter a valid Email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height:  25.0,
                          ),
                          TextFormFieldWidget(
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            label: 'Password',
                            labelFontFamily: 'Trueno',
                            labelFontSize: 12.0,
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                              width: 10.0,
                            ),
                            focusBorderSide: BorderSide(color: greenColor),
                            focusBorderRadius: BorderRadius.circular(50.0),
                            onSubmit: (value){
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data'))
                                );
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                                if(state is LoginSuccessState)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Logged in successfully'))
                                  );
                                }
                                else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Failed in successfully'))
                                  );
                                }
                              }
                            },
                            obsecureText: LoginCubit.get(context).isPassword,
                            suffixIcon:  LoginCubit.get(context).suffix,
                            onSuffixPressed: ()
                            {
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            validation: (String? value)
                            {
                              if(value!.length < 6)
                              {
                                return 'Minimum 6 characters required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5.0),
                          GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: InkWell(
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Forgot Password',
                                              style: TextStyle(
                                                  color: greenColor,
                                                  fontFamily: 'Trueno',
                                                  fontSize: 13.0,
                                                  decoration: TextDecoration.underline)),
                                        ],
                                      )))),
                          const SizedBox(height: 30.0),
                          InkWell(
                            onTap: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                 ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(content: Text('Processing Data'))
                                 );
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                                if(state is LoginSuccessState)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Logged in successfully'))
                                    );
                                    navigateTo(context, const ShopLayout());
                                  }
                                else
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Failed to Log in'))
                                    );
                                  }
                              }
                            },
                            child: ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => SizedBox(
                                  height: 50.0,
                                  child: Material(
                                      borderRadius: BorderRadius.circular(25.0),
                                      shadowColor: Colors.greenAccent,
                                      color: greenColor,
                                      elevation: 0,
                                      child: const Center(
                                          child: Text('LOGIN',
                                              style: TextStyle(
                                                  color: Colors.white, fontFamily: 'Trueno'))))),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                            ),
                          ),

                          const SizedBox(height: 25.0),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            const Text("Don't have account?",style: TextStyle(fontFamily: 'Trueno'),),
                            const SizedBox(width: 5.0),
                            InkWell(
                                onTap: () {

                                },
                                child: GestureDetector(
                                  onTap: ()
                                  {
                                    // Navigator.pop(context);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) ,);
                                  },
                                  child: Text('Register',
                                      style: TextStyle(
                                          color: greenColor,
                                          fontFamily: 'Trueno',
                                          fontSize: 15.0,
                                          decoration: TextDecoration.underline)),
                                ))
                          ]),
                        ],
                      ),
                    ),

                  ]),
                )),
          );
        },
        
      ),
    );
  }
}
