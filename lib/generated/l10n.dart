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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Super Fitness`
  String get app_name {
    return Intl.message(
      'Super Fitness',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `MALE`
  String get male {
    return Intl.message(
      'MALE',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `FEMALE`
  String get female {
    return Intl.message(
      'FEMALE',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `조선어`
  String get korean {
    return Intl.message(
      '조선어',
      name: 'korean',
      desc: '',
      args: [],
    );
  }

  /// `中文`
  String get chinese {
    return Intl.message(
      '中文',
      name: 'chinese',
      desc: '',
      args: [],
    );
  }

  /// `ໄທລາວ`
  String get lao {
    return Intl.message(
      'ໄທລາວ',
      name: 'lao',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Super Fitness`
  String get content_welcome {
    return Intl.message(
      'Welcome to Super Fitness',
      name: 'content_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Choose Mode`
  String get title_choose_mode {
    return Intl.message(
      'Choose Mode',
      name: 'title_choose_mode',
      desc: '',
      args: [],
    );
  }

  /// `Setting Language`
  String get setting_lang {
    return Intl.message(
      'Setting Language',
      name: 'setting_lang',
      desc: '',
      args: [],
    );
  }

  /// `Setting Gender`
  String get setting_gender {
    return Intl.message(
      'Setting Gender',
      name: 'setting_gender',
      desc: '',
      args: [],
    );
  }

  /// `MALE`
  String get gender_male {
    return Intl.message(
      'MALE',
      name: 'gender_male',
      desc: '',
      args: [],
    );
  }

  /// `FEMALE`
  String get gender_female {
    return Intl.message(
      'FEMALE',
      name: 'gender_female',
      desc: '',
      args: [],
    );
  }

  /// `Social Login Error`
  String get error_google_sign {
    return Intl.message(
      'Social Login Error',
      name: 'error_google_sign',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email_address {
    return Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signin {
    return Intl.message(
      'Sign in',
      name: 'signin',
      desc: '',
      args: [],
    );
  }

  /// `Apple`
  String get apple {
    return Intl.message(
      'Apple',
      name: 'apple',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get google {
    return Intl.message(
      'Google',
      name: 'google',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `My Favorite`
  String get my_favorite {
    return Intl.message(
      'My Favorite',
      name: 'my_favorite',
      desc: '',
      args: [],
    );
  }

  /// `My Course`
  String get my_coures {
    return Intl.message(
      'My Course',
      name: 'my_coures',
      desc: '',
      args: [],
    );
  }

  /// `Analysis`
  String get analysis {
    return Intl.message(
      'Analysis',
      name: 'analysis',
      desc: '',
      args: [],
    );
  }

  /// `My Alarms`
  String get alarm {
    return Intl.message(
      'My Alarms',
      name: 'alarm',
      desc: '',
      args: [],
    );
  }

  /// `View Profile`
  String get view_profile {
    return Intl.message(
      'View Profile',
      name: 'view_profile',
      desc: '',
      args: [],
    );
  }

  /// `App Version`
  String get app_version {
    return Intl.message(
      'App Version',
      name: 'app_version',
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

  /// `Premium Expired: `
  String get expired_date {
    return Intl.message(
      'Premium Expired: ',
      name: 'expired_date',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message(
      'Remember me',
      name: 'remember_me',
      desc: '',
      args: [],
    );
  }

  /// `Not register yet?`
  String get no_register {
    return Intl.message(
      'Not register yet?',
      name: 'no_register',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `The email validate is failed.`
  String get alert_email_error {
    return Intl.message(
      'The email validate is failed.',
      name: 'alert_email_error',
      desc: '',
      args: [],
    );
  }

  /// `The password is empty.`
  String get alert_password_error {
    return Intl.message(
      'The password is empty.',
      name: 'alert_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Create new account`
  String get create_new_account {
    return Intl.message(
      'Create new account',
      name: 'create_new_account',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message(
      'Full Name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `By signing up, I agree with the`
  String get desc_term_price {
    return Intl.message(
      'By signing up, I agree with the',
      name: 'desc_term_price',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Privacy`
  String get term_price {
    return Intl.message(
      'Terms & Privacy',
      name: 'term_price',
      desc: '',
      args: [],
    );
  }

  /// `You have already an account?`
  String get already_account {
    return Intl.message(
      'You have already an account?',
      name: 'already_account',
      desc: '',
      args: [],
    );
  }

  /// `Go to Login`
  String get goto_login {
    return Intl.message(
      'Go to Login',
      name: 'goto_login',
      desc: '',
      args: [],
    );
  }

  /// `Workout`
  String get workout {
    return Intl.message(
      'Workout',
      name: 'workout',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `workout(s)`
  String get workout_count {
    return Intl.message(
      'workout(s)',
      name: 'workout_count',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get all_category {
    return Intl.message(
      'All Categories',
      name: 'all_category',
      desc: '',
      args: [],
    );
  }

  /// `New Category(s)`
  String get new_category {
    return Intl.message(
      'New Category(s)',
      name: 'new_category',
      desc: '',
      args: [],
    );
  }

  /// `Hot Category(s)`
  String get hot_category {
    return Intl.message(
      'Hot Category(s)',
      name: 'hot_category',
      desc: '',
      args: [],
    );
  }

  /// `Current Course`
  String get current_course {
    return Intl.message(
      'Current Course',
      name: 'current_course',
      desc: '',
      args: [],
    );
  }

  /// `View All Histories >>`
  String get view_all_history {
    return Intl.message(
      'View All Histories >>',
      name: 'view_all_history',
      desc: '',
      args: [],
    );
  }

  /// `Alarms`
  String get alarms {
    return Intl.message(
      'Alarms',
      name: 'alarms',
      desc: '',
      args: [],
    );
  }

  /// `Please add your schedule time`
  String get set_alarm {
    return Intl.message(
      'Please add your schedule time',
      name: 'set_alarm',
      desc: '',
      args: [],
    );
  }

  /// `Please choose your favorite coures`
  String get set_favorite {
    return Intl.message(
      'Please choose your favorite coures',
      name: 'set_favorite',
      desc: '',
      args: [],
    );
  }

  /// `Everyday`
  String get everyday {
    return Intl.message(
      'Everyday',
      name: 'everyday',
      desc: '',
      args: [],
    );
  }

  /// `One time`
  String get onetime {
    return Intl.message(
      'One time',
      name: 'onetime',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get s_monday {
    return Intl.message(
      'Mon',
      name: 's_monday',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get s_tuesday {
    return Intl.message(
      'Tue',
      name: 's_tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get s_wednesday {
    return Intl.message(
      'Wed',
      name: 's_wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thr`
  String get s_thursday {
    return Intl.message(
      'Thr',
      name: 's_thursday',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get s_friday {
    return Intl.message(
      'Fri',
      name: 's_friday',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get s_saturday {
    return Intl.message(
      'Sat',
      name: 's_saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get s_sunday {
    return Intl.message(
      'Sun',
      name: 's_sunday',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Information`
  String get alarm_info {
    return Intl.message(
      'Alarm Information',
      name: 'alarm_info',
      desc: '',
      args: [],
    );
  }

  /// `You can add, edit, and delete for your alarms of Super Fitness.\nYou can see "+" floating button in right bottom of screen\n Also, you can see "Edit", "Delete" menu when click one alarm item of list.`
  String get alarm_info_desc {
    return Intl.message(
      'You can add, edit, and delete for your alarms of Super Fitness.\nYou can see "+" floating button in right bottom of screen\n Also, you can see "Edit", "Delete" menu when click one alarm item of list.',
      name: 'alarm_info_desc',
      desc: '',
      args: [],
    );
  }

  /// `Add Alarm`
  String get add_alarm {
    return Intl.message(
      'Add Alarm',
      name: 'add_alarm',
      desc: '',
      args: [],
    );
  }

  /// `Edit Alarm`
  String get edit_alarm {
    return Intl.message(
      'Edit Alarm',
      name: 'edit_alarm',
      desc: '',
      args: [],
    );
  }

  /// `Set Time`
  String get set_time {
    return Intl.message(
      'Set Time',
      name: 'set_time',
      desc: '',
      args: [],
    );
  }

  /// `Set Days`
  String get set_days {
    return Intl.message(
      'Set Days',
      name: 'set_days',
      desc: '',
      args: [],
    );
  }

  /// `Set Ringtone`
  String get set_ringtone {
    return Intl.message(
      'Set Ringtone',
      name: 'set_ringtone',
      desc: '',
      args: [],
    );
  }

  /// `Add Description`
  String get add_description {
    return Intl.message(
      'Add Description',
      name: 'add_description',
      desc: '',
      args: [],
    );
  }

  /// `Please input alarm description`
  String get alert_alarm_desc {
    return Intl.message(
      'Please input alarm description',
      name: 'alert_alarm_desc',
      desc: '',
      args: [],
    );
  }

  /// `Successfully add alarm`
  String get alert_alarm_add {
    return Intl.message(
      'Successfully add alarm',
      name: 'alert_alarm_add',
      desc: '',
      args: [],
    );
  }

  /// `Successfully edit alarm`
  String get alert_alarm_edit {
    return Intl.message(
      'Successfully edit alarm',
      name: 'alert_alarm_edit',
      desc: '',
      args: [],
    );
  }

  /// `Successfully delete alarm`
  String get alert_alarm_delete {
    return Intl.message(
      'Successfully delete alarm',
      name: 'alert_alarm_delete',
      desc: '',
      args: [],
    );
  }

  /// `Delete Alarm`
  String get delete_alarm {
    return Intl.message(
      'Delete Alarm',
      name: 'delete_alarm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `We just sent a verification code to you`
  String get send_code {
    return Intl.message(
      'We just sent a verification code to you',
      name: 'send_code',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verify_code {
    return Intl.message(
      'Verify Code',
      name: 'verify_code',
      desc: '',
      args: [],
    );
  }

  /// `You didn't get any code yet?`
  String get not_code {
    return Intl.message(
      'You didn\'t get any code yet?',
      name: 'not_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resend {
    return Intl.message(
      'Resend Code',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `We just sent a verification code again. Please check your email.`
  String get resend_desc {
    return Intl.message(
      'We just sent a verification code again. Please check your email.',
      name: 'resend_desc',
      desc: '',
      args: [],
    );
  }

  /// `You want to change your verification email?`
  String get change_email_desc {
    return Intl.message(
      'You want to change your verification email?',
      name: 'change_email_desc',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get change_email {
    return Intl.message(
      'Change Email',
      name: 'change_email',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Verification code is empty.`
  String get code_error {
    return Intl.message(
      'Verification code is empty.',
      name: 'code_error',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `lesson(s)`
  String get lesson_count {
    return Intl.message(
      'lesson(s)',
      name: 'lesson_count',
      desc: '',
      args: [],
    );
  }

  /// `Lesson`
  String get lesson {
    return Intl.message(
      'Lesson',
      name: 'lesson',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `You are a beginner or finished once course. Thank you.`
  String get lesson_empty {
    return Intl.message(
      'You are a beginner or finished once course. Thank you.',
      name: 'lesson_empty',
      desc: '',
      args: [],
    );
  }

  /// `Detail of Course`
  String get course_detail {
    return Intl.message(
      'Detail of Course',
      name: 'course_detail',
      desc: '',
      args: [],
    );
  }

  /// `Course During`
  String get course_during {
    return Intl.message(
      'Course During',
      name: 'course_during',
      desc: '',
      args: [],
    );
  }

  /// `Lesson During`
  String get lesson_during {
    return Intl.message(
      'Lesson During',
      name: 'lesson_during',
      desc: '',
      args: [],
    );
  }

  /// `Course Count`
  String get course_count {
    return Intl.message(
      'Course Count',
      name: 'course_count',
      desc: '',
      args: [],
    );
  }

  /// `Reapeat Time`
  String get repeat_time {
    return Intl.message(
      'Reapeat Time',
      name: 'repeat_time',
      desc: '',
      args: [],
    );
  }

  /// `Gym(s) of Course`
  String get course_gyms {
    return Intl.message(
      'Gym(s) of Course',
      name: 'course_gyms',
      desc: '',
      args: [],
    );
  }

  /// `Goto Course`
  String get goto_course {
    return Intl.message(
      'Goto Course',
      name: 'goto_course',
      desc: '',
      args: [],
    );
  }

  /// `Body Weight`
  String get body_weight {
    return Intl.message(
      'Body Weight',
      name: 'body_weight',
      desc: '',
      args: [],
    );
  }

  /// `Waist Measure`
  String get waist_measure {
    return Intl.message(
      'Waist Measure',
      name: 'waist_measure',
      desc: '',
      args: [],
    );
  }

  /// `Heart Rate`
  String get heart_rate {
    return Intl.message(
      'Heart Rate',
      name: 'heart_rate',
      desc: '',
      args: [],
    );
  }

  /// `Success Fitness`
  String get title_finish_course {
    return Intl.message(
      'Success Fitness',
      name: 'title_finish_course',
      desc: '',
      args: [],
    );
  }

  /// `Thanks very much for using our service.\nYou just finished one day course. Please try that continue. Left Days: `
  String get desc_finish_course {
    return Intl.message(
      'Thanks very much for using our service.\nYou just finished one day course. Please try that continue. Left Days: ',
      name: 'desc_finish_course',
      desc: '',
      args: [],
    );
  }

  /// `Premium Member`
  String get premium_member {
    return Intl.message(
      'Premium Member',
      name: 'premium_member',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get my_profile {
    return Intl.message(
      'My Profile',
      name: 'my_profile',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullname {
    return Intl.message(
      'Full Name',
      name: 'fullname',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get old_password {
    return Intl.message(
      'Old Password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get update_profile {
    return Intl.message(
      'Update Profile',
      name: 'update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Become a Premium`
  String get become_premium {
    return Intl.message(
      'Become a Premium',
      name: 'become_premium',
      desc: '',
      args: [],
    );
  }

  /// `Please correct old password.`
  String get error_old_password {
    return Intl.message(
      'Please correct old password.',
      name: 'error_old_password',
      desc: '',
      args: [],
    );
  }

  /// `The new password should be more then 6 characters.`
  String get error_new_password {
    return Intl.message(
      'The new password should be more then 6 characters.',
      name: 'error_new_password',
      desc: '',
      args: [],
    );
  }

  /// `The new password is not matched.`
  String get error_not_match {
    return Intl.message(
      'The new password is not matched.',
      name: 'error_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Your name is empty.`
  String get alt_error_name {
    return Intl.message(
      'Your name is empty.',
      name: 'alt_error_name',
      desc: '',
      args: [],
    );
  }

  /// `This course is a purchased course.`
  String get purchase_course {
    return Intl.message(
      'This course is a purchased course.',
      name: 'purchase_course',
      desc: '',
      args: [],
    );
  }

  /// `You need to upgrade the account for using this cousre.`
  String get purchase_course_detail {
    return Intl.message(
      'You need to upgrade the account for using this cousre.',
      name: 'purchase_course_detail',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to upgrade membership for now (5$)?`
  String get alert_upgrade_member {
    return Intl.message(
      'Do you want to upgrade membership for now (5\$)?',
      name: 'alert_upgrade_member',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade Now`
  String get upgrade_now {
    return Intl.message(
      'Upgrade Now',
      name: 'upgrade_now',
      desc: '',
      args: [],
    );
  }

  /// `- You can use the purchased course.`
  String get purchase_detail_01 {
    return Intl.message(
      '- You can use the purchased course.',
      name: 'purchase_detail_01',
      desc: '',
      args: [],
    );
  }

  /// `- You can use the analysis feature.`
  String get purchase_detail_02 {
    return Intl.message(
      '- You can use the analysis feature.',
      name: 'purchase_detail_02',
      desc: '',
      args: [],
    );
  }

  /// `- You need to pay 5$ per a month.`
  String get purchase_detail_03 {
    return Intl.message(
      '- You need to pay 5\$ per a month.',
      name: 'purchase_detail_03',
      desc: '',
      args: [],
    );
  }

  /// `Your name is invalid name`
  String get alt_name_error {
    return Intl.message(
      'Your name is invalid name',
      name: 'alt_name_error',
      desc: '',
      args: [],
    );
  }

  /// `Day(s)`
  String get course_day {
    return Intl.message(
      'Day(s)',
      name: 'course_day',
      desc: '',
      args: [],
    );
  }

  /// `In App Rate`
  String get in_app_rate {
    return Intl.message(
      'In App Rate',
      name: 'in_app_rate',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}