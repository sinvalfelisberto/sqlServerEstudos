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
select 2 - 3 as Subtra��o --subtra��o
select cast(458.99 * 2.59 as numeric(15,2)) as Multiplicacao --multiplicac�o
select cast(458.99/ 2.59 as numeric(15,2)) as Divis�o

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
select cast(getdate() as time) s�_hora

--SIGNAL (retorna -1 se o n�mero for negativo e +1 se for positivo)
select sign(-100) as negativo ,sign(10) as positivo, sign(null) as nulo, sign(0) as zero

--sum fun��o de agrega��o soma valores de colunas inteiras
select sum(1500 + 7777)

--AULA 13 - O USO DO IN, NOT IN, DISTINCT NO SELECT
use SQL_SERVER_TROVATO
select * into #alunos from alunos
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
		cast(max(at.valor) as numeric(15,2)) M�ximo,
		cast(min(at.valor) as numeric(15,2)) M�nimo,
		cast(sum(at.valor * at.valor_desconto) as numeric(15,2)) valor_desconto,
		cast(sum(at.valor - (at.valor * at.valor_desconto)) as numeric(15,2)) as total
  from	AlunosxTurmas at
		inner join Turmas t on t.id_turma = at.id_turma
		inner join Cursos c on c.id_curso = t.id_curso
group by t.id_curso, c.nome_curso

--max e min --> juntos na mesma query

select v.nome_curso, v.total from (select	t.id_curso,
		c.nome_curso,
		cast(max(at.valor) as numeric(15,2)) M�ximo,
		cast(min(at.valor) as numeric(15,2)) M�nimo,
		max(at.valor) - min(at.valor) as DIFEREN�A,
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
select PATINDEX('%rto%', 'Sinval Felisberto') as posi��o

--substring
declare @varTexto3 varchar(100)
	set @varTexto3 = 'Aqui � o canal do Alessandro Trovato no Youtube'

select resultado = SUBSTRING(@varTexto3, PATINDEX('%Trovato%',@varTexto3), 7)

--replace
select sa�da = replace('Sinval Felisberto', 's', '�')
select sa�da = replace(replace('Sinval Felisberto', 's', '�'), 'l', '1')

use SQL_SERVER_TROVATO
select	a.nome,
		convert(char, a.data_nascimento, 103) as data_nascimento,
		replace(replace(a.sexo, 'f', 'Feminino'), 'm', 'Masculino') as sexo
  from Alunos a

declare @cpf varchar(15)
	set @cpf = '111.222.333-72'
	set @cpf = replace(replace(@cpf, '.', ''), '-', '')

select S�P��fe = @cpf

--replicate IDEAL PARA CRIAR ARQUIVOS DE DADOS
select len(nome) from alunos

SELECT NOME + REPLICATE('�', 50 - LEN(NOME))
FROM ALUNOS

SELECT LEN(NOME + REPLICATE(' ', 50 - LEN(NOME)) + SEXO)
FROM ALUNOS

--REVERSE
SELECT REVERSE('SINVAL AMARAL')

--Conte�do da aula:
-- - Fun��o STRING_AGG - Agrupamento de string com defini��o de separador
-- - Fun��o SPACE - Preenchimento de uma string de espa�os
-- - Fun��o STUFF - Substitui cadeias inteiras de caracteres
-- - Declara��o e uso de vari�veis
-- - Fun��o DATEPART
-- - Fun��o TRIM

--Fun��o SPACE - Preenchimento de uma string de espa�os
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


  select	datepart(month, a.data_nascimento) m�s,
			string_agg(convert(nvarchar(max), a.nome+ space(2) + format(a.data_nascimento, 'dd/MM')), ' - ') 
				within group (order by datepart(year, a.data_nascimento) asc) as registro
    from alunos a
group by datepart(month, a.data_nascimento)
order by 1

--stuff
--substituir um caractere
select stuff('71824561172', 4, 5, 'XXXXX') as CPF


-- Aula 21
--Conte�do da aula:
-- - Fun��o SUBSTRING
-- - Fun��o TRIM
-- - Fun��o TRANSLATE
-- - Fun��o UPPER
-- - Fun��o LOWER
-- - Fun��o IIF
-- - Fun��o REPLACE
-- - Fun��o CHARINDEX
-- - Estrutura de repeti��o WHILE
-- testando o git por aqui
-- agora no online
