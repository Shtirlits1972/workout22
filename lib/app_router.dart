import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout1/block/exercise_block.dart';
import 'package:workout1/block/trayn_day_block.dart';
import 'package:workout1/forms/ex_list.dart';
import 'package:workout1/forms/ex_list_select.dart';
import 'package:workout1/forms/home_page.dart';
import 'package:workout1/forms/set_ex_add.dart';
import 'package:workout1/model/row_set.dart';

class AppRouter {
  final DataCubitEx exBlock = DataCubitEx(KeeperEx());
  final DataCubitDays days = DataCubitDays(KeeperTraynDay());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(value: days, child: const HomePage()),
        );
      case '/ExList':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: exBlock,
            child: const ExList(),
          ),
        );
      case '/ExListSelect':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: exBlock,
            child: const ExListSelect(),
          ),
        );

//  final code = settings.arguments as String;
//   return MaterialPageRoute(builder: (context) => SurveyConsentPage(languageCode: code));

      case '/SetExAdd':
        // String rowSet = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => SetExAdd(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider.value(value: days, child: const HomePage()),
        );
    }
  }
}
