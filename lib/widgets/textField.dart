import 'package:bloc_pattern_flutter_app/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextField extends StatefulWidget {
  RoundedTextField(
      {Key key,
      @required this.hint,
      this.parentAction,
      this.isPassword: false,
      this.isReadOnly: false,
      this.isEnabled: true,
      @required this.keyboardType,
      this.maxLength,
      this.inputFormatters,
      this.initialValue,
      this.textCapitalization: TextCapitalization.none,
      @required this.controller,
      this.textAlign: TextAlign.left})
      : super(key: key);

  final String hint;
  final String initialValue;
  final int maxLength;
  final bool isPassword;
  final bool isReadOnly;
  final bool isEnabled;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;

  final List<TextInputFormatter> inputFormatters;
  final void Function(String value) parentAction;

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool passwordVisible;

  @override
  void initState() {
    // TODO: implement initState
    passwordVisible = widget.isPassword;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Container(
        height: 50,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 40,
                child: TextFormField(
                  onChanged: (value) {
                    if (widget.parentAction != null) {
                      widget.parentAction(value);
                    }
                  },
                  textCapitalization: widget.textCapitalization,
                  textAlign: widget.textAlign,
                  initialValue: widget.initialValue,
                  inputFormatters: widget.inputFormatters,
                  obscureText: passwordVisible,
                  readOnly: widget.isReadOnly,
                  enabled: widget.isEnabled,
                  maxLength: widget.maxLength,
                  keyboardType: widget.keyboardType,
                  cursorColor: Constant.colorPurpleLight,
                  controller: widget.controller,
                  decoration: new InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(left: widget.textAlign == TextAlign.center ? 0 : 20),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Constant.colorPurpleLight, width: 1.2),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                        ),
                      ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Constant.colorPurpleLight, width: 1.2),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                        ),
                      ),
                    border: UnderlineInputBorder(),
                    filled: true,
                    labelStyle: TextStyle(fontFamily: Constant.fontMyraidPro),
                    hintStyle: new TextStyle(
                      color: Constant.colorGray,
                      fontSize: 16,
                      fontFamily: Constant.fontMyraidPro,
                      ),
                    hintText: widget.hint,
                    fillColor: Constant.colorWhite,
                    suffixIcon: widget.isPassword ? IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Constant.colorPurpleLight,
                        ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        debugPrint("Clicked : $passwordVisible");
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                        FocusScope.of(context).unfocus();
                      },
                      ) : null,
                    ),
                  ),
              ),
            ),

            Positioned(
                top: 0,
                left: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: Constant.colorWhite,
                        padding: EdgeInsets.only(left: 3,right: 3),
                        child:  Text(
                          widget.hint,
                          maxLines: 1,
                          style: TextStyle(fontFamily: Constant.fontMonsterRat, color: Constant.colorPurpleLight,fontSize: 10),
                          ),
                        )
                    ],
                  )
                  )),

          ],
        ));
  }
}
