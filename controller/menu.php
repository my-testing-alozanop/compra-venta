<?php
    /* TODO: Llamando Clases */
    require_once("../config/conexion.php");
    require_once("../models/Menu.php");
    /* TODO: Inicializando clase */
    $menu = new Menu();

    switch($_GET["op"]){

        /* TODO: Listado de registros formato JSON para Datatable JS */
        case "listar":
            $datos=$menu->get_menu_x_rol_id($_POST["rol_id"]);
            $data=Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["men_nom"];
                if ($row["mend_permi"]=="Si"){
                    $sub_array[] = '<button type="button"  onClick="deshabilitar('.$row["mend_id"].')" id="'.$row["mend_id"].'" class="btn btn-success btn-label btn-sm"><i class="ri-check-double-line label-icon align-middle fs-16 me-2"></i>'.$row["mend_permi"].'</button>';
                }else{
                    $sub_array[] = '<button type="button" onClick="habilitar('.$row["mend_id"].')" id="'.$row["mend_id"].'" class="btn btn-danger btn-label btn-sm"><i class="ri-close-circle-line label-icon align-middle fs-16 me-2"></i> '.$row["mend_permi"].'</button>';
                }
                $data[] = $sub_array;
            }

            $results = array(
                "sEcho"=>1,
                "iTotalRecords"=>count($data),
                "iTotalDisplayRecords"=>count($data),
                "aaData"=>$data);
            echo json_encode($results);
            break;

        case "habilitar":
            $menu->update_menu_habilitar($_POST["mend_id"]);
            break;

        case "deshabilitar":
            $menu->update_menu_deshabilitar($_POST["mend_id"]);
            break;

    }
?>