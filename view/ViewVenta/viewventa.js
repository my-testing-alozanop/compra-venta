$(document).ready(function () {
  var vent_id = getUrlParameter("v");

  $.post(
    "../../controller/venta.php?op=mostrar",
    { vent_id: vent_id },
    function (data) {
      data = JSON.parse(data);
      $("#txtdirecc").html(data.emp_direcc);
      $("#txtruc").html(data.emp_ruc);
      $("#txtemail").html(data.emp_correo);
      $("#txtweb").html(data.emp_pag);
      $("#txttelf").html(data.emp_telf);

      $("#vent_id").html(data.vent_id);
      $("#fech_crea").html(data.fech_crea);
      $("#pag_nom").html(data.pag_nom);
      $("#txttotal").html(data.vent_total);

      $("#vent_subtotal").html(data.vent_subtotal);
      $("#vent_igv").html(data.vent_igv);
      $("#vent_total").html(data.vent_total);

      $("#vent_coment").html(data.vent_coment);

      $("#usu_nom").html(data.usu_nom + " " + data.usu_ape);
      $("#mon_nom").html(data.mon_nom);

      $("#cli_nom").html("<b>Nombre: </b>" + data.cli_nom);
      $("#cli_ruc").html("<b>RUC: </b>" + data.cli_ruc);
      $("#cli_direcc").html("<b>Dirección: </b>" + data.cli_direcc);
      $("#cli_correo").html("<b>Correo: </b>" + data.cli_correo);
    }
  );

  $.post(
    "../../controller/venta.php?op=listardetalleformato",
    { vent_id: vent_id },
    function (data) {
      $("#listdetalle").html(data);
    }
  );
});

var getUrlParameter = function getUrlParameter(sParam) {
  var sPageURL = decodeURIComponent(window.location.search.substring(1)),
    sURLVariables = sPageURL.split("&"),
    sParameterName,
    i;

  for (i = 0; i < sURLVariables.length; i++) {
    sParameterName = sURLVariables[i].split("=");

    if (sParameterName[0] === sParam) {
      return sParameterName[1] === undefined ? true : sParameterName[1];
    }
  }
};
