// File: lib/providers/app_state_provider.dart

import 'package:flutter/material.dart';

enum AppPage { iframe, dashboard, static }

enum ActiveIframe { form, static }

class AppStateProvider extends ChangeNotifier {
  AppPage _currentPage = AppPage.iframe;
  ActiveIframe _activeIframe = ActiveIframe.form;
  bool _iframeVisible = true;
  String _receivedMessage = '';

  AppPage get currentPage => _currentPage;
  ActiveIframe get activeIframe => _activeIframe;
  bool get iframeVisible => _iframeVisible;
  String get receivedMessage => _receivedMessage;

  void changePage(AppPage page) {
    _currentPage = page;
    notifyListeners();
  }

  void toggleIframe() {
    _iframeVisible = !_iframeVisible;
    notifyListeners();
  }

  void switchIframe() {
    _activeIframe = _activeIframe == ActiveIframe.form
        ? ActiveIframe.static
        : ActiveIframe.form;
    notifyListeners();
  }

  void updateReceivedMessage(String message) {
    _receivedMessage = message;
    notifyListeners();
  }

  void clearMessage() {
    _receivedMessage = '';
    notifyListeners();
  }
}
