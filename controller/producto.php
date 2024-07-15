<?php
    /* TODO: Llamando Clases */
    require_once("../config/conexion.php");
    require_once("../models/Producto.php");
    /* TODO: Inicializando clase */
    $producto = new Producto();

    switch($_GET["op"]){
        /* TODO: Guardar y editar, guardar cuando el ID este vacio, y Actualizar cuando se envie el ID */
        case "guardaryeditar":
            if(empty($_POST["prod_id"])){
                $producto->insert_producto(
                    $_POST["suc_id"],
                    $_POST["cat_id"],
                    $_POST["prod_nom"],
                    $_POST["prod_descrip"],
                    $_POST["und_id"],
                    $_POST["mon_id"],
                    $_POST["prod_pcompra"],
                    $_POST["prod_pventa"],
                    $_POST["prod_stock"],
                    $_POST["prod_fechaven"],
                    $_POST["prod_img"]
                );
            }else{
                $producto->update_producto(
                    $_POST["prod_id"],
                    $_POST["suc_id"],
                    $_POST["cat_id"],
                    $_POST["prod_nom"],
                    $_POST["prod_descrip"],
                    $_POST["und_id"],
                    $_POST["mon_id"],
                    $_POST["prod_pcompra"],
                    $_POST["prod_pventa"],
                    $_POST["prod_stock"],
                    $_POST["prod_fechaven"],
                    $_POST["prod_img"]
                );
            }
            break;

        /* TODO: Listado de registros formato JSON para Datatable JS */
        case "listar":
            $datos=$producto->get_producto_x_suc_id($_POST["suc_id"]);
            $data=Array();
            foreach($datos as $row){
                $sub_array = array();

                if ($row["prod_img"] != ''){
                    $sub_array[] =
                    "<div class='d-flex align-items-center'>" .
                        "<div class='flex-shrink-0 me-2'>".
                            "<img src='../../assets/producto/".$row["prod_img"]."' alt='' class='avatar-xs rounded-circle'>".
                        "</div>".
                    "</div>";
                }else{
                    $sub_array[] =
                    "<div class='d-flex align-items-center'>" .
                        "<div class='flex-shrink-0 me-2'>".
                            "<img src='../../assets/producto/no_imagen.png' alt='' class='avatar-xs rounded-circle'>".
                        "</div>".
                    "</div>";
                }

                $sub_array[] = $row["cat_nom"];
                $sub_array[] = $row["prod_nom"];
                $sub_array[] = $row["und_nom"];
                $sub_array[] = $row["mon_nom"];
                $sub_array[] = $row["prod_pcompra"];
                $sub_array[] = $row["prod_pventa"];
                $sub_array[] = $row["prod_stock"];
                $sub_array[] = $row["fech_crea"];
                $sub_array[] = '<button type="button" onClick="editar('.$row["prod_id"].')" id="'.$row["prod_id"].'" class="btn btn-warning btn-icon waves-effect waves-light"><i class="ri-edit-2-line"></i></button>';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["prod_id"].')" id="'.$row["prod_id"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
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
            $datos=$producto->get_producto_x_prod_id($_POST["prod_id"]);
            if (is_array($datos)==true and count($datos)>0){
                foreach($datos as $row){
                    $output["prod_id"] = $row["prod_id"];
                    $output["cat_id"] = $row["cat_id"];
                    $output["und_id"] = $row["und_id"];
                    $output["und_nom"] = $row["und_nom"];
                    $output["mon_id"] = $row["mon_id"];
                    $output["prod_nom"] = $row["prod_nom"];
                    $output["prod_descrip"] = $row["prod_descrip"];
                    $output["prod_pcompra"] = $row["prod_pcompra"];
                    $output["prod_pventa"] = $row["prod_pventa"];
                    $output["prod_stock"] = $row["prod_stock"];
                    $output["fech_crea"] = $row["fech_crea"];
                    if($row["prod_img"] != ''){
                        $output["prod_img"] = '<img src="../../assets/producto/'.$row["prod_img"].'" class="rounded-circle avatar-xl img-thumbnail user-profile-image" alt="user-profile-image"></img><input type="hidden" name="hidden_producto_imagen" value="'.$row["prod_img"].'" />';
                    }else{
                        $output["prod_img"] = '<img src="../../assets/producto/no_imagen.png" class="rounded-circle avatar-xl img-thumbnail user-profile-image" alt="user-profile-image"></img><input type="hidden" name="hidden_producto_imagen" value="" />';
                    }
                    
                }
                echo json_encode($output);
            }
            break;

        /* TODO: Cambiar Estado a 0 del Registro */
        case "eliminar";
            $producto->delete_producto($_POST["prod_id"]);
            break;

        case "combo";
            $datos=$producto->get_producto_x_cat_id($_POST["cat_id"]);
            if(is_array($datos)==true and count($datos)>0){
                $html="";
                $html.="<option selected>Seleccionar</option>";
                foreach($datos as $row){
                    $html.= "<option value='".$row["prod_id"]."'>".$row["prod_nom"]."</option>";
                }
                echo $html;
            }
            break;

    }
?>