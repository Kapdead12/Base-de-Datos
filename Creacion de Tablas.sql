CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    correo VARCHAR(100) UNIQUE,
    contraseña VARCHAR(255),
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(255)
);


CREATE TABLE Usuario_Rol (
    id_usuario INT,
    id_rol INT,
    PRIMARY KEY(id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);


CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(255),
    precio DECIMAL(10, 2),
    cantidad INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE CategoriaProd (
    id_producto INT,
    id_categoria INT,
    PRIMARY KEY(id_producto, id_categoria),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Carrito (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('activo', 'abandonado', 'convertido') DEFAULT 'activo',
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE CarritoProducto (
    id_carrito INT,
    id_producto INT,
    cantidad INT,
    precio DECIMAL(10, 2),
    estado ENUM('activo', 'abandonado', 'convertido') DEFAULT 'activo',
    fecha_agregado DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id_carrito, id_producto),
    FOREIGN KEY (id_carrito) REFERENCES Carrito(id_carrito),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME ON UPDATE CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'procesado', 'enviado', 'entregado', 'cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Detalle_Pedido (
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    precio DECIMAL(10, 2),
    PRIMARY KEY(id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Direccion_Envio (
    id_dir_envio INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    estado ENUM('activo', 'abandonado') DEFAULT 'activo',
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Envio (
    id_envio INT AUTO_INCREMENT PRIMARY KEY,             
    id_pedido INT,                                           
    estado ENUM('pendiente', 'en_transito', 'entregado', 'cancelado') DEFAULT 'pendiente', 
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,    
    tiempo_est INT,                            
    costo DECIMAL(10, 2),                           
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)  
);

CREATE TABLE Metodo_Pago (
    id_met_pago INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(255),
    detalle VARCHAR(255)
);

CREATE TABLE Venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,                                
    id_met_pago INT,                          
    total DECIMAL(10, 2),                      
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_met_pago) REFERENCES Metodo_Pago(id_met_pago) 
);

CREATE TABLE Promocion (
    id_promocion INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    nombre VARCHAR(100),
    descripcion VARCHAR(255),
    valor DECIMAL(10, 2),
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    estado ENUM('activa', 'inactiva') DEFAULT 'activa',
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Reseña (
    id_reseña INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_producto INT,
    comentario TEXT,
    calificacion INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Historial_Pedido (
    id_hist_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    estado ENUM('pendiente', 'procesando', 'enviado', 'entregado', 'cancelado'),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    comentario TEXT,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

CREATE TABLE Historial_Inventario (
    id_hist_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    stock INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE LogUsuario (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    accion VARCHAR(255),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);
