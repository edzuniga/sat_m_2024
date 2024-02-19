import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:sat_m/bd/bd.dart';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/funciones/string_multiselects.dart';
import 'package:sat_m/modales/permiso_ubicacion.dart';
import 'package:sat_m/modales/salir_formulario_modal.dart';
import 'package:sat_m/modelos/satm_familias_modelo.dart';
import 'package:sat_m/providers/condiciones_familias_provider.dart';
import 'package:sat_m/providers/indice_pobreza_provider.dart';
import 'package:sat_m/providers/propension_migracion_provider.dart';
import 'package:sat_m/providers/satm_familias_provider.dart';
import 'package:sat_m/widgets/dropdowns_widget.dart';
import 'package:sat_m/widgets/inputs_sencillos_widget.dart';

class FormularioFamilias extends StatefulWidget {
  const FormularioFamilias({required this.idPais, super.key});

  final int idPais;

  @override
  State<FormularioFamilias> createState() => _FormularioFamiliasState();
}

class _FormularioFamiliasState extends State<FormularioFamilias> {
  //Llave del formulario
  final _llave = GlobalKey<FormState>();

  //Variables para Start (Timestamp)
  final DateTime _start = DateTime.now();

  //Cuenta de miembros migrantes
  //int _miembroIndex = 0;

  @override
  Widget build(BuildContext context) {
    //Variables que dependen del IDPAIS
    String nombrePais = "";
    String p01 = "";

    switch (widget.idPais) {
      //Honduras
      case 1:
        nombrePais = 'HONDURAS';
        p01 =
            '1. ¿Considera que en los últimos 3 años la migración de hondureños hacia los Estados Unidos ha reducido, se ha mantenido o ha incrementado?';
        break;

      //Guatemala
      case 2:
        nombrePais = 'GUATEMALA';
        p01 =
            '1. ¿Considera que en los últimos 3 años la migración de guatemaltecos hacia los Estados Unidos ha reducido, se ha mantenido o ha incrementado?';
        break;

      //El Salvador
      case 3:
        nombrePais = 'EL SALVADOR';
        p01 =
            '1. ¿Considera que en los últimos 3 años la migración de salvadoreños hacia los Estados Unidos ha reducido, se ha mantenido o ha incrementado?';
        break;
    }

    //Obtener tamaño de la pantalla
    Size screenSize = MediaQuery.of(context).size;

    //Iniciar provider
    var familiasProvider = Provider.of<SatmFamiliasProvider>(context);
    var condicionesProvider = Provider.of<CondicionesFamiliasProvider>(context);
    var indicePobrezaProvider = Provider.of<IndicePobrezaProvider>(context);
    var propensionProvider = Provider.of<PropensionMigracionProvider>(context);

    //listado final para la P04
    final listadoMultiP04 = familiasProvider.opcionesP04
        .map((p04) => MultiSelectItem<MultiSelectClass>(p04, p04.dato))
        .toList();

    //listado final para la P05
    final listadoMultiP05 = familiasProvider.opcionesP05
        .map((p05) => MultiSelectItem<MultiSelectClass>(p05, p05.dato))
        .toList();

    //listado final para la P08
    final listadoMultiP08 = familiasProvider.opcionesP08
        .map((p08) => MultiSelectItem<MultiSelectClass>(p08, p08.dato))
        .toList();

    //listado final para la P10
    final listadoMultiP10 = familiasProvider.opcionesP10
        .map((p10) => MultiSelectItem<MultiSelectClass>(p10, p10.dato))
        .toList();

    //listado final para la P12
    final listadoMultiP12 = familiasProvider.opcionesP12
        .map((p12) => MultiSelectItem<MultiSelectClass>(p12, p12.dato))
        .toList();

    //listado final para la P31
    final listadoMultiP31 = familiasProvider.opcionesP31
        .map((p31) => MultiSelectItem<MultiSelectClass>(p31, p31.dato))
        .toList();

    //listado final para la P35
    final listadoMultiP35 = familiasProvider.opcionesP35
        .map((p35) => MultiSelectItem<MultiSelectClass>(p35, p35.dato))
        .toList();

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kNaranjaPrincipal,
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  content: const SalirFormularioModal(),
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
                        familiasProvider.resetearVariables();
                        indicePobrezaProvider.resetearVariables();
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
            'SAT-M Familias',
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        'SISTEMA DE ALERTA TEMPRANA - MIGRACIÓN (SAT-M) ----- FAMILIAS',
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
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '* LA PERSONA QUE PROPORCIONA LOS DATOS DEBE DE SER PREFERENCIA JEFE O JEFA DEL HOGAR O UN MIEMBRO DE LA FAMILIA CON AL MENOS 15 AÑOS DE EDAD',
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
                    Text('Departamento:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'departamento_familias',
                        listado: familiasProvider.listadoDepartamentos),
                    const SizedBox(height: 15),
                    Text('Municipio:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        valorInicial: (familiasProvider.idMunicipio == null)
                            ? null
                            : familiasProvider.idMunicipio.toString(),
                        placeholder: 'Seleccione...',
                        caso: 'municipio_familias',
                        listado: familiasProvider.listadoMunicipios),
                    const SizedBox(height: 15),
                    Text('Nombre de la comunidad:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        valorInicial: (familiasProvider.comunidad == null)
                            ? null
                            : familiasProvider.comunidad.toString(),
                        placeholder: 'Seleccione...',
                        caso: 'comunidad_familias',
                        listado: familiasProvider.listadoComunidades),
                    const SizedBox(height: 15),
                    Text('¿Esta comunidad es patrocinada por World Vision?:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'patrocinio_familias',
                        listado: familiasProvider.listadoPatrocinio),
                    const SizedBox(height: 15),
                    Text('Nombre del encuestado:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacion(
                        controlador: familiasProvider.nomEncuestado,
                        pregunta: 'Encuestado...'),
                    const SizedBox(height: 15),
                    Text('Número de identidad:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacionSoloNumeros(
                        cuantosNumeros: 13,
                        controlador: familiasProvider.identidad,
                        pregunta: 'Sin guiones...'),
                    const SizedBox(height: 15),
                    Text('Edad:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacionSoloNumeros(
                        cuantosNumeros: 3,
                        controlador: familiasProvider.edad,
                        pregunta: 'Edad...'),
                    const SizedBox(height: 15),
                    Text('Fecha de nacimiento:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: familiasProvider.nacimiento,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: kNaranjaPrincipal),
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: kNaranjaPrincipal,
                        ),
                        hintText: 'Seleccione la Fecha... ',
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime inicio = DateTime(1990);
                        DateTime hoy = DateTime.now();
                        DateTime? pickedDate = await showDatePicker(
                          locale: const Locale('es', 'HN'),
                          context: context,
                          initialDate: inicio,
                          firstDate: DateTime(1920, 1, 1),
                          lastDate: hoy,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                      primary: kNaranjaPrincipal,
                                      onPrimary: Colors.white)),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          familiasProvider.nacimiento.text = formattedDate;
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
                    Text('Sexo:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'sexo_familias',
                        listado: familiasProvider.listadoSexo),
                    const SizedBox(height: 15),
                    Text('¿Estudia actualmente?:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'estudia_familias',
                        listado: familiasProvider.listadoEstudia),
                    const SizedBox(height: 15),
                    Text('Último año cursado:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'educacion_familias',
                        listado: familiasProvider.listadoEducacion),
                    const SizedBox(height: 15),
                    Text('¿Cuál es su estado civil?:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'estado_civil_familias',
                        listado: familiasProvider.listadoEstado),
                    const SizedBox(height: 15),
                    Text('Número de teléfono del encuestado:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloSinValidacionSoloNumeros(
                        cuantosNumeros: 8,
                        controlador: familiasProvider.telefonoEncuestado,
                        pregunta: 'Teléfono sin guiones...'),
                    const SizedBox(height: 15),
                    Text('¿Cuántas familias viven en esta casa?:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacionSoloNumeros(
                        cuantosNumeros: 2,
                        controlador: familiasProvider.familias,
                        pregunta: 'Cantidad...'),
                    const SizedBox(height: 15),
                    Text('¿Cuántas personas viven en esta casa?:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacionSoloNumeros(
                        condicionNinaNino: true,
                        cuantosNumeros: 3,
                        controlador: familiasProvider.miembros,
                        pregunta: 'Cantidad...'),
                    const SizedBox(height: 15),
                    Text(
                        '¿Cuántas NIÑAS menores de 18 años viven en este hogar?:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacionSoloNumeros(
                        condicionNinaNino: true,
                        cuantosNumeros: 3,
                        controlador: familiasProvider.nina,
                        pregunta: 'Cantidad...'),
                    const SizedBox(height: 15),
                    Text(
                        '¿Cuántas NIÑOS menores de 18 años viven en este hogar?:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacionSoloNumeros(
                        condicionNinaNino: true,
                        cuantosNumeros: 3,
                        controlador: familiasProvider.nino,
                        pregunta: 'Cantidad...'),
                    const SizedBox(height: 15),

                    (condicionesProvider.condicionNinaNino)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '¿Viven en este hogar ambos padres de los niños(as)?:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'ambosPadres_familias',
                                  listado: familiasProvider.listadoAmbosPadres),
                              const SizedBox(height: 15),
                              // Text(
                              //     '¿Hay Niñas y Niños patrocinados por World Vision en el Hogar?:',
                              //     style: GoogleFonts.lato(
                              //         fontSize: 14, color: Colors.black54)),
                              // const SizedBox(height: 7),
                              // DropdownSencillo(
                              //     placeholder: 'Seleccione...',
                              //     caso: 'nnPatrocinado_familias',
                              //     listado:
                              //         familiasProvider.listadoNnPatrocinado),
                              // const SizedBox(height: 15),
                              // (condicionesProvider.condicionNnPatrocinados)
                              //     ? Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.stretch,
                              //         children: [
                              //           Text(
                              //               '¿Escriba el número de ID de los niños y niñas?:',
                              //               style: GoogleFonts.lato(
                              //                   fontSize: 14,
                              //                   color: Colors.black54)),
                              //           const SizedBox(height: 7),
                              //           InputSencilloSinValidacion(
                              //               controlador:
                              //                   familiasProvider.idPatrocinio,
                              //               pregunta: '# de Id...'),
                              //           const SizedBox(height: 15),
                              //         ],
                              //       )
                              //     : Container(),
                            ],
                          )
                        : Container(),

                    //--------------SECCIÓN B - IDENTIFICACIÓN ----------------------//
                    Text(
                      'B. PERCEPCIÓN SOBRE LA MIGRACIÓN',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text(p01,
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p01_familias',
                        listado: familiasProvider.listadoP01),
                    const SizedBox(height: 15),
                    Text(
                        '2. ¿Piensa que en los próximos 2 años la migración hacia los Estados Unidos reducirá, se mantendrá igual o incrementará?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p02_familias',
                        listado: familiasProvider.listadoP02),
                    const SizedBox(height: 15),
                    Text(
                        '3. ¿Cuál considera usted que es la principal razón por la que las personas migran?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p03_familias',
                        listado: familiasProvider.listadoP03),
                    const SizedBox(height: 15),
                    Text(
                        '4. ¿Qué acciones podría hacer el gobierno en su municipio para reducir la migración?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    MultiSelectDialogField(
                      items: listadoMultiP04,
                      title: const Text("Opciones"),
                      selectedColor: kNaranjaPrincipal,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      buttonIcon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      buttonText: Text("Seleccione las que apliquen...",
                          style: GoogleFonts.lato(
                              fontSize: 14, color: Colors.black54)),
                      onConfirm: (seleccionadas) {
                        familiasProvider.seleccionadosP04 = seleccionadas;
                        //crear un array de los ids seleccionados
                        List<int> selectedProvi = [];
                        //poblar el array
                        for (int i = 0; i < seleccionadas.length; i++) {
                          selectedProvi.add(seleccionadas[i].id);
                        }
                        //Asignar el listado a la variable final
                        familiasProvider.valorp04 =
                            stringMultiselect(selectedProvi);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    Text(
                        '5. ¿Por qué considera que los niños y niñas se van solos?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    MultiSelectDialogField(
                      items: listadoMultiP05,
                      title: const Text("Opciones"),
                      selectedColor: kNaranjaPrincipal,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      buttonIcon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      buttonText: Text("Seleccione las que apliquen...",
                          style: GoogleFonts.lato(
                              fontSize: 14, color: Colors.black54)),
                      onConfirm: (seleccionadas) {
                        familiasProvider.seleccionadosP05 = seleccionadas;
                        //crear un array de los ids seleccionados
                        List<int> selectedProvi = [];
                        //poblar el array
                        for (int i = 0; i < seleccionadas.length; i++) {
                          selectedProvi.add(seleccionadas[i].id);
                        }
                        //Asignar el listado a la variable final
                        familiasProvider.valorp05 =
                            stringMultiselect(selectedProvi);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    Text(
                        '6. ¿Considera que pagando coyote, las personas que migran tienen mayor probabilidad de lograr pasar?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p06_familias',
                        listado: familiasProvider.listadoP06),
                    const SizedBox(height: 15),
                    Text(
                        '7. ¿Cuál es la principal razón que influye para que las personas tomen la decisión de migrar a los Estados Unidos?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p07_familias',
                        listado: familiasProvider.listadoP07),
                    const SizedBox(height: 15),
                    //------------SECCIÓN CONEXIONES CON AMIGOS Y FAMILIARES
                    Text(
                      'C. CONEXIONES CON AMIGOS Y FAMILIARES',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text('8. ¿Tiene amigos que…?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    MultiSelectDialogField(
                      confirmText: Text(
                        'ACEPTAR',
                        style: GoogleFonts.lato(
                            color: kNaranjaPrincipal, fontSize: 14),
                      ),
                      cancelText: Text(
                        'CANCELAR',
                        style: GoogleFonts.lato(
                            color: kNaranjaPrincipal, fontSize: 14),
                      ),
                      dialogHeight: screenSize.height * 0.4,
                      items: listadoMultiP08,
                      title: const Text("Opciones"),
                      selectedColor: kNaranjaPrincipal,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      buttonIcon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      buttonText: Text("Seleccione las que apliquen...",
                          style: GoogleFonts.lato(
                              fontSize: 14, color: Colors.black54)),
                      onConfirm: (seleccionadas) {
                        familiasProvider.seleccionadosP08 = seleccionadas;
                        //crear un array de los ids seleccionados
                        List<int> selectedProvi = [];
                        //poblar el array
                        for (int i = 0; i < seleccionadas.length; i++) {
                          selectedProvi.add(seleccionadas[i].id);
                        }
                        //Asignar el listado a la variable final
                        familiasProvider.valorp08 =
                            stringMultiselect(selectedProvi);

                        //condicion para la p9
                        if (selectedProvi.contains(3)) {
                          condicionesProvider.valorCondicion8 = true;
                        } else {
                          condicionesProvider.valorCondicion8 = false;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicion8)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '9. ¿Mantiene comunicación con ellos? (contacto vía teléfono, Facebook, etc.)',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p09_familias',
                                  listado: familiasProvider.listadoP09),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

                    Text('10. ¿Tiene familiares que…?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    MultiSelectDialogField(
                      confirmText: Text(
                        'ACEPTAR',
                        style: GoogleFonts.lato(
                            color: kNaranjaPrincipal, fontSize: 14),
                      ),
                      cancelText: Text(
                        'CANCELAR',
                        style: GoogleFonts.lato(
                            color: kNaranjaPrincipal, fontSize: 14),
                      ),
                      dialogHeight: screenSize.height * 0.4,
                      items: listadoMultiP10,
                      title: const Text("Opciones"),
                      selectedColor: kNaranjaPrincipal,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      buttonIcon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      buttonText: Text("Seleccione las que apliquen...",
                          style: GoogleFonts.lato(
                              fontSize: 14, color: Colors.black54)),
                      onConfirm: (seleccionadas) {
                        familiasProvider.seleccionadosP10 = seleccionadas;
                        //crear un array de los ids seleccionados
                        List<int> selectedProvi = [];
                        //poblar el array
                        for (int i = 0; i < seleccionadas.length; i++) {
                          selectedProvi.add(seleccionadas[i].id);
                        }
                        //Asignar el listado a la variable final
                        familiasProvider.valorp10 =
                            stringMultiselect(selectedProvi);

                        //Condicion10
                        if (selectedProvi.contains(3)) {
                          condicionesProvider.valorCondicion10 = true;
                        } else {
                          condicionesProvider.valorCondicion10 = false;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es obligatorio';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicion10)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '11. Si tiene familiares viviendo EEUU, ¿Mantiene comunicación con ellos? (contacto vía teléfono, Facebook, etc.)',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p11_familias',
                                  listado: familiasProvider.listadoP11),
                              const SizedBox(height: 15),
                              Text(
                                  '12. ¿Con qué parientes o familiares mantiene comunicación? (puede seleccionar varios)',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              MultiSelectDialogField(
                                confirmText: Text(
                                  'ACEPTAR',
                                  style: GoogleFonts.lato(
                                      color: kTextoAzul, fontSize: 14),
                                ),
                                cancelText: Text(
                                  'CANCELAR',
                                  style: GoogleFonts.lato(
                                      color: kTextoAzul, fontSize: 14),
                                ),
                                dialogHeight: screenSize.height * 0.4,
                                items: listadoMultiP12,
                                title: const Text("Opciones"),
                                selectedColor: kNaranjaPrincipal,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                buttonIcon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                buttonText: Text(
                                    "Seleccione las que apliquen...",
                                    style: GoogleFonts.lato(
                                        fontSize: 14, color: Colors.black54)),
                                onConfirm: (seleccionadas) {
                                  familiasProvider.seleccionadosP12 =
                                      seleccionadas;
                                  //crear un array de los ids seleccionados
                                  List<int> selectedProvi = [];
                                  //poblar el array
                                  for (int i = 0;
                                      i < seleccionadas.length;
                                      i++) {
                                    selectedProvi.add(seleccionadas[i].id);
                                  }
                                  //Asignar el listado a la variable final
                                  familiasProvider.valorp12 =
                                      stringMultiselect(selectedProvi);
                                },
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  '13. ¿Cuánto tiempo tienen de vivir en Estados Unidos?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p13_familias',
                                  listado: familiasProvider.listadoP13),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

                    //------------SECCIÓN EL HOGAR
                    Text(
                      'D. EL HOGAR',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text(
                        '14. ¿Usted ha viajado a Estados Unidos con el propósito de trabajar o quedarse viviendo allá?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p14_familias',
                        listado: familiasProvider.listadoP14),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP14)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '15. ¿Cuántas veces ha viajado a los Estados Unidos?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloSinValidacionSoloNumeros(
                                  cuantosNumeros: 3,
                                  controlador: familiasProvider.p15,
                                  pregunta: 'Cantidad...'),
                              const SizedBox(height: 15),
                              Text('16. ¿Cuándo fue la última vez que viajó?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p16_familias',
                                  listado: familiasProvider.listadoP16),
                              const SizedBox(height: 15),
                              Text('17. ¿La/lo han deportado/a alguna vez?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p17_familias',
                                  listado: familiasProvider.listadoP17),
                              const SizedBox(height: 15),
                              (condicionesProvider.condicionP17)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                            '18a. ¿Número de veces que ha sido deportado/a de Mexico?',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        InputSencilloSinValidacionSoloNumeros(
                                            cuantosNumeros: 3,
                                            controlador: familiasProvider.p18,
                                            pregunta: 'Cantidad...'),
                                        const SizedBox(height: 15),
                                        Text(
                                            '18b. ¿Número de veces que ha sido deportado/a de USA?',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        InputSencilloSinValidacionSoloNumeros(
                                            cuantosNumeros: 3,
                                            controlador: familiasProvider.p18B,
                                            pregunta: 'Cantidad...'),
                                        const SizedBox(height: 15),
                                        Text(
                                            '19. ¿Hace cuanto tiempo fue deportado/a la última vez?',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        DropdownSencillo(
                                            placeholder: 'Seleccione...',
                                            caso: 'p19_familias',
                                            listado:
                                                familiasProvider.listadoP19),
                                        const SizedBox(height: 15),
                                      ],
                                    )
                                  : Container(),
                            ],
                          )
                        : Container(),

                    Text(
                        '20. Actualmente sí usted tuviera la oportunidad de viajar legalmente a los Estados Unidos, ¿viajaría?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p20_familias',
                        listado: familiasProvider.listadoP20),
                    const SizedBox(height: 15),
                    //------------DE OSCAR
                    Text(
                        '21. Actualmente sí usted tuviera los medios para viajar ilegalmente a los Estados Unidos, ¿viajaría?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p21_familia',
                        listado: familiasProvider.listadoP21),
                    const SizedBox(height: 15),

                    (condicionesProvider.condicionP20y21)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '22. ¿Cuál sería su plan, por un corto tiempo o permanentemente?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p22_familia',
                                  listado: familiasProvider.listadoP22),
                              const SizedBox(height: 15),
                              Text(
                                  '23. ¿Cuál sería la principal razón para que usted decidiera viajar?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p23_familia',
                                  listado: familiasProvider.listadoP23),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

                    Text(
                        '24. ¿Algún miembro de este hogar ha viajado a Estados Unidos con el propósito de trabajar o quedarse a vivir?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p24_familia',
                        listado: familiasProvider.listadoP24),
                    /*
                    (condicionesProvider.condicionP24)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 25),
                              Center(
                                child: Text(
                                    '25. --- MIEMBROS QUE HAN MIGRADO ---',
                                    style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const Divider(),
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: 500,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: kNaranjaPrincipal),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            tooltip: 'Quitar',
                                            style: IconButton.styleFrom(
                                                shape: const CircleBorder(
                                                    side: BorderSide(
                                                        color:
                                                            kNaranjaPrincipal))),
                                            onPressed: _quitarMiembroMigrante,
                                            icon: const Icon(
                                              Icons.remove,
                                              color: kNaranjaPrincipal,
                                            )),
                                        IconButton(
                                            tooltip: 'Agregar',
                                            style: IconButton.styleFrom(
                                                shape: const CircleBorder(
                                                    side: BorderSide(
                                                        color:
                                                            kNaranjaPrincipal))),
                                            onPressed: _agregarMiembroMigrante,
                                            icon: const Icon(
                                              Icons.add,
                                              color: kNaranjaPrincipal,
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: _inputsListado.length,
                                          itemBuilder: (context, int i) {
                                            return _inputsListado[i];
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          )
                        : Container(), */

                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP24)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '27. ¿De las personas de este hogar, ha fallecido o desaparecido alguien durante su viaje?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p27_familia',
                                  listado: familiasProvider.listadoP27),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

                    Text(
                        '28. ¿Considera que en el futuro algún miembro de este hogar tendrá intenciones de viajar a Estados Unidos?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p28_familia',
                        listado: familiasProvider.listadoP28),
                    const SizedBox(height: 15),
                    Text(
                        '29. ¿Sabe sí un miembro de la familia recibe remesas de los Estados Unidos?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p29_familia',
                        listado: familiasProvider.listadoP29),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP29)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '30. ¿Cuál es promedio de ingresos por remesas mensualmente?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p30_familia',
                                  listado: familiasProvider.listadoP30),
                              const SizedBox(height: 15),
                              Text('31. ¿Quién manda esas remesas?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              MultiSelectDialogField(
                                confirmText: Text(
                                  'ACEPTAR',
                                  style: GoogleFonts.lato(
                                      color: kTextoAzul, fontSize: 14),
                                ),
                                cancelText: Text(
                                  'CANCELAR',
                                  style: GoogleFonts.lato(
                                      color: kTextoAzul, fontSize: 14),
                                ),
                                dialogHeight: screenSize.height * 0.4,
                                items: listadoMultiP31,
                                title: const Text("Opciones"),
                                selectedColor: kNaranjaPrincipal,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                buttonIcon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                buttonText: Text(
                                    "Seleccione las que apliquen...",
                                    style: GoogleFonts.lato(
                                        fontSize: 14, color: Colors.black54)),
                                onConfirm: (seleccionadas) {
                                  familiasProvider.seleccionadosP31 =
                                      seleccionadas;
                                  //crear un array de los ids seleccionados
                                  List<int> selectedProvi = [];
                                  //poblar el array
                                  for (int i = 0;
                                      i < seleccionadas.length;
                                      i++) {
                                    selectedProvi.add(seleccionadas[i].id);
                                  }
                                  //Asignar el listado a la variable final
                                  familiasProvider.valorp31 =
                                      stringMultiselect(selectedProvi);
                                },
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  '32. ¿Quién toma la decisión de cómo gastar las remesas?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p32_familia',
                                  listado: familiasProvider.listadoP32),
                              const SizedBox(height: 15),
                              (condicionesProvider.condicionP32)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text('Especifique quien:',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        InputSencilloConValidacion(
                                            controlador: familiasProvider.otro1,
                                            pregunta: 'Especifique...'),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(height: 15),
                              Text(
                                  '33. ¿En qué se gasta la mayor parte de esas remesas?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p33_familia',
                                  listado: familiasProvider.listadoP33),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

                    //SOLO PARA FAMILIAS CON EXPERIENCIA MIGRATORIA
                    (condicionesProvider.condicionP14y24)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '*SOLO PARA HOGARES CON EXPERIENCIA MIGRATORIA',
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kNaranjaPrincipal),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  '34. ¿Cuál es la principal razón por las que se fue el migrante?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p34_familia',
                                  listado: familiasProvider.listadoP34),
                              const SizedBox(height: 15),
                              Text(
                                  '35. ¿Cómo atravesó México? (puede seleccionar varias)',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              MultiSelectDialogField(
                                confirmText: Text(
                                  'ACEPTAR',
                                  style: GoogleFonts.lato(
                                      color: kTextoAzul, fontSize: 14),
                                ),
                                cancelText: Text(
                                  'CANCELAR',
                                  style: GoogleFonts.lato(
                                      color: kTextoAzul, fontSize: 14),
                                ),
                                dialogHeight: screenSize.height * 0.4,
                                items: listadoMultiP35,
                                title: const Text("Opciones"),
                                selectedColor: kNaranjaPrincipal,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                buttonIcon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                buttonText: Text(
                                    "Seleccione las que apliquen...",
                                    style: GoogleFonts.lato(
                                        fontSize: 14, color: Colors.black54)),
                                onConfirm: (seleccionadas) {
                                  familiasProvider.seleccionadosP35 =
                                      seleccionadas;
                                  //crear un array de los ids seleccionados
                                  List<int> selectedProvi = [];
                                  //poblar el array
                                  for (int i = 0;
                                      i < seleccionadas.length;
                                      i++) {
                                    selectedProvi.add(seleccionadas[i].id);
                                  }
                                  //Asignar el listado a la variable final
                                  familiasProvider.valorp35 =
                                      stringMultiselect(selectedProvi);
                                },
                              ),
                              const SizedBox(height: 15),
                              Text(
                                  '36. ¿Cómo cruzó la frontera de los Estados Unidos?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p36_familia',
                                  listado: familiasProvider.listadoP36),
                              const SizedBox(height: 15),
                              Text('37. ¿Contrató "coyote"?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p37_familia',
                                  listado: familiasProvider.listadoP37),
                              const SizedBox(height: 15),
                              (condicionesProvider.condicionP37)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text('38. ¿Dónde lo contrató?',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        DropdownSencillo(
                                            placeholder: 'Seleccione...',
                                            caso: 'p38_familia',
                                            listado:
                                                familiasProvider.listadoP38),
                                        const SizedBox(height: 15),
                                        Text(
                                            '39. ¿Cuánto pagó por el "coyote"?',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        DropdownSencillo(
                                            placeholder: 'Seleccione...',
                                            caso: 'p39_familia',
                                            listado:
                                                familiasProvider.listadoP39),
                                        const SizedBox(height: 15),
                                      ],
                                    )
                                  : Container(),
                              Text('40. ¿Cuáles son sus planes a futuro?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p40_familia',
                                  listado: familiasProvider.listadoP40),
                              const SizedBox(height: 15),
                              (condicionesProvider.condicionP40)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                            '41. Si ha decidido viajar a Estados Unidos, ¿Qué lo haría quedarse en $nombrePais?',
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.black54)),
                                        const SizedBox(height: 7),
                                        DropdownSencillo(
                                            placeholder: 'Seleccione...',
                                            caso: 'p41_familias',
                                            listado:
                                                familiasProvider.listadoP41),
                                        const SizedBox(height: 15),
                                      ],
                                    )
                                  : Container(),
                            ],
                          )
                        : Container(),
                    const Divider(),
                    Text('42. ¿Cuál es su condición laboral en este momento?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p42_familias',
                        listado: familiasProvider.listadoP42),
                    const SizedBox(height: 15),

                    (condicionesProvider.condicionNinaNino)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '43. ¿Todos los niños entre 7 y 18 años asisten a la escuela?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p43_familias',
                                  listado: familiasProvider.listadoP43),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

                    Text(
                        '44. ¿Cuál es el rango de ingresos de este hogar? (sin contar las remesas)',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p44_familias',
                        listado: familiasProvider.listadoP44),
                    const SizedBox(height: 15),

                    //------PROPIO DE HONDURAS | INICIO
                    (widget.idPais == 1)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '45. ¿Este hogar es beneficiario del BONO VIDA MEJOR (BONO 10 MIL)?',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'p45_familias',
                                  listado: familiasProvider.listadoP45),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),
                    //------PROPIO DE HONDURAS | FINAL

                    Text(
                        '45b. ¿De quién es la vivienda donde habita la familia?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'vivienda_familias',
                        listado: familiasProvider.listadoVivienda),
                    const SizedBox(height: 15),
                    Text(
                        '46. ¿Cuál es el material predominante en el PISO del hogar?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p46_familias',
                        listado: familiasProvider.listadoP46),
                    const SizedBox(height: 15),
                    Text(
                        '47. ¿Cómo obtiene el AGUA que utiliza en la vivienda?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p47_familias',
                        listado: familiasProvider.listadoP47),
                    const SizedBox(height: 15),
                    Text('48. ¿Qué tipo de ALUMBRADO utiliza en la vivienda?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p48_familias',
                        listado: familiasProvider.listadoP48),
                    const SizedBox(height: 15),
                    Text('49. ¿Qué tipo de SERVICIO SANITARIO o LETRINA tiene?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p49_familias',
                        listado: familiasProvider.listadoP49),
                    const SizedBox(height: 15),
                    Text('50. Zona:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p50_familias',
                        listado: familiasProvider.listadoP50),
                    const SizedBox(height: 15),

                    //--------------puntaje de PROPENSIÓN DE MIGRACIÓN

                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: kGrisClaroWeb,
                      ),
                      child: Text(
                          'Propensión: ${(propensionProvider.propension).toStringAsFixed(2)}',
                          style: GoogleFonts.lato()),
                    ),
                    const SizedBox(height: 15),

                    //--------------puntaje de PROPENSIÓN DE MIGRACIÓN

                    //---------------------SECCIÓN Indice de calificación de la pobreza
                    Text(
                      'Índice de Calificación de la Pobreza (Grameen Foundation (GF))',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text(
                        'PPI 1) ¿Cuántos miembros del hogar tienen 14 años o menos?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi1_familias',
                        listado: familiasProvider.listadoPpi1),
                    const SizedBox(height: 15),
                    Text(
                        'PPI 2) ¿Cuál es el nivel educativo más alto que alcanzó la jefa/esposa del hogar?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi2_familias',
                        listado: familiasProvider.listadoPpi2),
                    const SizedBox(height: 15),
                    Text(
                        'PPI 3) ¿Cuál es la ocupación principal que desempeña el jefe/esposo del hogar?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi3_familias',
                        listado: familiasProvider.listadoPpi3),

                    const SizedBox(height: 15),
                    Text(
                        'PPI 4) ¿En su ocupación principal, ¿cuántos miembros del hogar trabajan como empleado asalariado?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi4_familias',
                        listado: familiasProvider.listadoPpi4),
                    const SizedBox(height: 15),
                    Text(
                        'PPI 5) ¿Cuántas piezas utiliza este hogar para dormir?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi5_familias',
                        listado: familiasProvider.listadoPpi5),
                    const SizedBox(height: 15),
                    Text('PPI 6) ¿Cuál es el material predominante en el piso?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi6_familias',
                        listado: familiasProvider.listadoPpi6),
                    const SizedBox(height: 15),
                    Text(
                        'PPI 7) ¿Como obtiene el agua que utiliza en la vivienda?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi7_familias',
                        listado: familiasProvider.listadoPpi7),
                    const SizedBox(height: 15),
                    Text(
                        'PPI 8) ¿Alguien de los residentes de este hogar tiene una refrigeradora en buenas condiciones?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi8_familias',
                        listado: familiasProvider.listadoPpi8),
                    const SizedBox(height: 15),
                    Text(
                        'PPI 9) ¿Alguien de los residentes de este hogar tiene una estufa de cuatro hornillas en buenas condiciones?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi9_familias',
                        listado: familiasProvider.listadoPpi9),
                    const SizedBox(height: 15),
                    Text(
                        'PPI 10) ¿Alguien de los residentes de este hogar tiene televisión en buenas condiciones con o sin cable?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'pppi10_familias',
                        listado: familiasProvider.listadoPpi10),
                    const SizedBox(height: 15),

                    //--------------puntaje de ÍNDICE DE POBREZA

                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: kGrisClaroWeb,
                      ),
                      child: Text(
                          'Puntaje Obtenido: ${indicePobrezaProvider.indiceICP}',
                          style: GoogleFonts.lato()),
                    ),
                    const SizedBox(height: 15),

                    //--------------puntaje de ÍNDICE DE POBREZA

                    //-------------
                    Text(
                      'F. Otros Datos',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text('Nombre del Encuestador:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'encuestador_familia',
                        listado: familiasProvider.listadoFacilitador),
                    const SizedBox(height: 15),
                    Text('No. de Teléfono:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacionSoloNumeros(
                        controlador: familiasProvider.telFacilitador,
                        pregunta: 'Teléfono sin guiones ni espacios...',
                        cuantosNumeros: 8),
                    const SizedBox(height: 15),
                    Text('Fecha en la que se realizó la encuesta:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    TextFormField(
                      controller: familiasProvider.fecha,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: kNaranjaPrincipal),
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black45),
                        ),
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: kNaranjaPrincipal,
                        ),
                        hintText: 'Ingrese la Fecha... ',
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime hoy = DateTime.now();
                        DateTime? pickedDate = await showDatePicker(
                          locale: const Locale('es', 'HN'),
                          context: context,
                          initialDate: hoy,
                          firstDate: DateTime(hoy.year - 1, hoy.month, hoy.day),
                          lastDate: hoy,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                      primary: kNaranjaPrincipal,
                                      onPrimary: Colors.white)),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          familiasProvider.fecha.text = formattedDate;
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
                    Text('Observaciones',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputTextAreaSinValidacion(
                      controlador: familiasProvider.observaciones,
                      pregunta: 'Observaciones de la encuesta...',
                    ),
                    const SizedBox(height: 15),
                    Text('Obtener Ubicación:',
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
                      controlador: familiasProvider.lat,
                      pregunta: 'Latitud...',
                    ),
                    const SizedBox(height: 7),
                    InputSencilloConValidacion(
                      readOnly: true,
                      controlador: familiasProvider.lon,
                      pregunta: 'Longitud...',
                    ),
                    const SizedBox(height: 7),
                    InputSencilloConValidacion(
                      readOnly: true,
                      controlador: familiasProvider.alt,
                      pregunta: 'Altitud...',
                    ),
                    const SizedBox(height: 7),
                    InputSencilloConValidacion(
                      readOnly: true,
                      controlador: familiasProvider.acc,
                      pregunta: 'Exactitud...',
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              side: const BorderSide(
                                color: kNaranjaPrincipal,
                              )),
                          onPressed: () async {
                            if (_llave.currentState!.validate()) {
                              String codaleaUnico = randomAlphaNumeric(15);

                              //Obtener el úlitmo codalea de límites propensiones
                              // List<LimitesPropensionesModelo>
                              //     listadoLimitesPropensiones =
                              //     await DatabaseSatM.instance
                              //         .obtenerLimitesPropensiones();

                              // String ultimoLimitePropension =
                              //     listadoLimitesPropensiones
                              //         .last.codaleaPropension;

                              //Grabar Formulario en BD
                              await DatabaseSatM.instance
                                  .agregarFamilias(FamiliasModelo(
                                codaleaSatfamilias: codaleaUnico,
                                //codaleaPropension: ultimoLimitePropension,
                                start: DateFormat('yyyy-MM-dd hh:mm:ss')
                                    .format(_start),
                                end: DateFormat('yyyy-MM-dd hh:mm:ss')
                                    .format(DateTime.now()),
                                today: DateFormat('yyyy-MM-dd hh:mm:ss')
                                    .format(DateTime.now()),
                                idPais: familiasProvider.idPais,
                                idDepartamento: familiasProvider.idDepartamento,
                                idMunicipio: familiasProvider.idMunicipio!,
                                comunidad: familiasProvider.comunidad!,
                                patrocinio: familiasProvider.patrocinio,
                                nomEncuestado:
                                    familiasProvider.nomEncuestado.text,
                                identidad:
                                    int.parse(familiasProvider.identidad.text),
                                edad: int.parse(familiasProvider.edad.text),
                                nacimiento: familiasProvider.nacimiento.text,
                                sexo: familiasProvider.sexo,
                                estudia: familiasProvider.estudia,
                                educacion: familiasProvider.educacion,
                                estado: familiasProvider.estado,
                                telefonoEncuestado:
                                    familiasProvider.telefonoEncuestado.text,
                                familias: (familiasProvider
                                        .familias.text.isNotEmpty)
                                    ? int.parse(familiasProvider.familias.text)
                                    : 0,
                                miembros:
                                    int.parse(familiasProvider.miembros.text),
                                nina: int.parse(familiasProvider.nina.text),
                                nino: int.parse(familiasProvider.nino.text),
                                ambosPadres: familiasProvider.ambosPadres,
                                nnPatrocinado:
                                    (familiasProvider.nnPatrocinado == 0)
                                        ? 2
                                        : familiasProvider.nnPatrocinado,
                                idPatrocinio:
                                    familiasProvider.idPatrocinio.text,
                                p01: familiasProvider.p01,
                                p02: familiasProvider.p02,
                                p03: familiasProvider.p03,
                                p04: familiasProvider.p04,
                                p05: familiasProvider.p05,
                                p06: familiasProvider.p06,
                                p07: familiasProvider.p07,
                                p08: familiasProvider.p08,
                                p09: familiasProvider.p09,
                                p10: familiasProvider.p10,
                                p11: familiasProvider.p11,
                                p12: familiasProvider.p12,
                                p13: familiasProvider.p13,
                                p14: familiasProvider.p14,
                                p15: (familiasProvider.p15.text.isNotEmpty)
                                    ? int.parse(familiasProvider.p15.text)
                                    : 0,
                                p16: familiasProvider.p16,
                                p17: familiasProvider.p17,
                                p18: (familiasProvider.p18.text.isNotEmpty)
                                    ? int.parse(familiasProvider.p18.text)
                                    : 0,
                                p18B: (familiasProvider.p18B.text.isNotEmpty)
                                    ? int.parse(familiasProvider.p18B.text)
                                    : 0,
                                p19: familiasProvider.p19,
                                p20: familiasProvider.p20,
                                p21: familiasProvider.p21,
                                p22: familiasProvider.p22,
                                p23: familiasProvider.p23,
                                p24: familiasProvider.p24,
                                p27: familiasProvider.p27,
                                p28: familiasProvider.p28,
                                p29: familiasProvider.p29,
                                p30: familiasProvider.p30,
                                p31: familiasProvider.p31,
                                p32: familiasProvider.p32,
                                otro1: familiasProvider.otro1.text,
                                p33: familiasProvider.p33,
                                p34: familiasProvider.p34,
                                p35: familiasProvider.p35,
                                p36: familiasProvider.p36,
                                p37: familiasProvider.p37,
                                p38: familiasProvider.p38,
                                p39: familiasProvider.p39,
                                p40: familiasProvider.p40,
                                p41: familiasProvider.p41,
                                p42: familiasProvider.p42,
                                p43: familiasProvider.p43,
                                p44: familiasProvider.p44,
                                p45: (familiasProvider.p45 != 0)
                                    ? familiasProvider.p45
                                    : 0,
                                vivienda: familiasProvider.vivienda,
                                p46: familiasProvider.p46,
                                p47: familiasProvider.p47,
                                p48: familiasProvider.p48,
                                p49: familiasProvider.p49,
                                p50: familiasProvider.p50,
                                p51: propensionProvider.propension.toString(),
                                ppi1: familiasProvider.ppi1,
                                ppi2: familiasProvider.ppi2,
                                ppi3: familiasProvider.ppi3,
                                ppi4: familiasProvider.ppi4,
                                ppi5: familiasProvider.ppi5,
                                ppi6: familiasProvider.ppi6,
                                ppi7: familiasProvider.ppi7,
                                ppi8: familiasProvider.ppi8,
                                ppi9: familiasProvider.ppi9,
                                ppi10: familiasProvider.ppi10,
                                ppi11:
                                    indicePobrezaProvider.indiceICP.toString(),
                                facilitador: familiasProvider.facilitador.text,
                                telFacilitador: int.parse(
                                    familiasProvider.telFacilitador.text),
                                fecha: familiasProvider.fecha.text,
                                observaciones:
                                    familiasProvider.observaciones.text,
                                lat: familiasProvider.lat.text,
                                lon: familiasProvider.lon.text,
                                alt: familiasProvider.alt.text,
                                acc: familiasProvider.acc.text,
                              ));

                              //Agregar los miembros migrantes en loop
                              /* if (_inputsListado.isNotEmpty) {
                                for (var i = 0;
                                    i < _inputsListado.length;
                                    i++) {
                                  await DatabaseSatM.instance
                                      .agregarFamiliasMiembros(
                                          FamiliasMiembrosModelo(
                                    codaleaMiembros: randomAlphaNumeric(15),
                                    codaleaSatfamilias: codaleaUnico,
                                    edadMigrante: (_controladoresListado[i]
                                            .text
                                            .isNotEmpty)
                                        ? int.parse(
                                            _controladoresListado[i].text)
                                        : 0,
                                    sexoMigrante: (_sexoListado[i] != null)
                                        ? int.parse(_sexoListado[i].toString())
                                        : 0,
                                    tiempoMigrante:
                                        (_haceCuantoViajoListado[i] != null)
                                            ? int.parse(
                                                _haceCuantoViajoListado[i]
                                                    .toString())
                                            : 0,
                                    miembroMigrante:
                                        (_seEncuentraEnUSAListado[i] != null)
                                            ? int.parse(
                                                _seEncuentraEnUSAListado[i]
                                                    .toString())
                                            : 0,
                                    p26: (_p26Listado[i] != null)
                                        ? int.parse(_p26Listado[i].toString())
                                        : 0,
                                  ));
                                }
                              } */

                              //Reiniciar variables de providers y condiciones
                              familiasProvider.resetearVariables();
                              condicionesProvider.resetearCondicionesFamilias();
                              indicePobrezaProvider.resetearVariables();

                              Fluttertoast.showToast(
                                      msg: "Encuesta guardada exitosamente!!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
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
                            'Guardar Encuesta',
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
      var familiasProvider =
          Provider.of<SatmFamiliasProvider>(context, listen: false);

      //Asignar los valores de ubicación
      familiasProvider.valorlat = locationData.latitude.toString();
      familiasProvider.valorlon = locationData.longitude.toString();
      familiasProvider.valoralt = locationData.altitude.toString();
      familiasProvider.valoracc = locationData.accuracy.toString();
    });
  }

  Future<bool> showLocationPermissionDialog() async {
    return showDialog(
      context: context,
      builder: (context) => const LocationPermissionDialog(),
    ).then((result) => result == true);
  }
}
