import 'package:get_it/get_it.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton<GlobalAppLocalizations>(GlobalAppLocalizationsImpl());
}
