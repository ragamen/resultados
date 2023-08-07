import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resultados/supabase.dart';
import 'articulos.dart';
import 'gridprovider.dart';
import 'lista.dart';

class Loterias extends StatefulWidget {
  const Loterias({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoteriasState createState() => _LoteriasState();
}

class _LoteriasState extends State<Loterias> {
  SupaBaseHandler client = SupaBaseHandler();
  List<Articulos> gridMap = [];
  List<Articulos> newArray1 = [];
  List<Articulos> newArray2 = [];
  List<Articulos> gridMapSearch = [];
  TextEditingController xloteria = TextEditingController();
  TextEditingController xFecha = TextEditingController();
  bool flag = true;
  int currentIndex = 0;
  bool seguir = true;
  int pageActual = 0;
  final fecha = DateTime.now();
  final formato = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    //final prov = Provider.of<GridProvider>(context, listen: false);
    super.initState();
    String xfecha = "";
    leerGanadores(xfecha);
  }

  leerGanadores(xfecha) async {
    gridMap = await client.recibirDatos(xfecha);
    setState(() {
      gridMap = gridMap;
    });
    return gridMap;
  }

/*
  void updateArrays() async {
    for (int i = 0; i < gridMap.length; i++) {
      await Future.delayed(const Duration(seconds: 5));
      if (gridMap[i].operador.toLowerCase() == xloteria.text.toLowerCase()) {
        newArray1 = gridMap.sublist(i, i + 12);
        final prov = Provider.of<GridProvider>(context, listen: false);
        setState(() {
          prov.setArray01(newArray1);
        });
        newArray1 = [];
        break;
      }
    }
    seguir = true;
  }
*/
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<GridProvider>(context, listen: false);
    if (gridMap.isNotEmpty && seguir) {
      seguir = false;
    }
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Container(
            height: 35,
            width: 200,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 117, 231, 251),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Fecha a Consultar',
                      contentPadding: EdgeInsets.all(8)),
                  controller: xFecha,
                  onSubmitted: (value) {
                    if (value.isEmpty) {
                      final fecha = DateTime.now();
                      final formato = DateFormat('dd/MM/yyyy');
                      final fechaFormateada = formato.format(fecha);
                      xFecha.text = fechaFormateada;
                    }
                  }),
            ),
          ),
          Expanded(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 117, 231, 251),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  //  focusNode: _textFocusNode,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Buscar Operador, {fecha} opcional',
                      contentPadding: EdgeInsets.all(8)),
                  controller: xloteria,
                  onSubmitted: (value) {
                    if (mounted) {
                      setState(() {
                        gridMapSearch = [];
                        for (int index = 0; index < gridMap.length; index++) {
                          if (gridMap[index].operador.trim().toLowerCase() ==
                                  xloteria.text.trim().toLowerCase() &&
                              gridMap[index].fecha == xFecha.text) {
                            gridMapSearch.add(gridMap[index]);
                            //gridMapSearch[xj] = gridMap[index];
                          }
                          if (gridMapSearch.isEmpty) {
                            prov.setArray01(Lista.articulos);
                          }
                          if (gridMapSearch.length == 12) {
                            prov.setArray01(gridMapSearch);
                            seguir = true;
                          }
                          //  print(gridMapSearch[index]);
                        }
                        //                xloteria.text = value;
                        //                seguir = true;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      )),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Center(
                  child: Text(
                      prov.newArray01[0].operador + " de Fecha " + xFecha.text,
                      style: const TextStyle(fontSize: 25)),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 242, 229, 234),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        mainAxisExtent: 150,
                      ),
                      itemCount: prov.newArray01.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                16.0,
                              ),
                              color: Colors.amberAccent.shade100,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  prov.newArray01[index].nombre + '.png',
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                Text(prov.newArray01[index].nombre,
                                    style: const TextStyle(fontSize: 12)),
                                Text(prov.newArray01[index].hora,
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
