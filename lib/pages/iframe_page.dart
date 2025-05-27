// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';

class IframePage extends StatefulWidget {
  const IframePage({super.key});

  @override
  State<IframePage> createState() => _IframePageState();
}

class _IframePageState extends State<IframePage> {
  html.IFrameElement? _formIframe;
  html.IFrameElement? _staticIframe;
  Widget? _iframeWidget;

  @override
  void initState() {
    super.initState();

    // Create form iframe
    _formIframe = html.IFrameElement()
      ..src = 'web/assets/html/iframe_form.html'
      ..style.border = 'none'
      ..width = '100%'
      ..height = '400'
      ..id = 'formIframe';

    // Create static iframe
    _staticIframe = html.IFrameElement()
      ..src = 'web/assets/html/iframe_static.html'
      ..style.border = 'none'
      ..width = '100%'
      ..height = '400'
      ..id = 'staticIframe';

    // Listen to messages from iframe
    html.window.onMessage.listen((event) {
      if (event.data != null && event.origin == html.window.location.origin) {
        if (!mounted) return;
        context.read<AppStateProvider>().updateReceivedMessage(
          event.data['message'],
        );
      }
    });

    _updateIframeWidget();
  }

  void _updateIframeWidget() {
    final provider = context.read<AppStateProvider>();
    final iframe = provider.activeIframe == ActiveIframe.form
        ? _formIframe
        : _staticIframe;

    setState(() {
      _iframeWidget = HtmlElementView(viewType: iframe!.id);
    });

    // Register iframe view factory
    ui.platformViewRegistry.registerViewFactory(iframe!.id, (int _) => iframe);
  }

  void _sendMessageToIframe() {
    final provider = context.read<AppStateProvider>();
    final message = "Hello from Flutter!";
    final targetIframe = provider.activeIframe == ActiveIframe.form
        ? _formIframe
        : _staticIframe;
    if (targetIframe?.contentWindow != null) {
      targetIframe!.contentWindow!.postMessage({
        'type': 'updateText',
        'message': message,
      }, html.window.location.origin);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppStateProvider>();
    final activeIframe = provider.activeIframe == ActiveIframe.form
        ? 'Static Iframe'
        : 'Form Iframe';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton(
                onPressed: () {
                  provider.switchIframe();
                  _updateIframeWidget();
                },
                child: Text('Switch $activeIframe'),
              ),
              ElevatedButton(
                onPressed: () => provider.toggleIframe(),
                child: Text(
                  provider.iframeVisible ? 'Hide Iframe' : 'Show Iframe',
                ),
              ),
              ElevatedButton(
                onPressed: _sendMessageToIframe,
                child: const Text('Send Message to Iframe'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (provider.iframeVisible && _iframeWidget != null)
            SizedBox(height: 300, child: _iframeWidget),
          const SizedBox(height: 20),
          if (provider.receivedMessage.isNotEmpty)
            Text(
              "Message from iframe: ${provider.receivedMessage}",
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
        ],
      ),
    );
  }
}
