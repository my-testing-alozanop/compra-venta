<?php
    /* TODO: Llamando Clases */
    require_once("../config/conexion.php");
    require_once("../models/Moneda.php");
    /* TODO: Inicializando clase */
    $moneda = new Moneda();

    switch($_GET["op"]){
        /* TODO: Guardar y editar, guardar cuando el ID este vacio, y Actualizar cuando se envie el ID */
        case "guardaryeditar":
            if(empty($_POST["mon_id"])){
                $moneda->insert_moneda($_POST["suc_id"],$_POST["mon_nom"]);
            }else{
                $moneda->update_moneda($_POST["mon_id"],$_POST["suc_id"],$_POST["mon_nom"]);
            }
            break;

        /* TODO: Listado de registros formato JSON para Datatable JS */
        case "listar":
            $datos=$moneda->get_moneda_x_suc_id($_POST["suc_id"]);
            $data=Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["mon_nom"];
                $sub_array[] = $row["fech_crea"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["mon_id"].')" id="'.$row["mon_id"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["mon_id"].')" id="'.$row["mon_id"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
                $data[] = $sub_array;
            }

            $results = array(
                "sEcho"=>1,
                "iTotalRecords"=>count($data),
                "iTotalDisplayRecords"=>count($data),
                "aaData"=>$data);
            echo json_encode($results);
            break;

        /* TODO:Mostrar informacion de registro segun su ID */
        case "mostrar":
            $datos=$moneda->get_moneda_x_mon_id($_POST["mon_id"]);
            if (is_array($datos)==true and count($datos)>0){
                foreach($datos as $row){
                    $output["mon_id"] = $row["mon_id"];
                    $output["suc_id"] = $row["suc_id"];
                    $output["mon_nom"] = $row["mon_nom"];
                }
                echo json_encode($output);
            }
            break;

        /* TODO: Cambiar Estado a 0 del Registro */
        case "eliminar";
            $moneda->delete_moneda($_POST["mon_id"]);
            break;

            /* TODO: Listar Combo */
        case "combo";
            $datos=$moneda->get_moneda_x_suc_id($_POST["suc_id"]);
            if(is_array($datos)==true and count($datos)>0){
                $html="";
                $html.="<option value='0' selected>Seleccionar</option>";
                foreach($datos as $row){
                    $html.= "<option value='".$row["mon_id"]."'>".$row["mon_nom"]."</option>";
                }
                echo $html;
            }
            break;
    }
?>