<?php
    /* TODO: Llamando Clases */
    require_once("../config/conexion.php");
    require_once("../models/Usuario.php");
    /* TODO: Inicializando clase */
    $usuario = new Usuario();

    switch($_GET["op"]){
        /* TODO: Guardar y editar, guardar cuando el ID este vacio, y Actualizar cuando se envie el ID */
        case "guardaryeditar":
            if(empty($_POST["usu_id"])){
                $usuario->insert_usuario(
                    $_POST["suc_id"],
                    $_POST["usu_correo"],
                    $_POST["usu_nom"],
                    $_POST["usu_ape"],
                    $_POST["usu_dni"],
                    $_POST["usu_telf"],
                    $_POST["usu_pass"],
                    $_POST["rol_id"],
                    $_POST["usu_img"]
                );
            }else{
                $usuario->update_usuario(
                    $_POST["usu_id"],
                    $_POST["suc_id"],
                    $_POST["usu_correo"],
                    $_POST["usu_nom"],
                    $_POST["usu_ape"],
                    $_POST["usu_dni"],
                    $_POST["usu_telf"],
                    $_POST["usu_pass"],
                   $_POST["rol_id"],
                    $_POST["usu_img"]
                );
            }
            break;

        /* TODO: Listado de registros formato JSON para Datatable JS */
        case "listar":
            $datos=$usuario->get_usuario_x_suc_id($_POST["suc_id"]);
            $data=Array();
            foreach($datos as $row){
                $sub_array = array();

                 if ($row["usu_img"] != ''){
                    $sub_array[] =
                    "<div class='d-flex align-items-center'>" .
                        "<div class='flex-shrink-0 me-2'>".
                            "<img src='../../assets/usuario/".$row["usu_img"]."' alt='' class='avatar-xs rounded-circle'>".
                        "</div>".
                    "</div>";
                }else{
                    $sub_array[] =
                    "<div class='d-flex align-items-center'>" .
                        "<div class='flex-shrink-0 me-2'>".
                            "<img src='../../assets/usuario/no_imagen.png' alt='' class='avatar-xs rounded-circle'>".
                        "</div>".
                    "</div>";
                }
                $sub_array[] = $row["usu_correo"];
                $sub_array[] = $row["usu_nom"];
                $sub_array[] = $row["usu_ape"];
                $sub_array[] = $row["usu_dni"];
                $sub_array[] = $row["usu_telf"];
                $sub_array[] = $row["usu_pass"];
                $sub_array[] = $row["rol_nom"];
                $sub_array[] = $row["fech_crea"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["usu_id"].')" id="'.$row["usu_id"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["usu_id"].')" id="'.$row["usu_id"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
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
            $datos=$usuario->get_usuario_x_usu_id($_POST["usu_id"]);
            if (is_array($datos)==true and count($datos)>0){
                foreach($datos as $row){
                    $output["usu_id"] = $row["usu_id"];
                    $output["suc_id"] = $row["suc_id"];
                    $output["usu_nom"] = $row["usu_nom"];
                    $output["usu_ape"] = $row["usu_ape"];
                    $output["usu_correo"] = $row["usu_correo"];
                    $output["usu_dni"] = $row["usu_dni"];
                    $output["usu_telf"] = $row["usu_telf"];
                    $output["usu_pass"] = $row["usu_pass"];
                    $output["rol_id"] = $row["rol_id"];
                    if($row["usu_img"] != ''){
                        $output["usu_img"] = '<img src="../../assets/usuario/'.$row["usu_img"].'" class="rounded-circle avatar-xl img-thumbnail user-profile-image" alt="user-profile-image"></img><input type="hidden" name="hidden_usuario_imagen" value="'.$row["usu_img"].'" />';
                    }else{
                        $output["usu_img"] = '<img src="../../assets/usuario/no_imagen.png" class="rounded-circle avatar-xl img-thumbnail user-profile-image" alt="user-profile-image"></img><input type="hidden" name="hidden_usuario_imagen" value="" />';
                    }
                }
                echo json_encode($output);
            }
            break;

        /* TODO: Cambiar Estado a 0 del Registro */
        case "eliminar";
            $usuario->delete_usuario($_POST["usu_id"]);
            break;

        case "actualizar";
            $usuario->update_usuario_pass($_POST["usu_id"],$_POST["usu_pass"]);
            break;

    }
?>