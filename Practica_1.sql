//1.-Se crea las tablas de abajo
CREATE TABLE locaciones(
  id_locacion NUMBER PRIMARY KEY,
  calle VARCHAR2(100),
  cp VARCHAR2(100),
  municipio VARCHAR2(100),
  estado VARCHAR2(100),
  pais VARCHAR2(100),
  region VARCHAR2(100),
  CONSTRAINT fk_pais FOREIGN KEY (pais) REFERENCES paises(nombre_pais),
  CONSTRAINT fk_region FOREIGN KEY (region) REFERENCES regiones(nombre_region)
);

CREATE TABLE regiones (
  nombre_region VARCHAR2(100) NOT NULL,
  codigo_region VARCHAR2(100) NOT NULL,
  CONSTRAINT pk_regiones PRIMARY KEY (nombre_region) --esto es asi, no con codigo region
);

CREATE TABLE paises (
  nombre_pais VARCHAR2(100) NOT NULL,
  codigo_pais VARCHAR2(100) NOT NULL,
  CONSTRAINT pk_pais PRIMARY KEY(nombre_pais) 
);

CREATE TABLE puestos (
  codigo_puesto VARCHAR2(100),
  nombre_puesto VARCHAR2(100),
  CONSTRAINT pk_codigo_puesto PRIMARY KEY(nombre_puesto)--MODIFICACION
);

--2.-Creamos esta tabla, sin referencia a empleados, despues alteramos
CREATE TABLE departamentos (
  id_departamento NUMBER PRIMARY KEY,
  nombre_Departamento VARCHAR2(100),
  codigo_Departamento VARCHAR2(100),
  locacion NUMBER,
  manager NUMBER, --DEBE SER CAMBIADO A varchar2
  CONSTRAINT fk_departamentos_locaciones FOREIGN KEY (locacion) REFERENCES locaciones(id_locacion)
);

--3.-Esta tabla es la penultima en crearse
CREATE TABLE empleados (
  id_empleado NUMBER,
  nombre_empleado VARCHAR2(100) NOT NULL,
  apellidos_empleado VARCHAR2(100) NOT NULL,
  fecha_nacimiento DATE,
  fecha_contratacion DATE NOT NULL,
  edad NUMBER,
  sueldo NUMBER(10,2) NOT NULL,
  comision NUMBER(10,2),
  departamentos NUMBER,
  puesto VARCHAR2(100),
  gerente NUMBER,
  CONSTRAINT pk_empleados PRIMARY KEY (id_empleado),
  CONSTRAINT fk_empleados_departamentos FOREIGN KEY (departamentos) REFERENCES departamentos(id_departamento),
  CONSTRAINT fk_empleados_puestos FOREIGN KEY (puesto) REFERENCES puestos(nombre_puesto),
  CONSTRAINT fk_empleados_gerente FOREIGN KEY (gerente) REFERENCES empleados(id_empleado)
);

--4.-Creamos peniltimo la talabla empleados para poder añadir el identificador y alteramos departamento
ALTER TABLE departamentos
ADD CONSTRAINT fk_departamentos_manager FOREIGN KEY (manager) REFERENCES empleados(id_empleado);

--5.-Altero tabla, para poder solamente asignar lo valores pedidos en nombre_departamento y codigo_departamento
--ALTER TABLE departamentos
    --ADD CONSTRAINT chk_nombre_departamento CHECK (nombre_departamento IN ('Sistemas', 'RRHH'));

--6.-Altero tabla, para poder solamente asignar lo valores pedidos en nombre_departamento y codigo_departamento
--ALTER TABLE departamentos
    --ADD CONSTRAINT chk_codigo_departamento CHECK (codigo_departamento IN ('TI', 'RH'));


//1.-Insertamos valores para regiones
INSERT INTO regiones (nombre_region, codigo_region)
VALUES ('Norte', 'R001');

INSERT INTO regiones (nombre_region, codigo_region)
VALUES ('Sur', 'R002');

INSERT INTO regiones (nombre_region, codigo_region)
VALUES ('Este', 'R003');

INSERT INTO regiones (nombre_region, codigo_region)
VALUES ('Oeste', 'R004');

SELECT * FROM regiones;

--2.-Insertamo valores para Paises
INSERT INTO paises (nombre_pais, codigo_pais) 
    VALUES ('México', 'MEX');
INSERT INTO paises (nombre_pais, codigo_pais) 
    VALUES ('Guatemala', 'GUA');
    
SELECT * FROM paises;

--3.-Insertar 10 locaciones
INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (1, 'Av. Reforma', '06100', 'Ciudad de México', 'Ciudad de México', 'México', 'Norte');

INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (2, 'Av. Universidad', '04510', 'Coyoacán', 'Ciudad de México', 'México', 'Oeste');

INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (3, 'Calle 16 de Septiembre', '50070', 'Toluca', 'Estado de México', 'México', 'Norte');

INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (4, 'Paseo de la Reforma', '06600', 'Juárez', 'Ciudad de México', 'México', 'Oeste');

INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (5, 'Calle 5 de Mayo', '72000', 'Puebla', 'Puebla', 'México', 'Oeste');

INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (6, 'Calle Francisco I. Madero', '44100', 'Guadalajara', 'Jalisco', 'México', 'Norte');

INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (7, 'Av. Vallarta', '44110', 'Guadalajara', 'Jalisco', 'México', 'Sur');

INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (8, 'Av. Constituyentes', '58260', 'Morelia', 'Michoacán', 'México', 'Norte');

INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (9, 'Calle de la Ciudadela', '06040', 'Ciudad de México', 'Ciudad de México', 'México', 'Este');

INSERT INTO locaciones (id_locacion, calle, cp, municipio, estado, pais, region)
VALUES (10, 'Av. Paseo de la Reforma', '06600', 'Juárez', 'Ciudad de México', 'México', 'Sur');

SELECT * FROM locaciones;

--4.-Insertamos valores puesto
INSERT INTO puestos(codigo_puesto,nombre_puesto)
    VALUES(1,'Gerente');

INSERT INTO puestos(codigo_puesto,nombre_puesto)
    VALUES(2,'Analista');
    
INSERT INTO puestos(codigo_puesto,nombre_puesto)
    VALUES(3,'Desarrollador');

SELECT * FROM puestos;

--6.-Ingreamos valores para departamento, debemos ingresar 2, ante de ingresar los gerente(manager) y despues lo agregamos para poder asignar
--nombre_departamento: 'Sistemas', 'RRHH'
--codigo_departamento: 'TI', 'RH'
INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (1,'Sistemas','RH',NULL,2);

INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (2,'RRHH','RH',1,NULL);

INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (3,'Sistemas','RH',3,1);
    
INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (4,'RRHH','RH',5,2);
    
INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (5,'Sistemas','RH',6,NULL);
    
INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (6,'RRHH','RH',2,2);
    
INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (7,'Sistemas','RH',7,NULL);
    
INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (8,'RRHH','RH',9,NULL);
    
INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (9,'Sistemas','RH',10,1);
    
INSERT INTO departamentos (id_departamento, nombre_Departamento, codigo_Departamento, locacion, manager)
    VALUES (10,'Sistemas','RH',NULL,1);

SELECT * FROM departamentos;

//5.-Insertamos valores empleados, pero el departamento debe tener valores
//Debemos terne los manager, para poder crear en departamento
INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (1, 'María', 'López Hernández','06/06/1990','03/01/2012',33, 60000.00, 0.05, 1, 'Gerente', NULL);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (2, 'Laura', 'Ramírez García', '15/12/2002','12/09/2021',21, 80000.00, 0.10, 2, 'Gerente', NULL);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
    VALUES (3, 'Juan', 'García Pérez', '01-01-1990', '01-01-2020', 31, 50000.00, NULL, NULL, 'Analista', NULL);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (4, 'Pedro', 'Martínez Gómez','01/02/2000','08/05/2023',23, 40000.00, 0.02, 2, 'Desarrollador', 2);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (5, 'Carlos', 'Sánchez González', '04/01/2002','08/05/2023',23, 45000.00, 0.01, 3, 'Desarrollador', 1);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (6, 'Ana', 'Pérez Rodríguez', '25/08/1990','13/05/2009',23, 55000.00, NULL, 3, 'Desarrollador', 2);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (7, 'Daniel', 'Hernández Martínez', '17/11/2000','12/12/2022',21, 48000.00, NULL, 4, 'Analista', 2);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (8, 'Elena', 'Gómez Torres', '21/01/1995','09/11/2011',28, 60000.00, 0.05, 1, 'Desarrollador', NULL);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (9, 'Isabela', 'López Lopez', '17/11/2000','12/12/2022',22, 60000.00, 0.05, 1, 'Analista', NULL);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (10, 'Pedro', 'Gomez Gamas', '06/05/1988','05/05/2006',21, 40000.00, 0.02, 2, 'Analista', 2);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (11, 'Martha', 'Chile González', '04/01/2002','08/05/2022',22, 45000.00, 0.01, 3, 'Desarrollador', 1);

INSERT INTO empleados (id_empleado, nombre_empleado, apellidos_empleado, fecha_nacimiento, fecha_contratacion, edad, sueldo, comision, departamentos, puesto, gerente)
VALUES (12, 'Lolu', 'Parca Rodríguez', '25/08/1992','13/05/2009',22, 55000.00, NULL, 3, 'Desarrollador', 2);

SELECT * FROM empleados;











