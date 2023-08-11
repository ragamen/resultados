//import 'dart:html';
//import 'package:gotrue/src/types/provider.dart' hide Provider;
import 'dart:html';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultados/start_page.dart';
import 'package:resultados/usuarios.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'common.dart';
import 'ganador.dart';
import 'gridprovider.dart';

//import 'articulos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://qpewttmefqniyqflyjmu.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFwZXd0dG1lZnFuaXlxZmx5am11Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzM2NjI1NDYsImV4cCI6MTk4OTIzODU0Nn0.OnRuoILFCh1WhCTjNx8JGRPaf_OzrBthdhL-H3dXhQk");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _user;
  String? usuarioActivo = "";

  @override
  void initState() {
    super.initState();

    _getAuth();
    var isValido = false;
    usuarioActivo = _user!.email?.trim();
    leerUsuarios(usuarioActivo, isValido);
    if (!isValido) {
      avisar();
    }
  }

  leerUsuarios(activo, isValido) async {
    final data = await cliente
        .from('usuarios')
        .select(
            'email,password,activo,nombre,apellidos,fechanac,fechainicio,fechafinal,superuser')
        .eq('email', activo);
    int count = data.length;
    List<Usuarios> usuarios = [];
    for (int i = 0; i < count; i++) {
      usuarios.add(Usuarios.fromMap(data[i]));
    }
    if (usuarios[0].activo) {
      isValido = true;
    }
    return isValido;
  }

  avisar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Llamar a la administracion del Programa"),
      backgroundColor: Colors.redAccent,
    ));
  }

  Future<void> _getAuth() async {
    if (mounted) {
      setState(() {
        _user = cliente.auth.currentUser;
      });
    }
    cliente.auth.onAuthStateChange.listen((event) {
      if (mounted) {
        setState(() {
          _user = event.session?.user;
        });
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GridProvider>(create: (_) => GridProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //Consumer<GridProvider>(builder: (_, watch1, __) {
        home: _user == null ? const StartPage() : const MyWidget(),
        //MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

//
