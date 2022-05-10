import 'dart:async';
import 'dart:ui';

import 'package:elnaamy_group/l10n/messages_all.dart';
import 'package:elnaamy_group/pages/adresse_pages/add_address.dart';
import 'package:elnaamy_group/pages/adresse_pages/edite_address.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  String get appTitle {
    return Intl.message('eln3my', name: 'appTitle');
  }

  String get phoneNumber {
    return Intl.message("Enter Field ", name: 'phoneNumber');
  }

  String get vldpasswordrequired {
    return Intl.message('Please enter the password ',
        name: 'vldpasswordrequired');
  }

  String get vldpasswordlength {
    return Intl.message('Password Length must be 6 charachters at least. ',
        name: 'vldpasswordlength');
  }

  String get vldphonerequired {
    return Intl.message('Please enter the phone number ',
        name: 'vldphonerequired');
  }

  String get vldphonelength {
    return Intl.message('Phone Length must be 6 charachters at least. ',
        name: 'vldphonelength');
  }

  String get locale {
    return Intl.message('en', name: 'locale');
  }

  String get login {
    return Intl.message('Login', name: 'login');
  }

  String get userName {
    return Intl.message('User Name', name: 'userName');
  }

  String get password {
    return Intl.message('Password', name: 'password');
  }

  String get resetPaasword {
    return Intl.message('Have you lost the password ?', name: 'resetPaasword');
  }

  String get signUp {
    return Intl.message('Sign Up', name: 'signUp');
  }

  String get email {
    return Intl.message('Email', name: 'email');
  }

  String get phone {
    return Intl.message('phone', name: 'phone');
  }

  String get iAgreeAll {
    return Intl.message('I Agree All', name: 'iAgreeAll');
  }

  String get termsAndConditions {
    return Intl.message('Terms And Conditions', name: 'termsAndConditions');
  }

  String get resetPasswordAppBar {
    return Intl.message('Reset Password', name: 'resetPasswordAppBar');
  }

  String get sendCode {
    return Intl.message(
        'We will send a code to your email address to set a new password',
        name: 'sendCode');
  }

  String get confirmPassword {
    return Intl.message('Confirm Password', name: 'confirmPassword');
  }

  String get send {
    return Intl.message('Send', name: 'send');
  }

  String get home {
    return Intl.message('Home', name: 'home');
  }

  String get section {
    return Intl.message('Section', name: 'section');
  }

  String get myOrders {
    return Intl.message('My Orders', name: 'myOrders');
  }

  String get favorits {
    return Intl.message('Favorits', name: 'favorits');
  }

  String get myAccount {
    return Intl.message('Account', name: 'myAccount');
  }

  String get searchForProduct {
    return Intl.message('Search For Product', name: 'searchForProduct');
  }

  String get product {
    return Intl.message('Product', name: 'product');
  }

  String get services {
    return Intl.message('Services', name: 'services');
  }

  String get offersAndDiscount {
    return Intl.message('Offers And Discount', name: 'offersAndDiscount');
  }

  String get shareApp {
    return Intl.message('Share App', name: 'shareApp');
  }

  String get aboutApp {
    return Intl.message('About App', name: 'aboutApp');
  }

  String get contactus {
    return Intl.message('Contact Us', name: 'contactus');
  }

  String get logOut {
    return Intl.message('Log Out', name: 'logOut');
  }

  String get sectionStore {
    return Intl.message('Section Store', name: 'sectionStore');
  }

  String get productMedicine {
    return Intl.message('Product Medicine', name: 'productMedicine');
  }

  String get servicesMedicine {
    return Intl.message('Services Medicine', name: 'servicesMedicine');
  }

  String get orderManagment {
    return Intl.message('Order Managment', name: 'orderManagment');
  }

  String get favoriteLists {
    return Intl.message('Favorite Lists', name: 'favoriteLists');
  }

  String get productFavorite {
    return Intl.message('Product Favorite', name: 'productFavorite');
  }

  String get servicesFavorite {
    return Intl.message('Services Favorite', name: 'servicesFavorite');
  }

  String get address {
    return Intl.message('Address', name: 'address');
  }

  String get accountDeatails {
    return Intl.message('Account Details', name: 'accountDeatails');
  }

  String get replacementAndReturnPolicy {
    return Intl.message('replacement/ReturnPolicy ',
        name: 'replacementAndReturnPolicy');
  }

  String get replaceMentAndReturnRequest {
    return Intl.message('replaceMent/Return Request',
        name: 'replaceMentAndReturnRequest');
  }

  String get priacyPolicy {
    return Intl.message('Priacy Policy', name: 'priacyPolicy');
  }

  String get newUser {
    return Intl.message('New User', name: 'newUser');
  }

  String get addCart {
    return Intl.message('Add Cart', name: 'addCart');
  }

  String get subscribenow {
    return Intl.message('Book Now', name: 'subscribenow');
  }

  String get addNotes {
    return Intl.message('Add Notes', name: 'addNotes');
  }

  String get notes {
    return Intl.message('Notes', name: 'notes');
  }

  String get close {
    return Intl.message('Close', name: 'close');
  }

  String get saveNow {
    return Intl.message('Save Now', name: 'saveNow');
  }

  String get productDetails {
    return Intl.message('Details', name: 'productDetails');
  }

  String get description {
    return Intl.message('Description', name: 'description');
  }

  String get productManagment {
    return Intl.message('Product Managment', name: 'productManagment');
  }

  String get dateOrder {
    return Intl.message('Date Order', name: 'dateOrder');
  }

  String get yourOrderNum {
    return Intl.message('Your order number', name: 'yourOrderNum');
  }

  String get sumOrder {
    return Intl.message('Sum Order', name: 'sumOrder');
  }

  String get serviceManagment {
    return Intl.message('Service Managment', name: 'serviceManagment');
  }

  String get ordersDetails {
    return Intl.message('Orders Details', name: 'ordersDetails');
  }

  String get welcomTo {
    return Intl.message('Welcom To', name: 'welcomTo');
  }

  String get shipingTo {
    return Intl.message('shiping To', name: 'shipingTo');
  }

  String get theProductIncludeYourOrder {
    return Intl.message('The products included in your order',
        name: 'theProductIncludeYourOrder');
  }

  String get returnProduct {
    return Intl.message('Return Product', name: 'returnProduct');
  }

  String get rateProduct {
    return Intl.message('Rate Product', name: 'rateProduct');
  }

  String get cantLoad {
    return Intl.message('Cant Load', name: 'cantLoad');
  }

  String get shopingCart {
    return Intl.message('Shoping Cart', name: 'shopingCart');
  }

  String get youShouldLogIn {
    return Intl.message('You Should Log In', name: 'youShouldLogIn');
  }

  String get noData {
    return Intl.message('No Data', name: 'noData');
  }

  String get notesToReqest {
    return Intl.message('Notes To Reqest', name: 'notesToReqest');
  }

  String get totalAmount {
    return Intl.message('Total Amount', name: 'totalAmount');
  }

  String get tax5vat {
    return Intl.message('Tax 5 % VAT', name: 'tax5vat');
  }

  String get thePriceIncludeTax {
    return Intl.message('The price includes tax', name: 'thePriceIncludeTax');
  }

  String get sum {
    return Intl.message('Sum', name: 'sum');
  }

  String get followUpThePurchase {
    return Intl.message('Follow Up The Purchase', name: 'followUpThePurchase');
  }

  String get areYouSure {
    return Intl.message('Are You Sure', name: 'areYouSure');
  }

  String get doYouWantRemove {
    return Intl.message('Do You want To Remove Te Item From cart',
        name: 'doYouWantRemove');
  }

  String get no {
    return Intl.message('No', name: 'no');
  }

  String get yes {
    return Intl.message('Yes', name: 'yes');
  }

  String get invoiceDetails {
    return Intl.message('Invoice Details', name: 'invoiceDetails');
  }

  String get noAddressGoToAddAddress {
    return Intl.message('No Address Go To Add Address',
        name: 'noAddressGoToAddAddress');
  }

  String get addAddress {
    return Intl.message('Add Address', name: 'addAddress');
  }

  String get selectAddress {
    return Intl.message('Select Address', name: 'selectAddress');
  }

  String get chanage {
    return Intl.message('Chanage', name: 'chanage');
  }

  String get yourOrder {
    return Intl.message('Your Order', name: 'yourOrder');
  }

  String get shipping {
    return Intl.message('Shipping', name: 'shipping');
  }

  String get addresses {
    return Intl.message('Addresses', name: 'addresses');
  }

  String get firstName {
    return Intl.message('First Name', name: 'firstName');
  }

  String get lastName {
    return Intl.message('Last Name', name: 'lastName');
  }

  String get zipCode {
    return Intl.message('ZipCode ', name: 'zipCode');
  }

  String get destination {
    return Intl.message('Destination ', name: 'destination');
  }

  String get region {
    return Intl.message('Region ', name: 'region');
  }

  String get editeAddress {
    return Intl.message('EditeAddress ', name: 'editeAddress');
  }

  String get confirmation {
    return Intl.message('Confirmation ', name: 'confirmation');
  }

  String get youShouldApproveTermsAndCondition {
    return Intl.message('You Should approve the terms and condition',
        name: 'youShouldApproveTermsAndCondition');
  }

  String get youShouldSelectaddress {
    return Intl.message('You Should Select Address',
        name: 'youShouldSelectaddress');
  }

  String get returnOrder {
    return Intl.message('Return Order', name: 'returnOrder');
  }

  String get reasonreturn {
    return Intl.message(' Reason Return', name: 'reasonreturn');
  }

  String get error {
    return Intl.message('Error', name: 'error');
  }

  String get noAddress {
    return Intl.message('No Address', name: 'noAddress');
  }

  String get someThingWorngHappen {
    return Intl.message(' Some Thing Worn gHappen',
        name: 'someThingWorngHappen');
  }

  String get resetPasswordActivate {
    return Intl.message('Reset Password Activate',
        name: 'resetPasswordActivate');
  }

  String get weWillSendCodeYouremail {
    return Intl.message(
        "We will send a code to your email address to set a new password",
        name: 'weWillSendCodeYouremail');
  }
  String get pinCode {
    return Intl.message('Pin Code', name: 'pinCode');
  }
  String get newPassword {
    return Intl.message('New Password', name: 'newPassword');
  }
   String get confirmNewPassword {
    return Intl.message('Confirm New Password', name: 'confirmNewPassword');
  }
   String get invalidCode {
    return Intl.message('Invalid Code', name: 'invalidCode');
  }
   String get save {
    return Intl.message('Save', name: 'save');
  }
   String get selectBranch {
    return Intl.message('SelectBranch', name: 'selectBranch');
  }
   String get connectUs {
    return Intl.message('Connect Us', name: 'connectUs');
  }
   String get message {
    return Intl.message('Message', name: 'message');
  }
   String get repeatPassword {
    return Intl.message('Repeat Password', name: 'repeatPassword');
  }
   String get replacementPolicy {
    return Intl.message('Replacement Policy', name: 'replacementPolicy');
  }
  String get replacementrequest {
    return Intl.message('Replacement Request', name: 'replacementrequest');
  }
  String get reason {
    return Intl.message('Reason', name: 'reason');
  }
   String get replaceMentAndReturn {
    return Intl.message('Replacement/Return', name: 'replaceMentAndReturn');
  }
  
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
