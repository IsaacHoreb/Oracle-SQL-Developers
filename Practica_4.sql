SET SERVEROUTPUT ON

DECLARE
  -- Declarar variables
  v_sueldo NUMBER := &sueldo;
  v_comision NUMBER := &comision;
  v_fecha_actual VARCHAR2(50);
  
  -- Declarar cursor
  CURSOR cur_empleados_comision IS
    SELECT 
      UPPER(E.nombre_empleado || ' ' || E.apellidos_empleado) AS nombre_completo,
      TO_CHAR(E.fecha_contratacion, 'DD MON YY', 'NLS_DATE_LANGUAGE = SPANISH') AS fecha_contratacion,
      '(' || SUBSTR(E.telefono_emp,1,3) || ') ' || SUBSTR(E.telefono_emp,4,3) || '.' || SUBSTR(E.telefono_emp,7,4) AS telefono,
      TO_CHAR(E.sueldo, '$999,999.99') AS sueldo,
      TO_CHAR(E.sueldo * NVL(E.comision,0) / 100, '$999,999.99') AS total_comision,
      INITCAP(SUBSTR(G.apellidos_empleado,1,1) || LOWER(SUBSTR(G.apellidos_empleado,2)) || ' ' || SUBSTR(G.nombre_empleado,1,1) || LOWER(SUBSTR(G.nombre_empleado,2))) AS nombre_gerente
    FROM empleados E, empleados G
    WHERE E.gerente = G.id_empleado AND E.sueldo > v_sueldo AND NVL(E.comision, 0) > v_comision;

BEGIN
  -- Obtener fecha actual
  SELECT TO_CHAR(SYSDATE, 'DD MON YYYY HH24:MI:SS', 'NLS_DATE_LANGUAGE = SPANISH') INTO v_fecha_actual FROM DUAL;
  
  -- Imprimir resultados de cur_empleados_comision
  DBMS_OUTPUT.PUT_LINE('Reporte de empleados con sueldo mayor a ' || TO_CHAR(v_sueldo, '$999,999.99') || ' y comisión mayor a ' || TO_CHAR(v_comision, '999,999.99'));
  DBMS_OUTPUT.PUT_LINE('Fecha de ejecución: ' || v_fecha_actual);
  DBMS_OUTPUT.PUT_LINE('==================================================================================================================================');
  DBMS_OUTPUT.PUT_LINE('NOMBRE COMPLETO                                                 FECHA CONTRATACION  TELÉFONO            SUELDO            TOTAL COMISION      NOMBRE DEL GERENTE');
  DBMS_OUTPUT.PUT_LINE('==================================================================================================================================');
  
  FOR emp IN cur_empleados_comision LOOP
    DBMS_OUTPUT.PUT_LINE(LPAD(emp.nombre_completo, 64, ' ') || 
                         RPAD(emp.fecha_contratacion, 20, ' ') || 
                         LPAD(emp.telefono, 21, ' ') || 
                         RPAD(emp.sueldo, 20, ' ') || 
                         RPAD(emp.total_comision, 22, ' ') || 
                         LPAD(emp.nombre_gerente, 32, ' '));
  END LOOP;
END;

--2do bloque

SET SERVEROUTPUT ON

DECLARE
  v_departamento VARCHAR2(50) := '&ingresar_departamento';
  
  -- Cursor para empleados con gerente y departamento especificados
  CURSOR cur_empleados_dep IS
    SELECT 
      UPPER(E.nombre_empleado || ' ' || E.apellidos_empleado) AS "NOMBRE COMPLETO",
      INITCAP(SUBSTR(G.apellidos_empleado,1,1) || LOWER(SUBSTR(G.apellidos_empleado,2)) || ' ' || SUBSTR(G.nombre_empleado,1,1) || LOWER(SUBSTR(G.nombre_empleado,2))) AS "NOMBRE DEL GERENTE",
      D.nombre_departamento AS "DEPARTAMENTO"
    FROM empleados E, empleados G, departamentos D
    WHERE E.gerente = G.id_empleado AND E.departamentos = D.id_departamento AND D.nombre_departamento = v_departamento;

BEGIN
  -- Imprimir resultados de cur_empleados_dep
  DBMS_OUTPUT.PUT_LINE('Empleados del departamento "' || v_departamento || '"');
  DBMS_OUTPUT.PUT_LINE('Fecha y hora de ejecución: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
  DBMS_OUTPUT.PUT_LINE('====================================================================');
  DBMS_OUTPUT.PUT_LINE(LPAD('NOMBRE COMPLETO', 64, ' ') || 
                       LPAD('NOMBRE DEL GERENTE', 64, ' ') || 
                       LPAD('DEPARTAMENTO', 16, ' '));
  DBMS_OUTPUT.PUT_LINE('====================================================================');
  FOR emp IN cur_empleados_dep LOOP
    DBMS_OUTPUT.PUT_LINE(LPAD(emp."NOMBRE COMPLETO", 64, ' ') || 
                         LPAD(emp."NOMBRE DEL GERENTE", 64, ' ') || 
                         RPAD(emp."DEPARTAMENTO", 16, ' '));
  END LOOP;
END;





