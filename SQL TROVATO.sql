/****** Script for SelectTopNRows command from SSMS  ******/
use SQL_SERVER_TROVATO
select id_turma, id_curso, data_inicio
  from dbo.Turmas

select t.*
  from dbo.turmas t

select t.id_curso, t.id_turma, format(t.data_inicio, 'dd/MM/yyyy')
from turmas t

select t.* into #turmas from turmas t

select t.* from #turmas t

select t.id_turma IDT, t.id_curso IDC, FORMAT(t.data_inicio, 'dd/MM/yyyy') 'DATA COME�O'
from #turmas t

drop table dbo.#turmas

select a.* 
  from Alunos a
 where a.nome = 'Alan Moraes'

 select * into #alunos from alunos

 select a.* 
  from #Alunos a
 where a.nome = 'Alan Moraes'

 select a.* 
  from #Alunos a
 where a.data_nascimento >= '01/01/2005'

 select a.* 
  from #Alunos a
 where a.sexo = 'F'

 select a.* 
  from #Alunos a
 where a.sexo = 'm'

 select a.* 
  from #Alunos a
 where a.sexo = 'm' and
	   a.data_nascimento >= '01/01/2003' and
	   a.id_aluno > 500

select a.nome, a.sexo, year(a.data_nascimento)
  from #Alunos a
 where a.data_nascimento >= '01/01/2003'
 order by 3, 1

select * 
into #AlunosxTurmas
from AlunosxTurmas

select at.*
  from #AlunosxTurmas at

select at.*
 from #AlunosxTurmas at
where at.valor > 500

select floor(at.valor * at.valor_desconto) as desconto
 from #AlunosxTurmas at
where at.valor > 500 and
	  at.valor_desconto > 0

select	c.nome_curso, 
		format(t.data_inicio, 'dd/MM/yyyy') data_inicio, 
		format(t.data_termino, 'dd/MM/yyyy') data_termino,
		format(at.valor, 'C', 'pt-br') as valor_bruto, 
		--cast((at.valor * at.valor_desconto) as numeric(15,2)) as desconto, 
		format((at.valor * at.valor_desconto), 'C', 'pt-br') as desconto, 
		format((at.valor - (at.valor * at.valor_desconto)), 'C', 'pt-br') as Valor_Liquido
 from #AlunosxTurmas at, Turmas t, Cursos c
 where at.id_turma = t.id_turma and
	   t.id_curso = c.id_curso and
	   at.valor_desconto > 0


--total de turmas por curso
select	c.id_curso
		,c.nome_curso
		,count(t.id_turma) Total_Turmas
  from turmas t
  inner join cursos c on c.id_curso = t.id_curso
 group by c.nome_curso, c.id_curso


--todos os cursos, independente se h� ou n�o turmas
select	c.nome_curso, 
		count(t.id_curso) Total_Turmas
  from turmas t
  right join cursos c on c.id_curso = t.id_curso
group by c.nome_curso

--inner join sem inner join
select 	c.nome_curso, 
		count(t.id_curso) Total_Turmas
from turmas t, cursos c
where	c.id_curso = t.id_curso 
group by c.nome_curso

--lista completa de alunos
use SQL_SERVER_TROVATO
select	
		c.nome_curso,
		format(at.valor, 'c', 'pt-br') valor_bruto, 
		concat(floor(at.valor_desconto * 100), '%') desconto,
		format(iif(at.valor_desconto = 0, at.valor, at.valor * at.valor_desconto), 'c', 'pt-br') valor_liquido,
		format(t.data_inicio, 'dd/MM/yyyy') data_inicio,
		format(t.data_termino, 'dd/MM/yyyy') data_fim,
		a.nome aluno,
		iif(a.sexo = 'f', 'Feminino', 'Masculino') sexo
from AlunosxTurmas at
inner join alunos a on a.id_aluno = at.id_aluno
inner join turmas t on t.id_curso = at.id_turma
inner join cursos c on c.id_curso = t.id_curso
order by valor_liquido

--quantidade de turmas com alunos
select c.nome_curso, t.id_turma, count(1) Total
from turmas t
	 inner join AlunosxTurmas at on at.id_turma = t.id_turma
	 inner join Cursos c on c.id_curso = t.id_curso
group by t.id_turma, c.nome_curso

--matematica com sql server
select   1 + 2 as Resultado --soma
select 2 - 3 as Subtração --subtra��o
select cast(458.99 * 2.59 as numeric(15,2)) as Multiplicacao --multiplicac�o
select cast(458.99/ 2.59 as numeric(15,2)) as Divisão

--potencia��o
select POWER(3, 3) cubo, square(3) quadrado

--PERCENTAGEM
select 100 * 1.1 as resultado
select 100 +(100 * .1) resultado

--abs retorna o n�mero sem o sinal
select abs(100-999) as absoluto
select abs(-1) as absoluto

--raiz quadrada
select sqrt(4) raiz_quadrada
select sqrt(7) as resultado
select pi()

--data atual
select getdate() data_hora_atual

select format(getdate(), 'dd/MM/yyyy  HH:mm') data_hora_atual_formatada

select cast(getdate() as date) so_data
select cast(getdate() as time) só_hora

--SIGNAL (retorna -1 se o n�mero for negativo e +1 se for positivo)
select sign(-100) as negativo ,sign(10) as positivo, sign(null) as nulo, sign(0) as zero

--sum fun��o de agrega��o soma valores de colunas inteiras
select sum(1500 + 7777)

--AULA 13 - O USO DO IN, NOT IN, DISTINCT NO SELECT
use SQL_SERVER_TROVATO
--select * into #alunos from alunos
drop table #alunos

select c.id_curso,
		c.nome_curso,
		count(t.id_turma) as Total_Turmas
  from turmas t
	inner join cursos c on c.id_curso = t.id_curso
group by c.id_curso, c.nome_curso

--tirar a prova da quantidade de turmas por curso.
select count(*) as quantidade_turmas_vbaI
  from Turmas
 where turmas.id_curso = 1

 select count(*) as quantidade_turmas_vbaI
  from Turmas
 where turmas.id_curso = 5

 --in
 select turmas.id_curso,  count(*) as quantidade_turmas_vbaI
  from Turmas
 where turmas.id_curso in (1, 5)
 group by Turmas.id_curso

--not in
select turmas.id_curso,  count(*) as quantidade_turmas_vbaI
from Turmas
where turmas.id_curso not in (1, 5)
group by Turmas.id_curso

use SQL_SERVER_TROVATO
select distinct DATEPART(YEAR, Alunos.data_nascimento) as ano
FROM Alunos
order by ano

select	Cursos.id_curso,
		Cursos.nome_curso,
		AlunosxTurmas.valor,
		datename(WEEKDAY, Turmas.data_inicio) mes_inicio,
		datename(month, Turmas.data_termino) mes_fim,
		Alunos.nome,
		Alunos.sexo
  from AlunosxTurmas
  inner join Turmas on Turmas.id_turma = AlunosxTurmas.id_turma
  inner join Cursos on Cursos.id_curso = Turmas.id_curso
  inner join Alunos on Alunos.id_aluno = AlunosxTurmas.id_aluno --and Alunos.sexo = 'f'
  order by 2, sexo


select	Cursos.id_curso,
		Cursos.nome_curso,
		AlunosxTurmas.valor,
		datename(month, Turmas.data_inicio) mes_inicio,
		datename(month, Turmas.data_termino) mes_fim,
		Alunos.nome,
		Alunos.sexo
from AlunosxTurmas
inner join Turmas on Turmas.id_turma = AlunosxTurmas.id_turma
inner join Cursos on Cursos.id_curso = Turmas.id_curso
inner join Alunos on Alunos.id_aluno = AlunosxTurmas.id_aluno
where Alunos.sexo = 'm'
order by 2

--aula 14 - Fun��o de Agrega��o SUM

select	c.nome_curso,
		t.id_turma,
		format(at.valor, 'c', 'pt-br') valor_bruto,
		concat(cast(at.valor_desconto * 100 as integer), '%') Valor_Desconto,
		format(at.valor - (valor_desconto * at.valor), 'c', 'pt-br') 'valor com desconto'

  from	Turmas t
		inner join AlunosxTurmas at on at.id_turma = t.id_turma
		inner join Cursos c on c.id_curso = t.id_curso

select	c.nome_curso,
		
		--sum(valor_bruto) va,
		sum(at.valor) valor_bruto,
		cast(sum(at.valor * at.valor_desconto) as decimal(15,2)) as Valor_desconto,
		cast(sum(at.valor - (valor_desconto * at.valor)) as numeric(15,2)) 'Valor L�quido'
		--sum(at.valor - (valor_desconto * at.valor)) total

  from	Turmas t
		inner join AlunosxTurmas at on at.id_turma = t.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by c.nome_curso
 
 --select cast(7300-802 as numeric(15,2)) soma

 --somatorio por curso e por turma
 select	c.nome_curso,
		at.id_turma,
		sum(at.valor) valor_bruto,
		cast(sum(at.valor * at.valor_desconto) as decimal(15,2)) as Valor_desconto,
		cast(sum(at.valor - (valor_desconto * at.valor)) as numeric(15,2)) 'Valor L�quido'
  from	Turmas t
		inner join AlunosxTurmas at on at.id_turma = t.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by c.nome_curso, at.id_turma

 --somatorio por curso e por turma arredondando
 select	c.nome_curso,
		at.id_turma,
		sum(at.valor) valor_bruto,
		round(sum(at.valor * at.valor_desconto), 2) as Valor_desconto, --prefiro o cast
		round(sum(at.valor - (valor_desconto * at.valor)), 2) 'Valor L�quido' -- aqui tamb�m
  from	Turmas t
		inner join AlunosxTurmas at on at.id_turma = t.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by c.nome_curso, at.id_turma

--5o Ganhos por ano
 select	year(t.data_inicio) Ano,
		--c.nome_curso,
		--at.id_turma,
		sum(at.valor) valor_bruto,
		cast(sum(at.valor * at.valor_desconto) as decimal(15,2)) as Valor_desconto, --prefiro o cast
		cast(sum(at.valor - (valor_desconto * at.valor)) as decimal(15,2)) 'Valor L�quido' -- aqui tamb�m
  from	Turmas t
		inner join AlunosxTurmas at on at.id_turma = t.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by year(t.data_inicio)--, c.nome_curso, at.id_turma,

--5o Ganhos por mes
 select	datename(month, t.data_inicio) Mes,
		--c.nome_curso,
		--at.id_turma,
		sum(at.valor) valor_bruto,
		cast(sum(at.valor * at.valor_desconto) as decimal(15,2)) as Valor_desconto, --prefiro o cast
		cast(sum(at.valor - (valor_desconto * at.valor)) as decimal(15,2)) 'Valor L�quido' -- aqui tamb�m
  from	Turmas t
		inner join AlunosxTurmas at on at.id_turma = t.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by datename(month, t.data_inicio) --, c.nome_curso, at.id_turma,

--fun��es de agrega��o --> sum, count, avg, max e min
select * from AlunosxTurmas

select sum(valor) as total from AlunosxTurmas


select	c.nome_curso,
		t.id_turma,
		sum(valor) as total 
  from	AlunosxTurmas at
		inner join Turmas t on t.id_turma = at.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by c.nome_curso, t.id_turma

--subqueries
select sum(v.total) total_vendas from (
						select	c.nome_curso,
								t.id_turma,
								sum(valor) as total 
						  from	AlunosxTurmas at
								inner join Turmas t on t.id_turma = at.id_turma
								inner join Cursos c on c.id_curso = t.id_curso
						group by c.nome_curso, t.id_turma
						) v

select 1200 + 7300 + 1455 total


--count
select	t.id_curso,
		c.nome_curso,
		count(at.id_aluno) as quantidade_alunos,
		sum(at.valor) total
  from	AlunosxTurmas at
		inner join Turmas t on t.id_turma = at.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by t.id_curso, c.nome_curso

--average (m�dia)
select	t.id_curso,
		c.nome_curso,
		cast(avg(at.valor) as numeric(15,2)) total
  from	AlunosxTurmas at
		inner join Turmas t on t.id_turma = at.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by t.id_curso, c.nome_curso

--max --> o m�ximo de um valor
select	t.id_curso,
		c.nome_curso,
		cast(max(at.valor) as numeric(15,2)) total
  from	AlunosxTurmas at
		inner join Turmas t on t.id_turma = at.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by t.id_curso, c.nome_curso


--min --> o m�ximo de um valor
select	t.id_curso,
		c.nome_curso,
		cast(min(at.valor) as numeric(15,2)) total
  from	AlunosxTurmas at
		inner join Turmas t on t.id_turma = at.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by t.id_curso, c.nome_curso


--max e min --> juntos na mesma query
select	t.id_curso,
		c.nome_curso,
		cast(max(at.valor) as numeric(15,2)) Maximo,
		cast(min(at.valor) as numeric(15,2)) Minimo,
		cast(sum(at.valor * at.valor_desconto) as numeric(15,2)) valor_desconto,
		cast(sum(at.valor - (at.valor * at.valor_desconto)) as numeric(15,2)) as total
  from	AlunosxTurmas at
		inner join Turmas t on t.id_turma = at.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by t.id_curso, c.nome_curso

--max e min --> juntos na mesma query

select v.nome_curso, v.total from (select	t.id_curso,
		c.nome_curso,
		cast(max(at.valor) as numeric(15,2)) Maximo,
		cast(min(at.valor) as numeric(15,2)) Minimo,
		max(at.valor) - min(at.valor) as DIFERENCA,
		cast(sum(at.valor * at.valor_desconto) as numeric(15,2)) valor_desconto,
		cast(sum(at.valor - (at.valor * at.valor_desconto)) as numeric(15,2)) as total
  from	AlunosxTurmas at
		inner join Turmas t on t.id_turma = at.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by t.id_curso, c.nome_curso) v

where v.total > 1200

--aula 16 -fun��es de com datas
--fun��es: getdate(), datepart, dateadd, datediff
		--unidades: year, month, day

--getdate()
select getdate()

select convert(char, getdate(), 103) --dd/MM/yyyy
select convert(char, getdate(), 3) --dd/mm/yy
select convert(char, getdate(), 102) --yyyy.mm.dd
select convert(char, getdate(), 1) --mm/dd/yyyy

select concat(day(GETDATE()),'/', MONTH(GETDATE()))
select year('24/08/1982')
select datename(WEEKDAY, ('24/08/1982'))


--datepart
select DATEPART(year, getdate())
select datepart(day, getdate())

select datepart(year, data_nascimento) as ano from alunos
select distinct datepart(year, data_nascimento) as ano from alunos order by 1

select	datepart(year, data_nascimento) as ano, 
		count(*) quantidade_de_alunos_do_ano 
  from alunos
  group by datepart(year, data_nascimento)
  order by 2

--dateadd
select dateadd(year, 2, '24/08/1982') 
select convert(date, convert(date, dateadd(year, 2, getdate())))
select convert(char, convert(date, dateadd(year, 2, getdate())), 103)


select dateadd(month, 3, getdate())
select convert(date, dateadd(month, 3, getdate()))
select convert(char, dateadd(month, 3, getdate()), 103)

--simula data de vencimento com dia corridos
declare @diaEmissao date = getdate()

select convert(char,DATEADD(day, 30, @diaEmissao), 103) as data_vencimento

select convert(smalldatetime, dateadd(hour, 3, getdate()))

--datediff
select datediff(year,  '24/08/1982', '23/08/2022') idade

--Conte�do da aula:
-- - Fun��o ASCII
-- - Fun��o NCHAR
-- - Fun��o CHAR
-- - Fun��o CHARINDEX
-- - Fun��o CONCAT
-- - Fun��o CONCAT_WS
-- - Fun��o DIFFERENCE

-- - Fun��o ASCII
select ascii('a')
select ascii('A')
select ascii('9')

-- - Fun��o NCHAR
select nchar(97)
select nchar(65)
select nchar(57)

-- - Fun��o CHAR --> igual nchar
select char(97)
select char(65)
select char(57)

--charindex(pesquisa um char em uma sequencia de ate 8000 chars)
select CHARINDEX('i', 'Sinval')
select CHARINDEX('f', 'Sinval Felisberto', 8)
select CHARINDEX('felisberto', 'sinval amaral felisberto')

select	alunos.nome, 
		CHARINDEX('Lo', alunos.nome) as Prado
  from alunos
  order by 2 desc


select	alunos.nome, 
	CHARINDEX('Silva', alunos.nome) as Silva
from alunos
where convert(int, CHARINDEX('Silva', alunos.nome, 1)) > 0
order by 2

select	alunos.nome, 
	CHARINDEX('Silva', alunos.nome) as Silva
from alunos 
where CHARINDEX('Silva', alunos.nome, 1) != 0
order by 2

select concat('Sinval', ' ', 'Felisberto')

select concat('Sinval', '||', 'Felisberto')
select 'Sinval '+'Felisberto'

select concat(a.nome, ' - ', c.nome_curso) "Nome do Aluno - Curso"
from	alunos a
		inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
		inner join Turmas t on t.id_turma = at.id_turma
		inner join cursos c on c.id_curso = t.id_curso
order by 1

--concat_ws
select concat_ws(' ', 'Sinval', 'Amaral', 'Felisberto')

select concat_ws(	' - ', 
					a.nome, 
					c.nome_curso,
					'In�cio: ' + convert(char, t.data_inicio, 103),
					'T�rmino: ' + convert(char, t.data_termino, 103)
				) 
from	alunos a
		inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
		inner join Turmas t on t.id_turma = at.id_turma
		inner join cursos c on c.id_curso = t.id_curso
order by 1


select concat_ws(	' - ', 
					a.nome, 
					c.nome_curso,
					'In�cio: ' + trim(convert(char, t.data_inicio, 103)),
					'T�rmino: ' + trim(convert(char, t.data_termino, 103))
				) 
from	alunos a
		inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
		inner join Turmas t on t.id_turma = at.id_turma
		inner join cursos c on c.id_curso = t.id_curso
order by 1

--difference
-- escala de 0 a 4
select DIFFERENCE('Sinval', 'Sinvaldo')

select DIFFERENCE('Sinval', 'Cival')

select * from	(
				select concat_ws(	' - ', 
					a.nome, 
					c.nome_curso,
					'In�cio: ' + trim(convert(char, t.data_inicio, 103)),
					'T�rmino: ' + trim(convert(char, t.data_termino, 103))
								) linha
				from	alunos a
						inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
						inner join Turmas t on t.id_turma = at.id_turma
						inner join cursos c on c.id_curso = t.id_curso
				--order by 1
				
				) v



declare @valorAVista decimal(10,2) = 149.90,
		@valor decimal(10,2) = 149.90, 
		@parcela int = 1,
		@total decimal(10,2) 



set @total = @parcela * @valor

select @total as Valor_total,
case 
	when @total > @valorAVista then concat_ws(' - ','Possui juros no parcelamento!','Valor do Juros: ', format(sum(@total - @valorAVista), 'c', 'pt-br'))
	when @total < @valorAVista then concat_ws(' - ', 'Item com desconto no parcelamento!/n', format(sum(@total - @valorAVista), 'c', 'pt-br'))
	else 'N�o possui juros no valor'
end as Mensagem_Importante

--FORMATA��O DE CPF, CEP, NIS... s� funciona se n�o tiver o zero no in�cio
SELECT	FORMAT( 76901122, '##-###\.###' ) AS CEP,
		FORMAT(07182456117, '###\.###\.###-##') AS CPF

--aula 18
--Conte�do da aula:
-- - Fun��o FORMAT - forma��o com base em crit�rios regionais
-- - Fun��o LEFT - extra��o de textos a esquerda
-- - Fun��o RIGHT - extra��o de textos a direita
-- - Fun��o LEN - tamanho do conte�do de um campo
-- - Fun��o LOWER  - converte caracteres para min�sculo
-- - Fun��o UPPER - converte caracteres para mai�sculo

--format
--declare @dt datetime = getdate()
--select	@dt dia_de_hoje, 
--		format(@dt, 'd', 'en-us') as Americano, 
--		format(@dt, 'D', 'us-en') as Americano_Extenso,
--		format(@dt, 'd', 'pt-br') as Brasileiro,
--		format(@dt, 'D', 'pt-br') as Brasileiro_Extenso

--declare @dt datetime = getdate()

--SELECT	format(21300012145.37,'n', 'pt-br' ) numero_com_separadores,
--		format(21300012145.37,'G', 'pt-br' ) numero_formato_geral,
--		format(21300012145.37,'C', 'pt-br' ) numero_como_dinheiro

--left -> extrai caracteres � esquerda
select left('Sinval Felisberto', 6)
select right('Sinval Felisberto', 10)

select distinct left(a.nome, 5)
from Alunos a

select  right(a.nome, 5)
from Alunos a

--len
--retorna o tamanho do campo
select trim('sinval amaral felisberto')

select	max(len(a.nome)) as MaiorNome,
		min(len(a.nome)) as MenorNome
 from	Alunos a

 --upper --lower
 select upper('sinval amaral felisberto')
 select upper(a.nome) from alunos a

 select LOWER('sinval AMARAL FELISberto')
 select LOWER(a.nome) from alunos a

 SELECT * FROM ALUNOS
--cursor
use SQL_SERVER_TROVATO
 create table #TesteCursor
 (
	NOME VARCHAR(MAX),
	DTNASCIMENTO DATE,
	SEXO CHAR(1)
 )

 DECLARE	@NOME VARCHAR(MAX),
			@DTNASCIMENTO DATE,
			@SEXO CHAR(1)

DECLARE cursor_DadosGerais CURSOR
FOR select a.nome, a.data_nascimento, a.sexo from alunos a order by a.nome

open cursor_DadosGerais
fetch next from cursor_DadosGerais
	into @NOME, @DTNASCIMENTO, @SEXO

WHILE @@FETCH_STATUS = 0
BEGIN
	insert into #TesteCursor values(@NOME, @DTNASCIMENTO, @SEXO)
	fetch next from cursor_DadosGerais
	into @NOME, @DTNASCIMENTO, @SEXO
END

CLOSE cursor_DadosGerais
DEALLOCATE cursor_DadosGerais

select	nome,
		convert(char, dtnascimento, 103) 'Data de Nascimento',
		sexo
  from #TesteCursor 
  where month(dtnascimento) = 8 and day(DTNASCIMENTO) = 24
  order by DTNASCIMENTO, SEXO

  select * from #testecursor

drop table #TesteCursor

--aula 19 - fun��es de texto
--Conte�do da aula:
-- Fun��o LTRIM - Elimina espa�os � esquerda de uma string
-- Fun��o RTRIM - Elimina espa�os � direita de uma string
-- Fun��o PATINDEX - Localiza parte de textos em strings
-- Fun��o REPLACE - Substitui caracteres nos campos
-- Fun��o REPLICATE - Replica um caractere pelo n�mero definido
-- Fun��o REVERSE - Inverte uma string de texto

--ltrim
select ltrim('                Sinval Felisberto')

declare	@varTexto varchar(50)
	set @varTexto = '     este � um texto de exemplo de LTRIM'

select ltrim(@varTexto) as Teste
select resultado = ltrim(@varTexto)

--RTRIM
select rtrim('Sinval              ')

declare @varTexto2 varchar(50)
	set @varTexto2 = 'Este � um texto de exemplo do RTRIM        '
select resultado = rtrim(@varTexto2)

--PATINDEX
-- Retorna a posi��o inicial da primeira ocorr�ncia de um padr�o.
select PATINDEX('%rto%', 'Sinval Felisberto') as posicao

--substring
declare @varTexto3 varchar(100)
	set @varTexto3 = 'Aqui � o canal do Alessandro Trovato no Youtube'

select resultado = SUBSTRING(@varTexto3, PATINDEX('%Trovato%',@varTexto3), 7)

--replace
select saida = replace('Sinval Felisberto', 's', ' ')
select saida = replace(replace('Sinval Felisberto', 's', ' '), 'l', '1')

use SQL_SERVER_TROVATO
select	a.nome,
		convert(char, a.data_nascimento, 103) as data_nascimento,
		replace(replace(a.sexo, 'f', 'Feminino'), 'm', 'Masculino') as sexo
  from Alunos a

declare @cpf varchar(15)
	set @cpf = '111.222.333-72'
	set @cpf = replace(replace(@cpf, '.', ''), '-', '')

select CPF = @cpf

--replicate IDEAL PARA CRIAR ARQUIVOS DE DADOS
select len(nome) from alunos

SELECT NOME + REPLICATE(' ', 50 - LEN(NOME))
FROM ALUNOS

SELECT LEN(NOME + REPLICATE(' ', 50 - LEN(NOME)) + SEXO)
FROM ALUNOS

--REVERSE
SELECT REVERSE('SINVAL AMARAL')

--Conteúdo da aula:
-- - Função STRING_AGG - Agrupamento de string com definição de separador
-- - Função SPACE - Preenchimento de uma string de espaços
-- - Função STUFF - Substitui cadeias inteiras de caracteres
-- - Declaração e uso de variáveis
-- - Função DATEPART
-- - Função TRIM

--Função SPACE - Preenchimento de uma string de espaços
select 'sinval' + space(25) + 'x'

declare @vNome varchar(50)
	set	@vNome = 'Sinval Amaral Felisberto'
select len(@vNome + space(50 - len(@vNome)) + '19820824')

select	len(a.nome + space(50 - len(a.nome)) + 
		format(a.data_nascimento, 'yyyyMMdd'))
from alunos a

select	a.nome + space(50 - len(a.nome)) + 
		convert(nvarchar (4), datepart(year, a.data_nascimento)) +
		convert(nvarchar (2), datepart(month, a.data_nascimento)) +
		convert(nvarchar (2), datepart(day, a.data_nascimento)) --aqui o dia sairia com 1 digito, caso seja menor que 10 !n�o usar!
from alunos a

select	len(a.nome + space(50 - len(a.nome)) + 
		convert(nvarchar (4), datepart(year, a.data_nascimento)) +
		convert(nvarchar (2), datepart(month, a.data_nascimento)) +
		convert(nvarchar (2), datepart(day, a.data_nascimento)))
from alunos a

select	len(a.nome + space(50 - len(a.nome)) + 
		format(a.data_nascimento, 'yyyyMMdd'))
from alunos a

--STRING_AGG: Agrupamento de string com defini��o de separador

SELECT STRING_AGG(convert(nvarchar(max), sexo), ';') as registro
from alunos a

SELECT STRING_AGG(convert(nvarchar(max), isnull(sexo, 'N')), ';') as registro
from alunos a

  select	datepart(month, a.data_nascimento) ano,
			string_agg(convert(nvarchar(max), a.nome+ space(2) + format(a.data_nascimento, 'dd/MM/yyyy')), ' - ') 
			 as registro
    from alunos a
group by datepart(month, a.data_nascimento)
order by 1

select	datepart(year, a.data_nascimento) as ano,
		string_agg(convert(nvarchar(max), sexo), '-')
			within group (order by datepart(year, a.data_nascimento) asc) as registro
from alunos a
group by datepart(year, a.data_nascimento)


  select	datepart(month, a.data_nascimento) mês,
			string_agg(convert(nvarchar(max), a.nome+ space(2) + format(a.data_nascimento, 'dd/MM')), ' - ') 
				within group (order by datepart(year, a.data_nascimento) asc) as registro
    from alunos a
group by datepart(month, a.data_nascimento)
order by 1

--stuff
--substituir um caractere
select stuff('71824561172', 4, 5, 'XXXXX') as CPF


-- Aula 21
--Conteúdo da aula:
-- - Função SUBSTRING
-- - Função TRIM
-- - Função TRANSLATE
-- - Função UPPER
-- - Função LOWER
-- - Função IIF
-- - Função REPLACE
-- - Função CHARINDEX
-- - Estrutura de repetição WHILE
-- testando o git por aqui
-- agora no online

--substring
select SUBSTRING('Sinval Amaral Felisberto', 1, 7) as nome

select a.nome 
from alunos a

select substring(a.nome, 1, 7) 
from alunos a

--cursor para criar uma tabela de teste, com nome com mais de uma posição
create table ##TesteCursor
 (
	NOME VARCHAR(MAX),
	DTNASCIMENTO DATE,
	SEXO CHAR(1)
 )

DECLARE		
	@NOME1 VARCHAR(MAX),
	@DTNASCIMENTO1 DATE,
	@SEXO1 CHAR(1)

DECLARE 
	cursor_DadosGerais CURSOR
FOR 
	select a.nome, a.data_nascimento, a.sexo 
	from alunos a 
	order by a.nome

OPEN 
	cursor_DadosGerais
	FETCH NEXT FROM
		cursor_DadosGerais
		INTO @NOME1, @DTNASCIMENTO1, @SEXO1

	WHILE @@FETCH_STATUS = 0
		BEGIN
			insert into ##TesteCursor values(@NOME1+' '+@NOME1, @DTNASCIMENTO1, @SEXO1)
			fetch next from cursor_DadosGerais
			into @NOME, @DTNASCIMENTO, @SEXO
		END

CLOSE cursor_DadosGerais
DEALLOCATE cursor_DadosGerais



select	a.nome,
		case substring(a.nome, 1, charindex(' ', a.nome, charindex(' ', a.nome)+1))
			when '' then 
				a.nome
			else 
			substring(a.nome, 1, charindex(' ', a.nome, charindex(' ', a.nome)+1))
		end as nome_extraido
from ##TesteCursor a

DROP TABLE ##TESTECURSOR

--IIF
use sql_server_trovato
select * from alunos a
select iif(10 > 3, 'Verdadeiro', 'Falso')

--translate
select translate('2*[3+4]/{7-2}', '[]{}', '()()') as expressao_alterada
select translate('Sertão do Cariácica', 'ãá', 'aa') as expressao_alterada

--replace
declare @vOperacao varchar(max) 
set @vOperacao = '2*[3+4]/{7-2}'
set @vOperacao = replace(@vOperacao, '[', '(')
set @vOperacao = replace(@vOperacao, ']', ')')
set @vOperacao = replace(@vOperacao, '{', '(')
set @vOperacao = replace(@vOperacao, '}', ')')

select @vOperacao as alterado

--while
declare @vString varchar(max)
set @vString = 'SQL            Server                   |'
while CHARINDEX('  ', @vString) > 0
	begin
		set @vString = replace(@vString, '  ', ' ')
	end

select trim(@vString) as stringAlterada

declare @contador int = 1, 
		@StringDigitada varchar(max) = 'Numero digitado: '

while @contador <= 10
	begin
		select @StringDigitada + cast(@contador as char) as linha
		set @contador += 1
	end

--upper // lower
use SQL_SERVER_TROVATO
select	a.nome,	
		upper(a.nome) Maiusculo, 
		lower(a.nome) Minusculo 
  from Alunos a

  --Aula 23 - função Union e Union All

use AdventureWorksDW2019

-- o número de colunas devem ser iguais
select * from DimProduct

select	p.EnglishProductName, 
		p.SafetyStockLevel, 
		p.DaysToManufacture, 
		p.Class, 
		p.Color
  from DimProduct p
 where p.Color = 'NA'

 union

 select	p.EnglishProductName, 
		p.SafetyStockLevel, 
		p.DaysToManufacture, 
		p.Class, 
		p.Color
  from DimProduct p
 where p.Color <> 'Silver'

 --ignorar limitação de mesmo número de colunas
 select	p.EnglishProductName, 
		p.SafetyStockLevel, 
		p.DaysToManufacture,
		null, --adicionar o null
		null --adicionar o null
  from DimProduct p
 where p.Color = 'NA'

 union

 select	p.EnglishProductName, 
		p.SafetyStockLevel, 
		p.DaysToManufacture, 
		p.Class, 
		p.Color
  from DimProduct p
 where p.Color <> 'Silver'


 --ordem dos campos
 select	p.EnglishProductName, 
		p.SafetyStockLevel, 
		p.DaysToManufacture, 
		p.Class, 
		p.Color
  from DimProduct p
 where p.Color = 'NA'

 union

 select	p.EnglishProductName, 
		p.SafetyStockLevel, 
		p.Class, 
		p.DaysToManufacture, 
		p.Color
  from DimProduct p
 where p.Color <> 'Silver'

 --alias para colunas
 --80 registros com union
 select	p.EnglishProductName as Produto,
		p.SafetyStockLevel as Estoque_Seguro,
		p.DaysToManufacture Dias_Produção,
		p.Class Classe,
		p.Color Cor
   from DimProduct p
  where p.color = 'NA'
		and p.Class is not null

union

 select	p.EnglishProductName as ProdutoNome,
		p.SafetyStockLevel,
		p.DaysToManufacture,
		p.Class,
		p.Color
   from DimProduct p
  where p.color = 'Black'
		and p.Class = 'L'

--union all diferente de union
-- union coloca um distinct  na pesquisa
--union all deixa todos os registros


 --104 registros com union all
 select	p.EnglishProductName as Produto,
		p.SafetyStockLevel as Estoque_Seguro,
		p.DaysToManufacture Dias_Produção,
		p.Class Classe,
		p.Color Cor
   from DimProduct p
  where p.color = 'NA'
		and p.Class is not null

union all

 select	p.EnglishProductName as ProdutoNome,
		p.SafetyStockLevel,
		p.DaysToManufacture,
		p.Class,
		p.Color
   from DimProduct p
  where p.color = 'Black'
		and p.Class = 'L'

--mais um exemplo union all não há distinct
select	p.EnglishProductName, 
		p.Class, 
		p.Color
  from	DimProduct p

UNION ALL

select	p.EnglishProductName, 
		p.Class, 
		p.Color
  from	DimProduct p

order by 3

--mais um exemplo com union há distinct
select	p.EnglishProductName, 
		p.Class, 
		p.Color
  from	DimProduct p
 where p.Color = 'black'

UNION

select	p.EnglishProductName, 
		p.Class, 
		p.Color
  from	DimProduct p
 where	p.Class is not null

order by 3

--aula 24
--	sequences:	o que são
--				como cria-las
--				como alterar 
--				como apagar 
--				como reiniciar 

use SQL_SERVER_TROVATO

select a.* from Alunos a
select max(a.id_aluno) + 1 from Alunos a
--gera essa operação automaticamente
create sequence sequenciaTeste_01
select next value for sequenciaTeste_01

/*
tinyint - Range 0 to 255
smallint - Range -32,768 to 32,767
int - Range -2,147,483,648 to 2,147,483,647
bigint - Range -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 --> Default
decimal and numeric with a scale of 0.
*/

drop sequence sequenciaTeste_01

create sequence Sequencia
	as int
	start with 1
	increment by 1
	minvalue 1
	maxvalue 999
	cycle
	cache 3

select  s.cache_size,
		s.current_value
  from sys.sequences s
 where name = 'Sequencia'

 drop sequence Sequencia

--create schema Test

 create sequence Test.Sequencia
	as int
	start with 1
	increment by 1

select  s.cache_size, s.current_value
from sys.sequences s
where s.name = 'Sequencia'

select next value for Test.Sequencia as 'contando'

drop sequence Test.Sequencia

CREATE SEQUENCE Test.seq_Teste02
	AS NUMERIC
	START WITH 1
	INCREMENT BY 1

SELECT NEXT VALUE FOR Test.seq_Teste02 sequencia

select	s.current_value from sys.sequences s where s.name = 'seq_Teste02'

update sys.sequences 
set current_value = 1
where name = 'seq_Teste02'

alter sequence Test.seq_Teste02
	restart with 1

while (select	s.current_value from sys.sequences s where s.name = 'seq_Teste02') < 30
begin
	SELECT NEXT VALUE FOR Test.seq_Teste02 sequencia
end

--teste para alunos
declare @vIDAluno int
set @vIDAluno = next value for Test.seq_Teste02

select @vIDAluno as ProximoIDAluno

select * from sys.sequences

--Aula 25
-- Inserts
--Algumas técnicas para serem utilizadas

use SQL_SERVER_TROVATO

select * from alunos
select max(id_aluno) + 1 from Alunos

create sequence seq_tbAlunos 
	start with 793
	increment by 1

select next value for seq_tbAlunos

exec sp_columns Alunos

--insert com a descrição dos campos
insert into dbo.Alunos
	(	id_aluno, 
		nome, 
		data_nascimento, 
		sexo, 
		data_cadastro, 
		login_cadastro
	)
	values
	(	next value for seq_tbAlunos,
		'Sinval Amaral Felisberto',
		'24/08/1982',
		'M',
		GETDATE(),
		'SINVA'
	)

SELECT * FROM ALUNOS A
WHERE data_cadastro >= convert(date, getdate())

EXEC SP_COLUMNS CURSOS

SELECT MAX(ID_CURSO) + 1 FROM CURSOS

CREATE SEQUENCE seq_tbCursos
	as integer
	start with 12
	increment by 1

INSERT INTO dbo.Cursos
values
	(
		next value for seq_tbCursos,
		'Curso de Power BI do Sinval',
		getdate(),
		'SINVA'
	)

SELECT * FROM CURSOS
WHERE data_cadastro >= CONVERT(DATE, GETDATE())

--sem usar sequences, mas gasta mais recursos do banco, por usar um select antes de gravar
DECLARE @idCursos int
select @idCursos = max(id_curso) + 1 from Cursos

insert into dbo.Cursos
	values(@idCursos, 'Curso de C# do Sinval', getdate(), 'SINVA')

SELECT * FROM CURSOS
WHERE data_cadastro >= CONVERT(DATE, GETDATE())

--insert com a criação de nova tabela
--select * 
--into dbo.Nova_Tabela 
--from dbo.Cursos

--select * from dbo.Nova_Tabela 
--drop table dbo.Nova_Tabela 

--begin tran
--	truncate table dbo.Nova_Tabela --apaga dados da tabela
--	rollback
--end 

--delete from dbo.Nova_Tabela

--exec sp_columns Nova_Tabela

--insert into dbo.Nova_Tabela
--select * from Cursos
--where id_curso > 5

--select * from dbo.Nova_Tabela

--insert into Nova_Tabela 
--select	c.id_curso,
--		c.nome_curso,
--		getdate(),
--		'FELISBERTO'
--from Cursos c

--select * from dbo.Nova_Tabela

--drop table dbo.Nova_Tabela

--Aula 26: DELETE
SELECT *
INTO dbo.tbDelete
from dbo.Cursos

delete from dbo.tbDelete

select * from dbo.tbDelete

drop table dbo.tbDelete

SELECT *
INTO dbo.tbDelete
from dbo.Cursos

delete from dbo.tbDelete
where nome_curso like '%Avançado%'

select * from dbo.tbDelete

DELETE FROM DBO.tbDelete
WHERE nome_curso = 'VBA I'

SELECT *
INTO ALUNOSTEMP
FROM Alunos

SELECT A.id_aluno
FROM ALUNOSTEMP A
INNER JOIN AlunosxTurmas AT
ON A.id_aluno = AT.id_aluno

DELETE FROM ALUNOSTEMP
WHERE id_aluno NOT IN
	(
		SELECT A.id_aluno
		  FROM ALUNOSTEMP A
			INNER JOIN AlunosxTurmas AT ON A.id_aluno = AT.id_aluno
	)


--OPÇÃO 2
drop table ALUNOSTEMP

SELECT *
INTO ALUNOSTEMP
FROM Alunos


SELECT A.NOME, A.sexo
  FROM ALUNOSTEMP A
 WHERE A.id_aluno NOT IN
	 (
		select at.id_aluno from AlunosxTurmas at where a.id_aluno = at.id_aluno
	 )

delete FROM ALUNOSTEMP 
 WHERE id_aluno NOT IN
	 (
		select at.id_aluno from AlunosxTurmas at where id_aluno = at.id_aluno
	 )


SELECT A.NOME, A.sexo
  FROM ALUNOSTEMP A
 WHERE A.id_aluno IN
	 (
		select at.id_aluno from AlunosxTurmas at where a.id_aluno = at.id_aluno
	 )

--apagar todos os registros dos alunos com mais de 30 anos
drop table ALUNOSTEMP

SELECT *
INTO ALUNOSTEMP
FROM Alunos

select	a.id_aluno,
		DATEDIFF(year, a.data_nascimento, GETDATE()) as idade
from ALUNOSTEMP a
where datediff(year, a.data_nascimento, getdate()) > 30
order by 2 desc

select	a.id_aluno,
		cast(DATEDIFF(dd, a.data_nascimento, GETDATE()) / 365.25 as int) as idade
from ALUNOSTEMP a
where cast(DATEDIFF(dd, a.data_nascimento, GETDATE()) / 365.25 as int) > 30
order by 2 desc

DELETE FROM ALUNOSTEMP
where cast(DATEDIFF(dd, data_nascimento, GETDATE()) / 365.25 as int) > 30

SELECT	A.nome,
		A.data_nascimento,
		--DATEDIFF(year, A.data_nascimento, GETDATE()),
		floor(DATEDIFF(day, A.data_nascimento, GETDATE()) / 365.25) idade
FROM Alunos A
where month(cast(a.data_nascimento as datetime)) = 12

select 
	a.nome,
	a.data_nascimento,
	cast(datediff(DD, a.data_nascimento, getdate()) / 365.25 as int) as idade 
from alunostemp a
where month(cast(a.data_nascimento as datetime)) = 12


select	a.nome, 
		a.data_nascimento,
		--dateadd(YY, datediff(YY, a.data_nascimento, getdate()), GETDATE()) - case when dateadd(yy, datediff(yy, a.data_nascimento, getdate()), getdate()) >  getdate() then 1 else 0,
		DATEDIFF(YY, data_nascimento, GETDATE() - (CASE WHEN DATEADD(YY, DATEDIFF(YY, data_nascimento, GETDATE()), a.data_nascimento) > GETDATE() THEN 1 ELSE 0 end) as idade
from Alunos a
where id_aluno = 793

select CAST(DATEDIFF(DAY, '20/12/2000', GETDATE()) / 365.25 AS INT) idade 

print concat('idade: ',CAST(DATEDIFF(DAY, '20/12/2000', GETDATE()) / 365.25 AS INT))

--aula 27 DROP
-- apaga itens do banco de dados.
-- tabelas, bancos, sequencias, index e outros itens do banco de dados. Não tem como reaver!

create index indAlunosTeste on Alunos(id_aluno)

drop index Alunos.indAlunosTeste

--create procedure #procListaAlunos
--as
--select * from alunos
--where alunos.nome like 'G%'

--exec #procListaAlunos

--drop procedure procListaAlunos

--AULA 28 ALTER TABLE

SELECT * FROM TTEMP

drop table TTEMP

select *
into #tbtemp
from alunos

update #tbtemp
set sexo = 'm'

select * from #tbtemp

drop table #tbtemp

select *
into #tbtemp
from alunos

select * from #tbtemp
where sexo is null

update #tbtemp
set sexo = null
where id_aluno in (210, 211, 212, 213, 214, 215, 391, 392, 393)

select * from #tbtemp
where sexo is null

update #tbtemp
set sexo = 'f'
where id_aluno between 210 and 215

select * from #tbtemp
where sexo is null

update #tbtemp
set sexo = 'm'
where id_aluno between 391 and 393

select * from #tbtemp
where sexo is null

update #tbtemp
set sexo = null
where id_aluno = 391

select * from #tbtemp
where sexo is null

update #tbtemp
set sexo = 'm'
where id_aluno in (210, 211, 212, 213, 214, 215, 391, 392)
and sexo is null

select * from #tbtemp
where sexo is null

update #tbtemp
set sexo = lower(sexo),
	nome = upper(nome)
where id_aluno between 200 and 290

select * from #tbtemp
where id_aluno between 195 and 295

update #tbtemp set sexo = UPPER(sexo), nome = upper(nome), login_cadastro = LOWER(login_cadastro)

select * from #tbtemp

DROP TABLE #tbtemp
--Aula 30 - TRANSACTION
-- COISAS DE DBA

SELECT * 
INTO #TTEMP
FROM ALUNOS

SELECT * FROM #TTEMP

BEGIN TRANSACTION
	UPDATE #TTEMP
	   SET SEXO = LOWER(SEXO)
COMMIT

BEGIN TRANSACTION
	UPDATE #TTEMP
	   SET SEXO = UPPER(SEXO)
ROLLBACK

SELECT * FROM #TTEMP

BEGIN TRAN
	DELETE FROM #TTEMP
ROLLBACK

SELECT * FROM #TTEMP

---------
DECLARE @TR1 VARCHAR(20)
	SELECT @TR1 = 'Transação Delete'

begin tran
	delete from #TTEMP
	where nome like 'G%'
commit tran @tr1


if OBJECT_ID('TabelaTeste', 'U') is not null
	drop table TabelaTeste
go

create table TabelaTeste (
	id int primary key,
	letra char(1)
)
go

--iniciar a var de controle de transactions @@TRANCOUNT PARA 1
BEGIN TRANSACTION TR1
	PRINT 'Transaction : contador depois do 1º begin = ' + CAST(@@TRANCOUNT AS NVARCHAR(10))
	INSERT INTO TabelaTeste values(1, 'A')

BEGIN TRANSACTION TR2
	PRINT 'Transaction : contador depois do 2° begin = ' + CAST(@@TRANCOUNT AS NVARCHAR(10))
	INSERT INTO TabelaTeste VALUES(2, 'B')

BEGIN TRAN TR3
	PRINT 'Transaction : contador depois do 3° begin = ' + CAST(@@TRANCOUNT AS NVARCHAR(10))
	INSERT INTO TabelaTeste VALUES(3, 'C')

COMMIT TRAN TR2
	PRINT 'Transaction : contador depois do COMMIT TR2 = ' + CAST(@@TRANCOUNT AS NVARCHAR(10))

COMMIT TRAN TR1
	PRINT 'Transaction : contador depois do COMMIT TR1 = ' + CAST(@@TRANCOUNT AS NVARCHAR(10))

COMMIT TRAN TR3
	PRINT 'Transaction : contador depois do COMMIT TR3 = ' + CAST(@@TRANCOUNT AS NVARCHAR(10))

--aula 31 -- if else
drop table #TTEMP

select *
into #ttemp
from Alunos

if 10 > 20 
	select '10 é maior que vinte'
else
	select '10 é menor que vinte'

declare @dtDia date = dateadd(day, 2, getdate())

IF DATENAME(WEEKDAY, @dtDia) IN ('Sábado', 'Domingo')
	select 'Estamos no final de semana. Hoje é ' + datename(WEEKDAY, @dtDia)
else
	select 'Não estamos no final de semana. Hoje é ' + datename(WEEKDAY, @dtDia)

--variáveis globais
select @@SERVERNAME
select @@LANGUAGE
select @@LANGID
select @@TRANCOUNT

if @@LANGUAGE <> 'Português (Brasil)'
	SELECT 'Today is ' + DATENAME(weekday, getdate())
else
	select 'Hoje é '+ DATENAME(weekday, getdate())

--Português (Brasil)

set language 'English'
select @@LANGID as 'Language ID'

set language 'Português (Brasil)'
select @@LANGID

SELECT name, alias
FROM sys.syslanguages;

set language 'us_english'
select @@LANGID AS 'Language ID'

set language 'Deutsch'
select @@LANGID

set language 'us_english'
select @@LANGUAGE

if OBJECT_ID('dbo.Alunos', 'U') is null
	print 'A tabela não existe'
else 
	exec sp_columns Alunos

---------
declare 
	@vIdadeMax int, 
	@vParam int

set @vIdadeMax = 17
set @vParam = 25

if @vIdadeMax >= @vParam
	select 
			tp.nome, 
			tp.data_nascimento, 
			cast(datediff(day, tp.data_nascimento, getdate()) / 365.25 as int) as idade
	from #ttemp tp
	where cast(datediff(day, tp.data_nascimento, getdate()) / 365.25 as int) >= @vIdadeMax
	order by 3 asc
else
	select 
			tp.nome, 
			tp.data_nascimento, 
			cast(datediff(day, tp.data_nascimento, getdate()) / 365.25 as int) as idade
	from #ttemp tp
	where cast(datediff(day, tp.data_nascimento, getdate()) / 365.25 as int) <= @vIdadeMax
	order by 3 asc


declare @alteraNome varchar(max) = 'Snival Lenisberto'
declare @nomeCliente varchar(max) 
	set @nomeCliente = (select nome from #ttemp where nome like 'Sinval%')
	print @nomeCliente


if	@nomeCliente = 'Sinval Amaral Felisberto'
begin
	begin tran
	update #ttemp
	set nome = @alteraNome
	where id_aluno = 793;
	commit
	print 'nome alterado com sucesso'
end
else
	print 'Não foi alterado'

set @nomeCliente = (select nome from #ttemp where nome like 'Sinval%')

if @nomeCliente != 'Sinval Amaral Felisberto'
	print @nomeCliente
else
	select  nome from #ttemp where id_aluno = 793

declare @nomeCliente1 varchar(max) = 'Sinval Felisberto'
if @nomeCliente1 = ''
	

update #ttemp
set nome = 'Sinval Amaral Felisberto'
where id_aluno = 793

--functions
use AdventureWorks2019

--create FUNCTION Sales.ufn_SalesByStore (@storeid int)
--RETURNS TABLE
--AS
--RETURN
--(
--    SELECT P.ProductID, P.Name, cast(SUM(SD.LineTotal) as numeric(10,2)) AS 'Total'
--    FROM Production.Product AS P
--    JOIN Sales.SalesOrderDetail AS SD ON SD.ProductID = P.ProductID
--    JOIN Sales.SalesOrderHeader AS SH ON SH.SalesOrderID = SD.SalesOrderID
--    JOIN Sales.Customer AS C ON SH.CustomerID = C.CustomerID
--    WHERE C.StoreID = @storeid
--    GROUP BY P.ProductID, P.Name
--)
--GO

select * from Sales.ufn_SalesByStore(602)

--Aula 32: While
use SQL_SERVER_TROVATO

select *
into #ttemp
from Alunos

select * from #ttemp

declare @vString varchar(max)
set		@vString = 'SQL           Server                  !'

while CHARINDEX('  ', @vString) > 0
begin
	set @vString = REPLACE(@vString,'  ', ' ')
end
print ' '
print @vString

declare @contador int
	set @contador = 1

while @contador <= 10
begin
	print 'Contando: ' + cast(@contador as varchar)
	  set @contador += 1
end

----
declare @vcount1 int = 1

while @vcount1 <= 10
begin
	print 'O contador está em: ' + convert(varchar, @vcount1)
	if @vcount1 = 7
		break
	set @vcount1 += 1
end

--numeros ímpares
declare @valorDigitado int
	set @valorDigitado = 0

while @valorDigitado <= 10
begin
	if @valorDigitado % 2 = 0
		print 'O número ' + convert(varchar, @valorDigitado)+ ' é par!'
	else
		print 'O número ' + convert(varchar, @valorDigitado)+ ' é ímpar!'
	set @valorDigitado += 1
end

drop table #ttemp

set language 'English'

select x.*
into #ttemp
from
	(
	select	row_number() over (partition by nome_curso order by nome_curso) linha,
			y.id_aluno,
			y.nome,
			y.nome_curso,
			y.data_inicio,
			y.data_termino
	from
		(
			select	a.id_aluno,
					a.nome,
					c.nome_curso,
					t.data_inicio,
					t.data_termino
			from AlunosxTurmas at
			inner join Alunos a on a.id_aluno = at.id_aluno
			inner join Turmas t on t.id_turma = at.id_turma
			inner join Cursos c on c.id_curso = t.id_curso
		) y
	) x


select max(linha) quantidade_matriculados, nome_curso 
from #ttemp 
group by nome_curso
having max(linha) > 0

drop table #ttemp

select y.*
into #ttemp
from
	(
		select	row_number() over (order by id_aluno) as linha,
				x.id_aluno,
				x.nome,
				x.nome_curso,
				x.data_inicio,
				x.data_termino
		from 
		(select a.id_aluno, 
				a.nome,
				c.nome_curso,
				t.data_inicio,
				t.data_termino
		from AlunosxTurmas at
		inner join Alunos a on a.id_aluno = at.id_aluno
		inner join Turmas t on t.id_turma = at.id_turma
		inner join Cursos c on c.id_curso = t.id_curso) x
	) y

declare	@cont int,
		@MaxLinhas int, 
		@CursoProcura nvarchar(max),
		@CursoNome nvarchar(max),
		@NomeAluno nvarchar(max)

set @CursoProcura = 'vba'

select @cont = min(linha), @MaxLinhas = max(linha) from #ttemp
--print convert(varchar, @cont) + ' ' + convert(varchar, @MaxLinhas)

while @cont is not null and @cont <= @MaxLinhas
begin
	select	@CursoNome = nome_curso,
			@NomeAluno = nome
	from #ttemp
	where linha = @cont

	if CHARINDEX(@CursoProcura, @CursoNome) > 0
		print convert(varchar, @cont) + '> Curso: ' + @CursoNome + ' Aluno: ' + @NomeAluno

		set @cont += 1
end

--Aula 33: CASE...
--			 ELSE...
--				END

DROP TABLE #TTEMP

SET LANGUAGE 'us_english'


select x.*
into #ttemp
from 
	(
	select	row_number() over(order by id_aluno) as linha, v.id_aluno, v.nome, v.sexo, v.nome_curso, v.data_inicio, v.data_termino, v.valor
	from (
		select	a.id_aluno, a.nome, a.sexo, c.nome_curso, t.data_inicio, t.data_termino, at.valor
		from AlunosxTurmas at
			 inner join Turmas t on t.id_turma = at.id_turma
			 inner join Alunos a on a.id_aluno = at.id_aluno
			 inner join Cursos c on c.id_curso = t.id_curso ) v 
	) x

select * from #ttemp

update #ttemp
set sexo = null
where id_aluno in (2, 10, 27, 30)

select	id_aluno,
		nome,
		case sexo
			when 'm' then 'Masculino'
			when 'f' then 'Feminino'
			else 'Não definido'
			end as sexo,
		nome_curso
from #ttemp

----
-- usando o case para checagem de dados
----
select x.*
from 
(
select	id_aluno,
		nome,
		case sexo
			when 'm' then 'Masculino'
			when 'f' then 'Feminino'
			else 'Não definido'
			end as sexo,
		nome_curso
from #ttemp
)x
where sexo = 'Não definido'


---
select  nome, nome_curso, valor, convert(char, data_inicio, 103) dt_inicio,
		case year(data_inicio)
			when 2019 then 'Ano Anterior'
			when 2020 then 'Ano Atual'
			else 'Ano não esperado' 
			end as verificação_Ano
from #ttemp

select *
into #alunos
from alunos

select	id_aluno, 
		nome, 
		convert(char, data_nascimento, 103) as data_nascimento,
		floor(datediff(dd, data_nascimento, getdate()) / 365.25) as idade,
		case
			when floor(datediff(dd, data_nascimento, getdate()) / 365.25) < 18 then 'Menor de Idade'
			else 'Maior de idade' end as Maioridade
from #alunos
order by 4 asc

select dateadd(year, -17, getdate())

update #alunos
set data_nascimento = '2004-12-21'
where id_aluno in (726, 705, 639, 637)

exec sp_columns alunos

select	id_aluno, 
		nome, 
		convert(char, data_nascimento, 103) as dt_nascimento,
		floor(datediff(day, data_nascimento, getdate()) / 365.25) as idade,
		case
			when floor(datediff(dd, data_nascimento, getdate()) / 365.25) < 18 then 'Menor de Idade'
			else 'Maior de idade' end as Maioridade
from #alunos
order by 4 asc

drop table ALUNOSTEMP, TabelaTeste, tbDelete

select  a.nome,
		a.sexo
from #alunos a
order by
	case sexo when 'f' then 'Feminino'
			  when 'm' then 'Masculino'
			  else 'sexo' end asc

-- Aula 34
-- BEGIN/END
-- Controle de fluxo das Instruções T-SQL (Transaction SQL)

select x.*
into #ttemp
from 
(
	select	row_number() over( order by id_aluno) linha,
			y.id_aluno,
			y.nome,
			y.sexo,
			y.nome_curso,
			y.data_inicio,
			y.data_termino,
			y.valor
   from (select	a.id_aluno,
				a.nome,
				a.sexo,
				c.nome_curso,
				t.data_inicio,
				t.data_termino,
				at.valor
		
	   from AlunosxTurmas at
			 inner join turmas t on t.id_turma = at.id_turma
			 inner join cursos c on c.id_curso = t.id_curso
			 inner join alunos a on a.id_aluno = at.id_aluno) y
) x

select * from #ttemp

DECLARE @contadorBegin int = 0

while @contadorBegin <= 10
begin
	print 'Contador: ' + convert(varchar, @contadorBegin)
	set @contadorBegin += 1
end

begin transaction 
if @@TRANCOUNT = 0
	select t.nome, t.nome_curso, t.sexo 
	  from #ttemp t
	 where t.sexo = 'm'

rollback transaction

print 'Executar dois rollbacks geraria um erro de execução do segundo'

rollback transaction

print 'Transação desfeita'

-- com o BEGIN aninhado

begin transaction

if @@TRANCOUNT = 0
	begin
		select nome, nome_curso, sexo from #ttemp where sexo = 'm'
		rollback transaction
		print 'Executar dois rollbacks gera um erro no segundo'
	end
rollback transaction
print 'Transação desfeita'

-- Aula 35
-- TRY / CATCH

--excluindo a tabela temporária
drop table #ttemp

--recriando a tabela temporária
select x.*
into #ttemp
from	(select	row_number() over ( order by id_aluno) linha, y.id_aluno, y.nome, y.sexo, y.nome_curso, y.data_inicio, y.data_termino, y.valor
	from 
		(select  a.id_aluno, a.nome, a.sexo, c.nome_curso, t.data_inicio, t.data_termino, at.valor
		from AlunosxTurmas at
			 inner join Alunos a on a.id_aluno = at.id_aluno
			 inner join Turmas t on t.id_turma = at.id_turma
			 inner join Cursos c on c.id_curso = t.id_curso ) y ) x

--exemplo 1:

begin try
	select * from temptable
end try
begin catch
	select
		ERROR_MESSAGE() as numero_erro,
		ERROR_MESSAGE() as mensagem_erro,
		ERROR_LINE() as linha_erro
end catch

--exemplo 2:

create procedure proc_testeTryCatch
as 
	select * from Temptable


drop table retorno_erros

create table retorno_erros
(
	procedure_erro varchar(max),
	linha_erro int,
	mensagem_erro varchar(max),
	numero_erro int,
	data_erro datetime
)

--executando procedure e capturando o erro
begin try
	set language 'english-us'
	exec proc_testeTryCatch
end try
begin catch
	insert into retorno_erros values
	(
		ERROR_PROCEDURE(),
		ERROR_LINE(),
		ERROR_MESSAGE(),
		ERROR_NUMBER(),
		getdate()
	)
end catch

SELECT * from retorno_erros

DECLARE @procName varchar(max) = 'Temptable'
SELECT DISTINCT
       o.name AS Object_Name,
       o.type_desc,
	   m.definition as codigo
FROM sys.sql_modules m
       INNER JOIN
       sys.objects o
         ON m.object_id = o.object_id
WHERE m.definition Like '%' + @procName + '%' ESCAPE '\';

select count(*) quantidade_alunos, sexo, nome_curso from #ttemp
group by sexo, nome_curso
having sexo = 'f'


--executando procedure e capturando o erro
begin try
	set language 'english-us'
	exec proc_testeTryCatch
end try
begin catch
	insert into retorno_erros values
	(
		ERROR_PROCEDURE(),
		ERROR_LINE(),
		ERROR_MESSAGE(),
		ERROR_NUMBER(),
		getdate()
	)
end catch

begin try
	EXEC proc_testeTryCatch
	print convert(varchar, @@ERROR)
end try
begin catch
	IF @@ERROR = 208
		insert into retorno_erros values
	(
		ERROR_PROCEDURE(),
		ERROR_LINE(),
		ERROR_MESSAGE(),
		ERROR_NUMBER(),
		getdate()
	)
	ELSE
	  PRINT 'OUTRO TIPO DE ERRO' + CONVERT(VARCHAR, @@ERROR)

end catch

SELECT * from retorno_erros

-- Aula 36
-- Índices

drop table #ttemp

select x.*
into #ttemp
from (select row_number() over (order by id_aluno) linha, y.id_aluno, y.nome, y.sexo, y.nome_curso, y.data_inicio, y.data_termino, y.valor 
	    from (select a.id_aluno, a.nome, a.sexo, c.nome_curso, t.data_inicio, t.data_termino, at.valor
			    from AlunosxTurmas at 
					 inner join turmas t on t.id_turma = at. id_turma
					 inner join cursos c on c.id_curso = t.id_curso
					 right join alunos a on a.id_aluno = at.id_aluno
					 ) y ) x --a order dos joins importa no resultado dela.


select count(*) quantidade, a.nome from #ttemp a
group by a.nome
having count(*) > 0
order by 1 desc