import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sat_m/providers/condiciones_comunidades_provider.dart';
import 'package:sat_m/providers/condiciones_familias_provider.dart';
import 'package:sat_m/providers/satm_familias_provider.dart';

class InputSencilloConValidacion extends StatelessWidget {
  final TextEditingController controlador;
  final String pregunta;
  final String? placeholder;
  final bool readOnly;

  const InputSencilloConValidacion({
    required this.controlador,
    required this.pregunta,
    this.placeholder,
    this.readOnly = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: (readOnly) ? false : true,
      controller: controlador,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        hintText: placeholder,
        hintStyle: GoogleFonts.lato(fontSize: 16, color: Colors.black),
        labelText: pregunta,
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }
}

class InputSencilloSinValidacion extends StatelessWidget {
  final TextEditingController controlador;
  final String pregunta;
  final String? placeholder;

  const InputSencilloSinValidacion({
    required this.controlador,
    required this.pregunta,
    this.placeholder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: placeholder,
        hintStyle: GoogleFonts.lato(fontSize: 16, color: Colors.black),
        labelText: pregunta,
      ),
    );
  }
}

class InputSencilloSinValidacionSoloNumeros extends StatelessWidget {
  final TextEditingController controlador;
  final String pregunta;
  final String? placeholder;
  final int cuantosNumeros;

  const InputSencilloSinValidacionSoloNumeros({
    required this.controlador,
    required this.pregunta,
    this.placeholder,
    required this.cuantosNumeros,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: cuantosNumeros,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        hintText: placeholder,
        hintStyle: GoogleFonts.lato(fontSize: 16, color: Colors.black),
        labelText: pregunta,
        counterText: 'solo números',
        counterStyle:
            const TextStyle(fontStyle: FontStyle.italic, color: Colors.indigo),
      ),
    );
  }
}

class InputSencilloSinValidacionSinCuadroSoloNumeros extends StatelessWidget {
  const InputSencilloSinValidacionSinCuadroSoloNumeros({
    required this.controlador,
    required this.cuantosNumeros,
    this.fok = false,
    super.key,
  });

  final TextEditingController controlador;
  final int cuantosNumeros;
  final bool? fok;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: fok!,
      controller: controlador,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: cuantosNumeros,
      decoration: const InputDecoration(
        counterStyle:
            TextStyle(fontStyle: FontStyle.italic, color: Colors.indigo),
        counterText: '',
      ),
    );
  }
}

class InputSencilloConValidacionSinCuadroSoloNumeros extends StatelessWidget {
  const InputSencilloConValidacionSinCuadroSoloNumeros({
    required this.controlador,
    required this.cuantosNumeros,
    this.fok = false,
    super.key,
  });

  final TextEditingController controlador;
  final int cuantosNumeros;
  final bool? fok;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: fok!,
      controller: controlador,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: cuantosNumeros,
      decoration: const InputDecoration(
        counterStyle:
            TextStyle(fontStyle: FontStyle.italic, color: Colors.indigo),
        counterText: '',
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }
}

class InputSencilloSinValidacionSinCuadro extends StatelessWidget {
  final TextEditingController controlador;
  final String pregunta;
  final String? placeholder;

  const InputSencilloSinValidacionSinCuadro({
    required this.controlador,
    required this.pregunta,
    this.placeholder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );
  }
}

class InputSencilloConValidacionSoloNumeros extends StatelessWidget {
  final TextEditingController controlador;
  final String pregunta;
  final String? placeholder;
  final int cuantosNumeros;
  final bool? caso12Comunidades;
  final bool? condicionNinaNino;

  const InputSencilloConValidacionSoloNumeros({
    required this.controlador,
    required this.pregunta,
    this.placeholder,
    required this.cuantosNumeros,
    this.caso12Comunidades = false,
    this.condicionNinaNino = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: cuantosNumeros,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: placeholder,
        labelText: pregunta,
        counterText: 'solo números',
        counterStyle:
            const TextStyle(fontStyle: FontStyle.italic, color: Colors.indigo),
      ),
      onChanged: (value) {
        if (caso12Comunidades != null && caso12Comunidades == true) {
          var condicionesComunidadesProvider =
              Provider.of<CondicionesComunidadesProvider>(context,
                  listen: false);
          if (value != "00" && value != "" && int.parse(value) > 0) {
            condicionesComunidadesProvider.valorCondicion12 = true;
          } else {
            condicionesComunidadesProvider.valorCondicion12 = false;
          }
        }

        if (condicionNinaNino != null && condicionNinaNino == true) {
          var condicionesFamiliasProvider =
              Provider.of<CondicionesFamiliasProvider>(context, listen: false);
          var familiasProvider =
              Provider.of<SatmFamiliasProvider>(context, listen: false);
          if (familiasProvider.nina.text != "00" &&
              familiasProvider.nina.text != "" &&
              int.parse(familiasProvider.nina.text) > 0) {
            condicionesFamiliasProvider.valorCondicionNinaNino = true;
          } else if (familiasProvider.nino.text != "00" &&
              familiasProvider.nino.text != "" &&
              int.parse(familiasProvider.nino.text) > 0) {
            condicionesFamiliasProvider.valorCondicionNinaNino = true;
          } else {
            condicionesFamiliasProvider.valorCondicionNinaNino = false;
          }
        }
      },
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }
}

class InputTextAreaSinValidacion extends StatelessWidget {
  final TextEditingController controlador;
  final String pregunta;
  final String? placeholder;

  const InputTextAreaSinValidacion({
    required this.controlador,
    required this.pregunta,
    this.placeholder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 5,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
      maxLines: null,
      controller: controlador,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: placeholder,
        labelText: pregunta,
      ),
    );
  }
}

class InputTextAreaConValidacion extends StatelessWidget {
  final TextEditingController controlador;
  final String pregunta;
  final String? placeholder;

  const InputTextAreaConValidacion({
    required this.controlador,
    required this.pregunta,
    this.placeholder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 5,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
      maxLines: null,
      controller: controlador,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: placeholder,
        labelText: pregunta,
      ),
      validator: (valor) {
        if (valor == null || valor.isEmpty) {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }
}
