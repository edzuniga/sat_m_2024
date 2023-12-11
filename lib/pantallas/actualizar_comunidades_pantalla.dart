import 'dart:io';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:location/location.dart';

import 'package:sat_m/bd/bd.dart';
import 'package:sat_m/modales/permiso_ubicacion.dart';
import 'package:sat_m/modales/salir_formulario_actualizar_modal.dart';
import 'package:sat_m/modelos/satm_comunidades_modelo.dart';
import 'package:sat_m/providers/condiciones_comunidades_provider.dart';
import 'package:sat_m/providers/satm_comunidades_provider.dart';
import 'package:sat_m/widgets/dropdowns_widget.dart';
import 'package:sat_m/widgets/inputs_sencillos_widget.dart';
import 'package:sat_m/constantes/colores_constantes.dart';

class ActualizarComunidadesPantalla extends StatefulWidget {
  const ActualizarComunidadesPantalla(
      {required this.idPais, required this.codaleaRecibido, Key? key})
      : super(key: key);

  final String codaleaRecibido;
  final int idPais;

  @override
  State<ActualizarComunidadesPantalla> createState() =>
      _ActualizarComunidadesPantallaState();
}

class _ActualizarComunidadesPantallaState
    extends State<ActualizarComunidadesPantalla> {
  //Llave del formulario
  final _llave = GlobalKey<FormState>();

  //Variable para el checkbox de CONSENTIMIENTO
  final bool consentimiento = true;

  @override
  Widget build(BuildContext context) {
    //Iniciar Providers necesarios
    var providerComunidades = Provider.of<SatmComunidadesProvider>(context);
    var condicionesProvider =
        Provider.of<CondicionesComunidadesProvider>(context);

    //Variables que dependen del IDPAIS
    String nombrePais = "";
    String textoConsentimiento = "";
    //String pregunta14 = "";

    switch (widget.idPais) {
      //Honduras
      case 1:
        nombrePais = 'HONDURAS';
        textoConsentimiento =
            'Buenos días/tardes, gracias por tomarse el tiempo para reunirse conmigo hoy. Mi nombre es [ ] y formo parte del equipo de World Vision Honduras. Actualmente, la organización está llevando a cabo un levantamiento de información en diferentes zonas del país, para conocer las opiniones de la población respecto a la condición socioeconómica de los hogares, y la percepción sobre la situación de la migración forzada, entre otros temas.\n\nEn esta oportunidad, Usted ha sido identificado como informante calificado y mi visita tiene el propósito de solicitar su colaboración para llevar a cabo una entrevista y llenar una encuesta. Es importante destacar que su participación es voluntaria, y que la información obtenida es confidencial; si hay una o más preguntas, que no quisiera responder o terminar la conversación antes de finalizar la encuesta; siéntase en la libertad de comunicarlo y de inmediato suspendemos la consulta.\n\nAl participar, no hay ningún beneficio personal para usted y no hay riesgo; la data resultante será procesada y utilizada para fines de análisis y aprendizaje. World Vision no compartirá sus datos con nadie fuera del equipo, ni ahora, ni en el futuro.\n\n¿Tiene alguna pregunta para mí sobre el proceso de la entrevista?\n\n¿Acepta participar en esta entrevista? / Consentimiento otorgado Sí/No\n\nAl firmar este documento manifiesto ser mayor de 18 años y estoy dando mi consentimiento y acepto voluntariamente participar en la consulta.';
        //pregunta14 = '14. ¿Hay niñas y niños patrocinados por World Vision Honduras en el hogar?:';
        break;

      //Guatemala
      case 2:
        nombrePais = 'GUATEMALA';
        textoConsentimiento =
            'Buenos días/tardes, gracias por tomarse el tiempo para reunirse conmigo hoy. Mi nombre es [ ] y formo parte del equipo de World Vision Guatemala. Actualmente, la organización está llevando a cabo un levantamiento de información en diferentes zonas del país, para conocer las opiniones de la población respecto a la condición socioeconómica de los hogares, y la percepción sobre la situación de la migración forzada, entre otros temas.\n\nEn esta oportunidad, Usted ha sido identificado como informante calificado y mi visita tiene el propósito de solicitar su colaboración para llevar a cabo una entrevista y llenar una encuesta. Es importante destacar que su participación es voluntaria, y que la información obtenida es confidencial; si hay una o más preguntas, que no quisiera responder o terminar la conversación antes de finalizar la encuesta; siéntase en la libertad de comunicarlo y de inmediato suspendemos la consulta.\n\nAl participar, no hay ningún beneficio personal para usted y no hay riesgo; la data resultante será procesada y utilizada para fines de análisis y aprendizaje. World Vision no compartirá sus datos con nadie fuera del equipo, ni ahora, ni en el futuro.\n\n¿Tiene alguna pregunta para mí sobre el proceso de la entrevista?\n\n¿Acepta participar en esta entrevista? / Consentimiento otorgado Sí/No\n\nAl firmar este documento manifiesto ser mayor de 18 años y estoy dando mi consentimiento y acepto voluntariamente participar en la consulta.';
        //pregunta14 = '14. ¿Hay niñas y niños patrocinados por World Vision Guatemala en el hogar?:';
        break;

      //El Salvador
      case 3:
        nombrePais = 'EL SALVADOR';
        textoConsentimiento =
            'Buenos días/tardes, gracias por tomarse el tiempo para reunirse conmigo hoy. Mi nombre es [ ] y formo parte del equipo de World Vision El Salvador. Actualmente, la organización está llevando a cabo un levantamiento de información en diferentes zonas del país, para conocer las opiniones de la población respecto a la condición socioeconómica de los hogares, y la percepción sobre la situación de la migración forzada, entre otros temas.\n\nEn esta oportunidad, Usted ha sido identificado como informante calificado y mi visita tiene el propósito de solicitar su colaboración para llevar a cabo una entrevista y llenar una encuesta. Es importante destacar que su participación es voluntaria, y que la información obtenida es confidencial; si hay una o más preguntas, que no quisiera responder o terminar la conversación antes de finalizar la encuesta; siéntase en la libertad de comunicarlo y de inmediato suspendemos la consulta.\n\nAl participar, no hay ningún beneficio personal para usted y no hay riesgo; la data resultante será procesada y utilizada para fines de análisis y aprendizaje. World Vision no compartirá sus datos con nadie fuera del equipo, ni ahora, ni en el futuro.\n\n¿Tiene alguna pregunta para mí sobre el proceso de la entrevista?\n\n¿Acepta participar en esta entrevista? / Consentimiento otorgado Sí/No\n\nAl firmar este documento manifiesto ser mayor de 18 años y estoy dando mi consentimiento y acepto voluntariamente participar en la consulta.';
        //pregunta14 = '14. ¿Hay niñas y niños patrocinados por World Vision El Salvador en el hogar?:';
        break;
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kNaranjaPrincipal,
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  content: const SalirFormularioActualizarModal(),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'No',
                        style: TextStyle(color: kNaranjaPrincipal),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //Reiniciar variables
                        providerComunidades.reiniciarVariablesComunidades();
                        condicionesProvider.resetearCondiciones();
                        //Cerrar Modal
                        Navigator.pop(context);
                        //Cerrar la página del formulario
                        Navigator.pop(context, false);
                      },
                      child: const Text(
                        'Sí',
                        style: TextStyle(color: kNaranjaPrincipal),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: SvgPicture.asset(
                'assets/svg/backspace.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(
            'Editar SAT-M Comunidades',
            style: GoogleFonts.lato(
                fontWeight: FontWeight.w500, fontSize: 21, color: Colors.white),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFAFAFB),
                Color(0xFFFFF1E6),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _llave,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: kGrisClaroWeb,
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      width: double.infinity,
                      child: Text(
                        'WORLD VISION $nombrePais',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      color: kGrisClaroWeb,
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      width: double.infinity,
                      child: Text(
                        'SISTEMA DE ALERTA TEMPRANA - MIGRACIÓN (SAT-M) ----- NIVEL COMUNITARIO',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'INSTRUCCIONES: TODOS LOS CAMPOS DEBEN SER COMPLETADOS.',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '* LA PERSONA QUE PROPORCIONA LOS DATOS DEBE DE SER DE PREFERENCIA JEFE O JEFA DEL HOGAR O UN MIEMBRO DE LA FAMILIA CON AL MENOS 18 AÑOS DE EDAD',
                      style: GoogleFonts.lato(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 15),
                    //--------------SECCIÓN A - IDENTIFICACIÓN ----------------------//
                    Text(
                      'A. IDENTIFICACIÓN',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text('1. Departamento:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        valorInicial: (providerComunidades.idDepartamento != 0)
                            ? providerComunidades.idDepartamento.toString()
                            : null,
                        placeholder: 'Seleccione...',
                        caso: 'departamento',
                        listado: providerComunidades.listadoDepartamentos),
                    const SizedBox(height: 15),
                    Text('2. Municipio:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        valorInicial: (providerComunidades.idMunicipio == null)
                            ? null
                            : providerComunidades.idMunicipio.toString(),
                        placeholder: 'Seleccione...',
                        caso: 'municipio',
                        listado: providerComunidades.listadoMunicipios),
                    const SizedBox(height: 15),
                    Text('3. Nombre de la comunidad:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        valorInicial: (providerComunidades.comunidad == null)
                            ? null
                            : providerComunidades.comunidad.toString(),
                        placeholder: 'Seleccione...',
                        caso: 'comunidad',
                        listado: providerComunidades.listadoComunidades),

                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(14),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                      ),
                      child: Text(
                        textoConsentimiento,
                        style: GoogleFonts.lato(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'DOY MI CONSENTIMIENTO Y ACEPTO VOLUNTARIAMENTE PARTICIPAR EN ESTA ENCUESTA',
                      style: GoogleFonts.lato(color: Colors.black),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: consentimiento,
                          onChanged: (value) {},
                        ),
                        const Text('Sí')
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text('Firma de consentimiento',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    //ESPACIO PARA LA FIRMA
                    (providerComunidades.sign.text.isNotEmpty)
                        ? Image.file(File(providerComunidades.sign.text))
                        : Container(),
                    const SizedBox(height: 15),

                    (condicionesProvider.condicionAcepta)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //--------------SECCIÓN B - DATOS GENERALES ----------------------//
                              Text(
                                'B. DATOS GENERALES',
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kNaranjaPrincipal),
                              ),
                              const SizedBox(height: 15),
                              Text('4. Nombre de la persona informante:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacion(
                                  controlador:
                                      providerComunidades.nomEncuestado,
                                  pregunta: 'Encuestado...'),
                              const SizedBox(height: 15),
                              Text(
                                  '5. Número de teléfono de la persona informante:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloSinValidacionSoloNumeros(
                                  cuantosNumeros: 8,
                                  controlador:
                                      providerComunidades.telEncuestado,
                                  pregunta: 'Teléfono sin guiones...'),
                              const SizedBox(height: 15),
                              Text('6. Número de identidad nacional:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacionSoloNumeros(
                                  cuantosNumeros: 13,
                                  controlador: providerComunidades.identidad,
                                  pregunta: 'DNI sin guiones...'),
                              const SizedBox(height: 15),
                              Text('7. Edad:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacionSoloNumeros(
                                  cuantosNumeros: 3,
                                  controlador: providerComunidades.edad,
                                  pregunta: 'Edad...'),
                              const SizedBox(height: 15),
                              Text('8. Sexo:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.sexo != 0)
                                      ? providerComunidades.sexo.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'sexo',
                                  listado: providerComunidades.listadoSexo),
                              const SizedBox(height: 15),
                              Text('9. Último nivel educativo cursado:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial:
                                      (providerComunidades.educacion != 0)
                                          ? providerComunidades.educacion
                                              .toString()
                                          : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'educacion',
                                  listado:
                                      providerComunidades.listadoEducacion),
                              const SizedBox(height: 15),
                              (condicionesProvider.condicion9)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text('10. Último año cursado:',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        InputSencilloConValidacionSoloNumeros(
                                            cuantosNumeros: 2,
                                            controlador:
                                                providerComunidades.anoCursado,
                                            pregunta: 'Último año cursado...'),
                                        const SizedBox(height: 15),
                                      ],
                                    )
                                  : Container(),

                              Text('11. ¿Cuál es su estado civil?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.estado !=
                                          0)
                                      ? providerComunidades.estado.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'estado_civil',
                                  listado: providerComunidades.listadoEstado),
                              const SizedBox(height: 15),
                              Text(
                                  '12. ¿Cuántas personas menores de 18 años viven en éste hogar?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacionSoloNumeros(
                                  caso12Comunidades: true,
                                  cuantosNumeros: 2,
                                  controlador: providerComunidades.nino,
                                  pregunta: 'Cantidad...'),
                              const SizedBox(height: 15),
                              (condicionesProvider.condicion12)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                            '13. ¿Viven en este hogar ambos padres del/los menor/es?:',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        DropdownSencillo(
                                            valorInicial: (providerComunidades
                                                        .ambosPadres !=
                                                    0)
                                                ? providerComunidades
                                                    .ambosPadres
                                                    .toString()
                                                : null,
                                            placeholder: 'Seleccione...',
                                            caso: 'ambos_padres',
                                            listado: providerComunidades
                                                .listadoAmbosPadres),
                                        const SizedBox(height: 15),
                                        // Text(pregunta14,
                                        //     style: GoogleFonts.lato(
                                        //         fontSize: 14,
                                        //         color: Colors.black54)),
                                        // const SizedBox(height: 7),
                                        // DropdownSencillo(
                                        //     valorInicial: (providerComunidades
                                        //                 .nnPatrocinado !=
                                        //             0)
                                        //         ? providerComunidades
                                        //             .nnPatrocinado
                                        //             .toString()
                                        //         : null,
                                        //     placeholder: 'Seleccione...',
                                        //     caso: 'nn_patrocinado',
                                        //     listado: providerComunidades
                                        //         .listadoNnPatrocinado),
                                        // const SizedBox(height: 15),
                                        // (condicionesProvider.condicion14)
                                        //     ? Column(
                                        //         crossAxisAlignment:
                                        //             CrossAxisAlignment.stretch,
                                        //         children: [
                                        //           Text(
                                        //               '15. Escriba el número de ID de los niños y niñas:',
                                        //               style: GoogleFonts.lato(
                                        //                   fontSize: 14,
                                        //                   color:
                                        //                       Colors.black54)),
                                        //           const SizedBox(height: 7),
                                        //           InputSencilloConValidacion(
                                        //               controlador:
                                        //                   providerComunidades
                                        //                       .idPatrocinio,
                                        //               pregunta: '# de Id...'),
                                        //           const SizedBox(height: 15),
                                        //         ],
                                        //       )
                                        //     : Container(),
                                      ],
                                    )
                                  : Container(),
                              //SECCIÓN B. Datos Ingresos
                              Text(
                                'B. Datos Ingresos',
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kNaranjaPrincipal),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  '16. ¿El jefe/a de familia actualmente éstá trabajando?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.b1 != 0)
                                      ? providerComunidades.b1.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'b1',
                                  listado: providerComunidades.listadoB1),
                              const SizedBox(height: 15),
                              Text(
                                  '17. ¿El ingreso de este hogar está dentro del rango de?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.b2 != 0)
                                      ? providerComunidades.b2.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'b2',
                                  listado: providerComunidades.listadoB2),
                              const SizedBox(height: 15),
                              Text(
                                'C. VIVIENDA',
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kNaranjaPrincipal),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  '18. ¿Cuál es el material predominante de piso de la vivienda?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.c1 != 0)
                                      ? providerComunidades.c1.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'c1',
                                  listado: providerComunidades.listadoC1),
                              const SizedBox(height: 15),
                              Text(
                                  '19. ¿Cómo obtiene el agua que utiliza en la vivienda?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.c2 != 0)
                                      ? providerComunidades.c2.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'c2',
                                  listado: providerComunidades.listadoC2),
                              const SizedBox(height: 15),
                              Text(
                                  '20. ¿Qué tipo de alumbrado se utiliza en la vivienda?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.c3 != 0)
                                      ? providerComunidades.c3.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'c3',
                                  listado: providerComunidades.listadoC3),
                              const SizedBox(height: 15),
                              Text(
                                'D. INTENCIÓN DE EMIGRAR',
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kNaranjaPrincipal),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  '21. ¿Alguna vez se ha ido a los Estados Unidos con la intención de trabajar o residir?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.d1 != 0)
                                      ? providerComunidades.d1.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'd1',
                                  listado: providerComunidades.listadoD1),
                              const SizedBox(height: 15),
                              (condicionesProvider.condicion21)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                            '22. ¿Alguna vez ha sido deportado?:',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        DropdownSencillo(
                                            valorInicial:
                                                (providerComunidades.d2 != 0)
                                                    ? providerComunidades.d2
                                                        .toString()
                                                    : null,
                                            placeholder: 'Seleccione...',
                                            caso: 'd2',
                                            listado:
                                                providerComunidades.listadoD2),
                                        const SizedBox(height: 15),
                                      ],
                                    )
                                  : Container(),

                              Text(
                                  '23. ¿Si en estos momentos usted tuviera la oportunidad de irse legalmente (visa) a los Estados Unidos, se iría?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.d3 != 0)
                                      ? providerComunidades.d3.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'd3',
                                  listado: providerComunidades.listadoD3),
                              const SizedBox(height: 15),
                              Text(
                                  '24. ¿Si usted tuviera la manera y oportunidad de irse sin documentos, se iría?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.d4 != 0)
                                      ? providerComunidades.d4.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'd4',
                                  listado: providerComunidades.listadoD4),
                              const SizedBox(height: 15),
                              (condicionesProvider.condicion23y24)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                            '25. ¿La principal razón por la que se iría usted?:',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        DropdownSencillo(
                                            valorInicial:
                                                (providerComunidades.d9 != 0)
                                                    ? providerComunidades.d9
                                                        .toString()
                                                    : null,
                                            placeholder: 'Seleccione...',
                                            caso: 'd9',
                                            listado:
                                                providerComunidades.listadoD9),
                                        const SizedBox(height: 15),
                                      ],
                                    )
                                  : Container(),

                              Text(
                                  '26. ¿Hay alguien más en este hogar que se ha ido para los Estados Unidos con la intención de trabajar o residir?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.d5 != 0)
                                      ? providerComunidades.d5.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'd5',
                                  listado: providerComunidades.listadoD5),
                              const SizedBox(height: 15),
                              (condicionesProvider.condicion26)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text('27. ¿Ha sido deportado?:',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        DropdownSencillo(
                                            valorInicial:
                                                (providerComunidades.d6 != 0)
                                                    ? providerComunidades.d6
                                                        .toString()
                                                    : null,
                                            placeholder: 'Seleccione...',
                                            caso: 'd6',
                                            listado:
                                                providerComunidades.listadoD6),
                                        const SizedBox(height: 15),
                                        (condicionesProvider.condicion27)
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                      '28. La/s persona/s retornada/s , ¿piensa/n viajar de nuevo?:',
                                                      style: GoogleFonts.lato(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54)),
                                                  const SizedBox(height: 7),
                                                  DropdownSencillo(
                                                      valorInicial:
                                                          (providerComunidades
                                                                      .d7 !=
                                                                  0)
                                                              ? providerComunidades
                                                                  .d7
                                                                  .toString()
                                                              : null,
                                                      placeholder:
                                                          'Seleccione...',
                                                      caso: 'd7',
                                                      listado:
                                                          providerComunidades
                                                              .listadoD7),
                                                  const SizedBox(height: 15),
                                                ],
                                              )
                                            : Container(),
                                      ],
                                    )
                                  : Container(),

                              Text(
                                  '29. ¿Cree que en el futuro algún miembro de este hogar intentaría irse para Estados Unidos?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.d8 != 0)
                                      ? providerComunidades.d8.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'd8',
                                  listado: providerComunidades.listadoD8),
                              const SizedBox(height: 15),
                              Text(
                                'E. Conexiones Familiares y Amistades',
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kNaranjaPrincipal),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  '30. ¿Tiene familiares viviendo en USA y mantiene comunicación con ellos? (contacto vía teléfono, Facebook, etc.):',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.e1 != 0)
                                      ? providerComunidades.e1.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'e1',
                                  listado: providerComunidades.listadoE1),
                              const SizedBox(height: 15),
                              Text(
                                  '31. ¿Tiene amigos viviendo en USA y mantiene comunicación con ellos? (contacto vía teléfono, Facebook, etc.):',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades.e2 != 0)
                                      ? providerComunidades.e2.toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'e2',
                                  listado: providerComunidades.listadoE2),
                              const SizedBox(height: 15),
                              Text(
                                'F. Otros Datos',
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kNaranjaPrincipal),
                              ),
                              const SizedBox(height: 15),
                              Text('32. Nombre de la persona encuestadora:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  valorInicial: (providerComunidades
                                          .facilitador.text.isNotEmpty)
                                      ? providerComunidades.facilitador.text
                                          .toString()
                                      : null,
                                  placeholder: 'Seleccione...',
                                  caso: 'encuestador',
                                  listado:
                                      providerComunidades.listadoFacilitador),
                              const SizedBox(height: 15),
                              Text(
                                  '33. No. de teléfono de la persona encuestadora:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacionSoloNumeros(
                                  controlador:
                                      providerComunidades.telFacilitador,
                                  pregunta:
                                      'Teléfono sin guiones ni espacios...',
                                  cuantosNumeros: 8),
                              const SizedBox(height: 15),
                              Text('34. Fecha en que se realizó la encuesta:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              TextFormField(
                                controller: providerComunidades.fecha,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: kNaranjaPrincipal),
                                      borderRadius: BorderRadius.circular(15)),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black45),
                                  ),
                                  icon: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: kNaranjaPrincipal,
                                  ),
                                  hintText: 'Seleccione la Fecha... ',
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime hoy = DateTime.now();
                                  DateTime? pickedDate = await showDatePicker(
                                    locale: const Locale('es', 'HN'),
                                    context: context,
                                    initialDate: hoy,
                                    firstDate: DateTime(
                                        hoy.year - 1, hoy.month, hoy.day),
                                    lastDate: hoy,
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                                    primary: kNaranjaPrincipal,
                                                    onPrimary: Colors.white)),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    providerComunidades.fecha.text =
                                        formattedDate;
                                  }
                                },
                                validator: (val) {
                                  if (val == null || val == "") {
                                    return 'Debe Seleccionar una Fecha!';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              Text('35. Observaciones:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputTextAreaSinValidacion(
                                controlador: providerComunidades.observaciones,
                                pregunta: 'Observaciones de la encuesta...',
                              ),
                              const SizedBox(height: 15),
                              Text('36. Obtener Ubicación:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          side: const BorderSide(
                                            width: 0.5,
                                            color: kTextoAzul,
                                          )),
                                      onPressed: () {
                                        Location miUbicacion = Location();
                                        obtenerUbicacion(miUbicacion);
                                      },
                                      child: Text(
                                        'Obtener ubicación',
                                        style: GoogleFonts.lato(
                                          color: kTextoAzul,
                                        ),
                                      ))),
                              const SizedBox(height: 15),
                              InputSencilloConValidacion(
                                readOnly: true,
                                controlador: providerComunidades.lat,
                                pregunta: 'Latitud...',
                              ),
                              const SizedBox(height: 7),
                              InputSencilloConValidacion(
                                readOnly: true,
                                controlador: providerComunidades.lon,
                                pregunta: 'Longitud...',
                              ),
                              const SizedBox(height: 7),
                              InputSencilloConValidacion(
                                readOnly: true,
                                controlador: providerComunidades.alt,
                                pregunta: 'Altitud...',
                              ),
                              const SizedBox(height: 7),
                              InputSencilloConValidacion(
                                readOnly: true,
                                controlador: providerComunidades.acc,
                                pregunta: 'Exactitud...',
                              ),
                              const SizedBox(height: 25),
                            ],
                          )
                        : Container(),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              side: const BorderSide(
                                color: kNaranjaPrincipal,
                              )),
                          onPressed: () async {
                            //Guardar en BD
                            if (_llave.currentState!.validate()) {
                              //Llamar Actualizar en la BD
                              await DatabaseSatM.instance
                                  .actualizarComunidades(ComunidadesModelo(
                                codaleaSatcomunidades: widget.codaleaRecibido,
                                start: '',
                                end: '',
                                today: '',
                                idPais: providerComunidades.idPais,
                                idDepartamento:
                                    providerComunidades.idDepartamento,
                                idMunicipio: providerComunidades.idMunicipio!,
                                comunidad: providerComunidades.comunidad!,
                                acepta: providerComunidades.acepta,
                                sign: providerComunidades.sign.text,
                                nomEncuestado:
                                    providerComunidades.nomEncuestado.text,
                                telEncuestado:
                                    providerComunidades.telEncuestado.text,
                                identidad: providerComunidades.identidad.text,
                                edad: int.parse(providerComunidades.edad.text),
                                sexo: providerComunidades.sexo,
                                educacion: providerComunidades.educacion,
                                anoCursado: (providerComunidades
                                            .anoCursado.text.isNotEmpty &&
                                        providerComunidades.anoCursado.text !=
                                            "")
                                    ? int.parse(
                                        providerComunidades.anoCursado.text)
                                    : 0,
                                estado: providerComunidades.estado,
                                nino: int.parse(providerComunidades.nino.text),
                                ambosPadres: providerComunidades.ambosPadres,
                                nnPatrocinado:
                                    providerComunidades.nnPatrocinado,
                                idPatrocinio:
                                    providerComunidades.idPatrocinio.text,
                                b1: providerComunidades.b1,
                                b2: providerComunidades.b2,
                                c1: providerComunidades.c1,
                                c2: providerComunidades.c2,
                                c3: providerComunidades.c3,
                                d1: providerComunidades.d1,
                                d2: providerComunidades.d2,
                                d3: providerComunidades.d3,
                                d4: providerComunidades.d4,
                                d9: providerComunidades.d9,
                                d5: providerComunidades.d5,
                                d6: providerComunidades.d6,
                                d7: providerComunidades.d7,
                                d8: providerComunidades.d8,
                                e1: providerComunidades.e1,
                                e2: providerComunidades.e2,
                                facilitador:
                                    providerComunidades.facilitador.text,
                                telFacilitador: int.parse(
                                    providerComunidades.telFacilitador.text),
                                fecha: providerComunidades.fecha.text,
                                observaciones:
                                    providerComunidades.observaciones.text,
                                lat: providerComunidades.lat.text,
                                lon: providerComunidades.lon.text,
                                alt: providerComunidades.alt.text,
                                acc: providerComunidades.acc.text,
                              ));

                              //Resetear todas las variables
                              providerComunidades
                                  .reiniciarVariablesComunidades();
                              condicionesProvider.resetearCondiciones();

                              Fluttertoast.showToast(
                                      msg:
                                          "Encuesta Actualizada exitosamente!!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                  .then((value) {
                                //regresar con un true para recargar el estado
                                Navigator.pop(context, true);
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Hay campos requeridos!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.yellow,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                            }
                          },
                          child: Text(
                            'Actualizar Encuesta',
                            style: GoogleFonts.lato(
                                color: kNaranjaPrincipal,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> obtenerUbicacion(Location location) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      bool userAcceptedPermission = await showLocationPermissionDialog();
      if (!userAcceptedPermission) {
        // User did not accept the permission
        return;
      }

      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    await location.getLocation().then((locationData) {
      //Iniciar provider
      var providerComunidades =
          Provider.of<SatmComunidadesProvider>(context, listen: false);

      //Asignar los valores de ubicación
      providerComunidades.valorLat = locationData.latitude.toString();
      providerComunidades.valorLon = locationData.longitude.toString();
      providerComunidades.valorAlt = locationData.altitude.toString();
      providerComunidades.valorAcc = locationData.accuracy.toString();
    });
  }

  Future<bool> showLocationPermissionDialog() async {
    return showDialog(
      context: context,
      builder: (context) => const LocationPermissionDialog(),
    ).then((result) => result == true);
  }
}

//Función para guardar archivos
Future<String> guardarArchivo(Uint8List file) async {
  final appStorage = await getApplicationDocumentsDirectory();
  String randomName = randomAlpha(15);
  String direccionImagen = '${appStorage.path}/$randomName.png';
  File imageFile = File(direccionImagen);

  if (!await imageFile.exists()) {
    imageFile.create(recursive: true);
  }
  imageFile.writeAsBytes(file);

  return direccionImagen;
}
