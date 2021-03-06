import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_course/ui/pages/splash/splash.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {}

void main() {
  late SplashPresenterSpy presenter;
  late StreamController<String> navigateToController;

  When mockLoadCurrentAccountCall(SplashPresenter presenter) {
    return when(() => presenter.checkAccount());
  }

  void mockLoadCurrentAccount(SplashPresenter presenter) {
    mockLoadCurrentAccountCall(presenter).thenAnswer((_) async => null);
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    mockLoadCurrentAccount(presenter);
    navigateToController = StreamController<String>();
    when(() => presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);

    final splashPage = GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
        GetPage(
            name: '/any_route',
            page: () => const Scaffold(
                  body: Text('fake page'),
                ))
      ],
    );
    await tester.pumpWidget(splashPage);
  }

  tearDown(() {
    navigateToController.close();
  });

  testWidgets('Should present spinner on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.checkAccount()).called(1);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();

    expect(Get.currentRoute, '/');
  });
}
