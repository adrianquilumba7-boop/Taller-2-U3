// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:taller2/main.dart';

void main() {
  testWidgets('Game app loads correctly', (WidgetTester tester) async {
    // Cargar la app
    await tester.pumpWidget(const GameApp());

    // Verifica que aparece el título del juego
    expect(find.text('🎮 Learning RPG'), findsOneWidget);

    // Verifica que existe nivel
    expect(find.textContaining('Nivel'), findsOneWidget);

    // Verifica botones de navegación
    expect(find.text('⬅ Atrás'), findsOneWidget);
    expect(find.text('Siguiente ➡'), findsOneWidget);
  });
}
