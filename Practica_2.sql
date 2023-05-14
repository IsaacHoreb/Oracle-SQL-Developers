--1RA PARTE

--creacion del SEQUENCE para EPLEADOS
CREATE SEQUENCE ID_AUTOINCR
START WITH 900000
INCREMENT BY 1;

--creacion del SEQUENCE para DEPARTAMENTOS
CREATE SEQUENCE ID_AUTOINCR_DEPART
START WITH 900000
INCREMENT BY 1;

--creacion del SEQUENCE para LOCACIONES
CREATE SEQUENCE ID_AUTOINCR_LOCAC
START WITH 900000
INCREMENT BY 1;

--Mostrar donde estamos PARA PROBRAR EL SEQUENCE
--SELECT ID_AUTOINCR.NEXTVAL FROM DUAL;

--ALTERAR LAS TABLAS EMPLEADOS PARA ASIGNAR TELEFONO
ALTER TABLE empleados
ADD (telefono_emp varchar2(100));

--ALTERAR LAS TABLAS EMPLEADOS PARA ASIGNAR NUESTROS AUDITORIA
ALTER TABLE empleados
ADD (fecha_creacion DATE,
     usuario_creacion VARCHAR2(100));

--ALTERAR LAS TABLAS DEPARTAMETOS PARA ASIGNAR NUESTROS AUDITORIA
ALTER TABLE departamentos
ADD (fecha_creacion DATE,
     usuario_creacion VARCHAR2(100));

--ALTERAR LAS TABLAS LOCACIONES PARA ASIGNAR NUESTROS AUDITORIA
ALTER TABLE locaciones
ADD (fecha_creacion DATE,
     usuario_creacion VARCHAR2(100));

--ALTERAR LAS TABLAS paises PARA ASIGNAR NUESTROS AUDITORIA
ALTER TABLE paises
ADD (fecha_creacion DATE,
     usuario_creacion VARCHAR2(100));

--ALTERAR LAS TABLAS PUESTOS PARA ASIGNAR NUESTROS AUDITORIA
ALTER TABLE puestos
ADD (fecha_creacion DATE,
     usuario_creacion VARCHAR2(100));

--ALTERAR LAS TABLAS REGIONES PARA ASIGNAR NUESTROS AUDITORIA
ALTER TABLE regiones
ADD (fecha_creacion DATE,
     usuario_creacion VARCHAR2(100));

--Creacion del Trigger before para empleados
CREATE OR REPLACE TRIGGER empleados_insert
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
  SELECT ID_AUTOINCR.NEXTVAL INTO :new.ID_EMPLEADO FROM dual; --asignar el valor id cn el sequence
  :new.fecha_creacion := SYSDATE; --fecha o formato
  :new.usuario_creacion := USER; --Usuario que interactua
END;

--Creacion del Trigger before para departamentos
CREATE OR REPLACE TRIGGER departamento_insert
BEFORE INSERT ON departamentos
FOR EACH ROW
BEGIN
  SELECT ID_AUTOINCR_DEPART.NEXTVAL INTO :new.ID_DEPARTAMENTO FROM dual; --asignar el valor id cn el sequence
  :new.fecha_creacion := SYSDATE; --fecha o formato
  :new.usuario_creacion := USER; --Usuario que interactua
END;

--Creacion del Trigger before para locaciones
CREATE OR REPLACE TRIGGER locaciones_insert
BEFORE INSERT ON locaciones
FOR EACH ROW
BEGIN
  SELECT ID_AUTOINCR_LOCAC.NEXTVAL INTO :new.ID_LOCACION FROM dual; --asignar el valor id cn el sequence
  :new.fecha_creacion := SYSDATE; --fecha o formato
  :new.usuario_creacion := USER; --Usuario que interactua
END;

--Trigger para cada tabla que se activará cuando se actualice un registro en ella. 
--#Pero antes, tengo que agregar a la tabla para la update quien actualizó

--PARA EMPLEADOS
ALTER TABLE empleados
ADD (fecha_actualizacion DATE,
     usuario_actualizacion VARCHAR2(100));
     
SELECT * FROM EMPLEADOS;

--PARA DEPARTAMENTOS
ALTER TABLE departamentos
ADD (fecha_actualizacion DATE,
     usuario_actualizacion VARCHAR2(100));
     
SELECT * FROM DEPARTAMENTOS;

--PARA LOCACIONES
ALTER TABLE locaciones
ADD (fecha_actualizacion DATE,
     usuario_actualizacion VARCHAR2(100));
     
SELECT * FROM LOCACIONES;

--PARA PAISES
ALTER TABLE paises
ADD (fecha_actualizacion DATE,
     usuario_actualizacion VARCHAR2(100));
     
SELECT * FROM PAISES;

--PARA PUESTOS
ALTER TABLE puestos
ADD (fecha_actualizacion DATE,
     usuario_actualizacion VARCHAR2(100));
     
SELECT * FROM PUESTOS;

--PARA DEPARTAMENTOS
ALTER TABLE regiones
ADD (fecha_actualizacion DATE,
     usuario_actualizacion VARCHAR2(100));
     
SELECT * FROM REGIONES;

--Trigger para cada tabla que se activará cuando se actualice un registro en ella.
--EMPLEADOS
CREATE OR REPLACE TRIGGER update_empa
BEFORE UPDATE ON EMPLEADOS
FOR EACH ROW
BEGIN
  :new.fecha_actualizacion := SYSDATE;
  :new.usuario_actualizacion := USER;
END;

--DEPARTAMENTOS
CREATE OR REPLACE TRIGGER update_depa
BEFORE UPDATE ON DEPARTAMENTOS
FOR EACH ROW
BEGIN
  :new.fecha_actualizacion := SYSDATE;
  :new.usuario_actualizacion := USER;
END;

--LOCACIONES
CREATE OR REPLACE TRIGGER update_locac
BEFORE UPDATE ON LOCACIONES
FOR EACH ROW
BEGIN
  :new.fecha_actualizacion := SYSDATE;
  :new.usuario_actualizacion := USER;
END;

--PASIES
CREATE OR REPLACE TRIGGER update_paises
BEFORE UPDATE ON PAISES
FOR EACH ROW
BEGIN
  :new.fecha_actualizacion := SYSDATE;
  :new.usuario_actualizacion := USER;
END;

--PUESTOS
CREATE OR REPLACE TRIGGER update_puestos
BEFORE UPDATE ON PUESTOS
FOR EACH ROW
BEGIN
  :new.fecha_actualizacion := SYSDATE;
  :new.usuario_actualizacion := USER;
END;

--REGIONES
CREATE OR REPLACE TRIGGER update_regiones
BEFORE UPDATE ON REGIONES
FOR EACH ROW
BEGIN
  :new.fecha_actualizacion := SYSDATE;
  :new.usuario_actualizacion := USER;
END;

--2DA PARTE
/*
    1.-Realizar una consulta donde se muestre los datos de empleado, mostrar nombre completo en mayúsculas, concatenado el nombre y apellido. 
    2.-Mostrar la fecha con formato días a dos dígitos, mes a tres letras del mes, año dos dígitos separados por diagonales. 
    3.-Mostrar el teléfono separado por puntos, encerrado entre paréntesis. 
    4.-Mostrar el sueldo del empleado formato moneda, separador de miles, dos dígitos decimales. 
    5.-Mostrar el total de comisión, recordar que en comisión es un porcentaje, entonces se deberá calcular en base al sueldo. 
    6.-Mostrar el nombre del gerente, primera letra de apellido y nombre en mayúsculas, el resto en minúscula.
    
    #FUNCIONAMIENTO POR SEPARADO#
        --1
        SELECT UPPER(nombre_empleado || ' ' || apellidos_empleado) AS "NOMBRE COMPLETO" FROM empleados;
        --2
        SELECT TO_CHAR(fecha_contratacion, 'DD MON YY', 'NLS_DATE_LANGUAGE = SPANISH') AS "FECHA CONTRATACION" FROM empleados;
        --3
        SELECT '(' || SUBSTR(telefono_emp,1,3) || ') ' || SUBSTR(telefono_emp,4,3) || '.' || SUBSTR(telefono_emp,7,4) AS "TELEFONO" from empleados;
        --4
        SELECT TO_CHAR(sueldo, '$999,999.99') AS "SUELDO" FROM EMPLEADOS;
        --5
        SELECT TO_CHAR(sueldo * NVL(comision,0) / 100, '$999,999.99') AS "TOTAL COMISION" FROM EMPLEADOS;
        --6
        SELECT INITCAP(SUBSTR(G.apellidos_empleado,1,1) || LOWER(SUBSTR(G.apellidos_empleado,2)) || ' ' || SUBSTR(G.nombre_empleado,1,1) || LOWER(SUBSTR(G.nombre_empleado,2))) AS "Nombre del Gerente"
        FROM empleados E, empleados G
        WHERE E.gerente = G.id_empleado;
*/

--TODO FUNCIONANDO EN CONJUNTO
SELECT 
  UPPER(E.nombre_empleado || ' ' || E.apellidos_empleado) AS "NOMBRE COMPLETO",
  TO_CHAR(E.fecha_contratacion, 'DD MON YY', 'NLS_DATE_LANGUAGE = SPANISH') AS "FECHA CONTRATACION",
  '(' || SUBSTR(E.telefono_emp,1,3) || ') ' || SUBSTR(E.telefono_emp,4,3) || '.' || SUBSTR(E.telefono_emp,7,4) AS "TELEFONO",
  TO_CHAR(E.sueldo, '$999,999.99') AS "SUELDO",
  TO_CHAR(E.sueldo * NVL(E.comision,0) / 100, '$999,999.99') AS "TOTAL COMISION",
  INITCAP(SUBSTR(G.apellidos_empleado,1,1) || LOWER(SUBSTR(G.apellidos_empleado,2)) || ' ' || SUBSTR(G.nombre_empleado,1,1) || LOWER(SUBSTR(G.nombre_empleado,2))) AS "Nombre del Gerente"
FROM empleados E, empleados G
WHERE E.gerente = G.id_empleado;


/*
    1.-Realizar una consulta donde se muestre el nombre completo del empleado 
    2.-Nombre del manager
    3.-Nombre del Departamento, pero solo aquellos que tienen un manager asignado
    
    1.-
    SELECT e.nombre_empleado || ' ' || e.apellidos_empleado AS nombre_completo FROM EMPLEADOS e;
    --2
    SELECT (SELECT nombre_empleado FROM empleados WHERE id_empleado = e.gerente) AS nombre_gerente FROM empleados e
        WHERE e.gerente IS NOT NULL;
    --3
    SELECT (SELECT nombre_departamento FROM departamentos WHERE id_departamento = e.departamentos) AS nombre_departamento
        FROM empleados e
            WHERE e.gerente IS NOT NULL;
*/

--TODO FUNCIONANDO EN CONJUNTO
SELECT e.nombre_empleado || ' ' || e.apellidos_empleado AS nombre_completo,
       (SELECT nombre_empleado FROM empleados WHERE id_empleado = e.gerente) AS nombre_gerente,
       (SELECT nombre_departamento FROM departamentos WHERE id_departamento = e.departamentos) AS nombre_departamento
FROM empleados e
WHERE e.gerente IS NOT NULL;

SELECT * FROM EMPLEADOS;

    