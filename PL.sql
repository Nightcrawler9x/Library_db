--PL

--Un pl que calcula el total de ventas que lleva la libreria es crucial para realizar análisis financieros, 
--informes de ventas, seguimiento de tendencias y toma de decisiones comerciales estratégicas.

create or replace function TotalVentas()
returns numeric as $$
declare 
    total_ventas numeric;
begin
    select sum(DineroVendido) into total_ventas
    from (
        select sum(cast(l.Precio as numeric)) as DineroVendido
        from biblioteca.Pedido p
        join biblioteca.Libro l on p.Isbn = l.Isbn
        group by p.Isbn
    ) as Subconsulta;

    return total_ventas;
end;
$$ language plpgsql;


--Prueba del PL
select TotalVentas()





