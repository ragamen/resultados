//import 'dart:html';

import 'articulos.dart';
import 'common.dart';

class SupaBaseHandler {
/*
  static String supaBaseUrl ="https://qpewttmefqniyqflyjmu.supabase.co";
  static String supaBaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFwZXd0dG1lZnFuaXlxZmx5am11Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzM2NjI1NDYsImV4cCI6MTk4OTIzODU0Nn0.OnRuoILFCh1WhCTjNx8JGRPaf_OzrBthdhL-H3dXhQk";
  final client = SupabaseClient(supaBaseUrl, supaBaseKey);*/
  Future<List<Articulos>> readData(xfecha) async {
    if (xfecha == "") {
      final data = await cliente
          .from('loterias')
          .select('operador,numero,nombre,urlimage,hora,fecha')
          .order('operador', ascending: true)
          .order('hora', ascending: true);
      int count = data.length;
      List<Articulos> articulos = [];
      for (int i = 0; i < count; i++) {
        articulos.add(Articulos.fromMap(data[i]));
      }
      return articulos;
    } else {
      final data = await cliente
          .from('loterias')
          .select('operador,numero,nombre,urlimage,hora,fecha')
          .eq('fecha', xfecha)
          .order('operador', ascending: true)
          .order('hora', ascending: true);
      int count = data.length;
      List<Articulos> articulos = [];
      for (int i = 0; i < count; i++) {
        articulos.add(Articulos.fromMap(data[i]));
      }
      return articulos;
    }
  }

  Future<List<Articulos>> recibirDatos(xfecha) async {
    SupaBaseHandler client = SupaBaseHandler();
    List<Articulos> gridMap = await client.readData(xfecha);
    return gridMap;
  }

  Future<List<Articulos>> recibirDatosI(xLoteria) async {
    SupaBaseHandler client = SupaBaseHandler();
    List<Articulos> gridMap = await client.readDataI(xLoteria);
    return gridMap;
  }

  Future<List<Articulos>> readDataI(xLoteria) async {
    final data = await cliente
        .from('loterias')
        .select('operador,numero,nombre,urlimage,hora')
        .eq('operador', xLoteria)
        .order('operador', ascending: true)
        .order('hora', ascending: true);

    int count = data.length;
    List<Articulos> articulos = [];
    for (int i = 0; i < count; i++) {
      articulos.add(Articulos.fromMap(data[i]));
    }
    return articulos;
  }
}
