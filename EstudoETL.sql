--create table Vendas 
--(
--	data date,
--	valor decimal(18,2)
--)
--truncate table Vendas
--insert into Vendas values ('01/01/2020', 100.32), ('05/01/2020', 10.00), ('21/01/2020', 1499.00)


select * from Vendas

--create table dCalendario (data date)

--declare @contador int = 1, @data datetime = '01/01/2020'

--while @contador < 730
--begin
--	insert into dCalendario values (@data)
--	set @data = @data + 1
--	set @contador += 1
--end

--use Teste
--select	c.data, 
--		case when v.valor is not null then v.valor
--			 else (select top 1 v.valor from Vendas v where v.valor is not null and v.data <)
--from Vendas v
--right join dCalendario c on v.data = c.data
--where c.data <= '31/01/2020'

--usar subqueries
select	convert(char, t3.data, 103) data,
		CASE 
			WHEN T1.valor IS NOT NULL THEN format(T1.VALOR, 'c')
			ELSE 
			(
				SELECT TOP 1 format(T2.VALOR, 'c')
				FROM VENDAS T2
				WHERE T3.data > t2.data
				AND T2.valor IS NOT NULL
				ORDER BY T2.data DESC
			)
			END AS 'Valor Final Mostrado'
from Vendas T1
right join dCalendario T3 on T3.data = T1.data
where t3.data between '01/01/2020' and '31/01/2020'
