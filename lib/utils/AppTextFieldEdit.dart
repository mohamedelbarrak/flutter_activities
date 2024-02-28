import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

enum TextFieldTypeEdit{
  EMAIL,
  PASSWORD,
  NAME,
@Deprecated('Use MULTILINE instead. ADDRESS will be removed in major update')
ADDRESS,
MULTILINE,
OTHER,
PHONE,
URL,
NUMBER,
USERNAME
}

/// Default Text Form Field
class AppTextFieldEdit extends StatefulWidget {
  final TextEditingController? controller;
  final TextFieldType? textFieldTypeEdit;
  final InputDecoration? decoration;
  final FocusNode? focus;
  final FormFieldValidator<String>? validator;
  final bool? isPassword;
  final bool? isValidationRequired;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final FocusNode? nextFocus;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final bool? autoFocus;
  final bool? readOnly;
  final bool? enableSuggestions;
  final int? maxLength;
  final Color? cursorColor;
  final Widget? suffix;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final Iterable<String>? autoFillHints;
  final EdgeInsets? scrollPadding;
  final double? cursorWidth;
  final double? cursorHeight;
  final Function()? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final bool? showCursor;
  final TextSelectionControls? selectionControls;
  final StrutStyle? strutStyle;
  final String? obscuringCharacter;
  final String? initialValue;
  final Brightness? keyboardAppearance;
  final ToolbarOptions? toolbarOptions;
  final Widget? suffixPasswordVisibleWidget;
  final Widget? suffixPasswordInvisibleWidget;

  final String? errorThisFieldRequired;
  final String? errorInvalidEmail;
  final String? errorMinimumPasswordLength;
  final String? errorRetypePassword;
  final TextEditingController? retypePassword;
  final String? errorInvalidURL;
  final String? errorInvalidUsername;

  AppTextFieldEdit({
    this.controller,
    this.textFieldTypeEdit,
    this.decoration,
    this.focus,
    this.validator,
    this.isPassword,
    this.buildCounter,
    this.isValidationRequired,
    this.textCapitalization,
    this.textInputAction,
    this.onFieldSubmitted,
    this.nextFocus,
    this.textStyle,
    this.textAlign,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.onChanged,
    this.cursorColor,
    this.suffix,
    this.suffixIconColor,
    this.enableSuggestions,
    this.autoFocus,
    this.readOnly,
    this.maxLength,
    this.keyboardType,
    this.autoFillHints,
    this.scrollPadding,
    this.onTap,
    this.cursorWidth,
    this.cursorHeight,
    this.inputFormatters,
    this.errorThisFieldRequired,
    this.errorInvalidEmail,
    this.errorMinimumPasswordLength,
    this.errorRetypePassword,
    this.retypePassword,
    this.errorInvalidURL,
    this.errorInvalidUsername,
    this.textAlignVertical,
    this.expands,
    this.showCursor,
    this.selectionControls,
    this.strutStyle,
    this.obscuringCharacter,
    this.initialValue,
    this.keyboardAppearance,
    this.toolbarOptions,
    this.suffixPasswordVisibleWidget,
    this.suffixPasswordInvisibleWidget,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldEditState createState() => _AppTextFieldEditState();
}

class _AppTextFieldEditState extends State<AppTextFieldEdit> {
  bool isPasswordVisible = false;

  FormFieldValidator<String>? applyValidation() {
    if (widget.isValidationRequired.validate(value: true)) {
      if (widget.validator != null) {
        return widget.validator;
      } else if (widget.textFieldTypeEdit == TextFieldType.EMAIL) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: errorThisFieldRequired);
          if (!s.trim().validateEmail())
            return widget.errorInvalidEmail.validate(value: 'Email is invalid');
          return null;
        };
      } else if (widget.textFieldTypeEdit == TextFieldType.PASSWORD) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: errorThisFieldRequired);
          if (s.trim().length < passwordLengthGlobal)
            return widget.errorMinimumPasswordLength.validate(
                value:
                'Minimum password length should be $passwordLengthGlobal');
          if (s.trim() != widget.retypePassword?.text)
            return widget.errorRetypePassword.validate(
                value:
                'Password and confirm password should be same');
          return null;
        };
      } else if (widget.textFieldTypeEdit == TextFieldType.NAME ||
          widget.textFieldTypeEdit == TextFieldType.PHONE ||
          widget.textFieldTypeEdit == TextFieldType.NUMBER) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: errorThisFieldRequired);
          // if (s.trim() == 0)
          //   return widget.errorThisFieldRequired
          //       .validate(value: "Price should be greater than 0");
          return null;
        };
      } else if (widget.textFieldTypeEdit == TextFieldType.URL) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: errorThisFieldRequired);
          if (!s.validateURL()) {
            return widget.errorInvalidURL.validate(value: 'Invalid URL');
          }
          return null;
        };
      } else if (widget.textFieldTypeEdit == TextFieldType.USERNAME) {
        return (s) {
          if (s!.trim().isEmpty)
            return widget.errorThisFieldRequired
                .validate(value: errorThisFieldRequired);
          if (s.contains(' ')) {
            return widget.errorInvalidUsername
                .validate(value: 'Username should not contain space');
          }
          return null;
        };
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  TextCapitalization? applyTextCapitalization() {
    if (widget.textCapitalization != null) {
      return widget.textCapitalization;
    } else if (widget.textFieldTypeEdit == TextFieldType.NAME) {
      return TextCapitalization.words;
    } else if (widget.textFieldTypeEdit == TextFieldType.ADDRESS ||
        widget.textFieldTypeEdit == TextFieldType.MULTILINE) {
      return TextCapitalization.sentences;
    } else {
      return TextCapitalization.none;
    }
  }

  TextInputAction? applyTextInputAction() {
    if (widget.textInputAction != null) {
      return widget.textInputAction;
    } else if (widget.textFieldTypeEdit == TextFieldType.ADDRESS ||
        widget.textFieldTypeEdit == TextFieldType.MULTILINE) {
      return TextInputAction.newline;
    } else if (widget.nextFocus != null) {
      return TextInputAction.next;
    } else {
      return TextInputAction.done;
    }
  }

  TextInputType? applyTextInputType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType;
    } else if (widget.textFieldTypeEdit == TextFieldType.EMAIL) {
      return TextInputType.emailAddress;
    } else if (widget.textFieldTypeEdit == TextFieldType.ADDRESS ||
        widget.textFieldTypeEdit == TextFieldType.MULTILINE) {
      return TextInputType.multiline;
    } else if (widget.textFieldTypeEdit == TextFieldType.PASSWORD) {
      return TextInputType.visiblePassword;
    } else if (widget.textFieldTypeEdit == TextFieldType.PHONE ||
        widget.textFieldTypeEdit == TextFieldType.NUMBER) {
      return TextInputType.number;
    } else if (widget.textFieldTypeEdit == TextFieldType.URL) {
      return TextInputType.url;
    } else {
      return TextInputType.text;
    }
  }

  void onPasswordVisibilityChange(bool val) {
    isPasswordVisible = val;
    setState(() {});
  }

  Widget? suffixIcon() {
    if (widget.textFieldTypeEdit == TextFieldType.PASSWORD) {
      if (widget.suffix != null) {
        return widget.suffix;
      } else {
        if (isPasswordVisible) {
          if (widget.suffixPasswordVisibleWidget != null) {
            return widget.suffixPasswordVisibleWidget.onTap(() {
              onPasswordVisibilityChange(false);
            });
          } else {
            return Icon(
              Icons.visibility,
              color:
              widget.suffixIconColor ?? Theme.of(context).iconTheme.color,
            ).onTap(() {
              onPasswordVisibilityChange(false);
            });
          }
        } else {
          if (widget.suffixPasswordInvisibleWidget != null) {
            return widget.suffixPasswordInvisibleWidget.onTap(() {
              onPasswordVisibilityChange(true);
            });
          } else {
            return Icon(
              Icons.visibility_off,
              color:
              widget.suffixIconColor ?? Theme.of(context).iconTheme.color,
            ).onTap(() {
              onPasswordVisibilityChange(true);
            });
          }
        }
      }
    } else {
      return widget.suffix;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText:
      widget.textFieldTypeEdit == TextFieldType.PASSWORD && !isPasswordVisible,
      validator: applyValidation(),
      // textCapitalization: applyTextCapitalization(),
      textInputAction: applyTextInputAction(),
      onFieldSubmitted: (s) {
        if (widget.nextFocus != null)
          FocusScope.of(context).requestFocus(widget.nextFocus);

        if (widget.onFieldSubmitted != null) widget.onFieldSubmitted?.call(s);
      },
      keyboardType: applyTextInputType(),
      decoration: widget.decoration != null
          ? (widget.decoration?.copyWith(
        suffixIcon: suffixIcon(),
      ))
          : InputDecoration(),
      focusNode: widget.focus,
      style: widget.textStyle ?? primaryTextStyle(),
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: (widget.textFieldTypeEdit == TextFieldType.ADDRESS ||
          widget.textFieldTypeEdit == TextFieldType.MULTILINE)
          ? null
          : widget.maxLines.validate(value: 1),
      minLines: widget.minLines.validate(
          value: widget.textFieldTypeEdit == TextFieldType.MULTILINE ? 3 : 1),
      autofocus: widget.autoFocus ?? false,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      cursorColor: widget.cursorColor ??
          Theme.of(context).textSelectionTheme.cursorColor,
      readOnly: widget.readOnly.validate(),
      maxLength: widget.maxLength,
      enableSuggestions: widget.enableSuggestions.validate(value: true),
      autofillHints: widget.autoFillHints,
      scrollPadding: widget.scrollPadding ?? EdgeInsets.all(20),
      cursorWidth: widget.cursorWidth.validate(value: 2.0),
      cursorHeight: widget.cursorHeight,
      cursorRadius: radiusCircular(4),
      onTap: widget.onTap,
      buildCounter: widget.buildCounter,
      scrollPhysics: BouncingScrollPhysics(),
      enableInteractiveSelection: true,
      inputFormatters: widget.inputFormatters,
      textAlignVertical: widget.textAlignVertical,
      expands: widget.expands.validate(),
      showCursor: widget.showCursor,
      selectionControls: widget.selectionControls,
      strutStyle: widget.strutStyle,
      obscuringCharacter: widget.obscuringCharacter.validate(value: '•'),
      initialValue: widget.initialValue,
      keyboardAppearance: widget.keyboardAppearance,
      toolbarOptions: widget.toolbarOptions,
    );
  }
}
