// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Groupie`
  String get appTitle {
    return Intl.message(
      'Groupie',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Login now to see what they are talking!`
  String get loginSlogan {
    return Intl.message(
      'Login now to see what they are talking!',
      name: 'loginSlogan',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get Email {
    return Intl.message(
      'Email',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get EmailValidation {
    return Intl.message(
      'Please enter a valid email',
      name: 'EmailValidation',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get PasswordValidation {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'PasswordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message(
      'Sign In',
      name: 'SignIn',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get DontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'DontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register here`
  String get RegisterHere {
    return Intl.message(
      'Register here',
      name: 'RegisterHere',
      desc: '',
      args: [],
    );
  }

  /// `Create your account now to chat and explore`
  String get registerSlogan {
    return Intl.message(
      'Create your account now to chat and explore',
      name: 'registerSlogan',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get nameValidation {
    return Intl.message(
      'Name cannot be empty',
      name: 'nameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get haveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login now`
  String get loginNow {
    return Intl.message(
      'Login now',
      name: 'loginNow',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get groups {
    return Intl.message(
      'Groups',
      name: 'groups',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to Logout?`
  String get reallyLogout {
    return Intl.message(
      'Are you sure to Logout?',
      name: 'reallyLogout',
      desc: '',
      args: [],
    );
  }

  /// `Choose a language`
  String get chooseLanguage {
    return Intl.message(
      'Choose a language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Language Changed Successfully!`
  String get langChanged {
    return Intl.message(
      'Language Changed Successfully!',
      name: 'langChanged',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Create a group`
  String get createAGroup {
    return Intl.message(
      'Create a group',
      name: 'createAGroup',
      desc: '',
      args: [],
    );
  }

  /// `CANCLE`
  String get cancle {
    return Intl.message(
      'CANCLE',
      name: 'cancle',
      desc: '',
      args: [],
    );
  }

  /// `Group Created Successfully.`
  String get groupCreated {
    return Intl.message(
      'Group Created Successfully.',
      name: 'groupCreated',
      desc: '',
      args: [],
    );
  }

  /// `CREATE`
  String get create {
    return Intl.message(
      'CREATE',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `You have not joined any group, tap on the add icon to create a group or also search from top search button`
  String get createGroupDesc {
    return Intl.message(
      'You have not joined any group, tap on the add icon to create a group or also search from top search button',
      name: 'createGroupDesc',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Search Groups...`
  String get searchGroups {
    return Intl.message(
      'Search Groups...',
      name: 'searchGroups',
      desc: '',
      args: [],
    );
  }

  /// `Successfully joined the group`
  String get groupJoined {
    return Intl.message(
      'Successfully joined the group',
      name: 'groupJoined',
      desc: '',
      args: [],
    );
  }

  /// `Left the group `
  String get groupLeft {
    return Intl.message(
      'Left the group ',
      name: 'groupLeft',
      desc: '',
      args: [],
    );
  }

  /// `Joined`
  String get joined {
    return Intl.message(
      'Joined',
      name: 'joined',
      desc: '',
      args: [],
    );
  }

  /// `Join Now`
  String get joinNow {
    return Intl.message(
      'Join Now',
      name: 'joinNow',
      desc: '',
      args: [],
    );
  }

  /// `Admin:`
  String get displayAdmin {
    return Intl.message(
      'Admin:',
      name: 'displayAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Group Info`
  String get groupInfo {
    return Intl.message(
      'Group Info',
      name: 'groupInfo',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to Exit the group?`
  String get exitText {
    return Intl.message(
      'Are you sure to Exit the group?',
      name: 'exitText',
      desc: '',
      args: [],
    );
  }

  /// `Join the conversation as `
  String get groupTileSubTitle {
    return Intl.message(
      'Join the conversation as ',
      name: 'groupTileSubTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
