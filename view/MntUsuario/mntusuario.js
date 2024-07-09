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
    url: "../../controller/usuario.php?op=guardaryeditar",
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function (data) {
      $("#table_data").DataTable().ajax.reload();
      $("#modalmantenimiento").modal("hide");

      swal.fire({
        title: "Usuario",
        text: "Registro Confirmado",
        icon: "success",
      });
    },
  });
}

$(document).ready(function () {
  $.post(
    "../../controller/rol.php?op=combo",
    { suc_id: suc_id },
    function (data) {
      $("#rol_id").html(data);
    }
  );

  $("#table_data").DataTable({
    aProcessing: true,
    aServerSide: true,
    dom: "Bfrtip",
    buttons: ["copyHtml5", "excelHtml5", "csvHtml5"],
    ajax: {
      url: "../../controller/usuario.php?op=listar",
      type: "post",
      data: { suc_id: suc_id },
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
});

function editar(usu_id) {
  $.post(
    "../../controller/usuario.php?op=mostrar",
    { usu_id: usu_id },
    function (data) {
      data = JSON.parse(data);
      $("#usu_id").val(data.usu_id);
      $("#usu_correo").val(data.usu_correo);
      $("#usu_nom").val(data.usu_nom);
      $("#usu_ape").val(data.usu_ape);
      $("#usu_dni").val(data.usu_dni);
      $("#usu_telf").val(data.usu_telf);
      $("#usu_pass").val(data.usu_pass);
      $("#rol_id").val(data.rol_id).trigger("change");
    }
  );
  $("#lbltitulo").html("Editar Registro");
  $("#modalmantenimiento").modal("show");
}

function eliminar(usu_id) {
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
          "../../controller/usuario.php?op=eliminar",
          { usu_id: usu_id },
          function (data) {
            console.log(data);
          }
        );

        $("#table_data").DataTable().ajax.reload();

        swal.fire({
          title: "Usuario",
          text: "Registro Eliminado",
          icon: "success",
        });
      }
    });
}

$(document).on("click", "#btnnuevo", function () {
  $("#usu_id").val("");
  $("#usu_nom").val("");
  $("#lbltitulo").html("Nuevo Registro");
  $("#mantenimiento_form")[0].reset();
  $("#modalmantenimiento").modal("show");
});

init();
