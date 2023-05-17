--Inserccion en EMPLEADOS
ALTER TABLE empleados 
    ADD CORREO_EMP VARCHAR2(100);
    
DESCRIBE EMPLEADOS;

--Ejercicio 1

DECLARE
  v_nombre_empleado VARCHAR2(100) := 'Enamor';
  v_apellido_empleado VARCHAR2(100) := 'Gour';
  v_fecha_nacimiento DATE := TO_DATE('1990-01-01', 'YYYY-MM-DD');
  v_fecha_contratacion DATE := TO_DATE('2023-01-01', 'YYYY-MM-DD');
  v_edad NUMBER := 34;
  v_sueldo NUMBER := 5000;
  v_comision NUMBER := 1.1;
  v_departamento NUMBER := 900001;
  v_puesto VARCHAR2(100) := 'Analista';
  v_gerente NUMBER := 2;
  v_telefono_emp VARCHAR2(100) := '123456789';
  v_correo_emp VARCHAR2(100) := 'alkadsd.343@example.com';
BEGIN
  -- Verificar si el empleado ya existe por su correo
  DECLARE
    v_existe_empleado NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_existe_empleado
    FROM empleados
    WHERE correo_emp = v_correo_emp;
    
    IF v_existe_empleado > 0 THEN
      DBMS_OUTPUT.PUT_LINE('El empleado con el correo ' || v_correo_emp || ' ya existe.');
      RETURN; -- Salir del bloque anónimo si el empleado ya existe
    END IF;
  END;
  
  -- Insertar el nuevo empleado
  INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion,
                         edad, sueldo, comision, departamentos, puesto, gerente, telefono_emp, correo_emp)
  VALUES (ID_AUTOINCR.NEXTVAL, v_nombre_empleado, v_apellido_empleado, v_fecha_nacimiento, v_fecha_contratacion,
          v_edad, v_sueldo, v_comision, v_departamento, v_puesto, v_gerente, v_telefono_emp, v_correo_emp);
  
  DBMS_OUTPUT.PUT_LINE('Empleado insertado correctamente.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error al insertar el empleado: ' || SQLERRM);
END;

--guardar O comfirmar los datos ingresados
COMMIT;

SELECT * FROM EMPLEADOS;
SELECT * FROM DEPARTAMENTOS;

--Un agregado normal debido a problemas que tenia
INSERT INTO empleados (nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion,edad, sueldo, comision, departamentos, puesto, gerente, telefono_emp, correo_emp)
VALUES ('John', 'Doe', TO_DATE('1990-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'),34,5000, 1.1, 900000, 'Analista', 2, '123456789', 'john.doe@example.com');

-----------------------------------------------------
INSERT INTO locaciones (calle, cp, municipio, estado, pais, region)
VALUES ('Av. Paseo de la Tuxtla', '16101', 'Juárez', 'Ciudad de México', 'México', 'Sur');

INSERT INTO locaciones (calle, cp, municipio, estado, pais, region)
VALUES ('Calle colorado init', '16199', 'Juarez', 'Ciudad de México', 'México', 'Sur');

INSERT INTO locaciones (calle, cp, municipio, estado, pais, region)
VALUES ('init', '16119', 'Toluca', 'Jalisco', 'México', 'Sur');

INSERT INTO locaciones (calle, cp, municipio, estado, pais, region)
VALUES ('Calle presh ', '99199', 'Morelia', 'Michoacán', 'México', 'Norte');

INSERT INTO locaciones (calle, cp, municipio, estado, pais, region)
VALUES ('Masapan', '66699', 'Morelia', 'Michoacán', 'México', 'Norte');

INSERT INTO locaciones (calle, cp, municipio, estado, pais, region)
VALUES ('Word', '19099', 'Morelia', 'Michoacán', 'México', 'Norte');

SELECT * FROM LOCACIONES;

----------------------------------------
INSERT INTO departamentos (nombre_departamento, codigo_departamento, locacion, manager)
VALUES ('RRHH', 'RH', 900000, 2);

INSERT INTO departamentos (nombre_departamento, codigo_departamento, locacion, manager)
VALUES ('Sistemas', 'RH', 900001, 2);

INSERT INTO departamentos (nombre_departamento, codigo_departamento, locacion, manager)
VALUES ('Sistemas', 'RH', 900002, 2);
-------------------------------------------
SELECT * FROM DEPARTAMENTOS;
DESCRIBE DEPARTAMENTOS;
DESCRIBE EMPLEADOS;
DESCRIBE LOCACIONES;
DESCRIBE PAISES;
DESCRIBE PUESTOS;
DESCRIBE REGIONES;
---------------------------------------------------------
SELECT * FROM LOCACIONES;
SELECT * FROM PAISES;
SELECT * FROM REGIONES;
SELECT * FROM DEPARTAMENTOS;
SELECT * FROM EMPLEADOS;
---------------------

--LOCACIONES
INSERT INTO locaciones (calle, cp, municipio, estado, pais, region)
VALUES ('Huia', '39039', 'Morelia', 'Michoacán', 'México', 'Norte');

--PAISES
INSERT INTO paises (nombre_pais, codigo_pais) 
    VALUES ('Bolivia', 'BOL');

--REGIONES
INSERT INTO regiones (nombre_region, codigo_region)
VALUES ('Oeste', 'R004');

INSERT INTO departamentos (nombre_departamento, codigo_departamento, locacion, manager)
VALUES ('Sistemas', 'RH', 900002, 2);
--------------------------------------------------------------------------------
















