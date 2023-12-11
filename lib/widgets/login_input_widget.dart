import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginInputWidget extends StatelessWidget {
  const LoginInputWidget({
    super.key,
    required this.controlador,
    required this.iconoDireccion,
    required this.placeholder,
    this.contrasena = false,
  });

  final TextEditingController controlador;
  final String iconoDireccion;
  final String placeholder;
  final bool? contrasena;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        width: 336,
        height: 51,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              SvgPicture.asset(iconoDireccion),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 250,
                child: TextFormField(
                  obscureText: contrasena!,
                  controller: controlador,
                  decoration: InputDecoration.collapsed(
                    hintText: placeholder,
                    hintStyle: GoogleFonts.lato(
                      color: const Color(0xFF848484),
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio!!';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
