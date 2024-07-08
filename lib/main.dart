import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fjeje_timbu/constants/bNav.dart';
import 'package:fjeje_timbu/screens/cartScreen.dart';
import 'package:fjeje_timbu/screens/viewProduct.dart';
import 'package:fjeje_timbu/screens/splashScreen.dart';
import 'package:fjeje_timbu/constants/OnboardData.dart';
import 'package:fjeje_timbu/screens/productScreen.dart';
import 'package:fjeje_timbu/screens/profileScreen.dart';
import 'package:fjeje_timbu/screens/checkoutScreen.dart';
import 'package:fjeje_timbu/screens/onboardingScreen.dart';
import 'apis/timbu_api.dart'; // Ensure this import is correct based on your project structure

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimbuApiProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Jejelove x HNG 11',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
            }
          )
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash', // Set the initial route to 'splash'
        routes: {
          'splash': (context) => const Splash2(),
          'bnav': (context) => const BNavWidget(),
          'onboarding': (context) => OnBoarding(
            images: imageList,
            titles: titlesList,
            subtitles: subtitlesList,
          ),
          'checkout': (context) => const CheckoutSuccessPage(),
          'cart': (context) => CartPage(
            cart: const [], 
            removeFromCart: (product) {},
          ),
          'profile': (context) => const ProfileScreen(),
          'product': (context) => ProductScreen(
            cart: const [], 
            addToCart: (product) {},
          ),
          'products-detail': (context) => const ViewProductPage(),
        },
      ),
    );
  }
}
