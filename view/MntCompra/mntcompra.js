var emp_id = $("#emp_idx").val();
var suc_id = $("#suc_idx").val();
var usu_id = $("#usu_idx").val();

$(document).ready(function () {
  $.post(
    "../../controller/compra.php?op=registrar",
    { suc_id: suc_id, usu_id: usu_id },
    function (data) {
      data = JSON.parse(data);
      $("#compr_id").val(data.compr_id);
    }
  );

  $("#prov_id").select2();

  $("#cat_id").select2();

  $("#prod_id").select2();

  $("#pag_id").select2();

  $("#mon_id").select2();

  $.post(
    "../../controller/proveedor.php?op=combo",
    { emp_id: emp_id },
    function (data) {
      $("#prov_id").html(data);
    }
  );

  $.post(
    "../../controller/categoria.php?op=combo",
    { suc_id: suc_id },
    function (data) {
      $("#cat_id").html(data);
    }
  );

  $.post("../../controller/pago.php?op=combo", function (data) {
    $("#pag_id").html(data);
  });

  $.post(
    "../../controller/moneda.php?op=combo",
    { suc_id: suc_id },
    function (data) {
      $("#mon_id").html(data);
    }
  );

  $("#prov_id").change(function () {
    $("#prov_id").each(function () {
      prov_id = $(this).val();
      $.post(
        "../../controller/proveedor.php?op=mostrar",
        { prov_id: prov_id },
        function (data) {
          data = JSON.parse(data);
          $("#prov_ruc").val(data.prov_ruc);
          $("#prov_direcc").val(data.prov_direcc);
          $("#prov_telf").val(data.prov_telf);
          $("#prov_correo").val(data.prov_correo);
        }
      );
    });
  });

  $("#cat_id").change(function () {
    $("#cat_id").each(function () {
      cat_id = $(this).val();

      $.post(
        "../../controller/producto.php?op=combo",
        { cat_id: cat_id },
        function (data) {
          $("#prod_id").html(data);
        }
      );
    });
  });

  $("#prod_id").change(function () {
    $("#prod_id").each(function () {
      prod_id = $(this).val();

      $.post(
        "../../controller/producto.php?op=mostrar",
        { prod_id: prod_id },
        function (data) {
          data = JSON.parse(data);
          $("#prod_pcompra").val(data.prod_pcompra);
          $("#prod_stock").val(data.prod_stock);
          $("#und_nom").val(data.und_nom);
        }
      );
    });
  });
});

$(document).on("click", "#btnagregar", function () {
  var compr_id = $("#compr_id").val();
  var prod_id = $("#prod_id").val();
  var prod_pcompra = $("#prod_pcompra").val();
  var detc_cant = $("#detc_cant").val();

  if (
    $("#prod_id").val() == "" ||
    $("#prod_pcompra").val() == "" ||
    $("#detc_cant").val() == ""
  ) {
    swal.fire({
      title: "Compra",
      text: "Error Campos Vacios",
      icon: "error",
    });
  } else {
    $.post(
      "../../controller/compra.php?op=guardardetalle",
      {
        compr_id: compr_id,
        prod_id: prod_id,
        prod_pcompra: prod_pcompra,
        detc_cant: detc_cant,
      },
      function (data) {
        console.log(data);
      }
    );

    $.post(
      "../../controller/compra.php?op=calculo",
      { compr_id: compr_id },
      function (data) {
        data = JSON.parse(data);
        $("#txtsubtotal").html(data.compr_subtotal);
        $("#txtigv").html(data.compr_igv);
        $("#txttotal").html(data.compr_total);
      }
    );

    $("#prod_pcompra").val("");
    $("#detc_cant").val("");

    listar(compr_id);
  }
});

function eliminar(detc_id, compr_id) {
  swal
    .fire({
      title: "Eliminar!",
      text: "Desea Eliminar el Registro?",
      icon: "error",
      confirmButtonText: "Si",
      showCancelButton: true,
      cancelButtonText: "No",
    })
    .then((result) => {
      if (result.value) {
        $.post(
          "../../controller/compra.php?op=eliminardetalle",
          { detc_id: detc_id },
          function (data) {
            console.log(data);
          }
        );

        $.post(
          "../../controller/compra.php?op=calculo",
          { compr_id: compr_id },
          function (data) {
            data = JSON.parse(data);
            $("#txtsubtotal").html(data.compr_subtotal);
            $("#txtigv").html(data.compr_igv);
            $("#txttotal").html(data.compr_total);
          }
        );

        listar(compr_id);

        swal.fire({
          title: "Compra",
          text: "Registro Eliminado",
          icon: "success",
        });
      }
    });
}

function listar(compr_id) {
  $("#table_data").DataTable({
    aProcessing: true,
    aServerSide: true,
    dom: "Bfrtip",
    buttons: ["copyHtml5", "excelHtml5", "csvHtml5"],
    ajax: {
      url: "../../controller/compra.php?op=listardetalle",
      type: "post",
      data: { compr_id: compr_id },
    },
    bDestroy: true,
    responsive: true,
    bInfo: true,
    iDisplayLength: 10,
    order: [[0, "desc"]],
    language: {
      sProcessing: "Procesando...",
      sLengthMenu: "Mostrar _MENU_ registros",
      sZeroRecords: "No se encontraron resultados",
      sEmptyTable: "Ningún dato disponible en esta tabla",
      sInfo:
        "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
      sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
      sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
      sInfoPostFix: "",
      sSearch: "Buscar:",
      sUrl: "",
      sInfoThousands: ",",
      sLoadingRecords: "Cargando...",
      oPaginate: {
        sFirst: "Primero",
        sLast: "Último",
        sNext: "Siguiente",
        sPrevious: "Anterior",
      },
      oAria: {
        sSortAscending:
          ": Activar para ordenar la columna de manera ascendente",
        sSortDescending:
          ": Activar para ordenar la columna de manera descendente",
      },
    },
  });
}

$(document).on("click", "#btnguardar", function () {
  var compr_id = $("#compr_id").val();
  var pag_id = $("#pag_id").val();
  var prov_id = $("#prov_id").val();
  var prov_ruc = $("#prov_ruc").val();
  var prov_direcc = $("#prov_direcc").val();
  var prov_correo = $("#prov_correo").val();
  var compr_coment = $("#compr_coment").val();
  var mon_id = $("#mon_id").val();

  if (
    $("#pag_id").val() == "0" ||
    $("#prov_id").val() == "0" ||
    $("#mon_id").val() == "0"
  ) {
    /* TODO:Validacion de Pago , Proveedor , Moneda */
    swal.fire({
      title: "Compra",
      text: "Error Campos Vacios",
      icon: "error",
    });
  } else {
    $.post(
      "../../controller/compra.php?op=calculo",
      { compr_id: compr_id },
      function (data) {
        data = JSON.parse(data);
        console.log(data);
        if (data.compr_total == null) {
          /* TODO:Validacion de Detalle */
          swal.fire({
            title: "Compra",
            text: "Error No Existe Detalle",
            icon: "error",
          });
        } else {
          $.post(
            "../../controller/compra.php?op=guardar",
            {
              compr_id: compr_id,
              pag_id: pag_id,
              prov_id: prov_id,
              prov_ruc: prov_ruc,
              prov_direcc: prov_direcc,
              prov_correo: prov_correo,
              compr_coment: compr_coment,
              mon_id: mon_id,
            },
            function (data) {
              swal.fire({
                title: "Compra",
                text: "Compra registrada Correctamente con Nro: C-" + compr_id,
                icon: "success",
                footer:
                  "<a href='../ViewCompra/?c=" +
                  compr_id +
                  "' target='_blank'>Desea ver el Documento?</a>",
              });
            }
          );
        }
      }
    );
  }
});

$(document).on("click", "#btnlimpiar", function () {
  location.reload();
});
