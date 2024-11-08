import 'package:flutter/material.dart';
import 'FormularioEmergencia.dart';  // Asegúrate de importar la pantalla FormularioEmergencia
import 'VerEmergenciasPage.dart';    // Importa la pantalla VerEmergenciasPage
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // paquete importante para correr la BBDD

void main() {
   sqfliteFfiInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rangers SPD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green, Colors.grey, Colors.blue],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rangers SPD",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navega a la pantalla de creación de emergencia (FormularioEmergencia)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormularioEmergencia()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/crear.png', // Ruta de la imagen
                          width: 30, // Tamaño de la imagen
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Text("Crear nueva emergencia"),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navega a la pantalla de ver emergencias (VerEmergenciasPage)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VerEmergenciasPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/registro.png', // Ruta de la imagen
                          width: 30, // Tamaño de la imagen
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Text("Ver emergencias"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



