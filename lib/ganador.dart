import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultados/supabase.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
import 'articulos.dart';
import 'gridprovider.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  SupaBaseHandler client = SupaBaseHandler();
  List<Articulos> gridMap = [];
  List<Articulos> newArray1 = [];
  List<Articulos> newArray2 = [];

  bool flag = true;
  int currentIndex = 0;
  bool seguir = true;
  @override
  void initState() {
    //final prov = Provider.of<GridProvider>(context, listen: false);
    super.initState();
    leerGanadores();
  }

  leerGanadores() async {
    gridMap = await client.recibirDatos();
    setState(() {
      gridMap = gridMap;
    });
    return gridMap;
  }

  void updateArrays() async {
    // final prov = Provider.of<GridProvider>(context, listen: false);
    var compara = '';
    if (gridMap.isNotEmpty) {
      compara = gridMap[0].operador.trim();
    }
    var array = 1;
    int contx1 = 0;
    int contx2 = 0;
    var imprime = false;
    var inicio = 0;
    for (int i = 0; i < gridMap.length; i++) {
      print(gridMap[i].operador);
    }
    print('Longitud de la Lista---' + gridMap.length.toString());
    for (int i = 0; i < gridMap.length; i++) {
      if (compara == gridMap[i].operador.trim()) {
        if (array == 1) {
          contx1 = contx1 + 1;
        } else {
          contx2 = contx2 + 1;
        }
      } else {
        if (array == 1) {
          compara = gridMap[i].operador.trim();
          array = 2;
          contx2 = contx2 + 1; //mosca
        } else {
          imprime = true;
          compara = gridMap[i].operador.trim();
        }
      }
      if (i > 107 && array == 2) {
        print('Valor de I ..' + i.toString());
        print('Valor de contx2..' + contx2.toString());
        imprime = true;
        compara = gridMap[i].operador.trim();
      }
      if (imprime) {
        await Future.delayed(const Duration(seconds: 5));
        var x = inicio;
        var y = inicio + contx1;
        var x1 = inicio + contx1;
        var y1 = inicio + contx1 + contx2;
        newArray1 = gridMap.sublist(x, y);
        newArray2 = gridMap.sublist(x1, y1);
        final prov = Provider.of<GridProvider>(context, listen: false);
        setState(() {
          prov.setArray01(newArray1);
          prov.setArray02(newArray2);
        });
        inicio = contx1 + contx2 + inicio + 1;
        array = 1;
        contx1 = 0;
        contx2 = 0;
        imprime = false;
        newArray1 = [];
        newArray2 = [];
      }
    }
    seguir = true;
    print("valor de i -->");
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<GridProvider>(context, listen: false);
//    final watch = Provider.of<GridProvider>(context,listen: false);
    if (gridMap.isNotEmpty && seguir) {
      updateArrays();
      seguir = false;
    }
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Center(
                child: Text(prov.newArray01[0].operador,
                    style: TextStyle(fontSize: 25)),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(255, 242, 229, 234),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
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
                              //       'https://lotoven.com' + newArray1[index].urlimage,
                              //                          'https://lotoven.com' +
                              //                              prov.newArray01[index].urlimage
                              //                        Image.network(
                              //                          "https://qpewttmefqniyqflyjmu.supabase.co/storage/v1/object/public/media/imagenes/1687730617564000.png",
                              Image.asset(
                                prov.newArray01[index].nombre + '.png',
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              Text(prov.newArray01[index].nombre,
                                  style: TextStyle(fontSize: 12)),
                              Text(prov.newArray01[index].hora,
                                  style: TextStyle(fontSize: 12)),
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
        Expanded(
          child: Column(
            children: [
              Center(
                child: Text(prov.newArray02[0].operador,
                    style: TextStyle(fontSize: 25)),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 12, 243, 146),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      mainAxisExtent: 150,
                    ),
                    itemCount: prov.newArray02.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: const Color.fromARGB(255, 242, 229, 234),
                          child: Column(
                            children: [
                              //                        'https://lotoven.com' + newArray2[index].urlimage,
                              //                          'https://lotoven.com' +
                              //                              prov.newArray02[index].urlimage,
                              Image.asset(
                                prov.newArray02[index].nombre + '.png',
                                //                   Image.network(
                                //                    "https://qpewttmefqniyqflyjmu.supabase.co/storage/v1/object/public/media/imagenes/1687731106796000.jpg",
                                height: 80,
                                //                        width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Text(prov.newArray02[index].nombre,
                                  style: TextStyle(fontSize: 12)),
                              Text(prov.newArray02[index].hora,
                                  style: TextStyle(fontSize: 12)),
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
    );
  }
}
