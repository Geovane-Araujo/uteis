
-- data aleatória
create function dataaleatoria()
returns date
language plpgsql
as $$
declare
	dia integer;
	mes integer;
	ano integer;
	retData date;
begin
	dia = (SELECT floor(random() * 28 + 1)::int);
	mes = (SELECT floor(random() * 12 + 1)::int);
	ano = (SELECT floor(random() * ((2021-1957) + 1)+ 1957)::int);
	retData = (cast(dia || '/' || mes || '/' || ano as date));
	return retData;
end;
$$;

-- valor aleatório decimal

create function valoraleatorio()
returns decimal
language plpgsql
as $$
declare
	valor decimal;
begin
	valor = (SELECT floor(random() * 10000 + 1));
	return valor;
end;
$$;

create function numeroleatorio()
returns integer
language plpgsql
as $$
declare
	valor integer;
begin
	valor = (SELECT floor(random() * 1000000 + 1)::int);
	return valor;
end;
$$;

-- função que insere valores

create or replace function tabelaprocessamento(numerolinhas int)
RETURNS void
language plpgsql
as $$
	declare
		limite int = 0;
		dataa date;
		linha integer
		tipo integer;
		valor decimal;
begin
	while limite <= numerolinhas
		loop
			dataa = (select * from dataaleatoria());
			tipo = (SELECT floor(random() * 10 + 1)::int);
			valor = (select * from valoraleatorio());
			linha = (select * from numeroleatorio());
			
			insert into processa(data,tipo, valor, linha)
			values (dataa,tipo,valor,linha );
			limite = limite + 1;
		end loop;
end;
$$



-- tabela processamento
create table if not exists processa(
	id serial primary key,
	data date,
	tipo integer,
	valor decimal,
	linha integer
);