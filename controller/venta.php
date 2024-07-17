<?php
    /* TODO: Llamando Clases */
    require_once("../config/conexion.php");
    require_once("../models/Venta.php");
    /* TODO: Inicializando clase */
    $venta = new Venta();

    switch($_GET["op"]){

        case "registrar":
            $datos=$venta->insert_venta_x_suc_id($_POST["suc_id"],$_POST["usu_id"]);
            foreach($datos as $row){
                $output["vent_id"] = $row["vent_id"];
            }
            echo json_encode($output);
            break;

        case "guardardetalle":
            $datos=$venta->insert_venta_detalle($_POST["vent_id"],$_POST["prod_id"],$_POST["prod_pventa"],$_POST["detv_cant"]);
            break;

        case "calculo":
            $datos=$venta->get_venta_calculo($_POST["vent_id"]);
            foreach($datos as $row){
                $output["vent_subtotal"] = $row["vent_subtotal"];
                $output["vent_igv"] = $row["vent_igv"];
                $output["vent_total"] = $row["vent_total"];
            }
            echo json_encode($output);
            break;

        case "eliminardetalle":
            $venta->delete_venta_detalle($_POST["detv_id"]);
            break;

        case "listardetalle":
            $datos=$venta->get_venta_detalle($_POST["vent_id"]);
            $data=Array();
            foreach($datos as $row){
                $sub_array = array();
                if ($row["prod_img"] != ''){
                    $sub_array[] =
                    "<div class='d-flex align-items-center'>" .
                        "<div class='flex-shrink-0 me-2'>".
                            "<img src='../../assets/producto/".$row["PROD_IMG"]."' alt='' class='avatar-xs rounded-circle'>".
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
                $sub_array[] = $row["prod_pventa"];
                $sub_array[] = $row["detv_cant"];
                $sub_array[] = $row["detv_total"];
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["detv_id"].','.$row["vent_id"].')" id="'.$row["detv_id"].'" class="btn btn-danger btn-icon waves-effect waves-light"><i class="ri-delete-bin-5-line"></i></button>';
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
            $datos=$venta->get_venta_detalle($_POST["vent_id"]);
            foreach($datos as $row){
                ?>
                     <tr>
                        <td>
                            <?php 
                                if ($row["prod_img"] != ''){
                                    ?>
                                        <?php
                                            echo "<div class='d-flex align-items-center'>" .
                                                    "<div class='flex-shrink-0 me-2'>".
                                                        "<img src='../../assets/producto/".$row["prod_img"]."' alt='' class='avatar-xs rounded-circle'>".
                                                    "</div>".
                                                "</div>";
                                        ?>
                                    <?php
                                }else{
                                    ?>
                                        <?php 
                                            echo "<div class='d-flex align-items-center'>" .
                                                    "<div class='flex-shrink-0 me-2'>".
                                                        "<img src='../../assets/producto/no_imagen.png' alt='' class='avatar-xs rounded-circle'>".
                                                    "</div>".
                                                "</div>";
                                        ?>
                                    <?php
                                }
                            ?>
                        </td>
                        <td><?php echo $row["cat_nom"];?></td>
                        <td><?php echo $row["prod_nom"];?></td>
                        <td scope="row"><?php echo $row["und_nom"];?></td>
                        <td><?php echo $row["prod_pventa"];?></td>
                        <td><?php echo $row["detv_cant"];?></td>
                        <td class="text-end"><?php echo $row["detv_total"];?></td>
                    </tr>
                <?php
            }
            break;

        case "guardar":
            $datos=$venta->update_venta(
                $_POST["vent_id"],
                $_POST["pag_id"],
                $_POST["cli_id"],
                $_POST["cli_ruc"],
                $_POST["cli_direcc"],
                $_POST["cli_correo"],
                $_POST["vent_coment"],
                $_POST["mon_id"],
                $_POST["doc_id"]
            );
            break;

        case "mostrar":
            $datos=$venta->get_venta($_POST["vent_id"]);
            foreach($datos as $row){
                $output["vent_id"] = $row["vent_id"];
                $output["suc_id"] = $row["suc_id"];
                $output["pag_id"] = $row["pag_id"];
                $output["pag_nom"] = $row["pag_nom"];
                $output["cli_id"] = $row["cli_id"];
                $output["cli_ruc"] = $row["cli_ruc"];
                $output["cli_direcc"] = $row["cli_direcc"];
                $output["cli_correo"] = $row["cli_correo"];
                $output["vent_subtotal"] = $row["vent_subtotal"];
                $output["vent_igv"] = $row["vent_igv"];
                $output["vent_total"] = $row["vent_total"];
                $output["vent_coment"] = $row["vent_coment"];
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
                $output["cli_nom"] = $row["cli_nom"];
            }
            echo json_encode($output);
            break;

        case "listarventa":
            $datos=$venta->get_venta_listado($_POST["suc_id"]);
            $data=Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = "V-".$row["vent_id"];
                $sub_array[] = $row["cli_ruc"];
                $sub_array[] = $row["cli_nom"];
                $sub_array[] = $row["pag_nom"];
                $sub_array[] = $row["mon_nom"];
                $sub_array[] = $row["vent_subtotal"];
                $sub_array[] = $row["vent_igv"];
                $sub_array[] = $row["vent_total"];
                $sub_array[] = $row["usu_nom"]." ".$row["usu_ape"];
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
                $sub_array[] = '<a href="../ViewVenta/?v='.$row["vent_id"].'" target="_blank" class="btn btn-primary btn-icon waves-effect waves-light"><i class="ri-printer-line"></i></a>';
                $sub_array[] = '<button type="button" onClick="ver('.$row["vent_id"].')" id="'.$row["vent_id"].'" class="btn btn-success btn-icon waves-effect waves-light"><i class="ri-settings-2-line"></i></button>';
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