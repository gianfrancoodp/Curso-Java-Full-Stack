use negociowebcfp8;

drop trigger if exists TR_Articulos_Insert;
drop trigger if exists TR_Articulos_Delete;
drop trigger if exists TR_Articulos_Update;
drop table if exists control_table_articulos;

create table control_tabla_articulos(
	id int auto_increment primary key,
    tabla varchar(30) not null,
    accion enum('insert','delete','update') not null,
    fecha date not null,
    hora time not null,
    usuario varchar(20),
    terminal varchar(100),
    idRegistro int not null
);

delimiter //
create trigger TR_Articulos_Insert
	after insert
    on articulos for each row
    begin
		insert into control_tabla_articulos (tabla,accion,fecha,hora,usuario,terminal,idRegistro) 
        values 
        ('articulos','insert',current_date(),current_time(),current_user(), 
			(select user()),new.id);
    end;
// delimiter ;

delimiter //
create trigger TR_Articulos_Delete
	after delete
    on articulos for each row
    begin
		insert into control_tabla_articulos (tabla,accion,fecha,hora,usuario,terminal,idRegistro) 
        values 
        ('articulos','delete',current_date(),current_time(),current_user(), 
			(select user()),old.id);
    end;
// delimiter ;

delimiter //
	create trigger TR_Articulos_Update
    after update on articulos for each row
    begin
		insert into control_tabla_articulos (tabla,accion,fecha,hora,usuario,terminal,idRegistro) 
        values 
        ('articulo','update',current_date(),current_time(),current_user(), 
			(select user()),old.id);
    end;
// delimiter ;

call SP_Articulos_Insert('Collar marca PUPPY SA','Collar para perros marca PUPPY SA talle L','PRENDA','CANINO',100,800,50,20,70,'Producto para Perros grandes.');
call SP_Articulos_Insert('Peluche marca CATTY SA','Peluche en forma de Pez para gatos marca CATTY SA','JUGUETE','FELINO',120,850,70,59,88,'Producto especial para gatos bebes.');
call SP_Articulos_Insert('Rueda para Hamster HAMS','Rueda para Hamsters adultos','ACCESORIO','ROEDOR',500,1200,15,5,30,'Producto PREMIUM.');
call sp_Articulos_Update(
		2,
		'Peluche en forma de PEZ marca CATTY SA', 
        'Peluche PREMIUM en forma de pez para gatos bebes marca CATTY SA',
		(select tipo from articulos where id=2),
		(select especieRecomendada from articulos where id=2),
        (select costo from articulos where id=2),
        (select precio from articulos where id=2),
        (select stock from articulos where id=2),
        (select stockMinimo from articulos where id=2),
        (select stockMaximo from articulos where id=2),
        (select comentarios from articulos where id=2)
);
call SP_Articulos_Delete(1);

select * from control_tabla_articulos;

