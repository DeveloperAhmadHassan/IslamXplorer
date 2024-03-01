import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignInPage.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';

void main() {
  group('SignInPage Widget Tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      expect(find.text('Log In'), findsOneWidget);

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(CustomButton), findsOneWidget);
    });

    testWidgets('Error message is displayed when login fails', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      expect(find.text('Please enter email!'), findsOneWidget);
    });

    testWidgets('Tapping on Sign Up navigates to SignUpPage', (WidgetTester tester) async {

      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });
  });

  group('SignInPage Details Tests', () {
    testWidgets('Entering valid email and password triggers login', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      await tester.enterText(find.byKey(const Key('emailTextField')), '23324@students.riphah.edu.pk');
      await tester.enterText(find.byKey(const Key('passwordTextField')), '123123');

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();
    });

    testWidgets('Entering invalid email shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      await tester.enterText(find.byKey(const Key('emailTextField')), 'invalid-email');

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email!'), findsOneWidget);
    });
    //
    testWidgets('Entering empty email shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter email!'), findsOneWidget);
    });
    //
    testWidgets('Entering empty password shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      await tester.enterText(find.byKey(const Key('emailTextField')), 'valid@email.com');

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter password!'), findsOneWidget);
    });
  });
}
