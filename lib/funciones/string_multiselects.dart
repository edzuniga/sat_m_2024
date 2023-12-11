String stringMultiselect(List<int> dato) {
  String respuesta = "";
  if (dato.isNotEmpty) {
    for (int i = 0; i < dato.length; i++) {
      respuesta += "${dato[i]},";
    }
    respuesta = respuesta.substring(0, respuesta.length - 1);
    return respuesta;
  }
  return '';
}
