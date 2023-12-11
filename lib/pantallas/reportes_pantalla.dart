import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sat_m/constantes/colores_constantes.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({Key? key, required this.idPais, required this.rol})
      : super(key: key);

  final int idPais;
  final int rol;

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kNaranjaPrincipal,
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: SvgPicture.asset(
              'assets/svg/backspace.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          'Reportes',
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(
              fontWeight: FontWeight.w500, fontSize: 21, color: Colors.white),
        ),
      ),
      body:
          CuerpoCentral(rolRecibido: widget.rol, idPaisRecibido: widget.idPais),
    );
  }
}

class CuerpoCentral extends StatelessWidget {
  const CuerpoCentral({
    super.key,
    required this.rolRecibido,
    required this.idPaisRecibido,
  });

  final int rolRecibido;
  final int idPaisRecibido;

  @override
  Widget build(BuildContext context) {
    //LÓGICA DEPENDIENDO EL ROL Y PAÍS
    //CASO DEL RECOLECTOR
    if (rolRecibido == 3) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: const Center(
          child: Text(
              'Usted no tiene los suficientes privilegios para ver los reportes!!!'),
        ),
      );
    }
    //CASO DEL ADMIN PRINCIPAL O VEEDOR
    if (rolRecibido == 1 || rolRecibido == 4) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'Central de Información',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Haga click en el reporte que desea ver',
              style: GoogleFonts.lato(fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiMTFiZWQ2ZTMtOGY4Zi00YTM2LTg4OGEtMDMxZGVlNDdkMWFmIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection662f76393c87076e2ba7');
              },
              child: const Text('Comunidades Honduras'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiOWUxYjgwZDQtNDY4YS00ZmE0LTkyOWYtMTg5NzAxYzZkYTBmIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection662f76393c87076e2ba7');
              },
              child: const Text('Familias Honduras'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiMDFmNDZjOWItN2E2Yi00YzhiLThmNzktZDVlMjI1YWI3NmU0IiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection3d7a69367f87c30a5c7b');
              },
              child: const Text('Comunidades Guatemala'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiZDllZDNjMWEtYjdjYy00ZTQ0LWI5Y2UtOTE5NTk2ZDIyYzFlIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection3d7a69367f87c30a5c7b');
              },
              child: const Text('Familias Guatemala'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiYTM1YjE3OTAtNGVkYy00MjYwLTliNDktODIwMzg2MTU1OGRkIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection8d2f97a02e46c923e2e3');
              },
              child: const Text('Comunidades El Salvador'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiOWUwN2ExODYtMzI0Ni00MzcxLThlMzYtM2ExMTg3NzEwYjAwIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection8d2f97a02e46c923e2e3');
              },
              child: const Text('Familias El Salvador'),
            ),
          ],
        ),
      );
    }

    //PARA TODOS LOS CASOS DEL ROL ADMIN PAÍS (ROL == 2)
    //CASO ADMIN DE PAÍSES (HONDURAS)
    if (idPaisRecibido == 1) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'Central de Información',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Haga click en el reporte que desea ver',
              style: GoogleFonts.lato(fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiMTFiZWQ2ZTMtOGY4Zi00YTM2LTg4OGEtMDMxZGVlNDdkMWFmIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection662f76393c87076e2ba7');
              },
              child: const Text('Comunidades Honduras'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiOWUxYjgwZDQtNDY4YS00ZmE0LTkyOWYtMTg5NzAxYzZkYTBmIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection662f76393c87076e2ba7');
              },
              child: const Text('Familias Honduras'),
            ),
          ],
        ),
      );
    }

    //CASO ADMIN DE PAÍSES (GUATEMALA)
    if (idPaisRecibido == 2) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'Central de Información',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Haga click en el reporte que desea ver',
              style: GoogleFonts.lato(fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiMDFmNDZjOWItN2E2Yi00YzhiLThmNzktZDVlMjI1YWI3NmU0IiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection3d7a69367f87c30a5c7b');
              },
              child: const Text('Comunidades Guatemala'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await _launchURL(
                    'https://app.powerbi.com/view?r=eyJrIjoiZDllZDNjMWEtYjdjYy00ZTQ0LWI5Y2UtOTE5NTk2ZDIyYzFlIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection3d7a69367f87c30a5c7b');
              },
              child: const Text('Familias Guatemala'),
            ),
          ],
        ),
      );
    }

    //CASO ADMIN DE PAÍSES (EL SALVADOR)
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            'Central de Información',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            'Haga click en el reporte que desea ver',
            style: GoogleFonts.lato(fontStyle: FontStyle.italic),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () async {
              await _launchURL(
                  'https://app.powerbi.com/view?r=eyJrIjoiYTM1YjE3OTAtNGVkYy00MjYwLTliNDktODIwMzg2MTU1OGRkIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection8d2f97a02e46c923e2e3');
            },
            child: const Text('Comunidades El Salvador'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              await _launchURL(
                  'https://app.powerbi.com/view?r=eyJrIjoiOWUwN2ExODYtMzI0Ni00MzcxLThlMzYtM2ExMTg3NzEwYjAwIiwidCI6ImI5NTFlMDMwLWFmMzgtNDBkNy1iZDBiLWZiZWQzYzg3NjUzYSIsImMiOjZ9&pageName=ReportSection8d2f97a02e46c923e2e3');
            },
            child: const Text('Familias El Salvador'),
          ),
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  final urlFinal = Uri.parse(url); // replace with your URL
  if (!await launchUrl(urlFinal, mode: LaunchMode.inAppWebView)) {
    throw Exception('No se pudo abrir $urlFinal');
  }
}
