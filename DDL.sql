CREATE DATABASE IF NOT EXISTS TallerMecanico;
USE TallerMecanico;

CREATE TABLE IF NOT EXISTS cliente (
	cedula VARCHAR(10) PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	direccion VARCHAR(25) NOT NULL,
	telefono VARCHAR(10) NOT NULL,
	correo VARCHAR(20) NOT NULL
);
CREATE TABLE IF NOT EXISTS Vehiculo(
	id_cliente VARCHAR(10),
	placa VARCHAR(7) unique primary key not null,
	modelo VARCHAR(20) NOT NULL,
	color VARCHAR(20) NOT NULL,
	descripcion VARCHAR(50) NOT NULL,
	CONSTRAINT fk_cliente FOREIGN KEY(id_cliente) REFERENCES cliente(cedula) 
);
	
CREATE TABLE IF NOT EXISTS Cita(
	id_cita INT PRIMARY KEY,
	fecha DATE NOT NULL,
    estado VARCHAR(10) NOT NULL,
	id_vehiculo VARCHAR(7) NOT NULL,
	CONSTRAINT fk_vehiculo FOREIGN KEY(id_vehiculo) REFERENCES Vehiculo(placa) 
);

CREATE TABLE IF NOT EXISTS Maquinaria(
	codigo VARCHAR(10) PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS factura(
	numero_factura INT PRIMARY KEY,
	fecha DATE NOT NULL,
	iva DECIMAL NOT NULL,
	sub_total FLOAT NOT NULL,
	total FLOAT NOT NULL,
	id_vehiculo VARCHAR(10) NOT NULL, 
	id_cita INT,
	CONSTRAINT fk_vehiculo2 FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(placa),
	CONSTRAINT fk_cita FOREIGN KEY (id_cita) REFERENCES cita(id_cita)
);

CREATE TABLE IF NOT EXISTS Empleado(
	cedula VARCHAR(10) PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	area VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS servicio(
	id_Servicio VARCHAR(10) PRIMARY KEY,
	tipo VARCHAR(20) NOT NULL,
	precio FLOAT(50) NOT NULL,
	id_factura INT NOT NULL,
	id_empleado VARCHAR(10) NOT NULL,
	CONSTRAINT fk_servicio FOREIGN KEY (id_factura) REFERENCES Factura(numero_factura),
	CONSTRAINT fk_empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(cedula)
);
CREATE TABLE IF NOT EXISTS Maquinaria_Servicio(
	id_uso INT PRIMARY KEY,
	id_maquinaria VARCHAR(10) NOT NULL,
	id_servicio VARCHAR(10) NOT NULL,
	CONSTRAINT fk_maquinaria FOREIGN KEY (id_maquinaria) REFERENCES Maquinaria(Codigo),
	CONSTRAINT fk_servicio2 FOREIGN KEY (id_servicio) REFERENCES servicio(id_Servicio) 
);

CREATE TABLE IF NOT EXISTS Distribuidor(
	ruc VARCHAR(10) PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	telefono VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS Repuesto (
	id_Repuesto VARCHAR(50) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	costo FLOAT(50) NOT NULL,
	fechaOrden DATE NOT NULL,
	fechaLlegada DATE NOT NULL,
	id_distribuidor VARCHAR(15) NOT NULL,
	id_servicio VARCHAR(10) NOT NULL,
	CONSTRAINT fk_distribuidor FOREIGN KEY(id_distribuidor) REFERENCES Distribuidor(ruc),
	CONSTRAINT fk_servicio3 FOREIGN KEY (id_servicio) REFERENCES Servicio(id_servicio) 
);

-- Tabla de resumen donde se almacene el nombre del mentor y la cantidad de mentorizados
CREATE TABLE IF NOT EXISTS ResumenPago (
	Anio INT(4) NOT NULL,
    Mes INT(2) NOT NULL,
    TotalDinero FLOAT(50) NOT NULL,
    PRIMARY KEY (Anio, Mes)
);




