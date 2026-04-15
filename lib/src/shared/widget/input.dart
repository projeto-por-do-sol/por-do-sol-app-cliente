import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;
  final bool isPhoneOrEmail;
  final bool isRequired;

  CustomInput({
    super.key,
    required this.label,
    this.isPassword = false,
    this.controller,
    this.isEmail = false,
    this.isPhone = false,
    this.isPhoneOrEmail = false,
    this.isRequired = true,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late bool _obscureText;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 2),
          TextFormField(
            focusNode: _focusNode,
            keyboardType: widget.isEmail || widget.isPhoneOrEmail ? TextInputType.emailAddress : TextInputType.text,
            controller: widget.controller,
            obscureText: _obscureText && widget.isPassword,
            validator: (value) {
              if (widget.isRequired && (value == null || value.isEmpty)) {
                return 'Este campo é obrigatório';
              }

              if (value == null || value.isEmpty) return null;

              final valorLimpo = value.trim();

              if (widget.isPhone) {
                final phoneNumbers = valorLimpo.replaceAll(RegExp(r'[^0-9]'), '');

                if (phoneNumbers.length != 11) {
                  return 'Telefone inválido (use DDD + número)';
                }
                return null;
              }

              final bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(valorLimpo);

              if (widget.isEmail && !emailValid) {
                return 'Insira um e-mail válido';
              }

              if (widget.isPhoneOrEmail) {
                final phoneNumbers = valorLimpo.replaceAll(RegExp(r'[^0-9]'), '');
                final bool phoneValid = phoneNumbers.length == 11;

                if (!emailValid && !phoneValid) {
                  return 'Insira um e-mail ou telefone válido';
                }
              }

              return null;
            },

            decoration: InputDecoration(
              suffixIcon: !widget.isPassword ? null : InkWell(
                onTap: () {
                  _obscureText = !_obscureText;
                  setState(() {});
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: _focusNode.hasFocus ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2.0,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3.0,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 2.0,
                ),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 3.0,
                ),
              ),

              filled: true,
              fillColor: Colors.white,

            ),
          ),
        ],
      ),
    );
  }
}