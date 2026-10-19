import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:village_taxi/main.dart';

void main() {
  testWidgets('shows the village taxi booking screen', (tester) async {
    await tester.pumpWidget(const VillageTaxiApp());

    expect(find.text('Куда поедем?'), findsOneWidget);
    expect(find.text('Берёзовка'), findsOneWidget);
    expect(find.text('Выберите поездку'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Заказать такси'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Заказать такси'), findsOneWidget);
  });

  testWidgets('updates the fare and clearly labels demo orders', (
    tester,
  ) async {
    await tester.pumpWidget(const VillageTaxiApp());

    await tester.scrollUntilVisible(
      find.text('Комфорт'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Комфорт'));
    await tester.pumpAndSettle();

    expect(find.text('450 ₽'), findsWidgets);

    await tester.ensureVisible(find.text('Заказать такси'));
    await tester.tap(find.text('Заказать такси'));
    await tester.pumpAndSettle();

    expect(find.text('Заказ оформлен!'), findsOneWidget);
    expect(
      find.textContaining('Реальный водитель не вызывается.'),
      findsOneWidget,
    );
  });

  testWidgets('swaps pickup and destination addresses', (tester) async {
    await tester.pumpWidget(const VillageTaxiApp());

    await tester.tap(find.byTooltip('Поменять адреса местами'));
    await tester.pump();

    final fields = tester
        .widgetList<TextField>(find.byType(TextField))
        .toList();
    expect(fields[0].controller!.text, 'Ж/д вокзал');
    expect(fields[1].controller!.text, 'ул. Центральная, 12');
  });
}
