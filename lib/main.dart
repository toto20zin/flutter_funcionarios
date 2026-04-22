import 'package:flutter/material.dart';
import 'package:flutter_funcionario/root/theme.dart';
import 'package:flutter_funcionario/ui/splash.dart';

void main() {
  runApp(
    MaterialApp(title: "Funcionarios Da Empresa", theme: AppTheme.appTeme, home: Splash()),
  );
}