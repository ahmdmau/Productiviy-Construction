part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context)
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
        return;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    SizedBox(
                      height: 100,
                      child: Image.asset("assets/ic_logo.png"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70, bottom: 40),
                      child: Text(
                        "Welcome back,\nEngineer!",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(value);
                        });
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Email Address",
                          hintText: "Email Address"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          isPasswordValid = value.length >= 6;
                        });
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Password",
                          hintText: "Password"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          "Forgot Password? ",
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Get Now",
                          style: toscaTextFont.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(top: 40, bottom: 30),
                        child: isSigningIn
                            ? SpinKitCircle(color: mainColor)
                            : FloatingActionButton(
                                elevation: 0,
                                child: Icon(Icons.arrow_forward,
                                    color: (isEmailValid && isPasswordValid)
                                        ? Colors.white
                                        : Color(0xFFBEBEBE)),
                                backgroundColor:
                                    (isEmailValid && isPasswordValid)
                                        ? mainColor
                                        : Color(0xFFE4E4E4),
                                onPressed: (isEmailValid && isPasswordValid)
                                    ? () async {
                                        setState(() {
                                          isSigningIn = true;
                                        });
                                        SigninSignupResult result =
                                            await AuthServices.signIn(
                                                emailController.text,
                                                passwordController.text);

                                        if (result.user == null) {
                                          setState(() {
                                            isSigningIn = false;
                                          });

                                          Flushbar(
                                            duration: Duration(seconds: 4),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Color(0xFFFF5C83),
                                            message: result.message,
                                          ).show(context);
                                        }
                                      }
                                    : null,
                              ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Start fresh now? ",
                          style: greyTextFont.copyWith(
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Sign Up",
                          style: toscaTextFont.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
