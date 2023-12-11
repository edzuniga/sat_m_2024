import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sat_m/bd/bd.dart';
import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/pantallas/home_pantalla.dart';
import 'package:sat_m/pantallas/login.dart';
import 'package:sat_m/pantallas/onboarding_menu.dart';
import 'package:sat_m/providers/cantidades_totales_provider.dart';
import 'package:sat_m/providers/condiciones_comunidades_provider.dart';
import 'package:sat_m/providers/condiciones_familias_provider.dart';
import 'package:sat_m/providers/condiciones_miembros_migrantes_provider.dart';
import 'package:sat_m/providers/indice_pobreza_provider.dart';
import 'package:sat_m/providers/login_provider.dart';
import 'package:sat_m/providers/miembros_migrantes_provider.dart';
import 'package:sat_m/providers/propension_migracion_provider.dart';
import 'package:sat_m/providers/recuperar_provider.dart';
import 'package:sat_m/providers/satm_comunidades_provider.dart';
import 'package:sat_m/providers/satm_familia_miembros_provider.dart';
import 'package:sat_m/providers/satm_familias_provider.dart';
import 'package:sat_m/providers/sincronizar_provider.dart';

void main() {
  //----Para uso exclusivo VERTICAL
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //----Para uso exclusivo VERTICAL

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecuperarProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SatmComunidadesProvider()),
        ChangeNotifierProvider(create: (_) => SatmFamiliasProvider()),
        ChangeNotifierProvider(create: (_) => CondicionesComunidadesProvider()),
        ChangeNotifierProvider(create: (_) => CondicionesFamiliasProvider()),
        ChangeNotifierProvider(create: (_) => FamiliaMiembrosProvider()),
        ChangeNotifierProvider(create: (_) => CantidadesTotalesProvider()),
        ChangeNotifierProvider(create: (_) => IndicePobrezaProvider()),
        ChangeNotifierProvider(create: (_) => MiembrosMigrantesProvider()),
        ChangeNotifierProvider(create: (_) => PropensionMigracionProvider()),
        ChangeNotifierProvider(
            create: (_) => MiembrosMigrantesCondicionesProvider()),
        ChangeNotifierProvider(create: (_) => SincronizarProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'SAT-M APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kNaranjaPrincipal),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: Future.wait([
          DatabaseSatM.instance.obtenerUsuarios(),
          DatabaseSatM.instance.obtenerOnBoarding(),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> datosIniciales) {
          if (datosIniciales.hasError) {
            return const Scaffold(
              body: Center(
                child: Text(
                    'Ocurrió un error en la aplicación!!, contacte soporte!!!'),
              ),
            );
          }

          if (datosIniciales.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 15),
                    Text("Cargando datos...\nPor favor espere!!"),
                  ],
                ),
              ),
            );
          }
          if (datosIniciales.data![1].isEmpty ||
              datosIniciales.data![1] == []) {
            return const OnboardingMenuPantalla();
          } else {
            if (datosIniciales.data![0].isEmpty ||
                datosIniciales.data![0] == []) {
              return const LoginPage();
            } else {
              return const HomePage();
            }
          }
        },
      ),
    );
  }
}
