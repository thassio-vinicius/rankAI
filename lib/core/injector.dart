import 'package:get_it/get_it.dart';
import 'package:rankai/core/http/client.dart';
import 'package:rankai/features/chat/data/data_source/remote/ai_data_source.dart';
import 'package:rankai/features/chat/domain/repositories/ai_repository.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton<GlobalAppLocalizations>(GlobalAppLocalizationsImpl());

  sl.registerSingleton<HTTP>(HTTP());

  sl.registerFactory<AIDataSource>(
    () => AIDataSourceImpl(sl()),
  );

  sl.registerFactory<AIRepository>(
    () => AIRepository(sl()),
  );
}
