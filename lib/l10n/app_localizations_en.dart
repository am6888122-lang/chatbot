// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Chatbot';

  @override
  String get settings => 'Settings';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get security => 'Security';

  @override
  String get language => 'Language';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get logout => 'Logout';

  @override
  String languageChanged(Object language) {
    return 'Language changed to $language';
  }

  @override
  String get selectImageSource => 'Select Image Source';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get cancel => 'Cancel';

  @override
  String get changePassword => 'Change Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get save => 'Save';

  @override
  String get biometricId => 'Biometric ID';

  @override
  String get changePin => 'Change PIN';

  @override
  String get fillYourProfile => 'Fill Your Profile';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get continueAction => 'Continue';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign Up';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get letsYouIn => 'Let\'s you in';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get password => 'Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get chat => 'Chat';

  @override
  String get startChat => 'Start Chat';

  @override
  String get homeChat => 'Home Chat';

  @override
  String get typeMessage => 'Type a message...';

  @override
  String get send => 'Send';

  @override
  String get settingsUpdated => 'Settings updated successfully';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get passwordChanged => 'Password changed successfully';

  @override
  String get pinChanged => 'PIN changed successfully';

  @override
  String get logoutConfirmation => 'Are you sure you want to log out?';

  @override
  String get yesLogout => 'Yes, Logout';

  @override
  String get loginToYourAccount => 'Login to your\nAccount';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get signIn => 'Sign in';

  @override
  String get orContinueWith => 'or continue with';

  @override
  String get activeChats => 'Active Chats';

  @override
  String get endedChats => 'Ended Chats';

  @override
  String get seeAll => 'See All';

  @override
  String get startAnotherChat => 'Start Another Chat with Bobo';
}
