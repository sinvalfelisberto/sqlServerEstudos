--Aula 02 - Functions
--use [AdventureWorksDW2019]

select SUM(FIS.SalesAmount) TOTAL
from [dbo].[FactInternetSales] fis 
where fis.SalesOrderNumber = 'SO51179'

alter FUNCTION dbo.fn03_TotalPedido(@salesNumber as nchar(7))
returns float
as
begin
	declare @valorTotal as float;
	if	@salesNumber is null return 'É preciso informar o (SalesOrderNumber) para consultar';
	else
		if (select top 1 fis.SalesAmount from [dbo].[FactInternetSales] fis where fis.SalesOrderNumber = @salesNumber) is null return 'O (SalesOrderNumber) não é válido';
		else
			select @valorTotal = SUM(FIS.SalesAmount) from [dbo].[FactInternetSales] fis where fis.SalesOrderNumber = @salesNumber;
			return @valorTotal;	
end

select dbo.fn03_TotalPedido('sinval') as total

select distinct	fis.SalesOrderNumber, 
		cast(dbo.fn03_TotalPedido(fis.SalesOrderNumber) as decimal(18,2)) TotalOrder
from [dbo].[FactInternetSales] fis
where dbo.fn03_TotalPedido(fis.SalesOrderNumber) < 2500.00
order by 2
