DROP TABLE ubicaciones;
DROP TABLE empleados;

CREATE TABLE ubicaciones
AS SELECT * FROM locations;

CREATE TABLE empleados
AS SELECT * FROM employees;