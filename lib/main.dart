import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import "package:rankai/core/injector.dart" as di;
import 'package:rankai/core/injector.dart';
import 'package:rankai/core/presentation/routes/routes.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await dotenv.load(fileName: '.env');

  await di.init();

  runApp(const RankAI());
}

class RankAI extends StatelessWidget {
  const RankAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        sl<GlobalAppLocalizations>().setAppLocalizations(
          AppLocalizations.of(context),
        );
        return child ?? Container();
      },
    );
  }
}
