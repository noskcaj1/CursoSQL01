
-- Busca e saida de formato data

set dateformat dmy

Select ID_PEdido, DATA_EMISSAO,
       Convert(varchar(10), DATA_EMISSAO, 103) As Data
  From TB_PEDIDO
    Where DATA_EMISSAO = '17/12/2016'

-- Conteudo

Select * 
  From TB_CARGO
    Where / Order By / Group By / Having / Rollup / Cube
	Inner Join / Left Outer Join / RIGHT Outer Join
	Max() / Min() / Sum() / Avg()
	Distinct / Top / Union / Except / Intersect
	Pivot
	(SubConsulta) = Coluna, Tabela, Condição Where

-- Normalização

Pedidos
-------
1	Joao	01/01/2024	

Items Pedido
------------
1	1	Pneu
1	2	Oleo
...

Parcelas Pags
-------------
1	1	01/02/2024	100
1	2	01/03/2024	100
...

-- Associação (Join)

Select Top 1 * 
	From TB_Empregado		-- Tabela Pai

Select Top 1 * 
	From TB_Departamento	-- Tabela Filho

Select E.ID_Empregado, E.Nome, E.Data_Admissao, E.Salario, E.ID_Departamento 
	From TB_Empregado E	

Select D.ID_Departamento, D.Departamento
	From TB_Departamento D		

-- Associar

Select E.ID_Empregado, E.Nome, E.Data_Admissao, E.Salario, D.Departamento
	From TB_Empregado E Inner Join TB_Departamento D On
	     E.ID_Departamento = D.ID_Departamento 

Select E.ID_Empregado, E.Nome, E.Data_Admissao, E.Salario, D.Departamento
	From TB_Empregado E, TB_Departamento D 
	     Where E.ID_Departamento = D.ID_Departamento 

-- Empregados vs Cargos  (Inner Join)

Select Top 1 * From TB_Empregado

Select Top 1 * From TB_Cargo

Select E.ID_Empregado, E.Nome, E.ID_Cargo, E.Data_Admissao From TB_Empregado E

Select C.ID_Cargo, C.Cargo From TB_Cargo C

Select E.ID_Empregado, E.Nome, E.Data_Admissao, C.Cargo
  From TB_Empregado E Inner Join TB_Cargo C On
       E.ID_Cargo = C.ID_Cargo
	Where C.Cargo = 'Diretor'
      Order By E.Nome

-- Outer Join

Select Top 1 * From TB_Cargo
Select Top 1 * From TB_Empregado

Select C.ID_Cargo, C.Cargo From TB_Cargo C

Select E.Nome, E.ID_Cargo From TB_Empregado E

Select C.Cargo, IsNull(E.Nome, '') As Nome 
  From TB_Cargo C Left Outer Join TB_Empregado E On
      C.ID_Cargo = E.ID_Cargo

Select IsNull(C.Cargo, '') As Cargo, IsNull(E.Nome, '') As Nome 
  From TB_Cargo C Right Outer Join TB_Empregado E On
      C.ID_Cargo = E.ID_Cargo

-- Full Outer Full (traz tudo)

Select IsNull(C.Cargo, '') As Cargo, IsNull(E.Nome, '') As Nome 
  From TB_Cargo C Full Outer Join TB_Empregado E On
      C.ID_Cargo = E.ID_Cargo

Select IsNull(C.Cargo, '') As Cargo, IsNull(E.Nome, '') As Nome 
  From TB_Cargo C Full Outer Join TB_Empregado E On
      C.ID_Cargo = E.ID_Cargo
	Where C.Cargo Is Null Or E.Nome Is Null
	-- Auditoria de Relacionamentos

-- Join de várias tabelas

Select Top 1 * From TB_Cliente
Select Top 1 * From TB_Pedido
Select Top 1 * From TB_ItensPedido
Select Top 1 * From TB_Produto

Select C.ID_Cliente, C.Nome, C.E_mail From TB_Cliente C
Select P.ID_Pedido, P.ID_Cliente, P.Data_Emissao From TB_Pedido P
Select I.ID_Pedido, I.ID_Produto, I.Quantidade From TB_ItensPedido I
Select PR.ID_Produto, PR.Descricao From TB_Produto PR

Select C.Nome, C.E_mail, P.Data_Emissao, PR.Descricao, I.Quantidade
  From TB_Cliente C 
       Inner Join TB_Pedido P On C.ID_Cliente = P.ID_Cliente
	   Inner Join TB_ItensPedido I On P.ID_Pedido = I.ID_Pedido
	   Inner Join TB_Produto PR On I.ID_Produto = PR.ID_Produto
	     Where C.ID_Cliente = 3


