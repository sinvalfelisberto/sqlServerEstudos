--cursor pra fazer verificações linha a linha 
--um while
--criando

--variáveis do cursor
--use [AdventureWorks2019
create table #ttemp
(
	nome varchar(max),
	nome_meio varchar(max),
	sobrenome varchar(max)
)
DECLARE @FirstName varchar(50),
		@MiddleName varchar(50),
		@LastName varchar(50)


declare cur_NomeCompleto CURSOR
FOR select top 1000 FirstName, MiddleName, LastName from Person.Person order by FirstName

-- Abrindo o cursor
OPEN cur_NomeCompleto

--selecionar os dados
fetch next from cur_NomeCompleto
into @FirstName, @MiddleName, @LastName

--iteração entre os dados retornados pelo cursor
while @@FETCH_STATUS = 0
begin
		--select @FirstName +' '+ isnull(@MiddleName, '') + ' ' + @LastName as NomeCompleto
	insert into #ttemp values(@FirstName, @MiddleName, @LastName) 	
	fetch next from cur_NomeCompleto
	into @FirstName, @MiddleName, @LastName
end

--select @FirstName, @MiddleName, @LastName

--fechando e desalocando o cursor
close cur_NomeCompleto
deallocate cur_NomeCompleto
select * from #ttemp

select row_number() count(nome) from #ttemp 
