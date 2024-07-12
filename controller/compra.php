<?php
    /* TODO: Llamando Clases */
    require_once("../config/conexion.php");
    require_once("../models/Compra.php");
    /* TODO: Inicializando clase */
    $compra = new Compra();

    switch($_GET["op"]){

        case "registrar":
            $datos=$compra->insert_compra_x_suc_id($_POST["suc_id"],$_POST["usu_id"]);
            foreach($datos as $row){
                $output["compr_id"] = $row["compr_id"];
            }
            echo json_encode($output);
            break;

        case "guardardetalle":
            $datos=$compra->insert_compra_detalle($_POST["compr_id"],$_POST["prod_id"],$_POST["prod_pcompra"],$_POST["detc_cant"]);
            break;

        case "calculo":
            $datos=$compra->get_compra_calculo($_POST["compr_id"]);
            foreach($datos as $row){
                $output["compr_subtotal"] = $row["compr_subtotal"];
                $output["compr_igv"] = $row["compr_igv"];
                $output["compr_total"] = $row["compr_total"];
            }
            echo json_encode($output);
            break;

        case "eliminardetalle":
            $compra->delete_compra_detalle($_POST["detc_id"]);
            break;

        case "listardetalle":
            $datos=$compra->get_compra_detalle($_POST["compr_id"]);
            $data=Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = $row["cat_nom"];
                $sub_array[] = $row["prod_nom"];
                $sub_array[] = $row["und_nom"];
                $sub_array[] = $row["prod_pcompra"];
                $sub_array[] = $row["detc_cant"];
                $sub_array[] = $row["detc_total"];
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["detc_id"].','.$row["compr_id"].')" id="'.$row["detc_id"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
                $data[] = $sub_array;
            }

            $results = array(
                "sEcho"=>1,
                "iTotalRecords"=>count($data),
                "iTotalDisplayRecords"=>count($data),
                "aaData"=>$data);
            echo json_encode($results);
            break;

        case "listardetalleformato";
            $datos=$compra->get_compra_detalle($_POST["compr_id"]);
            foreach($datos as $row){
                ?>
                     <tr>
                        <th><?php echo $row["cat_nom"];?></th>
                        <td><?php echo $row["prod_nom"];?></td>
                        <td scope="row"><?php echo $row["und_nom"];?></td>
                        <td><?php echo $row["prod_pcompra"];?></td>
                        <td><?php echo $row["detc_cant"];?></td>
                        <td class="text-end"><?php echo $row["detc_total"];?></td>
                    </tr>
                <?php
            }
            break;

        case "guardar":
            $datos=$compra->update_compra(
                $_POST["compr_id"],
                $_POST["pag_id"],
                $_POST["prov_id"],
                $_POST["prov_ruc"],
                $_POST["prov_direcc"],
                $_POST["prov_correo"],
                $_POST["compr_coment"],
                $_POST["mon_id"]
            );
            break;

        case "mostrar":
            $datos=$compra->get_compra($_POST["compr_id"]);
            foreach($datos as $row){
                $output["compr_id"] = $row["compr_id"];
                $output["suc_id"] = $row["suc_id"];
                $output["pag_id"] = $row["pag_id"];
                $output["pag_nom"] = $row["pag_nom"];
                $output["prov_id"] = $row["prov_id"];
                $output["prov_ruc"] = $row["prov_ruc"];
                $output["prov_direcc"] = $row["prov_direcc"];
                $output["prov_correo"] = $row["prov_correo"];
                $output["compr_subtotal"] = $row["compr_subtotal"];
                $output["compr_igv"] = $row["compr_igv"];
                $output["compr_total"] = $row["compr_total"];
                $output["compr_coment"] = $row["compr_coment"];
                $output["usu_id"] = $row["usu_id"];
                $output["usu_nom"] = $row["usu_nom"];
                $output["usu_ape"] = $row["usu_ape"];
                $output["usu_correo"] = $row["usu_correo"];
                $output["mon_id"] = $row["mon_id"];
                $output["mon_nom"] = $row["mon_nom"];
                $output["fech_crea"] = $row["fech_crea"];
                $output["suc_nom"] = $row["suc_nom"];
                $output["emp_nom"] = $row["emp_nom"];
                $output["emp_ruc"] = $row["emp_ruc"];
                $output["emp_correo"] = $row["emp_correo"];
                $output["emp_telf"] = $row["emp_telf"];
                $output["emp_direcc"] = $row["emp_direcc"];
                $output["emp_pag"] = $row["emp_pag"];
                $output["com_nom"] = $row["com_nom"];
                $output["prov_nom"] = $row["prov_nom"];
            }
            echo json_encode($output);
            break;

        case "listarcompra":
            $datos=$compra->get_compra_listado($_POST["suc_id"]);
            $data=Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = "C-".$row["compr_id"];
                $sub_array[] = $row["prov_ruc"];
                $sub_array[] = $row["prov_nom"];
                $sub_array[] = $row["pag_nom"];
                $sub_array[] = $row["mon_nom"];
                $sub_array[] = $row["compr_subtotal"];
                $sub_array[] = $row["compr_igv"];
                $sub_array[] = $row["compr_total"];
                $sub_array[] = $row["usu_nom"]." ".$row["usu_ape"];
                $sub_array[] = '<a href="../ViewCompra/?c='.$row["compr_id"].'" target="_blank" class="btn btn-primary btn-icon waves-effect waves-light"><i class="ri-printer-line"></i></a>';
                $sub_array[] = '<button type="button" onClick="ver('.$row["compr_id"].')" id="'.$row["compr_id"].'" class="btn btn-success btn-icon waves-effect waves-light"><i class="ri-settings-2-line"></i></button>';
                $data[] = $sub_array;
            }

            $results = array(
                "sEcho"=>1,
                "iTotalRecords"=>count($data),
                "iTotalDisplayRecords"=>count($data),
                "aaData"=>$data);
            echo json_encode($results);
            break;

    }
?>