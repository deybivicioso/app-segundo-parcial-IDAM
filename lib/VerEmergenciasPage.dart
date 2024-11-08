import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';  // Asegúrate de importar la clase DatabaseHelper

class VerEmergenciasPage extends StatefulWidget {
  @override
  _VerEmergenciasPageState createState() => _VerEmergenciasPageState();
}

class _VerEmergenciasPageState extends State<VerEmergenciasPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> _emergencias;

  @override
  void initState() {
    super.initState();
    // Cargar las emergencias cuando la página se inicialice
    _emergencias = _databaseHelper.getEmergencias();  // Esta línea consulta la base de datos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Emergencias'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _emergencias,  // Usamos el futuro que obtuvimos al consultar la base de datos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay emergencias registradas'));
          }

          // Datos disponibles
          List<Map<String, dynamic>> emergencias = snapshot.data!;

          return ListView.builder(
            itemCount: emergencias.length,
            itemBuilder: (context, index) {
              var emergencia = emergencias[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 5,
                child: ListTile(
                  title: Text('Nombre: ${emergencia['nombre']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cédula: ${emergencia['cedula']}'),
                      Text('Categoría: ${emergencia['categoria']}'),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}


