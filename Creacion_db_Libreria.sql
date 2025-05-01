create schema Biblioteca

create table Biblioteca.Libro(
Isbn varchar(225) not null unique,
Titulo varchar(225) not null,
FechaDePublicacion date not null,
Precio varchar not null,
constraint pk_Libro primary key (Isbn)
);
create table biblioteca.Direccion(
Id serial,
NumeroPropiedad varchar(250) not null,
NumeroCalle int not null,
NumeroCarrera varchar(250) not null,
Ciudad varchar(250) not null,
constraint pk_Direccion primary key (Id)
);
create table biblioteca.Usuario(
Id serial,
IdDireccion int not null,
Genero varchar(250) not null,
Nombre varchar(250) not null,
Apellido varchar(250) not null,
Telefono varchar(225) not null,
Email varchar(250) not null,
constraint pk_Usuario primary key (Id),
constraint fk_Usuario_Direccion foreign key (IdDireccion)	
references biblioteca.Direccion(Id)
);
create table biblioteca.Pedido(
Id serial,
IdUsuario int not null,
Isbn varchar(225) not null,
FechaPedido date not null,
constraint pk_Pedido primary key (Id),
constraint fk_Pedido_Usuario foreign key (IdUsuario)	
references biblioteca.Usuario(Id),
constraint fk_LibroPedido_Libro foreign key (Isbn)	
references biblioteca.Libro(Isbn)
);
create table biblioteca.Libreria(
Id serial,
IdDireccion int not null,
Nombre varchar(250) not null,
Detalles varchar(250) not null,
constraint pk_Libreria primary key (Id),
constraint fk_Libreria_Direccion foreign key (IdDireccion)	
references biblioteca.Direccion(Id)
);
create table biblioteca.LibroDisponible(
IdLibreria int not null,
Isbn varchar(225) not null,
cantidad int not null,
constraint fk_LibroDisponible_Libro foreign key (Isbn)	
references biblioteca.Libro(Isbn),
constraint fk_LibroDisponible_Libreria foreign key (IdLibreria)	
references biblioteca.Libreria(Id)
);
create table biblioteca.Categoria(
Id serial,
Nombre varchar(250) not null,
constraint pk_Categoria primary key (Id)
);
create table biblioteca.LibroPorCategoria(
IdCategoria serial,
Isbn varchar(225) not null,
constraint pk_LibroPorCategoria_Libro foreign  key (Isbn)
references biblioteca.Libro(Isbn),
constraint pk_LibroPorCategoria_Categoria foreign  key (IdCategoria)	
references biblioteca.Categoria(Id)
);
create table biblioteca.Autor(
Id serial,
Nombre varchar(250) not null,
Apellido varchar(250) not null,
constraint pk_Autor primary key (Id)
);
create table biblioteca.LibroPorAutor(
IdAutor serial,
Isbn varchar(225) not null,
constraint pk_LibroPorAutor_Libro foreign  key (Isbn)
references biblioteca.Libro(Isbn),
constraint pk_LibroPorAutor_Categoria foreign  key (IdAutor)	
references biblioteca.Autor(Id)
);