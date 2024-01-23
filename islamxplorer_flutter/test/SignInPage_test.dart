import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:islamxplorer_flutter/main.dart';
import 'package:islamxplorer_flutter/pages/HomePage.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignInPage.dart';
import 'package:islamxplorer_flutter/pages/authPages/SignUpPage.dart';
import 'package:islamxplorer_flutter/widgets/utils/custom_button.dart';

void main() {
  group('SignInPage Widget Tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      // Verify that the title text is displayed.
      expect(find.text('Log In'), findsOneWidget);

      // Verify the presence of important widgets.
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password fields
      expect(find.byType(CustomButton), findsOneWidget);
    });

    testWidgets('Error message is displayed when login fails', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      // Tap the login button without entering credentials.
      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      // Verify that the error message is displayed.
      expect(find.text('Please enter email!'), findsOneWidget);
    });

    testWidgets('Tapping on Sign Up navigates to SignUpPage', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      // Tap on the Sign Up link.
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle(); // Wait for any animations to complete

      // Verify that the SignUpPage is pushed onto the navigation stack.
      expect(find.byType(Scaffold), findsOneWidget);

      // Verify that the Scaffold's AppBar has the correct title.
      expect(find.text('Sign Up'), findsOneWidget);
    });
  });

  group('SignInPage Details Tests', () {
    testWidgets('Entering valid email and password triggers login', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      // Enter a valid email and password.
      await tester.enterText(find.byKey(const Key('emailTextField')), '23324@students.riphah.edu.pk');
      await tester.enterText(find.byKey(const Key('passwordTextField')), '123123');

      // Tap on the login button.
      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      // Verify that the login was successful.
      // expect(find.byType(UserPage), findsOneWidget);
    });

    testWidgets('Entering invalid email shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      // Enter an invalid email.
      await tester.enterText(find.byKey(const Key('emailTextField')), 'invalid-email');

      // Tap on the login button.
      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      // Verify that an error message is displayed.
      expect(find.text('Please enter a valid email!'), findsOneWidget);
    });
    //
    testWidgets('Entering empty email shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      // Leave the email field empty.

      // Tap on the login button.
      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      // Verify that an error message is displayed.
      expect(find.text('Please enter email!'), findsOneWidget);
    });
    //
    testWidgets('Entering empty password shows error message', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignInPage()));

      // Enter a valid email.
      await tester.enterText(find.byKey(const Key('emailTextField')), 'valid@email.com');

      // Leave the password field empty.

      // Tap on the login button.
      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      // Verify that an error message is displayed.
      expect(find.text('Please enter password!'), findsOneWidget);
    });
  });
}
