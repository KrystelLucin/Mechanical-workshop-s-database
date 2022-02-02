USE TallerMecanico;
-- ------------------------------------------------------------------------ --
INSERT INTO distribuidor VALUES ("123emp4567", "pepe", "0987654321");
INSERT INTO cliente VALUES ("0123456987", "Francisco Perez","Samanes", "0987456123", "fran@hotmail.com" );
INSERT INTO cliente VALUES ("0123456988", "Hernan Lopez","Samanes", "0985456123", "hlopez@hotmail.com" );
INSERT INTO vehiculo VALUES ("0123456987", "GHD2584", "Toyota", "Azul", "Camioneta");
INSERT INTO vehiculo VALUES ("0123456988", "GHD2884", "Toyota", "Azul", "Camioneta");
INSERT INTO factura VALUES (123, "2003-03-06", 0.12, 400, 448, "GHD2584", NULL);
INSERT INTO factura VALUES (125, "2003-03-06", 0.12, 400, 448, "GHD2884", NULL);
INSERT INTO empleado VALUES ("7894561230", "Erick Diaz", "Cambio Repuestos");
INSERT INTO servicio VALUES ("s345", "Cambio motor", 200, 123, "7894561230");
INSERT INTO servicio VALUES ("s348", "Cambio Aceite", 200, 125, "7894561230");
INSERT INTO repuesto VALUES ("z100", "Motor", 200, "2003/03/04", "2003/03/06", "123emp4567", "s345");
INSERT INTO ResumenPago
	SELECT YEAR(fecha), MONTH(fecha) ,SUM(total)
	FROM factura GROUP BY YEAR(fecha), MONTH(fecha);
-- ------------------------------------------------------------------------ --
-- Presentar el nombre del repuesto más utilizado
SELECT DISTINCT id_Repuesto, COUNT(DISTINCT id_Repuesto) AS Cantidad
FROM factura f
JOIN servicio s ON numero_factura = id_factura
JOIN repuesto r ON s.id_Servicio = r.id_servicio
GROUP BY id_Repuesto
ORDER BY Cantidad DESC
LIMIT 1;

-- Presentar el nombre del cliente que ha obtenido servicio que no hayan necesitado un repuesto. Presentar el nombre del cliente
SELECT c.nombre 
FROM repuesto r RIGHT JOIN servicio s ON s.id_Servicio = r.id_servicio
INNER JOIN factura f ON numero_factura = id_factura
INNER JOIN vehiculo v ON placa = id_vehiculo
INNER JOIN cliente c ON  id_cliente = cedula
WHERE r.id_Repuesto IS NULL
GROUP BY nombre;

-- Disparador para actualizar la tabla de resumen
DELIMITER |
CREATE TRIGGER ActualizarResumen AFTER INSERT ON factura FOR EACH ROW
BEGIN
	UPDATE ResumenPago 
		SET TotalDinero = TotalDinero + NEW.total
		WHERE Mes = MONTH(NEW.fecha) 
        AND Anio = YEAR(NEW.fecha);
END;
|
DELIMITER ;

INSERT INTO factura VALUES (124, "2003-03-07", 0.12, 400, 448, "GHD2584", NULL);
