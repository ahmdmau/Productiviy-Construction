part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          padding: EdgeInsets.only(top: 100),
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/ic_logo.png'))),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70, bottom: 16),
                    child: Text(
                      "Productivity Construction",
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur \nadipiscing elit. Pellentesque rutrum",
                    style: greyTextFont.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 92,
                    height: 46,
                    margin: EdgeInsets.only(top: 70, bottom: 20),
                    child: RaisedButton(
                        child: Text(
                          "Get Started",
                          style: whiteTextFont.copyWith(fontSize: 16),
                        ),
                        color: mainColor,
                        onPressed: () {
                          BlocProvider.of<PageBloc>(context)
                              .add(GoToRegistrationPage(RegistrationData()));
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style:
                            greyTextFont.copyWith(fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<PageBloc>(context)
                              .add(GoToSignInPage());
                        },
                        child: Text(
                          "Sign In",
                          style: toscaTextFont,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
