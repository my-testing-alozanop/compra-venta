<?php
    class Usuario extends Conectar{
        /* TODO: Listar Registros */
        public function get_usuario_x_suc_id($suc_id){
            $conectar=parent::Conexion();
            $sql="call sp_l_usuario_01 (?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$suc_id);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }

        /* TODO: Listar Registro por ID en especifico */
        public function get_usuario_x_usu_id($usu_id){
            $conectar=parent::Conexion();
            $sql="call sp_l_usuario_02 (?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$usu_id);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }

        /* TODO: Eliminar o cambiar estado a eliminado */
        public function delete_usuario($usu_id){
            $conectar=parent::Conexion();
            $sql="call sp_d_usuario_01 (?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$usu_id);
            $query->execute();
        }

        /* TODO: Registro de datos */
        public function insert_usuario($suc_id,$usu_correo,$usu_nom,$usu_ape,$usu_dni,$usu_telf,$usu_pass,$rol_id){
            $conectar=parent::Conexion();
            $sql="call sp_i_usuario_01 (?,?,?,?,?,?,?,?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$suc_id);
            $query->bindValue(2,$usu_correo);
            $query->bindValue(3,$usu_nom);
            $query->bindValue(4,$usu_ape);
            $query->bindValue(5,$usu_dni);
            $query->bindValue(6,$usu_telf);
            $query->bindValue(7,$usu_pass);
            $query->bindValue(8,$rol_id);
            $query->execute();
        }

        /* TODO:Actualizar Datos */
        public function update_usuario($usu_id,$suc_id,$usu_correo,$usu_nom,$usu_ape,$usu_dni,$usu_telf,$usu_pass,$rol_id){
            $conectar=parent::Conexion();
            $sql="call sp_u_usuario_01 (?,?,?,?,?,?,?,?,?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$usu_id);
            $query->bindValue(2,$suc_id);
            $query->bindValue(3,$usu_correo);
            $query->bindValue(4,$usu_nom);
            $query->bindValue(5,$usu_ape);
            $query->bindValue(6,$usu_dni);
            $query->bindValue(7,$usu_telf);
            $query->bindValue(8,$usu_pass);
            $query->bindValue(9,$rol_id);
            $query->execute();
        }

        public function update_usuario_pass($usu_id,$usu_pass){
            $conectar=parent::Conexion();
            $sql="call sp_u_usuario_02 (?,?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$usu_id);
            $query->bindValue(2,$usu_pass);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }

        /* TODO:Acceso al Sistema */
        public function login(){
            $conectar=parent::Conexion();
            if (isset($_POST["enviar"])){
                $sucursal = $_POST["suc_id"];
                $correo = $_POST["usu_correo"];
                $pass =  $_POST["usu_pass"];
                if (empty($sucursal) and empty($correo) and empty($pass)){
                    exit();
                }else{
                    $sql="call sp_l_usuario_04 (?,?,?)";
                    $query=$conectar->prepare($sql);
                    $query->bindValue(1,$sucursal);
                    $query->bindValue(2,$correo);
                    $query->bindValue(3,$pass);
                    $query->execute();
                    $resultado = $query->fetch();
                    if (is_array($resultado) and count($resultado)>0){
                        /* TODO:Generar variables de Session del Usuario */
                        $_SESSION["usu_id"]=$resultado["usu_id"];
                        $_SESSION["usu_nom"]=$resultado["usu_nom"];
                        $_SESSION["usu_ape"]=$resultado["usu_ape"];
                        $_SESSION["usu_correo"]=$resultado["usu_correo"];
                        $_SESSION["suc_id"]=$resultado["suc_id"];
                        $_SESSION["com_id"]=$resultado["com_id"];
                        $_SESSION["emp_id"]=$resultado["emp_id"];
                        $_SESSION["rol_id"]=$resultado["rol_id"];

                        header("Location:".Conectar::ruta()."view/home/");
                    }else{
                        exit();
                    }
                }
            }else{
                exit();
            }
        }
    }
?>