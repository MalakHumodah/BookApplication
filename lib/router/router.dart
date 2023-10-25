import 'package:flutter/material.dart';
import 'package:myapp/API/Book_API/all_Books_screen.dart';
import 'package:myapp/pages/best_books.dart';
import 'package:myapp/pages/realtime_posts_pages/get_posts_page.dart';
import 'package:myapp/state_management/SharedPref/user_model.dart';
import '../API/Product_API/all_products_screen.dart';
import '../pages/errorPage.dart';
import '../pages/home_page.dart';
import '../pages/intro_pages/splash_page.dart';
import '../pages/intro_pages/sign_in_page.dart';
import '../pages/intro_pages/sign_up_page.dart';
import '../pages/intro_pages/startPage.dart';
import '../pages/intro_pages/welcome_page.dart';
import '../pages/realtime_posts_pages/adding_post_page.dart';
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
      case bestBooksScreen:
        {
          return _route(BestBooks());
        }
        case buyBooksPage:
        {
          return _route(GetPosts());
        }
        case sellBooksPage:
        {
          return _route(AddingPostPage());
        }

      default:
        return _route(ErrorPage());
    }
  }

  static MaterialPageRoute _route(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
