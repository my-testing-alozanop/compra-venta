<?php
    class Menu extends Conectar{
        /* TODO: Listar Registros */
        public function get_menu_x_rol_id($rol_id){
            $conectar=parent::Conexion();
            $sql="call sp_l_menu_01 (?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$rol_id);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }

        public function update_menu_habilitar($mend_id){
            $conectar=parent::Conexion();
            $sql="call sp_u_menu_01 (?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$mend_id);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }

        public function update_menu_deshabilitar($mend_id){
            $conectar=parent::Conexion();
            $sql="call sp_u_menu_02 (?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$mend_id);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }
    }
?>