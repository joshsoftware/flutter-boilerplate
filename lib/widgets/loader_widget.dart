import 'package:flutter/material.dart';

class LoaderWidget {
  static OverlayEntry _overlayEntry;
  static bool _onScreen = false;

  static bool isLoaderOn() => _onScreen;

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

  //Loader can be changed from here
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
