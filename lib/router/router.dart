import 'package:flutter/material.dart';
import 'package:myapp/API/Book_API/all_Books_screen.dart';
import 'package:myapp/state_management/SharedPref/user_model.dart';
import '../API/Product_API/all_products_screen.dart';
import '../pages/errorPage.dart';
import '../pages/firebase_cloud_pages/buy_post_page.dart';
import '../pages/firebase_cloud_pages/sell_post_screen.dart';
import '../pages/home_page.dart';
import '../pages/intro_pages/splash_page.dart';
import '../pages/intro_pages/sign_in_page.dart';
import '../pages/intro_pages/sign_up_page.dart';
import '../pages/intro_pages/startPage.dart';
import '../pages/intro_pages/welcome_page.dart';
import '../pages/realtime_posts_pages/add_reviewPost_page.dart';
import '../pages/realtime_posts_pages/reviews_posts_page.dart';
import 'constant_router.dart';

class RouterClass {
  static Route generate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case signUpPage:
        return _route(SignUpPage());

      case splashPage:
        return _route(SplashPage());

      case signInPage:
        return _route(SignInPage());

      case welcomePage:
        {
          return _route(WelcomePage());
        }
      case startPage:
        return _route(StartPage());

      case allProductScreen:
        {
          var model = routeSettings.arguments as UserModel;
          return _route(AllProductScreen(
            model: model,
          ));
        }
        case allBooksScreen:
        {
          var model = routeSettings.arguments as UserModel;
          return _route(AllBookScreen(
            model: model,
          ));
        }

      case homePage:
        {
          var model = routeSettings.arguments as UserModel;
          return _route(HomePage(
            model: model,
          ));
        }

        case buyPostsPage:
        {
          return _route(BuyPostsPage());
        }
        case sellPostPage:
        {
          return _route(SellPostPage());
        }
        case addingReviewPostPage:
        {
          return _route(AddingReviewPostPage());
        }
        case reviewPostsPage:
        {
          return _route(ReviewPostsPage());
        }

      default:
        return _route(ErrorPage());
    }
  }

  static MaterialPageRoute _route(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
