//import 'dart:html';
//import 'package:gotrue/src/types/provider.dart' hide Provider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        home: const MyWidget(),
        //MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

//
