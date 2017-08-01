# ---------------------------------------------------------------------- #
# Script generated with: DeZign for Databases V8.1.0                     #
# Target DBMS:           MySQL 5                                         #
# Project file:          minJIRA.dez                                     #
# Project name:                                                          #
# Author:                                                                #
# Script type:           Database creation script                        #
# Created on:            2017-08-01 07:35                                #
# ---------------------------------------------------------------------- #


# ---------------------------------------------------------------------- #
# Add tables                                                             #
# ---------------------------------------------------------------------- #

# ---------------------------------------------------------------------- #
# Add table "estado_proyecto"                                            #
# ---------------------------------------------------------------------- #

CREATE TABLE `estado_proyecto` (
    `ESTADOPROYECTO_ID` VARCHAR(3) NOT NULL,
    `DESCRIPCION` VARCHAR(40),
    CONSTRAINT `PK_estado_proyecto` PRIMARY KEY (`ESTADOPROYECTO_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "estado_tarea"                                               #
# ---------------------------------------------------------------------- #

CREATE TABLE `estado_tarea` (
    `ESTADOTAREA_ID` VARCHAR(5) NOT NULL,
    `DESCRIPCION` VARCHAR(40),
    CONSTRAINT `PK_estado_tarea` PRIMARY KEY (`ESTADOTAREA_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "prioridad"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE `prioridad` (
    `PRIORIDAD_ID` VARCHAR(5) NOT NULL,
    `DESCRIPCION` VARCHAR(40),
    CONSTRAINT `PK_prioridad` PRIMARY KEY (`PRIORIDAD_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "categoria"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE `categoria` (
    `CATEGORIA_ID` VARCHAR(10) NOT NULL,
    `DESCRIPCION` VARCHAR(40),
    CONSTRAINT `PK_categoria` PRIMARY KEY (`CATEGORIA_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "estado_usuario"                                             #
# ---------------------------------------------------------------------- #

CREATE TABLE `estado_usuario` (
    `ESTADO_USUARIO_ID` VARCHAR(3) NOT NULL,
    `DESCRIPCION` VARCHAR(40),
    CONSTRAINT `PK_estado_usuario` PRIMARY KEY (`ESTADO_USUARIO_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "tipotareadet"                                               #
# ---------------------------------------------------------------------- #

CREATE TABLE `tipotareadet` (
    `TIPOTAREADET_ID` VARCHAR(5) NOT NULL,
    `DESCRIPCION` VARCHAR(40),
    CONSTRAINT `PK_tipotareadet` PRIMARY KEY (`TIPOTAREADET_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "usuario"                                                    #
# ---------------------------------------------------------------------- #

CREATE TABLE `usuario` (
    `USER_ID` INTEGER NOT NULL AUTO_INCREMENT,
    `NOMBRE` VARCHAR(40),
    `LOGIN` VARCHAR(40),
    `PASSWORD` VARCHAR(40),
    `NIVEL` INTEGER,
    `PADRE` INTEGER,
    `EMAIL` VARCHAR(80),
    `ESTADO_USUARIO_ID` VARCHAR(3),
    CONSTRAINT `PK_usuario` PRIMARY KEY (`USER_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "proyecto"                                                   #
# ---------------------------------------------------------------------- #

CREATE TABLE `proyecto` (
    `PROYECTO_ID` INTEGER NOT NULL AUTO_INCREMENT,
    `NOMBRE` VARCHAR(40),
    `ESTADOPROYECTO_ID` VARCHAR(3),
    CONSTRAINT `PK_proyecto` PRIMARY KEY (`PROYECTO_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "modulo"                                                     #
# ---------------------------------------------------------------------- #

CREATE TABLE `modulo` (
    `MODULO_ID` INTEGER NOT NULL AUTO_INCREMENT,
    `NOMBRE` VARCHAR(40),
    `PROYECTO_ID` INTEGER,
    CONSTRAINT `PK_modulo` PRIMARY KEY (`MODULO_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "tarea"                                                      #
# ---------------------------------------------------------------------- #

CREATE TABLE `tarea` (
    `TAREA_ID` INTEGER NOT NULL AUTO_INCREMENT,
    `PROYECTO_ID` INTEGER NOT NULL,
    `MODULO_ID` INTEGER,
    `SOLICITANTE` INTEGER NOT NULL,
    `ESTADOTAREA_ID` VARCHAR(5) NOT NULL DEFAULT 'OPEN',
    `TITULO` VARCHAR(40),
    `DESCRIPCION` VARCHAR(200),
    `FECHA` DATE,
    `FECHAHORA` DATETIME,
    `RESPONSABLE` INTEGER NOT NULL,
    `PRIORIDAD_ID` VARCHAR(5) NOT NULL,
    `CATEGORIA_ID` VARCHAR(10) NOT NULL,
    `ADJUNTO` VARCHAR(100),
    `PORCENTAJE` INTEGER DEFAULT 0,
    `PADRE` INTEGER DEFAULT 0,
    CONSTRAINT `PK_tarea` PRIMARY KEY (`TAREA_ID`)
);

# ---------------------------------------------------------------------- #
# Add table "tarea_det"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE `tarea_det` (
    `TAREADET_ID` INTEGER NOT NULL AUTO_INCREMENT,
    `DESCRIPCION` VARCHAR(40),
    `FECHA` VARCHAR(40),
    `FECHAHORA` VARCHAR(40),
    `TAREA_ID` INTEGER,
    `TIPOTAREADET_ID` VARCHAR(5) NOT NULL,
    `HORAS` INTEGER,
    `USER_ID` INTEGER,
    CONSTRAINT `PK_tarea_det` PRIMARY KEY (`TAREADET_ID`)
);

# ---------------------------------------------------------------------- #
# Add foreign key constraints                                            #
# ---------------------------------------------------------------------- #

ALTER TABLE `usuario` ADD CONSTRAINT `estado_usuario_usuario` 
    FOREIGN KEY (`ESTADO_USUARIO_ID`) REFERENCES `estado_usuario` (`ESTADO_USUARIO_ID`);

ALTER TABLE `proyecto` ADD CONSTRAINT `estado_proyecto_proyecto` 
    FOREIGN KEY (`ESTADOPROYECTO_ID`) REFERENCES `estado_proyecto` (`ESTADOPROYECTO_ID`);

ALTER TABLE `modulo` ADD CONSTRAINT `proyecto_modulo` 
    FOREIGN KEY (`PROYECTO_ID`) REFERENCES `proyecto` (`PROYECTO_ID`);

ALTER TABLE `tarea` ADD CONSTRAINT `prioridad_tarea` 
    FOREIGN KEY (`PRIORIDAD_ID`) REFERENCES `prioridad` (`PRIORIDAD_ID`);

ALTER TABLE `tarea` ADD CONSTRAINT `estado_tarea_tarea` 
    FOREIGN KEY (`ESTADOTAREA_ID`) REFERENCES `estado_tarea` (`ESTADOTAREA_ID`);

ALTER TABLE `tarea` ADD CONSTRAINT `categoria_tarea` 
    FOREIGN KEY (`CATEGORIA_ID`) REFERENCES `categoria` (`CATEGORIA_ID`);

ALTER TABLE `tarea` ADD CONSTRAINT `proyecto_tarea` 
    FOREIGN KEY (`PROYECTO_ID`) REFERENCES `proyecto` (`PROYECTO_ID`);

ALTER TABLE `tarea` ADD CONSTRAINT `usuario_tarea` 
    FOREIGN KEY (`SOLICITANTE`) REFERENCES `usuario` (`USER_ID`);

ALTER TABLE `tarea` ADD CONSTRAINT `modulo_tarea` 
    FOREIGN KEY (`MODULO_ID`) REFERENCES `modulo` (`MODULO_ID`);

ALTER TABLE `tarea_det` ADD CONSTRAINT `tipotareadet_tarea_det` 
    FOREIGN KEY (`TIPOTAREADET_ID`) REFERENCES `tipotareadet` (`TIPOTAREADET_ID`);

ALTER TABLE `tarea_det` ADD CONSTRAINT `usuario_tarea_det` 
    FOREIGN KEY (`USER_ID`) REFERENCES `usuario` (`USER_ID`);

ALTER TABLE `tarea_det` ADD CONSTRAINT `tarea_tarea_det` 
    FOREIGN KEY (`TAREA_ID`) REFERENCES `tarea` (`TAREA_ID`);
