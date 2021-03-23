import 'package:flutter_mvvm_boilerplate/view_models/custom_url_view_model.dart';
import 'package:flutter_mvvm_boilerplate/view_models/login_view_model.dart';
import 'package:flutter_mvvm_boilerplate/views/custom_url_view.dart';
import 'package:flutter_mvvm_boilerplate/views/login_view.dart';
import 'package:provider/provider.dart';

class NavigationHelper {
  static getCustomURLScreenWithProvider() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CustomURLViewModel(),
        )
      ],
      child: CustomURLView(),
    );
  }

  static getLoginScreenWithProvider() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        )
      ],
      child: LoginView(),
    );
  }
}
