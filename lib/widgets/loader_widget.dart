import 'package:flutter/material.dart';

class LoaderWidget {
  static OverlayEntry _overlayEntry;
  static bool _onScreen = false;

  static bool isLoading() {
    if (_onScreen) {
      return true;
    }
    return false;
  }

  static void showLoader(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());

    hideLoader(context);

    _overlayEntry = createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry);
    _onScreen = true;
  }

  static void hideLoader(BuildContext context) {
    if (_onScreen) {
      _overlayEntry.remove();
      _onScreen = false;
    }
  }

  static OverlayEntry createOverlayEntry(BuildContext context) {
    return OverlayEntry(
        builder: (context) => Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Material(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
            ));
  }
}
