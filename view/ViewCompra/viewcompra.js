$(document).ready(function () {
  var compr_id = getUrlParameter("c");

  $.post(
    "../../controller/compra.php?op=mostrar",
    { compr_id: compr_id },
    function (data) {
      data = JSON.parse(data);
      $("#txtdirecc").html(data.emp_direcc);
      $("#txtruc").html(data.emp_ruc);
      $("#txtemail").html(data.emp_correo);
      $("#txtweb").html(data.emp_pag);
      $("#txttelf").html(data.emp_telf);

      $("#compr_id").html(data.compr_id);
      $("#fech_crea").html(data.fech_crea);
      $("#pag_nom").html(data.pag_nom);
      $("#txttotal").html(data.compr_total);

      $("#compr_subtotal").html(data.compr_subtotal);
      $("#compr_igv").html(data.compr_igv);
      $("#compr_total").html(data.compr_total);

      $("#compr_coment").html(data.compr_coment);

      $("#usu_nom").html(data.usu_nom + " " + data.usu_ape);
      $("#mon_nom").html(data.mon_nom);

      $("#prov_nom").html("<b>Nombre: </b>" + data.prov_nom);
      $("#prov_ruc").html("<b>RUC: </b>" + data.prov_ruc);
      $("#prov_direcc").html("<b>Dirección: </b>" + data.prov_direcc);
      $("#prov_correo").html("<b>Correo: </b>" + data.prov_correo);
    }
  );

  $.post(
    "../../controller/compra.php?op=listardetalleformato",
    { compr_id: compr_id },
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
