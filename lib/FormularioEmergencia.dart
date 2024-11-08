import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';  // Asegúrate de importar la clase DatabaseHelper

class FormularioEmergencia extends StatefulWidget {
  @override
  _FormularioEmergenciaState createState() => _FormularioEmergenciaState();
}

class _FormularioEmergenciaState extends State<FormularioEmergencia> {
  final _formKey = GlobalKey<FormState>();  // Para validar el formulario
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _cedulaController = TextEditingController();
  TextEditingController _categoriaController = TextEditingController();

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _guardarDatos() async {
    if (_formKey.currentState!.validate()) {
      // Inicializa la base de datos
      await _databaseHelper.database;

      // Si el formulario es válido, guarda los datos
      final nombre = _nombreController.text;
      final cedula = _cedulaController.text;
      final categoria = _categoriaController.text;

      // Crea un mapa con los datos para insertar en la base de datos
      Map<String, dynamic> emergencia = {
        'nombre': nombre,
        'cedula': cedula,
        'categoria': categoria,
      };

      // Inserta los datos en la base de datos
      await _databaseHelper.insertEmergencia(emergencia);

      // Muestra un mensaje al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Emergencia guardada correctamente')),
      );

      // Limpia los campos después de guardar
      _nombreController.clear();
      _cedulaController.clear();
      _categoriaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresar Emergencia'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre del paciente',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del paciente';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cedulaController,
                decoration: InputDecoration(
                  labelText: 'Cédula del paciente',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la cédula del paciente';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _categoriaController,
                decoration: InputDecoration(
                  labelText: 'Categoría del accidente',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la categoría del accidente';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _guardarDatos,
                child: Text('Guardar datos'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


