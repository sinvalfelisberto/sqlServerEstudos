--use teste

--create table tb02_Estoque_Produtos
--(
--	ID_PRODUTO NUMERIC(6) NOT NULL,
--	SALDO numeric(6) not null default 0
--)

--create table tb03_Produtos
--(
--	ID_PRODUTO NUMERIC(6) PRIMARY KEY NOT NULL,
--	NOME_PRODUTO NVARCHAR(50) NOT NULL,
--	SALDO NUMERIC(6) NOT NULL DEFAULT 0
--)

--ALTER TABLE tb02_Estoque_Produtos
--	add constraint fk_produto foreign key (id_produto)
--	references tb03_Produtos(id_produto)

--insert into tb03_Produtos 
--	(id_produto, nome_produto) 
--values	(1, 'Caneta Vermelha'), 
--		(2, 'Caneta Azul'), 
--		(3, 'Lápis')

--insert into tb02_Estoque_Produtos 
--	(id_produto, saldo) 
--values	(1, 5), 
--		(2, 7), 
--		(3, 100)

--create table testeandTeste (data date)

--Edit/IntelliSense/refresh Local Cache -- Ctrl + Shift + R

select p.id_produto, p.nome_produto, e.saldo
from  tb03_Produtos p
inner join tb02_Estoque_Produtos e on e.id_produto = p.id_produto



--ALTER function [dbo].[fn01_ConsultaSaldo](@pId as numeric(6))
--returns nvarchar(50)
--as 
--begin
--	if @pID is null return 'Produto (ID) não foi informado...';
--	else
--		--declaração de variaveis
--		declare @SaldoAtual numeric(6),
--				@NomeProduto nvarchar(50),
--				@msgFinal nvarchar(200);

--		select @SaldoAtual = saldo from tb02_Estoque_Produtos where ID_PRODUTO = @pId;
--		if @SaldoAtual is  null return 'Produto não encontrado!'
--		else
--			select @NomeProduto = nome_produto from tb03_Produtos where ID_PRODUTO = @pId;

--			set @msgFinal = concat('O saldo atual do produto ', @NomeProduto, ' é de ', @SaldoAtual, ' unidades');
--			return @msgFinal;
--end

select dbo.fn01_ConsultaSaldo(1) Saldo

select cast(dbo.fn01_ConsultaSaldo(p.ID_PRODUTO) as nvarchar(200)) Situação
from tb03_Produtos p