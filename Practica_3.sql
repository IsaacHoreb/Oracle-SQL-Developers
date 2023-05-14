--Realizar una consulta que extraiga el promedio de salario por departamento
--ROUND para solo 2 digitos
SELECT d.nombre_departamento,ROUND(AVG(e.sueldo),2) AS promedio_salario
    FROM empleados e
    JOIN departamentos d ON e.departamentos = d.id_departamento
GROUP BY d.nombre_departamento;

--Realizar una consulta que extraiga el promedio de salario por zona por locación
SELECT locaciones.region, locaciones.id_locacion, ROUND(AVG(empleados.sueldo), 2) AS promedio_salario
    FROM empleados JOIN departamentos ON empleados.departamentos = departamentos.id_departamento
    JOIN locaciones ON departamentos.locacion = locaciones.id_locacion
GROUP BY locaciones.region, locaciones.id_locacion;

--Realizar una consulta que muestre el conteo de empleados por departamento, se deberá incluir departamentos incluso si no tiene empleados.
SELECT d.nombre_departamento, COUNT(e.id_empleado) AS conteo_empleados
    FROM departamentos d
    LEFT OUTER JOIN empleados e ON d.id_departamento = e.departamentos
GROUP BY d.nombre_departamento;

--Realizar una consulta que muestre el conteo de empleados por gerente.
SELECT (m.nombre_empleado || ' ' || m.apellidos_empleado) AS gerente, COUNT(e.id_empleado) AS conteo_empleados
    FROM empleados e LEFT JOIN empleados m ON e.gerente = m.id_empleado
GROUP BY m.nombre_empleado, m.apellidos_empleado;

--Realizar una consulta que extraiga el salario mínimo y máximo por departamento.
SELECT d.nombre_departamento, MIN(e.sueldo) AS salario_minimo, MAX(e.sueldo) AS salario_maximo
    FROM empleados e INNER JOIN departamentos d ON e.departamentos = d.id_departamento
GROUP BY d.nombre_departamento;

--Realizar una consulta que extraiga los departamentos donde la suma total de los salarios de sus empleados sea mayor a 5000
SELECT d.nombre_departamento, SUM(e.sueldo) AS salario_total
    FROM empleados e INNER JOIN departamentos d ON e.departamentos = d.id_departamento
    GROUP BY d.nombre_departamento
HAVING SUM(e.sueldo) > 5000;

--Realizar una consulta que muestre la suma total de comisiones por periodo (MM-YY)
--(Periodo inicia con la fecha de contratación).
SELECT TO_CHAR(e.fecha_contratacion, 'MM-YY') AS periodo_fecha_contratacion, SUM(e.comision) AS total_comisiones
    FROM empleados e
GROUP BY TO_CHAR(e.fecha_contratacion, 'MM-YY');

SELECT * FROM DEPARTAMENTOS;
SELECT * FROM EMPLEADOS;
