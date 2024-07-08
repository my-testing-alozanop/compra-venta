var suc_id = $("#suc_idx").val();

function init() {
  $("#mantenimiento_form").on("submit", function (e) {
    guardaryeditar(e);
  });
}

function guardaryeditar(e) {
  e.preventDefault();
  var formData = new FormData($("#mantenimiento_form")[0]);
  formData.append("suc_id", $("#suc_idx").val());
  $.ajax({
    url: "../../controller/producto.php?op=guardaryeditar",
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function (data) {
      $("#table_data").DataTable().ajax.reload();
      $("#modalmantenimiento").modal("hide");

      swal.fire({
        title: "Producto",
        text: "Registro Confirmado",
        icon: "success",
      });
    },
  });
}

$(document).ready(function () {
  $.post(
    "../../controller/categoria.php?op=combo",
    { suc_id: suc_id },
    function (data) {
      $("#cat_id").html(data);
    }
  );

  $.post(
    "../../controller/unidad.php?op=combo",
    { suc_id: suc_id },
    function (data) {
      $("#und_id").html(data);
    }
  );

  $.post(
    "../../controller/moneda.php?op=combo",
    { suc_id: suc_id },
    function (data) {
      $("#mon_id").html(data);
    }
  );

  $("#table_data").DataTable({
    aProcessing: true,
    aServerSide: true,
    dom: "Bfrtip",
    buttons: ["copyHtml5", "excelHtml5", "csvHtml5"],
    ajax: {
      url: "../../controller/producto.php?op=listar",
      type: "post",
      data: { suc_id: suc_id },
    },
    bDestroy: true,
    responsive: true,
    bInfo: true,
    iDisplayLength: 20,
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
});

function editar(prod_id) {
  $.post(
    "../../controller/producto.php?op=mostrar",
    { prod_id: prod_id },
    function (data) {
      data = JSON.parse(data);
      $("#prod_id").val(data.prod_id);
      $("#prod_nom").val(data.prod_nom);
      $("#prod_descrip").val(data.prod_descrip);
      $("#prod_pcompra").val(data.prod_pcompra);
      $("#prod_pventa").val(data.prod_pventa);
      $("#prod_stock").val(data.prod_stock);
      $("#cat_id").val(data.cat_id).trigger("change");
      $("#und_id").val(data.und_id).trigger("change");
      $("#mon_id").val(data.mon_id).trigger("change");
    }
  );
  $("#lbltitulo").html("Editar Registro");
  $("#modalmantenimiento").modal("show");
}

function eliminar(prod_id) {
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
          "../../controller/producto.php?op=eliminar",
          { prod_id: prod_id },
          function (data) {
            console.log(data);
          }
        );

        $("#table_data").DataTable().ajax.reload();

        swal.fire({
          title: "Producto",
          text: "Registro Eliminado",
          icon: "success",
        });
      }
    });
}

$(document).on("click", "#btnnuevo", function () {
  $("#prod_id").val("");
  $("#prod_nom").val("");
  $("#prod_descrip").val("");
  $("#prod_pcompra").val("");
  $("#prod_pventa").val("");
  $("#prod_stock").val("");
  $("#cat_id").val("").trigger("change");
  $("#und_id").val("").trigger("change");
  $("#mon_id").val("").trigger("change");
  $("#lbltitulo").html("Nuevo Registro");
  $("#mantenimiento_form")[0].reset();
  $("#modalmantenimiento").modal("show");
});

init();
