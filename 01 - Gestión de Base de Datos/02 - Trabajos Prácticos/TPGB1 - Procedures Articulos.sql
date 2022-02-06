use negociowebcfp8;

drop procedure if exists SP_Articulos_Insert;
drop procedure if exists SP_Articulos_Delete;
drop procedure if exists SP_Articulos_Update;

delimiter //
create procedure SP_Articulos_Insert(in 
		Pnombre varchar(40),
		Pdescripcion varchar(150),
		Ptipo enum('PRENDA','JUGUETE','ALIMENTO','SNACK','ACCESORIO','CORREAS','MEDICAMENTO'),
		PespecieRecomendada enum('CANINO','FELINO','AVE','PEZ','ROEDOR'),
		Pcosto double,
		Pprecio double,
		Pstock int,
		PstockMinimo int,
		PstockMaximo int,
		Pcomentarios varchar(255)
)
	begin
		insert into articulos (nombre,descripcion,tipo,especieRecomendada,costo,precio,stock,stockMinimo,stockMaximo,comentarios) 
		 	values 
            (Pnombre,Pdescripcion,Ptipo,PespecieRecomendada,Pcosto,Pprecio,Pstock,PstockMinimo,PstockMaximo,Pcomentarios);
    end;
// delimiter ;

delimiter //
create procedure SP_Articulos_Update(in 
		Pid int,
		Pnombre varchar(40),
		Pdescripcion varchar(150),
		Ptipo enum('PRENDA','JUGUETE','ALIMENTO','SNACK','ACCESORIO','CORREAS','MEDICAMENTO'),
		PespecieRecomendada enum('CANINO','FELINO','AVE','PEZ','ROEDOR'),
		Pcosto double,
		Pprecio double,
		Pstock int,
		PstockMinimo int,
		PstockMaximo int,
		Pcomentarios varchar(255)
)
	begin
		update articulos set nombre=Pnombre, descripcion=Pdescripcion, tipo=Ptipo, especieRecomendada=PespecieRecomendada,
			costo=Pcosto, precio=Pprecio, stock=Pstock, stockMinimo=PstockMinimo, stockMaximo=PstockMaximo, comentarios=Pcomentarios 
            where id=Pid;
    end;
// delimiter ;

delimiter //
create procedure SP_Articulos_Delete(in Pid int)
	begin
		delete from articulos where id=Pid;
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

select * from articulos;
