import 'package:flutter/material.dart';
import 'package:mantia/core/app_exception.dart';
import 'package:mantia/core/app_logger.dart';
import 'package:mantia/repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  final AuthRepository authRepository;

  const LoginScreen({super.key, required this.authRepository});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isRegistering = false;
  bool _isLoading = false;
  bool _hidePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateFields() {
    if (_isRegistering && _nameController.text.trim().length < 2) {
      return 'Escribe tu nombre.';
    }
    final email = _emailController.text.trim();
    if (!email.contains('@') || !email.contains('.')) {
      return 'Ingresa un correo válido.';
    }
    if (_passwordController.text.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_isLoading) return;

    final problem = _validateFields();
    if (problem != null) {
      setState(() => _errorMessage = problem);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_isRegistering) {
        await widget.authRepository.register(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
        );
      } else {
        await widget.authRepository.signIn(
          _emailController.text,
          _passwordController.text,
        );
      }
    } on AppException catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = error.message);
    } catch (error, stackTrace) {
      AppLogger.unexpected('Fallo inesperado en el login', error, stackTrace);
      if (!mounted) return;
      setState(
        () =>
            _errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo.',
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.build_circle_outlined,
                    size: 64,
                    color: colors.primary,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Mantia',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isRegistering ? 'Crea tu cuenta' : 'Inicia sesión',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  if (_isRegistering) ...[
                    TextField(
                      controller: _nameController,
                      enabled: !_isLoading,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre',
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  TextField(
                    controller: _emailController,
                    enabled: !_isLoading,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    enabled: !_isLoading,
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () =>
                            setState(() => _hidePassword = !_hidePassword),
                      ),
                    ),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(_errorMessage!, style: TextStyle(color: colors.error)),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(_isRegistering ? 'Registrarme' : 'Entrar'),
                  ),
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            setState(() {
                              _isRegistering = !_isRegistering;
                              _errorMessage = null;
                            });
                          },
                    child: Text(
                      _isRegistering
                          ? 'Ya tengo cuenta: iniciar sesión'
                          : 'No tengo cuenta: registrarme',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
