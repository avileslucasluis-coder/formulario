import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _ocultarPassword = true;
  bool _ocultarConfirmPassword = true;

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _registrarUsuario() {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes realizar la lógica de registro del usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '¡Registro exitoso para ${_nombreController.text.trim()}!',
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Crea tu cuenta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // nombre completo
              TextFormField(
                controller: _nombreController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa tu nombre completo';
                  }

                  if (value.trim().length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // correo electronico
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'ejemplo@correo.com',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa tu correo electrónico';
                  }

                  final emailRegex = RegExp(
                    r'^(?!.*\.\.)([A-Za-z0-9]+[A-Za-z0-9._%+-]*)@([A-Za-z0-9-]+\.)+[A-Za-z]{2,}$',
                  );

                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Ingresa un correo electrónico válido';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              // contraseña
              TextFormField(
                controller: _passwordController,
                obscureText: _ocultarPassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _ocultarPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _ocultarPassword = !_ocultarPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }

                  if (value.trim().length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              // confirmar contraseña
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _ocultarConfirmPassword,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _ocultarConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _ocultarConfirmPassword = !_ocultarConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor confirma tu contraseña';
                  }

                  if (value.trim() != _passwordController.text.trim()) {
                    return 'Las contraseñas no coinciden';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 32),

              //boton de registro
              FilledButton.icon(
                onPressed: _registrarUsuario,
                icon: Icon(Icons.check_circle_outline),
                label: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('REGISTRARME', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
