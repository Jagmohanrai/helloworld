library constants;

import 'package:flutter/material.dart';

const Color purple_light = Color(0xFF9299FA);
const Color purple_dark = Color(0xFF3941A2);

// Multiply this function with your static code to get its responsive version
//Just pass it with the context tot his funtion

double responsiveCofficient(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return 0.0013 * size.height;
}

// class Logos {
//   /// Scrittr Logo in Colour.
//   /// `SVG File`
//   static const String scrittrInColor = "assets/logos/logo_color.svg";

//   /// `Scrittr Logo` in White Colour.
//   /// `SVG File`
//   static const String scrittrInWhite = "assets/logos/logo_white.svg";

//   /// Google Logo in Colour.
//   /// `SVG File`
//   static const String google = "assets/logos/google.png";

//   /// Facebook Logo in Colour.
//   /// `SVG File`
//   static const String fb = "assets/logos/fb.png";
// }

// class Images {
//   static const String ganesh = "assets/images/ganesh.jpg";
//   static const String india = "assets/images/india.jpg";
//   static const String swasthik = "assets/images/swasthik.jpg";
// }

// class Illustrations {
//   static const String security = "assets/illustrations/security.svg";
//   static const String registerPageSvg =
//       "assets/illustrations/registerpagesvg.svg";
// }

// class Icons {
//   static const String homeFilled = "assets/icons/home_filled.svg";
//   static const String homeUnfilled = "assets/icons/home_unfilled.svg";
//   static const String storyWallFilled = "assets/icons/storywall_filled.svg";
//   static const String storyWallUnfilled = "assets/icons/storywall_unfilled.svg";
//   static const String activityFilled = "assets/icons/activity_filled.svg";
//   static const String activityUnfilled = "assets/icons/activity_unfilled.svg";
//   static const String profileFilled = "assets/icons/profile_filled.svg";
//   static const String profileUnfilled = "assets/icons/profile_unfilled.svg";
//   static const String verifiedTick = "assets/icons/verified_tick.svg";
// }

// class Server {
//   static const String serverAddress = "amazon-1-13234";

//   ///POST request
//   static const String newSignUp = "$serverAddress" + "/user/signup";

//   ///POST request
//   static const String fetchFeed = "$serverAddress" + "/user/signup";
// }
