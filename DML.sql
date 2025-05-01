--Select de cada tabla

select * from biblioteca.usuario u 
select * from biblioteca.libro l 
select * from biblioteca.direccion d 
select * from biblioteca.autor a 
select * from biblioteca.categoria c 
select * from biblioteca.libreria l 
select * from biblioteca.librodisponible l 
select * from biblioteca.libroporautor l 
select * from biblioteca.libroporcategoria l 
select * from biblioteca.pedido p 


--5 consultas que le añaden valor al negocio

--1) Conocer cuales son los libros más solicitados
select  l.Titulo, count(-1) as VecesSolicitado
from biblioteca.Libro l
join biblioteca.Pedido p on l.Isbn = p.Isbn
group  by l.Titulo
order by  VecesSolicitado desc;

--2) Conocer cuales son los usuarios más activos de la libreria, que realizaron la mayor cantidad de pedidos
select u.Nombre, u.Apellido, count(-1) as PedidosRealizados
from biblioteca.Usuario u
join biblioteca.Pedido p on u.Id = p.IdUsuario
group  by u.Nombre, u.Apellido
order by PedidosRealizados desc;

--3) Conocer la cantidad de libros que hay por cada categoria
select c.Nombre AS Categoria, count(-1) as CantidadLibros
from biblioteca.LibroPorCategoria lc
join biblioteca.Categoria c on lc.IdCategoria = c.Id
join biblioteca.Libro l on lc.Isbn = l.Isbn
group  by c.id
order by c.id ;

--4) Conocer la cantidad de usuarios que viven en la ciudad de Bucaramanga, que es donde se encuentra la libreria
select count(-1) as UsuariosEnBucaramanga
from biblioteca.Usuario u
join biblioteca.Direccion d on u.IdDireccion = d.Id
where d.Ciudad = 'Bucaramanga';

--5) Conocer cuales libros del inventario se encuentran temporalmente agotados
select l.Isbn, l.Titulo
from biblioteca.Libro l
join biblioteca.LibroDisponible ld on l.Isbn = ld.Isbn
where ld.Cantidad = 0;
