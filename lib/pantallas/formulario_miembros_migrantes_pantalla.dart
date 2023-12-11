import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:sat_m/bd/bd.dart';

import 'package:sat_m/constantes/colores_constantes.dart';
import 'package:sat_m/modales/salir_formulario_modal.dart';
import 'package:sat_m/modelos/miembros_migrantes_modelo.dart';
import 'package:sat_m/modelos/usuarios_modelo.dart';
import 'package:sat_m/providers/condiciones_miembros_migrantes_provider.dart';
import 'package:sat_m/providers/miembros_migrantes_provider.dart';
import 'package:sat_m/widgets/dropdowns_widget.dart';
import 'package:sat_m/widgets/inputs_sencillos_widget.dart';

class FormularioMiembrosMigrantes extends StatefulWidget {
  const FormularioMiembrosMigrantes(
      {required this.codaleaBoleta, required this.idPais, Key? key})
      : super(key: key);

  final int idPais;
  final String codaleaBoleta;

  @override
  State<FormularioMiembrosMigrantes> createState() =>
      _FormularioComunidadesState();
}

class _FormularioComunidadesState extends State<FormularioMiembrosMigrantes> {
  //Llave del formulario
  final _llave = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Variables que dependen del IDPAIS
    String nombrePais = "";

    switch (widget.idPais) {
      //Honduras
      case 1:
        nombrePais = 'HONDURAS';
        break;

      //Guatemala
      case 2:
        nombrePais = 'GUATEMALA';
        break;

      //El Salvador
      case 3:
        nombrePais = 'EL SALVADOR';
        break;
    }

    //Inicializar providers necesarios
    var miembrosMigrantesProvider =
        Provider.of<MiembrosMigrantesProvider>(context);

    var condicionesProvider =
        Provider.of<MiembrosMigrantesCondicionesProvider>(context);

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
                        condicionesProvider.resetearVariables();
                        miembrosMigrantesProvider.resetearVariables();

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
            'Miembros Migrantes',
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
                        'MONITOREO DE LA MIGRACIÓN',
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
                    //--------------SECCIÓN A - GENERALES ----------------------//
                    Text(
                        '¿Usted o algún familiar/vecino ha sido retornado recientemente a $nombrePais?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'retornado_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadoretornado),
                    const SizedBox(height: 15),

                    (condicionesProvider.condicion0)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  'Si la respuesta es sí, por favor indique la temporalidad del retorno:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              DropdownSencillo(
                                  placeholder: 'Seleccione...',
                                  caso: 'temporalidad_miembros_migrantes',
                                  listado: miembrosMigrantesProvider
                                      .listadotemporalidad),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

                    Text(
                        '¿Esta encuesta ya fue levantada por el SAT-M de WVH en su comunidad?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'comunidad_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadocomunidad),
                    const SizedBox(height: 15),

//-----------------SECCIÓN A INFORMACIÓN PERSONAL ----------------------------//
                    const SizedBox(height: 15),
                    Text(
                      'A. INFORMACIÓN PERSONAL',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text('1. Nombre completo:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacion(
                        controlador: miembrosMigrantesProvider.nomEncuestado,
                        pregunta: 'Nombre completo....'),
                    const SizedBox(height: 15),
                    Text('2. Edad:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacionSoloNumeros(
                        cuantosNumeros: 3,
                        controlador: miembrosMigrantesProvider.edad,
                        pregunta: 'Edad...'),
                    const SizedBox(height: 15),
                    Text('3. Género:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'genero_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadogenero),
                    const SizedBox(height: 15),

//-----------------SECCIÓN A INFORMACIÓN PERSONAL ----------------------------//

//-----------------SECCIÓN B INFORMACIÓN DE CONTACTO ----------------------------//
                    const SizedBox(height: 15),
                    Text(
                      'B. INFORMACIÓN DE CONTACTO',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text('4. Número de teléfono:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacionSoloNumeros(
                        cuantosNumeros: 8,
                        controlador: miembrosMigrantesProvider.numTelefono,
                        pregunta: 'Sin guiones...'),
                    const SizedBox(height: 15),
//-----------------SECCIÓN B INFORMACIÓN DE CONTACTO ----------------------------//

//-----------------SECCIÓN C INFORMACIÓN DEMOGRÁFICA ----------------------------//
                    const SizedBox(height: 15),
                    Text(
                      'C. INFORMACIÓN DEMOGRÁFICA',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text('5. Departamento:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'departamento_miembros_migrantes',
                        listado:
                            miembrosMigrantesProvider.listadoidDepartamento),
                    const SizedBox(height: 15),
                    Text('Municipio:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        valorInicial: (miembrosMigrantesProvider.idMunicipio ==
                                null)
                            ? null
                            : miembrosMigrantesProvider.idMunicipio.toString(),
                        placeholder: 'Seleccione...',
                        caso: 'municipio_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadoidMunicipio),
                    const SizedBox(height: 15),
                    Text('Nombre de la comunidad:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        valorInicial: (miembrosMigrantesProvider.nomComunidad ==
                                null)
                            ? null
                            : miembrosMigrantesProvider.nomComunidad.toString(),
                        placeholder: 'Seleccione...',
                        caso: 'nomComunidad_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadoNomComunidad),
                    const SizedBox(height: 15),
                    Text('6. Nivel educativo:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'nivel_educativo_miembros_migrantes',
                        listado:
                            miembrosMigrantesProvider.listadonivelEducativo),
                    const SizedBox(height: 15),
                    Text('7. Ocupación actual:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    InputSencilloConValidacion(
                        controlador: miembrosMigrantesProvider.ocupacion,
                        pregunta: 'Ocupación...'),
                    const SizedBox(height: 15),
                    Text('8. ¿Cuál es su estado civil?:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'estado_civil_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadoestadoCivil),
                    const SizedBox(height: 15),
//-----------------SECCIÓN C INFORMACIÓN DEMOGRÁFICA ----------------------------//

//-----------------SECCIÓN D INFORMACIÓN SOBRE LA MIGRACIÓN --------------------//
                    const SizedBox(height: 15),
                    Text(
                      'D. INFORMACIÓN SOBRE LA MIGRACIÓN',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text(
                        '9. ¿Esta encuesta la está realizando un familiar o vecino debido a la migración de una persona o familia en su hogar o cercano al mismo?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p09_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadop09),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP09)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '- Si la respuesta es sí, por favor indique su relación con la persona o familia migrante:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacion(
                                  controlador:
                                      miembrosMigrantesProvider.p09Relacion,
                                  pregunta: 'relación'),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),
                    Text('10. Motivo de la migración:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p10_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadop10),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP10)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '- Si la respuesta es otro, por favor especificar:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacion(
                                  controlador:
                                      miembrosMigrantesProvider.p10Otro,
                                  pregunta: 'especifique'),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

                    Text(
                        '11. País de destino ¿Cuál es el país de destino al que tiene la intención de migrar o migro?:',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p11_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadop11),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP11)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  '- Si la respuesta es otro, por favor especificar:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacion(
                                  controlador:
                                      miembrosMigrantesProvider.p11Otro,
                                  pregunta: 'especifique'),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

//-----------------SECCIÓN D INFORMACIÓN SOBRE LA MIGRACIÓN --------------------//

//-----------------SECCIÓN E INFORMACIÓN SOBRE LA FAMILIA DE LA PERSONA QUE MIGRÓ --------------------//
                    const SizedBox(height: 15),
                    Text(
                      'E. INFORMACIÓN SOBRE LA FAMILIA DE LA PERSONA QUE MIGRÓ',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text('12. ¿Dejó familiares en $nombrePais?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p12_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadop12),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP12)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('- Si la respuesta es sí:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              Text('- Número de familiares dejados:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacionSoloNumeros(
                                  cuantosNumeros: 2,
                                  controlador:
                                      miembrosMigrantesProvider.p12Numero,
                                  pregunta: '# de familiares dejados...'),
                              const SizedBox(height: 15),
                              Text('- Relación con los familiares dejados:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacion(
                                  controlador:
                                      miembrosMigrantesProvider.p12Relacion,
                                  pregunta: 'Relación...'),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

//-----------------SECCIÓN E INFORMACIÓN SOBRE LA FAMILIA DE LA PERSONA QUE MIGRÓ --------------------//

//-----------------SECCIÓN F AL ENCUESTADO --------------------//
                    const SizedBox(height: 15),
                    Text(
                      'F. AL ENCUESTADO',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text('13. ¿Ha migrado anteriormente?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p13_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadop13),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP13)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('- Si la respuesta es sí:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              Text('- Año de la migración anterior:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacionSoloNumeros(
                                  cuantosNumeros: 4,
                                  controlador:
                                      miembrosMigrantesProvider.p13Anio,
                                  pregunta: 'solo números...'),
                              const SizedBox(height: 15),
                              Text('- País de destino anterior:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputSencilloConValidacion(
                                  controlador:
                                      miembrosMigrantesProvider.p13Pais,
                                  pregunta: 'Escriba el país...'),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

//-----------------SECCIÓN F AL ENCUESTADO --------------------//

//-----------------SECCIÓN G CONDICIONES DE MIGRACIÓN --------------------//
                    const SizedBox(height: 15),
                    Text(
                      'G. CONDICIONES DE MIGRACIÓN',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text('14. ¿Enfrento desafíos durante la migración?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p14_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadop14),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP14)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('- Si la respuesta es sí:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              Text('- Descripción de los desafíos:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputTextAreaSinValidacion(
                                  controlador:
                                      miembrosMigrantesProvider.p14Descripcion,
                                  pregunta: 'Descripción...'),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

                    Text(
                        '15. ¿Ha tenido acceso a servicios de apoyo en el país?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p15_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadop15),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP15)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('- Si la respuesta es sí:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              Text('- Tipo de servicios utilizados:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputTextAreaSinValidacion(
                                  controlador:
                                      miembrosMigrantesProvider.p15Servicios,
                                  pregunta: 'Tipos de servicios...'),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

//-----------------SECCIÓN G CONDICIONES DE MIGRACIÓN --------------------//

//-----------------SECCIÓN H EXPECTATIVAS Y PLANES FUTUROS --------------------//
                    const SizedBox(height: 15),
                    Text(
                      'H. EXPECTATIVAS Y PLANES FUTUROS',
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kNaranjaPrincipal),
                    ),
                    const SizedBox(height: 15),
                    Text(
                        '16. ¿Tiene planes de regresar a $nombrePais si migra?',
                        style: GoogleFonts.lato(
                            fontSize: 14, color: Colors.black54)),
                    const SizedBox(height: 7),
                    DropdownSencillo(
                        placeholder: 'Seleccione...',
                        caso: 'p16_miembros_migrantes',
                        listado: miembrosMigrantesProvider.listadop16),
                    const SizedBox(height: 15),
                    (condicionesProvider.condicionP16)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('- Si la respuesta es sí:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              Text('- Razones para regresar:',
                                  style: GoogleFonts.lato(
                                      fontSize: 14, color: Colors.black54)),
                              const SizedBox(height: 7),
                              InputTextAreaSinValidacion(
                                  controlador:
                                      miembrosMigrantesProvider.p16Razones,
                                  pregunta: 'Razones...'),
                              const SizedBox(height: 15),
                            ],
                          )
                        : Container(),

//-----------------SECCIÓN H EXPECTATIVAS Y PLANES FUTUROS --------------------//
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
                            //Guardar en BD
                            if (_llave.currentState!.validate()) {
                              //Obtener los datos del usuario
                              List<UsuariosModelo> datosUsuario =
                                  await DatabaseSatM.instance.obtenerUsuarios();

                              await DatabaseSatM.instance
                                  .agregarMiembrosMigrantes(
                                      MiembrosMigrantesModelo(
                                codaleaMiembros: randomAlphaNumeric(15),
                                codaleaSatfamilias: widget.codaleaBoleta,
                                retornado: miembrosMigrantesProvider.retornado,
                                temporalidad:
                                    miembrosMigrantesProvider.temporalidad,
                                comunidad: miembrosMigrantesProvider.comunidad,
                                nomEncuestado: miembrosMigrantesProvider
                                    .nomEncuestado.text,
                                edad: int.parse(
                                    miembrosMigrantesProvider.edad.text),
                                genero: miembrosMigrantesProvider.genero,
                                numTelefono:
                                    miembrosMigrantesProvider.numTelefono.text,
                                idDepartamento:
                                    miembrosMigrantesProvider.idDepartamento,
                                idMunicipio:
                                    miembrosMigrantesProvider.idMunicipio!,
                                nomComunidad:
                                    miembrosMigrantesProvider.nomComunidad!,
                                nivelEducativo:
                                    miembrosMigrantesProvider.nivelEducativo,
                                ocupacion:
                                    miembrosMigrantesProvider.ocupacion.text,
                                estadoCivil:
                                    miembrosMigrantesProvider.estadoCivil,
                                p09: miembrosMigrantesProvider.p09,
                                p09Relacion:
                                    miembrosMigrantesProvider.p09Relacion.text,
                                p10: miembrosMigrantesProvider.p10,
                                p10Otro: miembrosMigrantesProvider.p10Otro.text,
                                p11: miembrosMigrantesProvider.p11,
                                p11Otro: miembrosMigrantesProvider.p11Otro.text,
                                p12: miembrosMigrantesProvider.p12,
                                p12Numero: (miembrosMigrantesProvider
                                        .p12Numero.text.isNotEmpty)
                                    ? int.parse(miembrosMigrantesProvider
                                        .p12Numero.text)
                                    : 0,
                                p12Relacion:
                                    miembrosMigrantesProvider.p12Relacion.text,
                                p13: miembrosMigrantesProvider.p13,
                                p13Anio: (miembrosMigrantesProvider
                                        .p13Anio.text.isNotEmpty)
                                    ? int.parse(
                                        miembrosMigrantesProvider.p13Anio.text)
                                    : 0,
                                p13Pais: miembrosMigrantesProvider.p13Pais.text,
                                p14: miembrosMigrantesProvider.p14,
                                p14Descripcion: miembrosMigrantesProvider
                                    .p14Descripcion.text,
                                p15: miembrosMigrantesProvider.p15,
                                p15Servicios:
                                    miembrosMigrantesProvider.p15Servicios.text,
                                p16: miembrosMigrantesProvider.p16,
                                p16Razones:
                                    miembrosMigrantesProvider.p16Razones.text,
                                fechaCreado: DateFormat('yyyy-MM-dd hh:mm:ss')
                                    .format(DateTime.now()),
                                creadoPor: datosUsuario[0].id!,
                              ));

                              //Resetear todas las variables
                              miembrosMigrantesProvider.resetearVariables();
                              condicionesProvider.resetearVariables();

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
}
