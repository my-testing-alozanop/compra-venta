<?php
    class Compania extends Conectar{
        /* TODO: Listar Registros */
        public function get_compania(){
            $conectar=parent::Conexion();
            $sql="call sp_l_compania_01";
            $query=$conectar->prepare($sql);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }

        /* TODO: Listar Registro por ID en especifico */
        public function get_compania_x_com_id($com_id){
            $conectar=parent::Conexion();
            $sql="call sp_l_compania_02 (?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$com_id);
            $query->execute();
            return $query->fetchAll(PDO::FETCH_ASSOC);
        }

        /* TODO: Eliminar o cambiar estado a eliminado */
        public function delete_compania($com_id){
            $conectar=parent::Conexion();
            $sql="call sp_d_compania_01 (?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$com_id);
            $query->execute();
        }

        /* TODO: Registro de datos */
        public function insert_compania($com_nom){
            $conectar=parent::Conexion();
            $sql="call sp_i_compania_01 (?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$com_nom);
            $query->execute();
        }

        /* TODO:Actualizar Datos */
        public function update_compania($com_id,$com_nom){
            $conectar=parent::Conexion();
            $sql="call sp_u_compania_01 (?,?)";
            $query=$conectar->prepare($sql);
            $query->bindValue(1,$com_id);
            $query->bindValue(2,$com_nom);
            $query->execute();
        }
    }
?>