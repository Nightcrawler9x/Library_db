

--TRIGGER

--Un trigger que implementa la restricción de no permitir pedir prestado un libro agotado respalda 
--una regla de negocio crítica para la operación de la librería. 
--Esta regla asegura que los usuarios no puedan solicitar libros que no están disponibles en stock, 
--es decir, libros que tienen una cantidad igual a 0 en la tabla 

create or replace function  verificarDisponibilidadLibro()
returns trigger as $$
begin
  if exists  (
    select  1
    from biblioteca.LibroDisponible ld
    where  ld.Isbn = new.Isbn and ld.Cantidad = 0
  ) then
    raise exception 'El libro solicitado está agotado en este momento por lo cual no puede ser pedido';
  end if;
  return new;
end;
$$ language plpgsql;

create trigger triggerVerificarDisponibilidad
before insert on biblioteca.Pedido
for each row
execute function verificarDisponibilidadLibro();



--Prueba del trigger:

insert into biblioteca.Pedido (IdUsuario, Isbn, FechaPedido) values (1501, '619943460-9', '2023-02-23');

insert into biblioteca.Pedido (IdUsuario, Isbn, FechaPedido) values (1502, '939284582-0', '2023-02-23');

insert into biblioteca.Pedido (IdUsuario, Isbn, FechaPedido) values (1503, '916586354-2', '2023-02-23');

