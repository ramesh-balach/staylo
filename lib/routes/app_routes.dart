import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staylo/view/explore/explore_view.dart';
import 'package:staylo/view/message/message_view.dart';
import 'package:staylo/view/place_detail/place_detail_view.dart';
import 'package:staylo/view/profile/profile_view.dart';
import 'package:staylo/view/wishlist/wishlist_view.dart';
import '../utils/components/custom_text_widget.dart';
import '../view/bottomnav/bottom_nav_bar.dart';
import '../view/login/login_view.dart';

class AppRoutes {
  // routes name
  static const String loginView = 'loginView';
  static const String bottomNavBar = 'bottomNavBar';
  static const String exploreView = 'exploreView';
  static const String messageView = 'messageView';
  static const String wishlistView = 'wishlistView';
  static const String profileView = 'profileView';
  static const String placeDetailView = 'placeDetailView';

  // routes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginView(),
        );
      case bottomNavBar:
        return MaterialPageRoute(
          builder: (BuildContext context) => const BottomNavBar(),
        );
      case exploreView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ExploreView(),
        );
      case messageView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const MessageView(),
        );
      case wishlistView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const WishlistView(),
        );
      case profileView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProfileView(),
        );
      case placeDetailView:
        final place = settings.arguments as DocumentSnapshot;
        return MaterialPageRoute(
          builder: (BuildContext context) => PlaceDetailView(place: place,),
        );
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: CustomTextWidget(text: 'No Screen Found'),
                  ),
                ));
    }
  }
}
