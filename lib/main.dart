import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:demo_ecommerce/app/injection.dart';
import 'package:demo_ecommerce/app/router.dart';
import 'package:demo_ecommerce/config/build_config.dart';
import 'package:demo_ecommerce/features/base/style/theme.dart';
import 'package:demo_ecommerce/libraries/products/products_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);

  await dotenv.load(fileName: BuildConfig.envFileName);
  await initDI();
  await Hive.initFlutter();
  await setupDependencies();
  await initProductBox();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) async {
    ChuckerFlutter.isDebugMode = true;
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp.router(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            title: "Demo Ecommerce",
            debugShowCheckedModeBanner: false,
            theme: themeLight(context),
            routerConfig: locator<AppRouter>().router,
          );
        },
        designSize: MediaQuery.sizeOf(context));
  }
}
