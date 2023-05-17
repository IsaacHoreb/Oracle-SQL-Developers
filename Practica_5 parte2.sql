DECLARE
  v_nombre_departamento VARCHAR2(100);
  v_codigo_departamento VARCHAR2(100);
  v_direccion VARCHAR2(100);
  v_pais VARCHAR2(100);
  v_region VARCHAR2(100);
  v_locacion_id NUMBER;
  v_departamento_id NUMBER;
BEGIN
  -- Pedir los datos necesarios al usuario
  v_nombre_departamento := '&v_nombre_departamento';
  v_codigo_departamento := '&v_codigo_departamento';
  v_direccion := '&v_direccion';
  v_pais := '&v_pais';
  v_region := '&v_region';
  
  BEGIN
    -- Verificar si el país ya existe en la tabla de paises
    SELECT nombre_pais INTO v_pais
    FROM paises
    WHERE nombre_pais = v_pais;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- El país no existe, se creará un nuevo registro en la tabla de paises
      INSERT INTO paises (nombre_pais, codigo_pais)
      VALUES (v_pais, '&v_codigo_pais');
      COMMIT;
  END;
  
  BEGIN
    -- Verificar si la región ya existe en la tabla de regiones
    SELECT nombre_region INTO v_region
    FROM regiones
    WHERE nombre_region = v_region;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- La región no existe, se creará un nuevo registro en la tabla de regiones
      INSERT INTO regiones (nombre_region, codigo_region)
      VALUES (v_region, '&v_codigo_region');
      COMMIT;
  END;
  
  BEGIN
    -- Verificar si la locación ya existe en la tabla de locaciones
    SELECT id_locacion INTO v_locacion_id
    FROM locaciones
    WHERE calle = v_direccion;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- La locación no existe, se creará un nuevo registro en la tabla de locaciones
      INSERT INTO locaciones (id_locacion, calle)
      VALUES (ID_AUTOINCR_LOCAC.NEXTVAL, v_direccion);
      v_locacion_id := ID_AUTOINCR_LOCAC.CURRVAL;
      COMMIT;
  END;
  
  BEGIN
    -- Verificar si el departamento ya existe en la tabla de departamentos
    SELECT id_departamento INTO v_departamento_id
    FROM departamentos
    WHERE nombre_departamento = v_nombre_departamento;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- El departamento no existe, se creará un nuevo registro en la tabla de departamentos
      INSERT INTO departamentos (id_departamento, nombre_departamento, codigo_departamento, locacion)
      VALUES (ID_AUTOINCR_DEPART.NEXTVAL, v_nombre_departamento, v_codigo_departamento, v_locacion_id);
      COMMIT; --ACORDAR QUE ES PARA CONFIRMAR Y GUARDAR TODOS LOS DATOS
  END;
  
  DBMS_OUTPUT.PUT_LINE('Departamento creado exitosamente.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;