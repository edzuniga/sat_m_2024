import 'dart:io';
import 'package:path/path.dart';
import 'package:sat_m/modelos/comunidades_modelo.dart';
import 'package:sat_m/modelos/departamentos_modelo.dart';
import 'package:sat_m/modelos/familias_miembros_modelo.dart';
import 'package:sat_m/modelos/ingresos_opciones_modelo.dart';
import 'package:sat_m/modelos/limites_propensiones_modelo.dart';
import 'package:sat_m/modelos/miembros_migrantes_modelo.dart';
import 'package:sat_m/modelos/municipios_modelo.dart';
import 'package:sat_m/modelos/onboarding_modelo.dart';
import 'package:sat_m/modelos/paises_modelo.dart';
import 'package:sat_m/modelos/preguntas_ponderaciones_modelo.dart';
import 'package:sat_m/modelos/propensiones_modelo.dart';
import 'package:sat_m/modelos/rangos_modelo.dart';
import 'package:sat_m/modelos/roles_modelo.dart';
import 'package:sat_m/modelos/satm_comunidades_modelo.dart';
import 'package:sat_m/modelos/satm_familias_modelo.dart';
import 'package:sat_m/modelos/satm_preguntas_modelo.dart';
import 'package:sat_m/modelos/usuarios_modelo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseSatM {
  //Para que solo haya una instancia de la BD
  DatabaseSatM._privateConstructor();
  static final DatabaseSatM instance = DatabaseSatM._privateConstructor();

  //Revisan si ya DB ya fue creada, SINO la CREA
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'satm_db.db');

    // ignore: avoid_print
    //print(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    //-------------------CREACIÓN DE TABLAS INICIALES----------------------//

    //Creación de tabla FORMULARIO COMUNIDADES
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `satm_comunidades` (
          `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `codalea_satcomunidades` TEXT(15) NOT NULL,
          `start` TEXT NOT NULL,
          `end` TEXT NOT NULL,
          `today` TEXT NOT NULL,
          `idPais` INTEGER NOT NULL,
          `idDepartamento` INTEGER NOT NULL,
          `idMunicipio` INTEGER NOT NULL,
          `comunidad` INTEGER NOT NULL,
          `acepta` INTEGER NOT NULL,
          `sign` TEXT NOT NULL,
          `nom_encuestado` TEXT NOT NULL,
          `tel_encuestado` TEXT,
          `identidad` TEXT NOT NULL,
          `edad` INTEGER NOT NULL,
          `sexo` INTEGER NOT NULL,
          `educacion` INTEGER NOT NULL,
          `ano_cursado` INTEGER NOT NULL,
          `estado` INTEGER NOT NULL,
          `nino` INTEGER NOT NULL,
          `ambos_padres` INTEGER NOT NULL,
          `nn_patrocinado` INTEGER NOT NULL,
          `id_patrocinio` TEXT,
          `b1` INTEGER NOT NULL,
          `b2` INTEGER NOT NULL,
          `c1` INTEGER NOT NULL,
          `c2` INTEGER NOT NULL,
          `c3` INTEGER NOT NULL,
          `d1` INTEGER NOT NULL,
          `d2` INTEGER NOT NULL,
          `d3` INTEGER NOT NULL,
          `d4` INTEGER NOT NULL,
          `d9` INTEGER NOT NULL,
          `d5` INTEGER NOT NULL,
          `d6` INTEGER NOT NULL,
          `d7` INTEGER NOT NULL,
          `d8` INTEGER NOT NULL,
          `e1` INTEGER NOT NULL,
          `e2` INTEGER NOT NULL,
          `facilitador` TEXT NOT NULL,
          `tel_facilitador` INTEGER NOT NULL,
          `fecha` TEXT NOT NULL,
          `observaciones` TEXT,
          `lat` TEXT NOT NULL,
          `lon` TEXT NOT NULL,
          `alt` TEXT NOT NULL,
          `acc` TEXT NOT NULL
        )
    ''');

    //Creación de tabla FORMULARIO FAMILIAS
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `satm_familias` (
          `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `codalea_satfamilias` TEXT(15) DEFAULT NULL,
          `codalea_propension` TEXT(15) DEFAULT NULL,
          `start` TEXT NOT NULL,
          `end` TEXT NOT NULL,
          `today` TEXT NOT NULL,
          `idPais` INTEGER NOT NULL,
          `idDepartamento` INTEGER NOT NULL,
          `idMunicipio` INTEGER NOT NULL,
          `comunidad` INTEGER NOT NULL,
          `patrocinio` INTEGER,
          `nom_encuestado` TEXT NOT NULL,
          `identidad` INTEGER NOT NULL,
          `edad` INTEGER NOT NULL,
          `nacimiento` TEXT NOT NULL,
          `sexo` INTEGER NOT NULL,
          `estudia` INTEGER NOT NULL,
          `educacion` INTEGER,
          `estado` INTEGER NOT NULL,
          `telefono_encuestado` TEXT,
          `familias` INTEGER NOT NULL,
          `miembros` INTEGER NOT NULL,
          `nina` INTEGER NOT NULL,
          `nino` INTEGER NOT NULL,
          `ambos_padres` INTEGER NOT NULL,
          `nn_patrocinado` INTEGER,
          `id_patrocinio` TEXT,
          `p01` INTEGER NOT NULL,
          `p02` INTEGER NOT NULL,
          `p03` INTEGER NOT NULL,
          `p04` TEXT NOT NULL,
          `p05` TEXT NOT NULL,
          `p06` INTEGER NOT NULL,
          `p07` INTEGER NOT NULL,
          `p08` TEXT NOT NULL,
          `p09` INTEGER NOT NULL,
          `p10` TEXT NOT NULL,
          `p11` INTEGER NOT NULL,
          `p12` TEXT NOT NULL,
          `p13` INTEGER NOT NULL,
          `p14` INTEGER NOT NULL,
          `p15` INTEGER NOT NULL,
          `p16` INTEGER NOT NULL,
          `p17` INTEGER NOT NULL,
          `p18` INTEGER,
          `p18b` INTEGER,
          `p19` INTEGER NOT NULL,
          `p20` INTEGER NOT NULL,
          `p21` INTEGER NOT NULL,
          `p22` INTEGER NOT NULL,
          `p23` INTEGER NOT NULL,
          `p24` INTEGER NOT NULL,
          `p27` INTEGER NOT NULL,
          `p28` INTEGER NOT NULL,
          `p29` INTEGER NOT NULL,
          `p30` INTEGER NOT NULL,
          `p31` TEXT NOT NULL,
          `p32` INTEGER NOT NULL,
          `otro1` TEXT,
          `p33` INTEGER NOT NULL,
          `p34` INTEGER NOT NULL,
          `p35` TEXT NOT NULL,
          `p36` INTEGER NOT NULL,
          `p37` INTEGER NOT NULL,
          `p38` INTEGER NOT NULL,
          `p39` INTEGER,
          `p40` INTEGER NOT NULL,
          `p41` INTEGER NOT NULL,
          `p42` INTEGER NOT NULL,
          `p43` INTEGER NOT NULL,
          `p44` INTEGER NOT NULL,
          `p45` INTEGER NOT NULL,
          `vivienda` INTEGER NOT NULL,
          `p46` INTEGER NOT NULL,
          `p47` INTEGER NOT NULL,
          `p48` INTEGER NOT NULL,
          `p49` INTEGER NOT NULL,
          `p50` INTEGER NOT NULL,
          `p51` TEXT NOT NULL,
          `ppi1` INTEGER NOT NULL,
          `ppi2` INTEGER NOT NULL,
          `ppi3` INTEGER NOT NULL,
          `ppi4` INTEGER NOT NULL,
          `ppi5` INTEGER NOT NULL,
          `ppi6` INTEGER NOT NULL,
          `ppi7` INTEGER NOT NULL,
          `ppi8` INTEGER NOT NULL,
          `ppi9` INTEGER NOT NULL,
          `ppi10` INTEGER NOT NULL,
          `ppi11` TEXT NOT NULL,
          `facilitador` TEXT,
          `tel_facilitador` INTEGER,
          `fecha` TEXT,
          `observaciones` TEXT,
          `lat` TEXT,
          `lon` TEXT,
          `alt` TEXT,
          `acc` TEXT
        )
    ''');

    //Creación de tabla de MIEMBROS MIGRANTES
    await db.execute('''
      CREATE TABLE IF NOT EXISTS `satm_familias_miembros_migrantes` (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      codalea_miembros TEXT NOT NULL,
      codalea_satfamilias TEXT NOT NULL,
      retornado INTEGER NOT NULL DEFAULT 0,
      temporalidad INTEGER NOT NULL DEFAULT 0,
      comunidad INTEGER NOT NULL DEFAULT 0,
      nom_encuestado TEXT DEFAULT NULL,
      edad INTEGER NOT NULL DEFAULT 0,
      genero INTEGER NOT NULL DEFAULT 0,
      num_telefono TEXT DEFAULT NULL,
      idDepartamento INTEGER NOT NULL DEFAULT 0,
      idMunicipio INTEGER NOT NULL DEFAULT 0,
      nom_comunidad INTEGER DEFAULT NULL,
      nivel_educativo INTEGER NOT NULL DEFAULT 0,
      ocupacion TEXT DEFAULT NULL,
      estado_civil INTEGER NOT NULL DEFAULT 0,
      p09 INTEGER NOT NULL DEFAULT 0,
      p09relacion TEXT DEFAULT NULL,
      p10 INTEGER NOT NULL DEFAULT 0,
      p10otro TEXT DEFAULT NULL,
      p11 INTEGER NOT NULL DEFAULT 0,
      p11otro TEXT DEFAULT NULL,
      p12 INTEGER NOT NULL DEFAULT 0,
      p12numero INTEGER NOT NULL DEFAULT 0,
      p12relacion TEXT DEFAULT NULL,
      p13 INTEGER NOT NULL DEFAULT 0,
      p13anio INTEGER NOT NULL DEFAULT 0,
      p13pais TEXT DEFAULT NULL,
      p14 INTEGER NOT NULL DEFAULT 0,
      p14descripcion TEXT DEFAULT NULL,
      p15 INTEGER NOT NULL DEFAULT 0,
      p15servicios TEXT DEFAULT NULL,
      p16 INTEGER DEFAULT 0,
      p16razones TEXT DEFAULT NULL,
      fecha_creado TEXT NOT NULL,
      creado_por INTEGER NOT NULL
      );
    ''');

    //Creación de tabla FAMILIAS MIEMBROS
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `satm_familias_miembros` (
          `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `codalea_miembros` TEXT(15) NOT NULL,
          `codalea_satfamilias` TEXT(15) NOT NULL,
          `edad_migrante` INTEGER NOT NULL,
          `sexo_migrante` INTEGER NOT NULL,
          `tiempo_migrante` INTEGER NOT NULL,
          `miembro_migrante` INTEGER NOT NULL,
          `p26` INTEGER DEFAULT NULL
        )
    ''');

    //Creación de tabla PREGUNTAS
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `satm_preguntas` (
          `idPregunta` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `codigo_pregunta` TEXT(10) NOT NULL,
          `pregunta` TEXT NOT NULL
        )
    ''');

    //Creación de tabla PONDERACIONES
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `satm_preguntas_ponderaciones` (
          `idPonderacion` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `idPregunta` INTEGER NOT NULL,
          `codigo_pregunta` TEXT(10) NOT NULL,
          `opcion_nombre` TEXT NOT NULL,
          `opcion_valor` INTEGER NOT NULL,
          `ponderacion` TEXT NOT NULL
        )
    ''');

    //Creación de tabla PROPENSIONES
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `satm_propensiones` (
          `idPropension` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `propension` TEXT NOT NULL,
          `valor_minimo` TEXT NOT NULL,
          `valor_maximo` TEXT NOT NULL
        ) 
    ''');

    //Creación de tabla USUARIOS
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `satm_usuarios` (
          `id` INTEGER NOT NULL,
          `codalea_usuario` TEXT(15) NOT NULL,
          `nombres` TEXT NOT NULL,
          `apellidos` TEXT NOT NULL,
          `correo` TEXT NOT NULL,
          `contra` TEXT,
          `idPais` INTEGER NOT NULL,
          `foto` TEXT,
          `tel_facilitador` TEXT,
          `idRol` INTEGER NOT NULL,
          `activo` INTEGER,
          `fecha_creado` TEXT,
          `creado_por` INTEGER,
          `fecha_modi` TEXT,
          `modificado_por` INTEGER,
          `form_fam` INTEGER,
          `form_comu` INTEGER
        )
    ''');

    //Creación de tabla DEPARTAMENTOS (POR PAIS)
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `wvi_departamentos` (
          `idDepartamento` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `idPais` INTEGER NOT NULL,
          `departamento` TEXT NOT NULL
        )
    ''');

    //Creación de tabla MUNICIPIOS (POR PAIS)
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `wvi_municipios` (
          `idMunicipio` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `idPais` INTEGER NOT NULL,
          `idDepartamento` INTEGER NOT NULL,
          `municipio` TEXT NOT NULL
        )
    ''');

    //Creación de tabla PAÍSES
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `wvi_paises` (
          `idPais` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `pais` TEXT NOT NULL,
          `moneda` TEXT NOT NULL,
          `simbolo` TEXT NOT NULL,
          `digitosDNI` INTEGER NOT NULL
        )
    ''');

    //Creación de tabla OPCIONES DE INGRESOS
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `wvi_ingresos_opciones` (
          `idPais` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `ingreso_opt1` TEXT NOT NULL,
          `ingreso_opt2` TEXT NOT NULL,
          `ingreso_opt3` TEXT NOT NULL,
          `ingreso_opt4` TEXT NOT NULL,
          `ingreso_opt5` TEXT NOT NULL,
          `ingreso_opt6` TEXT NOT NULL
        )
    ''');

    //Creación de tabla RANGOS DE P44
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `wvi_rangos_p44` (
          `idPais` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `rango44_opt1` TEXT NOT NULL,
          `rango44_opt2` TEXT NOT NULL,
          `rango44_opt3` TEXT NOT NULL,
          `rango44_opt4` TEXT NOT NULL,
          `rango44_opt5` TEXT NOT NULL
        ) 
    ''');

    //Creación de tabla COMUNIDADES (DEL MÓDULO)
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `wvi_comunidades` (
          `idComunidad` INTEGER NOT NULL ,
          `codaleaComunidad` TEXT NOT NULL,
          `idPais` INTEGER NOT NULL,
          `idDepartamento` INTEGER NOT NULL,
          `idMunicipio` INTEGER NOT NULL,
          `nombreComunidad` TEXT NOT NULL
        ) 
    ''');

    //Creación de tabla ROLES
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `wvi_roles` (
          `idRol` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `rol` TEXT NOT NULL
        )
    ''');

    //Creación de onBoarding
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `wvi_onboarding` (
          `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `activo` INTEGER NOT NULL
        )
    ''');

    //Creación de LÍMITES DE PROPENSIONES
    await db.execute('''
        CREATE TABLE IF NOT EXISTS `wvi_propensiones` (
          `idPropension` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          `codaleaPropension` TEXT NOT NULL,
          `limite_inf` REAL NOT NULL,
          `limite_sup` REAL NOT NULL
        )
    ''');

    //-------------------CREACIÓN DE TABLAS INICIALES----------------------//

    //-------------------INSERTS INICIALES----------------------//
    //INSERTS DE PREGUNTAS CON PONDERACIONES
    await db.execute('''
        INSERT INTO `satm_preguntas` (`idPregunta`, `codigo_pregunta`, `pregunta`) VALUES
          (1, "p09", "¿Mantiene comunicación con ellos? (contacto vía teléfono, Facebook, etc.)"),
          (2, "p11", "Si tiene familiares viviendo EEUU, ¿Mantiene comunicación con ellos? (contacto vía teléfono, Facebook, etc.)"),
          (3, "p16", "¿Cuándo fue la última vez que viajó?"),
          (4, "p17", "¿La/lo han deportado/a alguna vez?"),
          (5, "p20", "Actualmente sí usted tuviera la oportunidad de viajar legalmente a los Estados Unidos, ¿viajaría?"),
          (6, "p21", "Actualmente sí usted tuviera los medios para viajar ilegalmente a los Estados Unidos, ¿viajaría?"),
          (7, "p23", "¿Cuál sería la principal razón para que usted decidiera viajar?"),
          (8, "p24", "¿Algún miembro de este hogar a viajado a Estados Unidos con el propósito de trabajar o quedarse a vivir?"),
          (9, "p26", "¿La persona fue deportada?"),
          (10, "p27", "¿De las personas de este hogar ha fallecido o desaparecido durante su viaje?"),
          (11, "p28", "¿Considera que en el futuro algún miembro de este hogar tendrá intenciones de viajar a Estados Unidos?"),
          (12, "p40", "¿Cuáles son sus planes a futuro?"),
          (13, "p42", "¿Cuál es su condición laboral en este momento?"),
          (14, "p44", "¿Cuál es el rango de ingresos de este hogar? (sin contar las remesas)"),
          (15, "p46", "¿Cuál es el material predominante en el PISO del hogar?"),
          (16, "p47", "¿Cómo obtiene el AGUA que utiliza en la vivienda?"),
          (17, "p48", "¿Qué tipo de ALUMBRADO utiliza en la vivienda?"),
          (18, "p49", "¿Qué tipo de SERVICIO SANITARIO o LETRINA tiene?"),
          (19, "ppi1", "¿Cuántos miembros del hogar tienen 14 años o menos?"),
          (20, "ppi2", "¿Cuál es el nivel educativo más alto que alcanzó la jefa/esposa del hogar?"),
          (21, "ppi3", "¿Cuál es la ocupación principal que desempeña el jefe/esposo del hogar?"),
          (22, "ppi4", "¿En su ocupación principal, ¿cuántos miembros del hogar trabajan como empleado asalariado?"),
          (23, "ppi5", "¿Cuántas piezas utiliza este hogar para dormir?"),
          (24, "ppi6", "¿Cuál es el material predominante en el piso?"),
          (25, "ppi7", "¿Como obtiene el agua que utiliza en la vivienda?"),
          (26, "ppi8", "¿Alguien de los residentes de este hogar tiene una refrigeradora en buenas condiciones?"),
          (27, "ppi9", "¿Alguien de los residentes de este hogar tiene una estufa de cuatro hornillas en buenas condiciones?"),
          (28, "ppi10", "¿Alguien de los residentes de este hogar tiene televisión en buenas condiciones con o sin cable?")
    ''');

    //INSERTS DE PONDERACIONES INICIALES
    await db.execute('''
      INSERT INTO `satm_preguntas_ponderaciones` (`idPonderacion`, `idPregunta`, `codigo_pregunta`, `opcion_nombre`, `opcion_valor`, `ponderacion`) VALUES
        (1, 1, "p09", "Sí", 1, "0.03"),
        (2, 1, "p09", "No", 2, "0"),
        (3, 2, "p11", "Sí", 1, "0.05"),
        (4, 2, "p11", "No", 2, "0"),
        (5, 3, "p16", "Menos de 1 año", 1, "0.05"),
        (6, 3, "p16", "Entre 1 – 3 años", 2, "0.03"),
        (7, 3, "p16", "Entre 3 – 5 años", 3, "0"),
        (8, 3, "p16", "Más de 5 años", 4, "0"),
        (9, 4, "p17", "Sí", 1, "0.05"),
        (10, 4, "p17", "No", 2, "0"),
        (11, 5, "p20", "Sí", 1, "0.08"),
        (12, 5, "p20", "Quizás", 2, "0.05"),
        (13, 5, "p20", "No", 3, "0"),
        (14, 5, "p20", "NS/NR", 4, "0"),
        (15, 6, "p21", "Sí", 1, "0.13"),
        (16, 6, "p21", "Quizás", 2, "0.08"),
        (17, 6, "p21", "No", 3, "0"),
        (18, 6, "p21", "NS/NR", 4, "0"),
        (19, 7, "p23", "No tiene trabajo", 1, "0.01"),
        (20, 7, "p23", "Porque pese a tener trabajo sus ingresos no son suficientes", 2, "0.01"),
        (21, 7, "p23", "Porque ha sido amenazado de muerte, extorsionado, etc.", 3, "0.02"),
        (22, 7, "p23", "Por el barrio/colonia donde vive es inseguro", 4, "0.01"),
        (23, 7, "p23", "Para reunirse con los familiares que viven en Estados Unidos", 5, "0.01"),
        (24, 7, "p23", "Porque las leyes migratorias facilitan el establecerse en ese país", 6, "0.01"),
        (25, 7, "p23", "Porque considera que las condiciones en Honduras no mejoraran", 7, "0.01"),
        (26, 7, "p23", "Por Deudas", 8, "0.01"),
        (27, 7, "p23", "Por violencia en el hogar", 9, "0.02"),
        (28, 7, "p23", "NS/NR", 10, "0"),
        (29, 8, "p24", "Sí", 1, "0.05"),
        (30, 8, "p24", "No", 2, "0"),
        (31, 9, "p26", "Sí", 1, "0.05"),
        (32, 9, "p26", "No", 2, "0"),
        (33, 10, "p27", "Sí", 1, "0"),
        (34, 10, "p27", "No", 2, "0"),
        (35, 11, "p28", "Sí", 1, "0.08"),
        (36, 11, "p28", "No", 2, "0"),
        (37, 12, "p40", "Viajar nuevamente en los proximos seis meses", 1, "0.13"),
        (38, 12, "p40", "Viajar nuevamente en el proximo año", 2, "0.08"),
        (39, 12, "p40", "No viajar y establecerse en Honduras", 3, "0"),
        (40, 12, "p40", "No ha decidido aún", 4, "0"),
        (41, 12, "p40", "NS/NR", 5, "0"),
        (42, 13, "p42", "Está trabajando para alguien", 1, "0"),
        (43, 13, "p42", "Trabaja por cuenta propia (negocio propio o realizando trabajos particulares)", 2, "0"),
        (44, 13, "p42", "Está buscando trabajo", 3, "0.08"),
        (45, 13, "p42", "No trabaja y no está buscando trabajo", 4, "0.08"),
        (46, 13, "p42", "Es estudiante", 5, "0"),
        (47, 13, "p42", "Es ama de casa", 6, "0"),
        (48, 13, "p42", "Es jubilado/pensionado o incapacitado permanente", 7, "0"),
        (49, 13, "p42", "Otro", 8, "0"),
        (50, 14, "p44", "Menos de Mil quinientos Mensuales", 1, "0.05"),
        (51, 14, "p44", "Entre mil 500 a Lps. 7 mil mensuales", 2, "0.05"),
        (52, 14, "p44", "Entre Lps. 7 mil y 14 mil mensuales", 3, "0"),
        (53, 14, "p44", "Más de Lps. 14 mil", 4, "0"),
        (54, 14, "p44", "NS/NR", 5, "0"),
        (55, 15, "p46", "Cerámica / granito", 1, "0"),
        (56, 15, "p46", "Plancha de cemento", 2, "0"),
        (57, 15, "p46", "Madera", 3, "0"),
        (58, 15, "p46", "Tierra", 4, "0.02"),
        (59, 15, "p46", "Otro", 5, "0"),
        (60, 16, "p47", "Servicio público por tubería", 1, "0"),
        (61, 16, "p47", "Servicio privado por tubería", 2, "0"),
        (62, 16, "p47", "Pozo malacate", 3, "0"),
        (63, 16, "p47", "Pozo con bomba", 4, "0"),
        (64, 16, "p47", "Río, riachuelo, ojo de agua, etc.", 5, "0.02"),
        (65, 16, "p47", "Carro cisterna", 6, "0.02"),
        (66, 16, "p47", "Pick-up con drones o barriles", 7, "0.02"),
        (67, 16, "p47", "Llave pública o comunitaria", 8, "0.02"),
        (68, 16, "p47", "Del vecino / otra vivienda", 9, "0.02"),
        (69, 16, "p47", "Otro", 10, "0.02"),
        (70, 17, "p48", "Servicio público", 1, "0"),
        (71, 17, "p48", "Servicio privado colectivo", 2, "0"),
        (72, 17, "p48", "Planta propia", 3, "0"),
        (73, 17, "p48", "Energía solar", 4, "0"),
        (74, 17, "p48", "Vela", 5, "0.02"),
        (75, 17, "p48", "Candil o lámpara de gas", 6, "0.02"),
        (76, 17, "p48", "Ocote", 7, "0.02"),
        (77, 17, "p48", "Otro", 8, "0.02"),
        (78, 18, "p49", "Inodoro conectado a alcantarilla", 1, "0"),
        (79, 18, "p49", "Inodoro conectado a pozo séptico", 2, "0"),
        (80, 18, "p49", "Inodoro con descarga a río, laguna o mar", 3, "0"),
        (81, 18, "p49", "Letrina con descarga a río, laguna o mar", 4, "0"),
        (82, 18, "p49", "Letrina con cierre hidráulico", 5, "0"),
        (83, 18, "p49", "Letrina con pozo séptico", 6, "0.02"),
        (84, 18, "p49", "Letrina con pozo negro", 7, "0.02"),
        (85, 18, "p49", "Otro", 8, "0"),
        (86, 18, "p49", "No tiene", 9, "0.02"),
        (87, 18, "p49", "NS/NR", 10, "0"),
        (88, 19, "ppi1", "Cinco o más", 1, "0"),
        (89, 19, "ppi1", "Cuatro", 2, "11"),
        (90, 19, "ppi1", "Tres", 3, "14"),
        (91, 19, "ppi1", "Dos", 4, "16"),
        (92, 19, "ppi1", "Uno", 5, "23"),
        (93, 19, "ppi1", "Ninguno", 6, "32"),
        (94, 20, "ppi2", "Ninguno, pre-escolar, programa de alfabetización", 1, "0"),
        (95, 20, "ppi2", "Básica/primaria", 2, "6"),
        (96, 20, "ppi2", "Ciclo común, no hay jefa/esposa, o sin datos", 3, "10"),
        (97, 20, "ppi2", "Diversificado o mayor", 4, "14"),
        (98, 21, "ppi3", "Sin datos", 1, "0"),
        (99, 21, "ppi3", "Agricultor, ganadero, trabajador agropecuario o no hay jefe/esposo", 2, "9"),
        (100, 21, "ppi3", "Comerciante, vendedor, ocupación de los servicios, operador de carga y almacenaje, trabajador en la industria textil albañilería, mecánica, gráfica, química, alimentos, etc.", 3, "11"),
        (101, 21, "ppi3", "Empleado de oficina, conductor transporte, profesional, técnico, director, gerente, administrador o ocupación afín", 4, "16"),
        (102, 22, "ppi4", "Ninguno", 1, "0"),
        (103, 22, "ppi4", "Uno", 2, "3"),
        (104, 22, "ppi4", "Dos o más", 3, "10"),
        (105, 23, "ppi5", "Uno", 1, "0"),
        (106, 23, "ppi5", "Dos", 2, "1"),
        (107, 23, "ppi5", "Tres", 3, "4"),
        (108, 23, "ppi5", "Cuatro o más", 4, "5"),
        (109, 24, "ppi6", "Tierra, otro o sin datos", 1, "0"),
        (110, 24, "ppi6", "Ladrillo de barro, plancha de cemento o madera", 2, "3"),
        (111, 24, "ppi6", "Ladrillo de cemento", 3, "4"),
        (112, 24, "ppi6", "Cerámica o ladrillo de granito", 4, "7"),
        (113, 25, "ppi7", "No servicio público por tubería", 1, "0"),
        (114, 25, "ppi7", "Servicio público por tubería", 2, "3"),
        (115, 26, "ppi8", "No", 1, "0"),
        (116, 26, "ppi8", "Sí", 2, "4"),
        (117, 27, "ppi9", "No", 1, "0"),
        (118, 27, "ppi9", "Sí", 2, "4"),
        (119, 28, "ppi10", "No", 1, "0"),
        (120, 28, "ppi10", "Sí, sin cable", 2, "2"),
        (121, 28, "ppi10", "Sí, con cable", 3, "4")
    ''');

    //INSERTS DE LAS PROPENSIONES
    await db.execute('''
      INSERT INTO `satm_propensiones` (`idPropension`, `propension`, `valor_minimo`, `valor_maximo`) VALUES
        (1, "Propensión Baja", "0", "0.39"),
        (2, "Propensión Media", "0.4", "0.59"),
        (3, "Propensión Alta", "0.6", "1")
    ''');

    //INSERTS DE LOS ROLES
    await db.execute('''
      INSERT INTO `wvi_roles` (`idRol`, `rol`) VALUES
        (1, "Administrador General"),
        (2, "Administrador País"),
        (3, "Recolector"),
        (4, "Veedor")
    ''');

    //INSERTS DE DEPARTAMENTOS
    await db.execute('''
      INSERT INTO `wvi_departamentos` (`idDepartamento`, `idPais`, `departamento`) VALUES
        (1, 1, "Atlántida"),
        (2, 1, "Colón"),
        (3, 1, "Comayagua"),
        (4, 1, "Copán"),
        (5, 1, "Cortés"),
        (6, 1, "Choluteca"),
        (7, 1, "El Paraíso"),
        (8, 1, "Francisco Morazán"),
        (9, 1, "Gracias a Dios"),
        (10, 1, "Intibucá"),
        (11, 1, "Islas de la Bahía"),
        (12, 1, "La Paz"),
        (13, 1, "Lempira"),
        (14, 1, "Ocotepeque"),
        (15, 1, "Olancho"),
        (16, 1, "Santa Bárbara"),
        (17, 1, "Valle"),
        (18, 1, "Yoro"),
        (19, 2, "Alta Verapaz"),
        (20, 2, "Baja Verapaz"),
        (21, 2, "Chimaltenango"),
        (22, 2, "Chiquimula"),
        (23, 2, "El Progreso"),
        (24, 2, "Escuintla"),
        (25, 2, "Guatemala"),
        (26, 2, "Huehuetenango"),
        (27, 2, "Izabal"),
        (28, 2, "Jalapa"),
        (29, 2, "Jutiapa"),
        (30, 2, "Petén"),
        (31, 2, "Quetzaltenango"),
        (32, 2, "Quiché"),
        (33, 2, "Retalhuleu"),
        (34, 2, "Sacatepéquez"),
        (35, 2, "San Marcos"),
        (36, 2, "Santa Rosa"),
        (37, 2, "Solola"),
        (38, 2, "Suchitepéquez"),
        (39, 2, "Totonicapán"),
        (40, 2, "Zacapa"),
        (41, 3, "Ahuachapán"),
        (42, 3, "Santa Ana"),
        (43, 3, "Sonsonate"),
        (44, 3, "Chalatenango"),
        (45, 3, "La Libertad"),
        (46, 3, "San Salvador"),
        (47, 3, "Cuscatlán"),
        (48, 3, "La Paz"),
        (49, 3, "Cabañas"),
        (50, 3, "San Vicente"),
        (51, 3, "Usulután"),
        (52, 3, "San Miguel"),
        (53, 3, "Morazán"),
        (54, 3, "La Unión")
    ''');

    //INSERTS DE MUNICIPIOS
    await db.execute('''
      INSERT INTO `wvi_municipios` (`idMunicipio`, `idPais`, `idDepartamento`, `municipio`) VALUES
        (1, 1, 1, "La Ceiba"),
        (2, 1, 1, "El Porvenir"),
        (3, 1, 1, "Esparta"),
        (4, 1, 1, "Jutiapa"),
        (5, 1, 1, "La Masica"),
        (6, 1, 1, "San Francisco"),
        (7, 1, 1, "Tela"),
        (8, 1, 1, "Arizona"),
        (9, 1, 2, "Trujillo"),
        (10, 1, 2, "Balfate"),
        (11, 1, 2, "Iriona"),
        (12, 1, 2, "Limón"),
        (13, 1, 2, "Sabá"),
        (14, 1, 2, "Santa Fé"),
        (15, 1, 2, "Santa Rosa de Aquán"),
        (16, 1, 2, "Sonaguera"),
        (17, 1, 2, "Tocoa"),
        (18, 1, 2, "Bonito Oriental"),
        (19, 1, 3, "Comayagua"),
        (20, 1, 3, "Ajuterique"),
        (21, 1, 3, "El Rosario"),
        (22, 1, 3, "Esquías"),
        (23, 1, 3, "Humuya"),
        (24, 1, 3, "La Libertad"),
        (25, 1, 3, "Lamaní"),
        (26, 1, 3, "La Trinidad"),
        (27, 1, 3, "Lejamaní"),
        (28, 1, 3, "Meámbar"),
        (29, 1, 3, "Minas de Oro"),
        (30, 1, 3, "Ojo de Agua"),
        (31, 1, 3, "San Jerónimo"),
        (32, 1, 3, "San José de Comayagua"),
        (33, 1, 3, "San José del Potrero"),
        (34, 1, 3, "San Luis"),
        (35, 1, 3, "San Sebastián"),
        (36, 1, 3, "Siguatepeque"),
        (37, 1, 3, "Villa de San Antonio"),
        (38, 1, 3, "Las Lajas"),
        (39, 1, 3, "Taulabe"),
        (40, 1, 4, "Santa Rosa de Copán"),
        (41, 1, 4, "Cabañas"),
        (42, 1, 4, "Concepción"),
        (43, 1, 4, "Copán Ruinas"),
        (44, 1, 4, "Corquín"),
        (45, 1, 4, "Cucuyagua"),
        (46, 1, 4, "Dolores"),
        (47, 1, 4, "Dulce Nombre"),
        (48, 1, 4, "El Paraíso"),
        (49, 1, 4, "Florida"),
        (50, 1, 4, "La Jigua"),
        (51, 1, 4, "La Unión"),
        (52, 1, 4, "Nueva Arcadia"),
        (53, 1, 4, "San Agustín"),
        (54, 1, 4, "San Antonio"),
        (55, 1, 4, "San Jerónimo"),
        (56, 1, 4, "San José"),
        (57, 1, 4, "San Juan de Opoa"),
        (58, 1, 4, "San Nicolás"),
        (59, 1, 4, "San Pedro"),
        (60, 1, 4, "Santa Rita"),
        (61, 1, 4, "Trinidad de Copán"),
        (62, 1, 4, "Veracruz"),
        (63, 1, 5, "San Pedro Sula"),
        (64, 1, 5, "Choloma"),
        (65, 1, 5, "Omoa"),
        (66, 1, 5, "Pimienta"),
        (67, 1, 5, "Potrerillos"),
        (68, 1, 5, "Puerto Cortés"),
        (69, 1, 5, "San Antonio de Cortés"),
        (70, 1, 5, "San Francisco de Yojoa"),
        (71, 1, 5, "San Manuel"),
        (72, 1, 5, "Santa Cruz de Yojoa"),
        (73, 1, 5, "Villanueva"),
        (74, 1, 5, "La Lima"),
        (75, 1, 6, "Choluteca"),
        (76, 1, 6, "Apacilagua"),
        (77, 1, 6, "Concepción de Marí"),
        (78, 1, 6, "Duyure"),
        (79, 1, 6, "El Corpus"),
        (80, 1, 6, "El Triunfo"),
        (81, 1, 6, "Marcovia"),
        (82, 1, 6, "Morolica"),
        (83, 1, 6, "Namasigue"),
        (84, 1, 6, "Orocuina"),
        (85, 1, 6, "Pespire"),
        (86, 1, 6, "San Antonio de Flores"),
        (87, 1, 6, "San Isidro"),
        (88, 1, 6, "San José"),
        (89, 1, 6, "San Marcos de Colón"),
        (90, 1, 6, "Santa Ana de Yusguare"),
        (91, 1, 7, "Yuscarán"),
        (92, 1, 7, "Alauca"),
        (93, 1, 7, "Danlí"),
        (94, 1, 7, "El Paraíso"),
        (95, 1, 7, "Guinope"),
        (96, 1, 7, "Jacaleapa"),
        (97, 1, 7, "Liure"),
        (98, 1, 7, "Morocelí"),
        (99, 1, 7, "Oropolí"),
        (100, 1, 7, "Potrerillos"),
        (101, 1, 7, "San Antonio de Flores"),
        (102, 1, 7, "San Lucas"),
        (103, 1, 7, "San Matías"),
        (104, 1, 7, "Soledad"),
        (105, 1, 7, "Teupasenti"),
        (106, 1, 7, "Texiguat"),
        (107, 1, 7, "Vado Ancho"),
        (108, 1, 7, "Yauyupe"),
        (109, 1, 7, "Trojes"),
        (110, 1, 8, "Distrito Central"),
        (111, 1, 8, "Alubarén"),
        (112, 1, 8, "Cedros"),
        (113, 1, 8, "Curarén"),
        (114, 1, 8, "El Porvenir"),
        (115, 1, 8, "Guaimaca"),
        (116, 1, 8, "La Libertad"),
        (117, 1, 8, "La Venta"),
        (118, 1, 8, "Lepaterique"),
        (119, 1, 8, "Maraita"),
        (120, 1, 8, "Marale"),
        (121, 1, 8, "Nueva Armenia"),
        (122, 1, 8, "Ojojona"),
        (123, 1, 8, "Orica"),
        (124, 1, 8, "Reitoca"),
        (125, 1, 8, "Sabanagrande"),
        (126, 1, 8, "San Antonio de Oriente"),
        (127, 1, 8, "San Buenaventura"),
        (128, 1, 8, "San Ignacio"),
        (129, 1, 8, "San Juan de Flores"),
        (130, 1, 8, "San Miguelito"),
        (131, 1, 8, "Santa Ana "),
        (132, 1, 8, "Santa Lucía"),
        (133, 1, 8, "Talanga"),
        (134, 1, 8, "Tatumba"),
        (135, 1, 8, "Valle de Angeles"),
        (136, 1, 8, "Villa de San Francisco"),
        (137, 1, 8, "Vallecillos"),
        (138, 1, 9, "Puerto Lempira"),
        (139, 1, 9, "Brus Laguna"),
        (140, 1, 9, "Ahuás"),
        (141, 1, 9, "Juan Francisco Bulnes"),
        (142, 1, 9, "Ramón V. Morales"),
        (143, 1, 9, "Wampusirpi"),
        (144, 1, 10, "La Esperanza"),
        (145, 1, 10, "Camasca"),
        (146, 1, 10, "Colomoncagua"),
        (147, 1, 10, "Concepción"),
        (148, 1, 10, "Dolores"),
        (149, 1, 10, "Intibucá"),
        (150, 1, 10, "Jesús de Otoro"),
        (151, 1, 10, "Magdalena"),
        (152, 1, 10, "Masaguara"),
        (153, 1, 10, "San Antonio"),
        (154, 1, 10, "San Isidro"),
        (155, 1, 10, "San Juan"),
        (156, 1, 10, "San Marco de Sierra"),
        (157, 1, 10, "San Miguelito"),
        (158, 1, 10, "Santa Lucía"),
        (159, 1, 10, "Yamaraguila"),
        (160, 1, 10, "San Francisco de Opalaca"),
        (161, 1, 11, "Roatán"),
        (162, 1, 11, "Guanaja"),
        (163, 1, 11, "José Santos Guardiola"),
        (164, 1, 11, "Utila"),
        (165, 1, 12, "La Paz"),
        (166, 1, 12, "Aguaqueterique"),
        (167, 1, 12, "Cabañas"),
        (168, 1, 12, "Cane"),
        (169, 1, 12, "Chinacla"),
        (170, 1, 12, "Guajiquiro"),
        (171, 1, 12, "Lauterique"),
        (172, 1, 12, "Marcala"),
        (173, 1, 12, "Mercedes de Oriente"),
        (174, 1, 12, "Opatoro"),
        (175, 1, 12, "San Antonio del Norte"),
        (176, 1, 12, "San José"),
        (177, 1, 12, "San Juan"),
        (178, 1, 12, "San Pedro de Tutule"),
        (179, 1, 12, "Santa Ana "),
        (180, 1, 12, "Santa Elena"),
        (181, 1, 12, "Santa María"),
        (182, 1, 12, "Santiago de Puringla"),
        (183, 1, 12, "Yarula"),
        (184, 1, 13, "Gracias"),
        (185, 1, 13, "Belén"),
        (186, 1, 13, "Candelaria"),
        (187, 1, 13, "Cololaca"),
        (188, 1, 13, "Erandique"),
        (189, 1, 13, "Gualcince"),
        (190, 1, 13, "Guarita"),
        (191, 1, 13, "La Campa"),
        (192, 1, 13, "La Iguala"),
        (193, 1, 13, "Las Flores"),
        (194, 1, 13, "La Unión"),
        (195, 1, 13, "La Virtud"),
        (196, 1, 13, "Lepaera"),
        (197, 1, 13, "Mapulaca"),
        (198, 1, 13, "Pinaera"),
        (199, 1, 13, "San Andrés"),
        (200, 1, 13, "San Francisco"),
        (201, 1, 13, "San Juan Guarita"),
        (202, 1, 13, "San Manuel Colohete"),
        (203, 1, 13, "San Rafael"),
        (204, 1, 13, "San Sebastián"),
        (205, 1, 13, "Santa Cruz"),
        (206, 1, 13, "Talgua"),
        (207, 1, 13, "Tambla"),
        (208, 1, 13, "Tomalá"),
        (209, 1, 13, "Valladolid"),
        (210, 1, 13, "Virginia"),
        (211, 1, 13, "San Marcos de Caiquín"),
        (212, 1, 14, "Ocotepeque"),
        (213, 1, 14, "Belén Gualcho"),
        (214, 1, 14, "Concepción"),
        (215, 1, 14, "Dolores Merendón"),
        (216, 1, 14, "Fraternidad"),
        (217, 1, 14, "La Encarnación"),
        (218, 1, 14, "la Labor"),
        (219, 1, 14, "Lucerna"),
        (220, 1, 14, "Mercedes"),
        (221, 1, 14, "San Fernando"),
        (222, 1, 14, "San Francisco del Valle"),
        (223, 1, 14, "San Jorge"),
        (224, 1, 14, "San Marcos"),
        (225, 1, 14, "Santa Fé"),
        (226, 1, 14, "Sensenti"),
        (227, 1, 14, "Sinuapa"),
        (228, 1, 15, "Juticalpa"),
        (229, 1, 15, "Campamento"),
        (230, 1, 15, "Catacamas"),
        (231, 1, 15, "Concordia"),
        (232, 1, 15, "Dulce nombre de Culmí"),
        (233, 1, 15, "El Rosario"),
        (234, 1, 15, "Esquipulas del Norte"),
        (235, 1, 15, "Gualaco"),
        (236, 1, 15, "Guarizama"),
        (237, 1, 15, "Guata"),
        (238, 1, 15, "Guayape"),
        (239, 1, 15, "Jano"),
        (240, 1, 15, "La Unión"),
        (241, 1, 15, "Manguile"),
        (242, 1, 15, "Manto"),
        (243, 1, 15, "Salamá"),
        (244, 1, 15, "San Esteban"),
        (245, 1, 15, "San Francisco de Becerra"),
        (246, 1, 15, "San Francisco de la Paz"),
        (247, 1, 15, "Santa Maria del Real"),
        (248, 1, 15, "Silca"),
        (249, 1, 15, "Yocón"),
        (250, 1, 15, "Patuca"),
        (251, 1, 16, "Santa Bárbara"),
        (252, 1, 16, "Arada"),
        (253, 1, 16, "Atima"),
        (254, 1, 16, "Azacualpa"),
        (255, 1, 16, "Ceguaca"),
        (256, 1, 16, "Concepción del Norte"),
        (257, 1, 16, "Concepción del Sur"),
        (258, 1, 16, "Chinda"),
        (259, 1, 16, "El Nispero"),
        (260, 1, 16, "Gualala"),
        (261, 1, 16, "Ilama"),
        (262, 1, 16, "Macuelizo"),
        (263, 1, 16, "Naranjito"),
        (264, 1, 16, "Nuevo Celilac"),
        (265, 1, 16, "Petoa"),
        (266, 1, 16, "Protección"),
        (267, 1, 16, "Quimistán"),
        (268, 1, 16, "San Francisco de Ojuera"),
        (269, 1, 16, "San José de Colinas"),
        (270, 1, 16, "San Luis"),
        (271, 1, 16, "San Marcos"),
        (272, 1, 16, "San Nicolás"),
        (273, 1, 16, "San Pedro Zacapa"),
        (274, 1, 16, "Santa Rita"),
        (275, 1, 16, "San vicente Centenario"),
        (276, 1, 16, "Trinidad"),
        (277, 1, 16, "Las Vegas"),
        (278, 1, 16, "Nueva Frontera"),
        (279, 1, 17, "Nacaome"),
        (280, 1, 17, "Alianza"),
        (281, 1, 17, "Amapala"),
        (282, 1, 17, "Aramecina"),
        (283, 1, 17, "Caridad"),
        (284, 1, 17, "Goascorán"),
        (285, 1, 17, "Langue"),
        (286, 1, 17, "San Francisco de Coray"),
        (287, 1, 17, "San Lorenzo"),
        (288, 1, 18, "Yoro"),
        (289, 1, 18, "Arenal"),
        (290, 1, 18, "El Negrito"),
        (291, 1, 18, "El Progreso"),
        (292, 1, 18, "Jocón"),
        (293, 1, 18, "Morazán"),
        (294, 1, 18, "Olanchito"),
        (295, 1, 18, "Santa Rita"),
        (296, 1, 18, "Sulaco"),
        (297, 1, 18, "Victoría"),
        (298, 1, 18, "Yorito"),
        (299, 2, 19, "Chahal"),
        (300, 2, 19, "Chisec"),
        (301, 2, 19, "Cobán"),
        (302, 2, 19, "Fray Bartolomé de las Casas"),
        (303, 2, 19, "La Tinta"),
        (304, 2, 19, "Lanquín"),
        (305, 2, 19, "Panzós"),
        (306, 2, 19, "Raxruhá"),
        (307, 2, 19, "San Cristóbal Verapaz"),
        (308, 2, 19, "San Juan Chamelco"),
        (309, 2, 19, "San Pedro Carchá"),
        (310, 2, 19, "Santa Cruz Verapaz"),
        (311, 2, 19, "Santa María Cahabón"),
        (312, 2, 19, "Senahú"),
        (313, 2, 19, "Tamahú"),
        (314, 2, 19, "Tactic"),
        (315, 2, 19, "Tucurú"),
        (316, 2, 20, "Cubulco"),
        (317, 2, 20, "Granados"),
        (318, 2, 20, "Purulhá"),
        (319, 2, 20, "Rabinal"),
        (320, 2, 20, "Salamá"),
        (321, 2, 20, "San Jerónimo"),
        (322, 2, 20, "San Miguel Chicaj"),
        (323, 2, 20, "Santa Cruz el Chol"),
        (324, 2, 21, "Acatenango"),
        (325, 2, 21, "Chimaltenango"),
        (326, 2, 21, "El Tejar"),
        (327, 2, 21, "Parramos"),
        (328, 2, 21, "Patzicía"),
        (329, 2, 21, "Patzún"),
        (330, 2, 21, "Pochuta"),
        (331, 2, 21, "San Andrés Itzapa"),
        (332, 2, 21, "San José Poaquíl"),
        (333, 2, 21, "San Juan Comalapa"),
        (334, 2, 21, "San Martín Jilotepeque"),
        (335, 2, 21, "Santa Apolonia"),
        (336, 2, 21, "Santa Cruz Balanyá"),
        (337, 2, 21, "Tecpán"),
        (338, 2, 21, "Yepocapa"),
        (339, 2, 21, "Zaragoza"),
        (340, 2, 22, "Camotán"),
        (341, 2, 22, "Chiquimula"),
        (342, 2, 22, "Concepción Las Minas"),
        (343, 2, 22, "Esquipulas"),
        (344, 2, 22, "Ipala"),
        (345, 2, 22, "Jocotán"),
        (346, 2, 22, "Olopa"),
        (347, 2, 22, "Quezaltepeque"),
        (348, 2, 22, "San Jacinto"),
        (349, 2, 22, "San José la Arada"),
        (350, 2, 22, "San Juan Ermita"),
        (351, 2, 23, "El Jícaro"),
        (352, 2, 23, "Guastatoya"),
        (353, 2, 23, "Morazán"),
        (354, 2, 23, "San Agustín Acasaguastlán"),
        (355, 2, 23, "San Antonio La Paz"),
        (356, 2, 23, "San Cristóbal Acasaguastlán"),
        (357, 2, 23, "Sanarate"),
        (358, 2, 23, "Sansare"),
        (359, 2, 24, "Escuintla"),
        (360, 2, 24, "Guanagazapa"),
        (361, 2, 24, "Iztapa"),
        (362, 2, 24, "La Democracia"),
        (363, 2, 24, "La Gomera"),
        (364, 2, 24, "Masagua"),
        (365, 2, 24, "Nueva Concepción"),
        (366, 2, 24, "Palín"),
        (367, 2, 24, "San José"),
        (368, 2, 24, "San Vicente Pacaya"),
        (369, 2, 24, "Santa Lucía Cotzumalguapa"),
        (370, 2, 24, "Siquinalá"),
        (371, 2, 24, "Tiquisate"),
        (372, 2, 25, "Amatitlán"),
        (373, 2, 25, "Chinautla"),
        (374, 2, 25, "Chuarrancho"),
        (375, 2, 25, "Guatemala"),
        (376, 2, 25, "Fraijanes"),
        (377, 2, 25, "Mixco"),
        (378, 2, 25, "Palencia"),
        (379, 2, 25, "San José del Golfo"),
        (380, 2, 25, "San José Pinula"),
        (381, 2, 25, "San Juan Sacatepéquez"),
        (382, 2, 25, "San Miguel Petapa"),
        (383, 2, 25, "San Pedro Ayampuc"),
        (384, 2, 25, "San Pedro Sacatepéquez"),
        (385, 2, 25, "San Raymundo"),
        (386, 2, 25, "Santa Catarina Pinula"),
        (387, 2, 25, "Villa Canales"),
        (388, 2, 25, "Villa Nueva"),
        (389, 2, 26, "Aguacatán"),
        (390, 2, 26, "Chiantla"),
        (391, 2, 26, "Colotenango"),
        (392, 2, 26, "Concepción Huista"),
        (393, 2, 26, "Cuilco"),
        (394, 2, 26, "Huehuetenango"),
        (395, 2, 26, "Jacaltenango"),
        (396, 2, 26, "La Democracia"),
        (397, 2, 26, "La Libertad"),
        (398, 2, 26, "Malacatancito"),
        (399, 2, 26, "Nentón"),
        (400, 2, 26, "San Antonio Huista"),
        (401, 2, 26, "San Gaspar Ixchil"),
        (402, 2, 26, "San Ildefonso Ixtahuacán"),
        (403, 2, 26, "San Juan Atitán"),
        (404, 2, 26, "San Juan Ixcoy"),
        (405, 2, 26, "San Mateo Ixtatán"),
        (406, 2, 26, "San Miguel Acatán"),
        (407, 2, 26, "San Pedro Nécta"),
        (408, 2, 26, "San Pedro Soloma"),
        (409, 2, 26, "San Rafael La Independencia"),
        (410, 2, 26, "San Rafael Pétzal"),
        (411, 2, 26, "San Sebastián Coatán"),
        (412, 2, 26, "San Sebastián Huehuetenango"),
        (413, 2, 26, "Santa Ana Huista"),
        (414, 2, 26, "Santa Bárbara"),
        (415, 2, 26, "Santa Cruz Barillas"),
        (416, 2, 26, "Santa Eulalia"),
        (417, 2, 26, "Santiago Chimaltenango"),
        (418, 2, 26, "Tectitán"),
        (419, 2, 26, "Todos Santos Cuchumatán"),
        (420, 2, 26, "Unión Cantinil"),
        (421, 2, 27, "El Estor"),
        (422, 2, 27, "Livingston"),
        (423, 2, 27, "Los Amates"),
        (424, 2, 27, "Morales"),
        (425, 2, 27, "Puerto Barrios"),
        (426, 2, 28, "Jalapa"),
        (427, 2, 28, "Mataquescuintla"),
        (428, 2, 28, "Monjas"),
        (429, 2, 28, "San Carlos Alzatate"),
        (430, 2, 28, "San Luis Jilotepeque"),
        (431, 2, 28, "San Manuel Chaparrón"),
        (432, 2, 28, "San Pedro Pinula"),
        (433, 2, 29, "Agua Blanca"),
        (434, 2, 29, "Asunción Mita"),
        (435, 2, 29, "Atescatempa"),
        (436, 2, 29, "Comapa"),
        (437, 2, 29, "Conguaco"),
        (438, 2, 29, "El Adelanto"),
        (439, 2, 29, "El Progreso"),
        (440, 2, 29, "Jalpatagua"),
        (441, 2, 29, "Jerez"),
        (442, 2, 29, "Jutiapa"),
        (443, 2, 29, "Moyuta"),
        (444, 2, 29, "Pasaco"),
        (445, 2, 29, "Quesada"),
        (446, 2, 29, "San José Acatempa"),
        (447, 2, 29, "Santa Catarina Mita"),
        (448, 2, 29, "Yupiltepeque"),
        (449, 2, 29, "Zapotitlán"),
        (450, 2, 30, "Dolores"),
        (451, 2, 30, "El Chal"),
        (452, 2, 30, "Ciudad Flores"),
        (453, 2, 30, "La Libertad"),
        (454, 2, 30, "Las Cruces"),
        (455, 2, 30, "Melchor de Mencos"),
        (456, 2, 30, "Poptún"),
        (457, 2, 30, "San Andrés"),
        (458, 2, 30, "San Benito"),
        (459, 2, 30, "San Francisco"),
        (460, 2, 30, "San José"),
        (461, 2, 30, "San Luis"),
        (462, 2, 30, "Santa Ana"),
        (463, 2, 30, "Sayaxché"),
        (464, 2, 31, "Almolonga"),
        (465, 2, 31, "Cabricán"),
        (466, 2, 31, "Cajolá"),
        (467, 2, 31, "Cantel"),
        (468, 2, 31, "Coatepeque"),
        (469, 2, 31, "Colomba Costa Cuca"),
        (470, 2, 31, "Concepción Chiquirichapa"),
        (471, 2, 31, "El Palmar"),
        (472, 2, 31, "Flores Costa Cuca"),
        (473, 2, 31, "Génova"),
        (474, 2, 31, "Huitán"),
        (475, 2, 31, "La Esperanza"),
        (476, 2, 31, "Olintepeque"),
        (477, 2, 31, "Palestina de Los Altos"),
        (478, 2, 31, "Quetzaltenango"),
        (479, 2, 31, "Salcajá"),
        (480, 2, 31, "San Carlos Sija"),
        (481, 2, 31, "San Francisco La Unión"),
        (482, 2, 31, "San Juan Ostuncalco"),
        (483, 2, 31, "San Martín Sacatepéquez"),
        (484, 2, 31, "San Mateo"),
        (485, 2, 31, "San Miguel Sigüilá"),
        (486, 2, 31, "Sibilia"),
        (487, 2, 31, "Zunil"),
        (488, 2, 32, "Canillá"),
        (489, 2, 32, "Chajul"),
        (490, 2, 32, "Chicamán"),
        (491, 2, 32, "Chiché"),
        (492, 2, 32, "Chichicastenango"),
        (493, 2, 32, "Chinique"),
        (494, 2, 32, "Cunén"),
        (495, 2, 32, "Ixcán Playa Grande"),
        (496, 2, 32, "Joyabaj"),
        (497, 2, 32, "Nebaj"),
        (498, 2, 32, "Pachalum"),
        (499, 2, 32, "Patzité"),
        (500, 2, 32, "Sacapulas"),
        (501, 2, 32, "San Andrés Sajcabajá"),
        (502, 2, 32, "San Antonio Ilotenango"),
        (503, 2, 32, "San Bartolomé Jocotenango"),
        (504, 2, 32, "San Juan Cotzal"),
        (505, 2, 32, "San Pedro Jocopilas"),
        (506, 2, 32, "Santa Cruz del Quiché"),
        (507, 2, 32, "Uspantán"),
        (508, 2, 32, "Zacualpa"),
        (509, 2, 33, "Champerico"),
        (510, 2, 33, "El Asintal"),
        (511, 2, 33, "Nuevo San Carlos"),
        (512, 2, 33, "Retalhuleu"),
        (513, 2, 33, "San Andrés Villa Seca"),
        (514, 2, 33, "San Felipe Reu"),
        (515, 2, 33, "San Martín Zapotitlán"),
        (516, 2, 33, "San Sebastián"),
        (517, 2, 33, "Santa Cruz Muluá"),
        (518, 2, 34, "Alotenango"),
        (519, 2, 34, "Ciudad Vieja"),
        (520, 2, 34, "Jocotenango"),
        (521, 2, 34, "Antigua Guatemala"),
        (522, 2, 34, "Magdalena Milpas Altas"),
        (523, 2, 34, "Pastores"),
        (524, 2, 34, "San Antonio Aguas Calientes"),
        (525, 2, 34, "San Bartolomé Milpas Altas"),
        (526, 2, 34, "San Lucas Sacatepéquez"),
        (527, 2, 34, "San Miguel Dueñas"),
        (528, 2, 34, "Santa Catarina Barahona"),
        (529, 2, 34, "Santa Lucía Milpas Altas"),
        (530, 2, 34, "Santa María de Jesús"),
        (531, 2, 34, "Santiago Sacatepéquez"),
        (532, 2, 34, "Santo Domingo Xenacoj"),
        (533, 2, 34, "Sumpango"),
        (534, 2, 35, "Ayutla"),
        (535, 2, 35, "Catarina"),
        (536, 2, 35, "Comitancillo"),
        (537, 2, 35, "Concepción Tutuapa"),
        (538, 2, 35, "El Quetzal"),
        (539, 2, 35, "El Tumbador"),
        (540, 2, 35, "Esquipulas Palo Gordo"),
        (541, 2, 35, "Ixchiguán"),
        (542, 2, 35, "La Blanca"),
        (543, 2, 35, "La Reforma"),
        (544, 2, 35, "Malacatán"),
        (545, 2, 35, "Nuevo Progreso"),
        (546, 2, 35, "Ocós"),
        (547, 2, 35, "Pajapita"),
        (548, 2, 35, "Río Blanco"),
        (549, 2, 35, "San Antonio Sacatepéquez"),
        (550, 2, 35, "San Cristóbal Cucho"),
        (551, 2, 35, "San José El Rodeo"),
        (552, 2, 35, "San José Ojetenam"),
        (553, 2, 35, "San Lorenzo"),
        (554, 2, 35, "San Marcos"),
        (555, 2, 35, "San Miguel Ixtahuacán"),
        (556, 2, 35, "San Pablo"),
        (557, 2, 35, "San Pedro Sacatepéquez"),
        (558, 2, 35, "San Rafael Pie de la Cuesta"),
        (559, 2, 35, "Sibinal"),
        (560, 2, 35, "Sipacapa"),
        (561, 2, 35, "Tacaná"),
        (562, 2, 35, "Tajumulco"),
        (563, 2, 35, "Tejutla"),
        (564, 2, 36, "Barberena"),
        (565, 2, 36, "Casillas"),
        (566, 2, 36, "Chiquimulilla"),
        (567, 2, 36, "Cuilapa"),
        (568, 2, 36, "Guazacapán"),
        (569, 2, 36, "Nueva Santa Rosa"),
        (570, 2, 36, "Oratorio"),
        (571, 2, 36, "Pueblo Nuevo Viñas"),
        (572, 2, 36, "San Juan Tecuaco"),
        (573, 2, 36, "San Rafael las Flores"),
        (574, 2, 36, "Santa Cruz Naranjo"),
        (575, 2, 36, "Santa María Ixhuatán"),
        (576, 2, 36, "Santa Rosa de Lima"),
        (577, 2, 36, "Taxisco"),
        (578, 2, 37, "Concepción"),
        (579, 2, 37, "Nahualá"),
        (580, 2, 37, "Panajachel"),
        (581, 2, 37, "San Andrés Semetabaj"),
        (582, 2, 37, "San Antonio Palopó"),
        (583, 2, 37, "San José Chacayá"),
        (584, 2, 37, "San Juan La Laguna"),
        (585, 2, 37, "San Lucas Tolimán"),
        (586, 2, 37, "San Marcos La Laguna"),
        (587, 2, 37, "San Pablo La Laguna"),
        (588, 2, 37, "San Pedro La Laguna"),
        (589, 2, 37, "Santa Catarina Ixtahuacán"),
        (590, 2, 37, "Santa Catarina Palopó"),
        (591, 2, 37, "Santa Clara La Laguna"),
        (592, 2, 37, "Santa Cruz La Laguna"),
        (593, 2, 37, "Santa Lucía Utatlán"),
        (594, 2, 37, "Santa María Visitación"),
        (595, 2, 37, "Santiago Atitlán"),
        (596, 2, 37, "Sololá"),
        (597, 2, 38, "Chicacao"),
        (598, 2, 38, "Cuyotenango"),
        (599, 2, 38, "Mazatenango"),
        (600, 2, 38, "Patulul"),
        (601, 2, 38, "Pueblo Nuevo"),
        (602, 2, 38, "Río Bravo"),
        (603, 2, 38, "Samayac"),
        (604, 2, 38, "San Antonio Suchitepéquez"),
        (605, 2, 38, "San Bernardino"),
        (606, 2, 38, "San Francisco Zapotitlán"),
        (607, 2, 38, "San Gabriel"),
        (608, 2, 38, "San José El Idolo"),
        (609, 2, 38, "San José La Maquina"),
        (610, 2, 38, "San Juan Bautista"),
        (611, 2, 38, "San Lorenzo"),
        (612, 2, 38, "San Miguel Panán"),
        (613, 2, 38, "San Pablo Jocopilas"),
        (614, 2, 38, "Santa Bárbara"),
        (615, 2, 38, "Santo Domingo Suchitepéquez"),
        (616, 2, 38, "Santo Tomás La Unión"),
        (617, 2, 38, "Zunilito"),
        (618, 2, 39, "Momostenango"),
        (619, 2, 39, "San Andrés Xecul"),
        (620, 2, 39, "San Bartolo"),
        (621, 2, 39, "San Cristóbal Totonicapán"),
        (622, 2, 39, "San Francisco El Alto"),
        (623, 2, 39, "Santa Lucía La Reforma"),
        (624, 2, 39, "Santa María Chiquimula"),
        (625, 2, 39, "Totonicapán"),
        (626, 2, 40, "Cabañas"),
        (627, 2, 40, "Estanzuela"),
        (628, 2, 40, "Gualán"),
        (629, 2, 40, "Huité"),
        (630, 2, 40, "La Unión"),
        (631, 2, 40, "Río Hondo"),
        (632, 2, 40, "San Diego"),
        (633, 2, 40, "San Jorge"),
        (634, 2, 40, "Teculután"),
        (635, 2, 40, "Usumatlán"),
        (636, 2, 40, "Zacapa"),
        (637, 3, 41, "Ahuachapán"),
        (638, 3, 41, "Apaneca"),
        (639, 3, 41, "Atiquizaya"),
        (640, 3, 41, "Concepción de Ataco"),
        (641, 3, 41, "El Refugio"),
        (642, 3, 41, "Guaymango"),
        (643, 3, 41, "Jujutla"),
        (644, 3, 41, "San Francisco Menéndez"),
        (645, 3, 41, "San Lorenzo"),
        (646, 3, 41, "San Pedro Puxtla"),
        (647, 3, 41, "Tacuba"),
        (648, 3, 41, "Turín"),
        (649, 3, 42, "Candelaria de la Frontera"),
        (650, 3, 42, "Coatepeque"),
        (651, 3, 42, "Chalchuapa"),
        (652, 3, 42, "El Congo"),
        (653, 3, 42, "El Porvenir"),
        (654, 3, 42, "Masahuat"),
        (655, 3, 42, "Metapán"),
        (656, 3, 42, "San Antonio Pajonal"),
        (657, 3, 42, "San Sebastián Salitrillo"),
        (658, 3, 42, "Santa Ana"),
        (659, 3, 42, "Santa Rosa Guachipilín"),
        (660, 3, 42, "Santiago de la Frontera"),
        (661, 3, 42, "Texistepeque"),
        (662, 3, 43, "Acajutla"),
        (663, 3, 43, "Armenia"),
        (664, 3, 43, "Caluco"),
        (665, 3, 43, "Cuisnahuat"),
        (666, 3, 43, "Santa Isabel Ishuatán"),
        (667, 3, 43, "Izalco"),
        (668, 3, 43, "Juayúa"),
        (669, 3, 43, "Nahuizalco"),
        (670, 3, 43, "Nahulingo"),
        (671, 3, 43, "Salcoatitán"),
        (672, 3, 43, "San Antonio del Monte"),
        (673, 3, 43, "San Julián"),
        (674, 3, 43, "Santa Catarina Masahuat"),
        (675, 3, 43, "Santo Domingo de Guzmán"),
        (676, 3, 43, "Sonsonate"),
        (677, 3, 43, "Sonzacate"),
        (678, 3, 44, "Agua Caliente"),
        (679, 3, 44, "Arcatao"),
        (680, 3, 44, "Azacualpa"),
        (681, 3, 44, "Citalá"),
        (682, 3, 44, "Comapala"),
        (683, 3, 44, "Concepción Quezaltepeque"),
        (684, 3, 44, "Chalatenango"),
        (685, 3, 44, "Dulce Nombre de María"),
        (686, 3, 44, "El Carrizal"),
        (687, 3, 44, "El Paraíso"),
        (688, 3, 44, "La Laguna"),
        (689, 3, 44, "La Palma"),
        (690, 3, 44, "La Reina"),
        (691, 3, 44, "Las Vueltas"),
        (692, 3, 44, "Nombre de Jesús"),
        (693, 3, 44, "Nueva Concepción"),
        (694, 3, 44, "Nueva Trinidad"),
        (695, 3, 44, "Ojos de Agua"),
        (696, 3, 44, "Potonico"),
        (697, 3, 44, "San Antonio de la Cruz"),
        (698, 3, 44, "San Antonio Los Ranchos"),
        (699, 3, 44, "San Fernando (Chalatenango)"),
        (700, 3, 44, "San Francisco Lempa"),
        (701, 3, 44, "San Francisco Morazán"),
        (702, 3, 44, "San Ignacio"),
        (703, 3, 44, "San Isidro Labrador"),
        (704, 3, 44, "Cancasque"),
        (705, 3, 44, "Las Flores"),
        (706, 3, 44, "San Luis del Carmen"),
        (707, 3, 44, "San Miguel de Mercedes"),
        (708, 3, 44, "San Rafael"),
        (709, 3, 44, "Santa Rita"),
        (710, 3, 44, "Tejutla"),
        (711, 3, 45, "Antiguo Cuscatlán"),
        (712, 3, 45, "Ciudad Arce"),
        (713, 3, 45, "Colón"),
        (714, 3, 45, "Comasagua"),
        (715, 3, 45, "Chiltiupán"),
        (716, 3, 45, "Huizúcar"),
        (717, 3, 45, "Jayaque"),
        (718, 3, 45, "Jicalapa"),
        (719, 3, 45, "La Libertad"),
        (720, 3, 45, "Nuevo Cuscatlán"),
        (721, 3, 45, "Santa Tecla"),
        (722, 3, 45, "Quezaltepeque"),
        (723, 3, 45, "Sacacoyo"),
        (724, 3, 45, "San José Villanueva"),
        (725, 3, 45, "San Juan Opico"),
        (726, 3, 45, "San Matías"),
        (727, 3, 45, "San Pablo Tacachico"),
        (728, 3, 45, "Tamanique"),
        (729, 3, 45, "Talnique"),
        (730, 3, 45, "Teotepeque"),
        (731, 3, 45, "Tepecoyo"),
        (732, 3, 45, "Zaragoza"),
        (733, 3, 46, "Aguilares"),
        (734, 3, 46, "Apopa"),
        (735, 3, 46, "Ayutuxtepeque"),
        (736, 3, 46, "Cuscatancingo"),
        (737, 3, 46, "El Paisnal"),
        (738, 3, 46, "Guazapa"),
        (739, 3, 46, "Ilopango"),
        (740, 3, 46, "Mejicanos"),
        (741, 3, 46, "Nejapa"),
        (742, 3, 46, "Panchimalco"),
        (743, 3, 46, "Rosario de Mora"),
        (744, 3, 46, "San Marcos"),
        (745, 3, 46, "San Martín"),
        (746, 3, 46, "San Salvador"),
        (747, 3, 46, "Santiago Texacuangos"),
        (748, 3, 46, "Santo Tomás"),
        (749, 3, 46, "Soyapango"),
        (750, 3, 46, "Tonacatepeque"),
        (751, 3, 46, "Ciudad Delgado"),
        (752, 3, 47, "Candelaria"),
        (753, 3, 47, "Cojutepeque"),
        (754, 3, 47, "El Carmen (Cuscatlán)"),
        (755, 3, 47, "El Rosario (Cuscatlán)"),
        (756, 3, 47, "Monte San Juan"),
        (757, 3, 47, "Oratorio de Concepción"),
        (758, 3, 47, "San Bartolomé Perulapía"),
        (759, 3, 47, "San Cristóbal"),
        (760, 3, 47, "San José Guayabal"),
        (761, 3, 47, "San Pedro Perulapán"),
        (762, 3, 47, "San Rafael Cedros"),
        (763, 3, 47, "San Ramón"),
        (764, 3, 47, "Santa Cruz Analquito"),
        (765, 3, 47, "Santa Cruz Michapa"),
        (766, 3, 47, "Suchitoto"),
        (767, 3, 47, "Tenancingo"),
        (768, 3, 48, "Cuyultitán"),
        (769, 3, 48, "El Rosario (La Paz)"),
        (770, 3, 48, "Jerusalén"),
        (771, 3, 48, "Mercedes La Ceiba"),
        (772, 3, 48, "Olocuilta"),
        (773, 3, 48, "Paraíso de Osorio"),
        (774, 3, 48, "San Antonio Masahuat"),
        (775, 3, 48, "San Emigdio"),
        (776, 3, 48, "San Francisco Chinameca"),
        (777, 3, 48, "San Juan Nonualco"),
        (778, 3, 48, "San Juan Talpa"),
        (779, 3, 48, "San Juan Tepezontes"),
        (780, 3, 48, "San Luis Talpa"),
        (781, 3, 48, "San Miguel Tepezontes"),
        (782, 3, 48, "San Pedro Masahuat"),
        (783, 3, 48, "San Pedro Nonualco"),
        (784, 3, 48, "San Rafael Obrajuelo"),
        (785, 3, 48, "Santa María Ostuma"),
        (786, 3, 48, "Santiago Nonualco"),
        (787, 3, 48, "Tapalhuaca"),
        (788, 3, 48, "Zacatecoluca"),
        (789, 3, 48, "San Luis La Herradura"),
        (790, 3, 49, "Cinquera"),
        (791, 3, 49, "Guacotecti"),
        (792, 3, 49, "Ilobasco"),
        (793, 3, 49, "Jutiapa"),
        (794, 3, 49, "San Isidro (Cabañas)"),
        (795, 3, 49, "Sensuntepeque"),
        (796, 3, 49, "Tejutepeque"),
        (797, 3, 49, "Victoria"),
        (798, 3, 49, "Dolores"),
        (799, 3, 50, "Apastepeque"),
        (800, 3, 50, "Guadalupe"),
        (801, 3, 50, "San Cayetano Istepeque"),
        (802, 3, 50, "Santa Clara"),
        (803, 3, 50, "Santo Domingo"),
        (804, 3, 50, "San Esteban Catarina"),
        (805, 3, 50, "San Ildefonso"),
        (806, 3, 50, "San Lorenzo"),
        (807, 3, 50, "San Sebastián"),
        (808, 3, 50, "San Vicente"),
        (809, 3, 50, "Tecoluca"),
        (810, 3, 50, "Tepetitán"),
        (811, 3, 50, "Verapaz"),
        (812, 3, 51, "Alegría"),
        (813, 3, 51, "Berlín"),
        (814, 3, 51, "California"),
        (815, 3, 51, "Concepción Batres"),
        (816, 3, 51, "El Triunfo"),
        (817, 3, 51, "Ereguayquín"),
        (818, 3, 51, "Estanzuelas"),
        (819, 3, 51, "Jiquilisco"),
        (820, 3, 51, "Jucuapa"),
        (821, 3, 51, "Jucuarán"),
        (822, 3, 51, "Mercedes Umaña"),
        (823, 3, 51, "Nueva Granada"),
        (824, 3, 51, "Ozatlán"),
        (825, 3, 51, "Puerto El Triunfo"),
        (826, 3, 51, "San Agustín"),
        (827, 3, 51, "San Buenaventura"),
        (828, 3, 51, "San Dionisio"),
        (829, 3, 51, "Santa Elena"),
        (830, 3, 51, "San Francisco Javier"),
        (831, 3, 51, "Santa María"),
        (832, 3, 51, "Santiago de María"),
        (833, 3, 51, "Tecapán"),
        (834, 3, 51, "Usulután"),
        (835, 3, 52, "Carolina"),
        (836, 3, 52, "Ciudad Barrios"),
        (837, 3, 52, "Comacarán"),
        (838, 3, 52, "Chapeltique"),
        (839, 3, 52, "Chinameca"),
        (840, 3, 52, "Chirilagua"),
        (841, 3, 52, "El Tránsito"),
        (842, 3, 52, "Lolotique"),
        (843, 3, 52, "Moncagua"),
        (844, 3, 52, "Nueva Guadalupe"),
        (845, 3, 52, "Nuevo Edén de San Juan"),
        (846, 3, 52, "Quelepa"),
        (847, 3, 52, "San Antonio del Mosco"),
        (848, 3, 52, "San Gerardo"),
        (849, 3, 52, "San Jorge"),
        (850, 3, 52, "San Luis de la Reina"),
        (851, 3, 52, "San Miguel"),
        (852, 3, 52, "San Rafael Oriente"),
        (853, 3, 52, "Sesori"),
        (854, 3, 52, "Uluazapa"),
        (855, 3, 53, "Arambala"),
        (856, 3, 53, "Cacaopera"),
        (857, 3, 53, "Corinto"),
        (858, 3, 53, "Chilanga"),
        (859, 3, 53, "Delicias de Concepción"),
        (860, 3, 53, "El Divisadero"),
        (861, 3, 53, "El Rosario (Morazán)"),
        (862, 3, 53, "Gualococti"),
        (863, 3, 53, "Guatajiagua"),
        (864, 3, 53, "Joateca"),
        (865, 3, 53, "Jocoaitique"),
        (866, 3, 53, "Jocoro"),
        (867, 3, 53, "Lolotiquillo"),
        (868, 3, 53, "Meanguera"),
        (869, 3, 53, "Osicala"),
        (870, 3, 53, "Perquín"),
        (871, 3, 53, "San Carlos"),
        (872, 3, 53, "San Fernando (Morazán)"),
        (873, 3, 53, "San Francisco Gotera"),
        (874, 3, 53, "San Isidro (Morazán)"),
        (875, 3, 53, "San Simón"),
        (876, 3, 53, "Sensembra"),
        (877, 3, 53, "Sociedad"),
        (878, 3, 53, "Torola"),
        (879, 3, 53, "Yamabal"),
        (880, 3, 53, "Yoloaiquín"),
        (881, 3, 54, "Anamoros"),
        (882, 3, 54, "Bolívar"),
        (883, 3, 54, "Concepción de Oriente"),
        (884, 3, 54, "Conchagua"),
        (885, 3, 54, "El Carmen (La Unión)"),
        (886, 3, 54, "El Sauce"),
        (887, 3, 54, "Intipucá"),
        (888, 3, 54, "La Unión"),
        (889, 3, 54, "Lislique"),
        (890, 3, 54, "Meanguera del Golfo"),
        (891, 3, 54, "Nueva Esparta"),
        (892, 3, 54, "Pasaquina"),
        (893, 3, 54, "Polorós"),
        (894, 3, 54, "San Alejo"),
        (895, 3, 54, "San José"),
        (896, 3, 54, "Santa Rosa de Lima"),
        (897, 3, 54, "Yayantique"),
        (898, 3, 54, "Yucuaiquín")
    ''');

    //-------------------INSERTS INICIALES----------------------//
  }

  //-----FUNCIONES PARA OBTENER, AGREGAR, EDITAR O BORRAR REGISTROS -------//

  //AGREGAR ONBOARDING
  Future<int> agregarOnBoardingActivo(OnBoardingModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('wvi_onboarding', modelo.toJson());
    return resultado;
  }

  //AGREGAR SATM COMUNIDADES
  Future<int> agregarComunidades(ComunidadesModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('satm_comunidades', modelo.toJson());
    return resultado;
  }

  //AGREGAR SATM COMUNIDADES
  Future<int> agregarComunidadModulo(ComunidadesModuloModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('wvi_comunidades', modelo.toJson());
    return resultado;
  }

  //AGREGAR SATM FAMILIAS
  Future<int> agregarFamilias(FamiliasModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('satm_familias', modelo.toJson());
    return resultado;
  }

  //AGREGAR SATM FAMILIAS MIEMBROS
  Future<int> agregarFamiliasMiembros(FamiliasMiembrosModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('satm_familias_miembros', modelo.toJson());
    return resultado;
  }

  //AGREGAR SATM PREGUNTAS
  Future<int> agregarSatPreguntas(PreguntasModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('satm_preguntas', modelo.toJson());
    return resultado;
  }

  //AGREGAR SATM PREGUNTAS PONDERACIONES
  Future<int> agregarSatPreguntasPonderaciones(
      PreguntasPonderacionesModelo modelo) async {
    Database db = await instance.database;
    int resultado =
        await db.insert('satm_preguntas_ponderaciones', modelo.toJson());
    return resultado;
  }

  //AGREGAR PROPENSIONES
  Future<int> agregarPropensiones(PropensionesModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('satm_propensiones', modelo.toJson());
    return resultado;
  }

  //AGREGAR USUARIOS
  Future<int> agregarUsuarios(UsuariosModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('satm_usuarios', modelo.toJson());
    return resultado;
  }

  //AGREGAR PAÍSES
  Future<int> agregarPaises(PaisesModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('wvi_paises', modelo.toJson());
    return resultado;
  }

  //AGREGAR DEPARTAMENTOS
  Future<int> agregarDepartamentos(DepartamentosModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('wvi_departamentos', modelo.toJson());
    return resultado;
  }

  //AGREGAR MUNICIPIOS
  Future<int> agregarMunicipios(MunicipiosModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('wvi_municipios', modelo.toJson());
    return resultado;
  }

  //AGREGAR INGRESOS OPCIONES
  Future<int> agregarOpcionesIngresos(IngresosOpcionesModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('wvi_ingresos_opciones', modelo.toJson());
    return resultado;
  }

  //AGREGAR INGRESOS OPCIONES
  Future<int> agregarRangos(RangosModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('wvi_rangos_p44', modelo.toJson());
    return resultado;
  }

  //AGREGAR MIEMBROS MIGRANTES
  Future<int> agregarMiembrosMigrantes(MiembrosMigrantesModelo modelo) async {
    Database db = await instance.database;
    int resultado =
        await db.insert('satm_familias_miembros_migrantes', modelo.toJson());
    return resultado;
  }

  //AGREGAR LÍMITES DE PROPENSIONES
  Future<int> agregarLimitesPropensiones(
      LimitesPropensionesModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.insert('wvi_propensiones', modelo.toJson());
    return resultado;
  }

  //OBTENER ONBOARDING ACTIVO
  Future<List<OnBoardingModelo>> obtenerOnBoarding() async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_onboarding');
    List<OnBoardingModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => OnBoardingModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER LÍMITES DE PROPENSIONES
  Future<List<LimitesPropensionesModelo>> obtenerLimitesPropensiones() async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_propensiones');
    List<LimitesPropensionesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => LimitesPropensionesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER SATM COMUNIDADES
  Future<List<ComunidadesModelo>> obtenerSatmComunidades() async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_comunidades');
    List<ComunidadesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => ComunidadesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER LAS COMUNIDADES MÓDULO
  Future<List<ComunidadesModuloModelo>> obtenerComunidadesModulo(
      int idMunicipio) async {
    Database db = await instance.database;
    var respuesta = await db.query(
      'wvi_comunidades',
      where: 'idMunicipio = ?',
      whereArgs: [idMunicipio],
    );
    List<ComunidadesModuloModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => ComunidadesModuloModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER TODAS LAS COMUNIDADES MÓDULOS
  Future<List<ComunidadesModuloModelo>>
      obtenerTodasLasComunidadesModulo() async {
    Database db = await instance.database;
    var respuesta = await db.query(
      'wvi_comunidades',
    );
    List<ComunidadesModuloModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => ComunidadesModuloModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER SATM COMUNIDADES POR CODALEA
  Future<ComunidadesModelo> obtenerSatmComunidadesPorCodalea(
      String codalea) async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_comunidades',
        where: 'codalea_satcomunidades = ?', whereArgs: [codalea]);
    List<ComunidadesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => ComunidadesModelo.fromJson(e)).toList()
        : [];

    return listado.first;
  }

  //OBTENER SATM FAMILIAS
  Future<List<FamiliasModelo>> obtenerSatmFamilias() async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_familias');
    List<FamiliasModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => FamiliasModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER SATM FAMILIAS POR CODALEA
  Future<FamiliasModelo> obtenerSatmFamiliasPorCodalea(String codalea) async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_familias',
        where: 'codalea_satfamilias = ?', whereArgs: [codalea]);
    List<FamiliasModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => FamiliasModelo.fromJson(e)).toList()
        : [];

    return listado.first;
  }

  //OBTENER SATM FAMILIAS MIEMBROS
  Future<List<FamiliasMiembrosModelo>> obtenerSatmFamiliasMiembros() async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_familias_miembros');
    List<FamiliasMiembrosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => FamiliasMiembrosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER SATM FAMILIAS MIEMBROS POR CODALEA DE MIEMBRO
  Future<FamiliasMiembrosModelo> obtenerSatmFamiliasMiembrosPorCodalea(
      String codalea) async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_familias_miembros',
        where: 'codalea_miembros = ?', whereArgs: [codalea]);
    List<FamiliasMiembrosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => FamiliasMiembrosModelo.fromJson(e)).toList()
        : [];

    return listado.first;
  }

  //OBTENER SATM FAMILIAS MIEMBROS POR CODALEA DE SATM FAMILIAS
  Future<List<FamiliasMiembrosModelo>>
      obtenerSatmFamiliasMiembrosPorCodaleaFamilias(String codalea) async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_familias_miembros',
        where: 'codalea_satfamilias = ?', whereArgs: [codalea]);
    List<FamiliasMiembrosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => FamiliasMiembrosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER SATM PREGUNTAS
  Future<List<PreguntasModelo>> obtenerSatmPreguntas() async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_preguntas');
    List<PreguntasModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => PreguntasModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER SATM PONDERACIONES
  Future<List<PreguntasPonderacionesModelo>> obtenerSatmPonderaciones() async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_preguntas_ponderaciones');
    List<PreguntasPonderacionesModelo> listado = respuesta.isNotEmpty
        ? respuesta
            .map((e) => PreguntasPonderacionesModelo.fromJson(e))
            .toList()
        : [];

    return listado;
  }

  //OBTENER PROPENSIONES
  Future<List<PropensionesModelo>> obtenerPropensiones() async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_propensiones');
    List<PropensionesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => PropensionesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER USUARIOS
  Future<List<UsuariosModelo>> obtenerUsuarios() async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_usuarios');
    List<UsuariosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => UsuariosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER DEPARTAMENTOS
  Future<List<DepartamentosModelo>> obtenerDepartamentos() async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_departamentos');
    List<DepartamentosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => DepartamentosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER DEPARTAMENTOS POR ID DEPARTAMENTO
  Future<List<DepartamentosModelo>> obtenerDepartamentosPorId(int id) async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_departamentos',
        where: 'idDepartamento = ?', whereArgs: [id]);
    List<DepartamentosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => DepartamentosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER DEPARTAMENTOS
  Future<List<DepartamentosModelo>> obtenerDepartamentosPorPais(
      int idPais) async {
    Database db = await instance.database;
    var respuesta = await db
        .query('wvi_departamentos', where: 'idPais = ?', whereArgs: [idPais]);
    List<DepartamentosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => DepartamentosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER MUNICIPIOS
  Future<List<MunicipiosModelo>> obtenerMunicipios() async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_municipios');
    List<MunicipiosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => MunicipiosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER MUNICIPIOS
  Future<List<MunicipiosModelo>> obtenerMunicipiosPorDepto(
      int idDepartamento) async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_municipios',
        where: 'idDepartamento = ?', whereArgs: [idDepartamento]);
    List<MunicipiosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => MunicipiosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER PAÍSES
  Future<List<PaisesModelo>> obtenerPaises() async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_paises');
    List<PaisesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => PaisesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER PAÍS POR ID
  Future<List<PaisesModelo>> obtenerPaisesPorId(int idPais) async {
    Database db = await instance.database;
    var respuesta =
        await db.query('wvi_paises', where: 'idPais = ?', whereArgs: [idPais]);
    List<PaisesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => PaisesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER OPCIONES DE INGRESO
  Future<List<IngresosOpcionesModelo>> obtenerOpcionesIngresos() async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_ingresos_opciones');
    List<IngresosOpcionesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => IngresosOpcionesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER OPCIONES DE INGRESO POR ID PAÍS
  Future<List<IngresosOpcionesModelo>> obtenerOpcionesIngresosPorIdPais(
      int idPais) async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_ingresos_opciones',
        where: 'idPais = ?', whereArgs: [idPais]);
    List<IngresosOpcionesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => IngresosOpcionesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER RANGOS
  Future<List<RangosModelo>> obtenerRangos() async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_rangos_p44');
    List<RangosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => RangosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER RANGOS POR ID PAÍS
  Future<List<RangosModelo>> obtenerRangosPorIdPais(int idPais) async {
    Database db = await instance.database;
    var respuesta = await db
        .query('wvi_rangos_p44', where: 'idPais = ?', whereArgs: [idPais]);
    List<RangosModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => RangosModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER ROLES
  Future<List<RolesModelo>> obtenerRoles() async {
    Database db = await instance.database;
    var respuesta = await db.query('wvi_roles');
    List<RolesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => RolesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER MIEMBROS MIGRANTES
  Future<List<MiembrosMigrantesModelo>> obtenerMiembrosMigrantes() async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_familias_miembros_migrantes');
    List<MiembrosMigrantesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => MiembrosMigrantesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER MIEMBROS MIGRANTES POR CODALEA
  Future<List<MiembrosMigrantesModelo>> obtenerMiembrosMigrantesPorCodalea(
      String codalea) async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_familias_miembros_migrantes',
        where: 'codalea_miembros = ?', whereArgs: [codalea]);
    List<MiembrosMigrantesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => MiembrosMigrantesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //OBTENER MIEMBROS MIGRANTES POR CODALEA DE SATM FAMILIA
  Future<List<MiembrosMigrantesModelo>>
      obtenerMiembrosMograntesPorCodaleaSatmFamilia(String codalea) async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_familias_miembros_migrantes',
        where: 'codalea_satfamilias = ?', whereArgs: [codalea]);
    List<MiembrosMigrantesModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => MiembrosMigrantesModelo.fromJson(e)).toList()
        : [];

    return listado;
  }

  //BORRAR SATM FORMULARIOS COMUNIDADES
  Future<int> borrarComunidades() async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_comunidades');
    return resultado;
  }

  //BORRAR SATM FORMULARIOS COMUNIDADES POR CODALEA
  Future<int> borrarComunidadesPorCodalea(String codalea) async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_comunidades',
        where: 'codalea_satcomunidades = ?', whereArgs: [codalea]);
    return resultado;
  }

  //BORRAR SATM FORMULARIOS FAMILIAS
  Future<int> borrarFamilias() async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_familias');
    return resultado;
  }

  //BORRAR SATM FORMULARIOS FAMILIAS POR CODALEA
  Future<int> borrarFamiliasPorCodalea(String codalea) async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_familias',
        where: 'codalea_satfamilias = ?', whereArgs: [codalea]);
    return resultado;
  }

  //BORRAR SATM FORMULARIOS FAMILIAS MIEMBROS
  Future<int> borrarFamiliasMiembros() async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_familias_miembros');
    return resultado;
  }

  //BORRAR COMUNIDADES MÓDULO
  Future<int> borrarComunidadesModulo() async {
    Database db = await instance.database;
    int resultado = await db.delete('wvi_comunidades');
    return resultado;
  }

  //BORRAR SATM FORMULARIOS FAMILIAS MIEMBROS POR CODALEA DE FAMILIA
  Future<int> borrarFamiliasMiembrosPorCodaleaFamilia(String codalea) async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_familias_miembros',
        where: 'codalea_satfamilias = ?', whereArgs: [codalea]);
    return resultado;
  }

  //BORRAR SATM PONDERACIONES
  Future<int> borrarPonderaciones() async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_preguntas_ponderaciones');
    return resultado;
  }

  //BORRAR SATM PROPENSIONES
  Future<int> borrarPropensiones() async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_propensiones');
    return resultado;
  }

  //BORRAR USUARIOS
  Future<int> borrarUsuarios() async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_usuarios');
    return resultado;
  }

  //BORRAR PAÍSES
  Future<int> borrarPaises() async {
    Database db = await instance.database;
    int resultado = await db.delete('wvi_paises');
    return resultado;
  }

  //BORRAR DEPARTAMENTOS
  Future<int> borrarDepartamentos() async {
    Database db = await instance.database;
    int resultado = await db.delete('wvi_departamentos');
    return resultado;
  }

  //BORRAR MUNICIPIOS
  Future<int> borrarMunicipios() async {
    Database db = await instance.database;
    int resultado = await db.delete('wvi_municipios');
    return resultado;
  }

  //BORRAR OPCIONES DE INGRESOS
  Future<int> borrarOpcionesIngresos() async {
    Database db = await instance.database;
    int resultado = await db.delete('wvi_ingresos_opciones');
    return resultado;
  }

  //BORRAR RANGOS P44
  Future<int> borrarRangosP44() async {
    Database db = await instance.database;
    int resultado = await db.delete('wvi_rangos_p44');
    return resultado;
  }

  //BORRAR ONBOARDING
  Future<int> borrarOnBoarding() async {
    Database db = await instance.database;
    int resultado = await db.delete('wvi_onboarding');
    return resultado;
  }

  //BORRAR MIEMBROS MODELOS COMPLETA
  Future<int> borrarMiembrosMigrantes() async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_familias_miembros_migrantes');
    return resultado;
  }

  //BORRAR SATM MIEMBROS MIGRANTES POR CODALEA DE FAMILIA
  Future<int> borrarMiembrosMigrantesPorCodaleaFamilia(String codalea) async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_familias_miembros_migrantes',
        where: 'codalea_satfamilias = ?', whereArgs: [codalea]);
    return resultado;
  }

  //BORRAR SATM MIEMBROS MIGRANTES POR CODALEA PROPIO (SOLO UN MIEMBRO)
  Future<int> borrarMiembrosMigrantesPorCodalea(String codalea) async {
    Database db = await instance.database;
    int resultado = await db.delete('satm_familias_miembros_migrantes',
        where: 'codalea_miembros = ?', whereArgs: [codalea]);
    return resultado;
  }

  //ACTUALIZAR COMUNIDADES POR CODALEA
  Future<int> actualizarComunidades(ComunidadesModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.rawUpdate(
        'UPDATE satm_comunidades SET  idDepartamento = ?, idMunicipio = ?, comunidad = ?, nom_encuestado = ?, tel_encuestado = ?, identidad = ?, edad = ?, sexo = ?, educacion = ?, ano_cursado = ?, estado = ?, nino = ?, ambos_padres = ?, nn_patrocinado = ?, id_patrocinio = ?, b1 = ?, b2 = ?, c1 = ?, c2 = ?, c3 = ?, d1 = ?, d2 = ?, d3 = ?, d4 = ?, d9 = ?, d5 = ?, d6 = ?, d7 = ?, d8 = ?, e1 = ?, e2 = ?, facilitador = ?, tel_facilitador = ?, fecha = ?, observaciones = ?, lat = ?, lon = ?, alt = ?, acc = ? WHERE codalea_satcomunidades = ?',
        [
          modelo.idDepartamento,
          modelo.idMunicipio,
          modelo.comunidad,
          modelo.nomEncuestado,
          modelo.telEncuestado,
          modelo.identidad,
          modelo.edad,
          modelo.sexo,
          modelo.educacion,
          modelo.anoCursado,
          modelo.estado,
          modelo.nino,
          modelo.ambosPadres,
          modelo.nnPatrocinado,
          modelo.idPatrocinio,
          modelo.b1,
          modelo.b2,
          modelo.c1,
          modelo.c2,
          modelo.c3,
          modelo.d1,
          modelo.d2,
          modelo.d3,
          modelo.d4,
          modelo.d9,
          modelo.d5,
          modelo.d6,
          modelo.d7,
          modelo.d8,
          modelo.e1,
          modelo.e2,
          modelo.facilitador,
          modelo.telFacilitador,
          modelo.fecha,
          modelo.observaciones,
          modelo.lat,
          modelo.lon,
          modelo.alt,
          modelo.acc,
          modelo.codaleaSatcomunidades,
        ]);
    return resultado;
  }

  //ACTUALIZAR FAMILIAS POR CODALEA
  Future<int> actualizarFamilias(FamiliasModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.rawUpdate(
        'UPDATE satm_familias SET idDepartamento = ?, idMunicipio = ?, comunidad = ?, patrocinio = ?, nom_encuestado = ?, identidad = ?, edad = ?, nacimiento = ?, sexo = ?, estudia = ?, educacion = ?, estado = ?, telefono_encuestado = ?, familias = ?, miembros = ?, nina = ?, nino = ?, ambos_padres = ?, nn_patrocinado = ?, id_patrocinio = ?, p01 = ?, p02 = ?, p03 = ?, p04 = ?, p05 = ?, p06 = ?, p07 = ?, p08 = ?, p09 = ?, p10 = ?, p11 = ?, p12 = ?, p13 = ?, p14 = ?, p15 = ?, p16 = ?, p17 = ?, p18 = ?, p18b = ?, p19 = ?, p20 = ?, p21 = ?, p22 = ?, p23 = ?, p24 = ?, p27 = ?, p28 = ?, p29 = ?, p30 = ?, p31 = ?, p32 = ?, otro1 = ?, p33 = ?, p34 = ?, p35 = ?, p36 = ?, p37 = ?, p38 = ?, p39 = ?, p40 = ?, p41 = ?, p42 = ?, p43 = ?, p44 = ?, p45 = ?, vivienda = ?, p46 = ?, p47 = ?, p48 = ?, p49 = ?, p50 = ?, p51 = ?, ppi1 = ?, ppi2 = ?, ppi3 = ?, ppi4 = ?, ppi5 = ?, ppi6 = ?, ppi7 = ?, ppi8 = ?, ppi9 = ?, ppi10 = ?, ppi11 = ?, facilitador = ?, tel_facilitador = ?, fecha = ?, observaciones = ?, lat = ?, lon = ?, alt = ?, acc = ? WHERE codalea_satfamilias = ?',
        [
          modelo.idDepartamento,
          modelo.idMunicipio,
          modelo.comunidad,
          modelo.patrocinio,
          modelo.nomEncuestado,
          modelo.identidad,
          modelo.edad,
          modelo.nacimiento,
          modelo.sexo,
          modelo.estudia,
          modelo.educacion,
          modelo.estado,
          modelo.telefonoEncuestado,
          modelo.familias,
          modelo.miembros,
          modelo.nina,
          modelo.nino,
          modelo.ambosPadres,
          modelo.nnPatrocinado,
          modelo.idPatrocinio,
          modelo.p01,
          modelo.p02,
          modelo.p03,
          modelo.p04,
          modelo.p05,
          modelo.p06,
          modelo.p07,
          modelo.p08,
          modelo.p09,
          modelo.p10,
          modelo.p11,
          modelo.p12,
          modelo.p13,
          modelo.p14,
          modelo.p15,
          modelo.p16,
          modelo.p17,
          modelo.p18,
          modelo.p18B,
          modelo.p19,
          modelo.p20,
          modelo.p21,
          modelo.p22,
          modelo.p23,
          modelo.p24,
          modelo.p27,
          modelo.p28,
          modelo.p29,
          modelo.p30,
          modelo.p31,
          modelo.p32,
          modelo.otro1,
          modelo.p33,
          modelo.p34,
          modelo.p35,
          modelo.p36,
          modelo.p37,
          modelo.p38,
          modelo.p39,
          modelo.p40,
          modelo.p41,
          modelo.p42,
          modelo.p43,
          modelo.p44,
          modelo.p45,
          modelo.vivienda,
          modelo.p46,
          modelo.p47,
          modelo.p48,
          modelo.p49,
          modelo.p50,
          modelo.p51,
          modelo.ppi1,
          modelo.ppi2,
          modelo.ppi3,
          modelo.ppi4,
          modelo.ppi5,
          modelo.ppi6,
          modelo.ppi7,
          modelo.ppi8,
          modelo.ppi9,
          modelo.ppi10,
          modelo.ppi11,
          modelo.facilitador,
          modelo.telFacilitador,
          modelo.fecha,
          modelo.observaciones,
          modelo.lat,
          modelo.lon,
          modelo.alt,
          modelo.acc,
          modelo.codaleaSatfamilias
        ]);
    return resultado;
  }

  //ACTUALIZAR COMUNIDADES POR CODALEA
  Future<int> actualizarMiembrosMigrantes(
      MiembrosMigrantesModelo modelo) async {
    Database db = await instance.database;
    int resultado = await db.rawUpdate(
        'UPDATE satm_familias_miembros_migrantes SET retornado = ?, temporalidad = ?, comunidad = ?, nom_encuestado = ?, edad = ?, genero = ?, num_telefono = ?, idDepartamento = ?, idMunicipio = ?, nom_comunidad = ?, nivel_educativo = ?, ocupacion = ?, estado_civil = ?, p09 = ?, p09relacion = ?, p10 = ?, p10otro = ?, p11 = ?, p11otro = ?, p12 = ?, p12numero = ?, p12relacion = ?, p13 = ?, p13anio = ?, p13pais = ?, p14 = ?, p14descripcion = ?, p15 = ?, p15servicios = ?, p16 = ?, p16razones = ? WHERE codalea_miembros = ?',
        [
          modelo.retornado,
          modelo.temporalidad,
          modelo.comunidad,
          modelo.nomEncuestado,
          modelo.edad,
          modelo.genero,
          modelo.numTelefono,
          modelo.idDepartamento,
          modelo.idMunicipio,
          modelo.nomComunidad,
          modelo.nivelEducativo,
          modelo.ocupacion,
          modelo.estadoCivil,
          modelo.p09,
          modelo.p09Relacion,
          modelo.p10,
          modelo.p10Otro,
          modelo.p11,
          modelo.p11Otro,
          modelo.p12,
          modelo.p12Numero,
          modelo.p12Relacion,
          modelo.p13,
          modelo.p13Anio,
          modelo.p13Pais,
          modelo.p14,
          modelo.p14Descripcion,
          modelo.p15,
          modelo.p15Servicios,
          modelo.p16,
          modelo.p16Razones,
          modelo.codaleaMiembros,
        ]);
    return resultado;
  }

  //-----FUNCIONES PARA OBTENER, AGREGAR, EDITAR O BORRAR REGISTROS -------//

  //-----FUNCIONES ESPECIALES -------//
  //OBTENER PONDERACIÓN POR ID D PREGUNTA Y OPCIÓN ELEGIDA
  Future<List<PreguntasPonderacionesModelo>> obtenerPonderacionPorIdyValor(
      int id, int opcionValor) async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_preguntas_ponderaciones',
        where: 'idPregunta = ? AND opcion_valor = ?',
        whereArgs: [id, opcionValor]);
    List<PreguntasPonderacionesModelo> listado = respuesta.isNotEmpty
        ? respuesta
            .map((e) => PreguntasPonderacionesModelo.fromJson(e))
            .toList()
        : [];

    return listado;
  }

  //OBTENER ID DE LA PREGUNTA POR CÓDIGO
  Future<List<PreguntasModelo>> obtenerIdPregunta(String codigo) async {
    Database db = await instance.database;
    var respuesta = await db.query('satm_preguntas',
        where: 'codigo_pregunta = ?', whereArgs: [codigo]);
    List<PreguntasModelo> listado = respuesta.isNotEmpty
        ? respuesta.map((e) => PreguntasModelo.fromJson(e)).toList()
        : [];

    return listado;
  }
  //-----FUNCIONES ESPECIALES -------//
}
