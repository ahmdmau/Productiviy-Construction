part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = Color(0xFF99CBCC);
Color accentColor1 = Color(0xFF7BB3B4);
Color accentColor2 = Color(0xFFE66F25);
Color accentColor3 = Color(0xFFADADAD);
const iconColorPrimaryDark = Color(0xFF212121);
const appWhite = Color(0xFFFFFFFF);
const appTextColorPrimary = Color(0xFF212121);

// TextStyle
// Raleway
TextStyle blackTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle toscaTextFont = GoogleFonts.raleway()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);

// Open Sans
TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle orangeNumberFont =
    GoogleFonts.openSans().copyWith(color: accentColor2);

TextStyle secondaryTextStyle({
  int size = 14,
  Color color,
  FontWeight weight = FontWeight.normal,
  String fontFamily,
  double letterSpacing,
}) {
  return TextStyle(
    fontSize: size.toDouble(),
    color: color,
    fontWeight: weight,
    fontFamily: fontFamily,
    letterSpacing: letterSpacing,
  );
}
