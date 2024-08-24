
-- Agregação de Dados (Funções)

Select Count(*) As Total_Clientes			-- Contagem
  From TB_CLIENTE

Select Sum(QUANTIDADE) as Entregue_2016		-- Somatória
  From TB_ITENSPEDIDO
    Where Year(Data_Entrega) = 2016

Select Max(Pr_Unitario) As Maior, Min(Pr_Unitario) As Menor,   -- Maior, Menor
       Avg(Pr_Unitario) As Media, StDev(Pr_Unitario) As Desvio -- Média, Desvio Padrão
  From TB_ITENSPEDIDO
    Where Year(Data_Entrega) = 2016

-- Group By

Select ID_Cliente, Max(Vlr_Total) As Maior, Min(Vlr_Total) As Menor
  From TB_PEDIDO
    Group By ID_Cliente

Select ID_Cliente, ID_Empregado, Max(Vlr_Total) As Maior, Min(Vlr_Total) As Menor
  From TB_PEDIDO
    Group By ID_Cliente, ID_Empregado
	  Order By ID_Cliente 

-- Condição pós agregação

Select ID_CLIENTE, Id_Empregado, Max(Vlr_Total) As Total
  From TB_PEDIDO
    Group by ID_CLIENTE, Id_Empregado
	  Having Max(Vlr_Total) > 7000    -- Where da Agregação
	    Order By ID_CLIENTE

Select ID_CLIENTE, Id_Empregado, Min(Vlr_Total) As Total
  From TB_PEDIDO
    Group by ID_CLIENTE, Id_Empregado
	  Having Min(Vlr_Total) < 10    -- Where da Agregação
	    Order By ID_CLIENTE

-- Rollup [1 Nivel de Total] / Cube [Plano Cartesiano de Totais]
-- Montagem de Sub Totais

Select ID_CLIENTE, ID_EMPREGADO, Sum(Vlr_Total) As Total
  From TB_PEDIDO
    Group By ID_CLIENTE, ID_EMPREGADO
	  With Rollup
        Order By ID_CLIENTE

Select P.ID_CLIENTE, P.ID_EMPREGADO,  
       IP.ID_PRODUTO, Sum(IP.QUANTIDADE) As Total
  From TB_PEDIDO P Inner Join TB_ITENSPEDIDO IP On
       P.ID_PEDIDO = IP.ID_PEDIDO
    Where P.ID_CLIENTE = 3
      Group By P.ID_CLIENTE, P.ID_EMPREGADO, IP.ID_PRODUTO
	    With Cube 
	      Order By P.ID_CLIENTE

-- União (Uniao de consultas desde que o numero de colunas seja igual
--        e do mesmo tipo. Expressões fixas, 
--		  Funções ISNULL() e CONVERT() podem ser usadas)

Select Top 5 '2016' As Ano, ID_CLIENTE, Max(Vlr_Total) As Maior
  From TB_PEDIDO
    Where Year(Data_emissao) = 2016
	  Group By ID_CLIENTE
Union
Select Top 5 '2017' As Ano, ID_CLIENTE, Max(Vlr_Total) As Maior
  From TB_PEDIDO
    Where Year(Data_emissao) = 2017
	  Group By ID_CLIENTE

Select Nome, Fone1, Fone2, 'C' As Tipo From TB_CLIENTE
Union
Select Nome, '', '', 'E' As Tipo From TB_EMPREGADO

-- Opções de União

Select Top 3 * From TB_PEDIDO
Union  -- Une, exceto informações duplicadas (todas as colunas)        3 Linhas
Select Top 2 * From TB_PEDIDO

Select Top 3 * From TB_PEDIDO
Union All -- Une tudo, mesmo informações duplicadas                    5 Linhas
Select Top 2 * From TB_PEDIDO

Select Top 3 * From TB_PEDIDO
Intersect -- Exibe somente informações comuns aos dois resultados      2 Linhas
Select Top 2 * From TB_PEDIDO

Select Top 3 * From TB_PEDIDO
Except -- Exibe oque está no conjunto 1 que não existe no cj 2		   1 Linha
Select Top 2 * From TB_PEDIDO

-- Pivot : Exibe um conjunto de linhas com agrupamento de colunas

-- Exemplo (dados em linha)
1		2000		100
1		2001		200
1		2002		250
2		2000		120
2		2001		200
2		2002		220

-- Exemplo (dados em coluna) : Mais intuitivo e util
		2000		2001		2002
1		100			200			250
2		120			200			220

-- 1° Etapa : Montagem de Tabela Temporária com resultados a colunar

Select Year(IP.DATA_ENTREGA) As Ano , P.DESCRICAO, IP.QUANTIDADE
  Into #TabConsulta
  From TB_ITENSPEDIDO IP Inner Join TB_PRODUTO P On
       IP.ID_PRODUTO = P.ID_PRODUTO

Select * From #TabConsulta

-- 2° Etapa : Montagem do relatório colunado

Select DESCRICAO, [2016] As Ano2016, [2017] As Ano2017, 
                  [2018] As Ano2018, [2019] As Ano2019 
  From #TabConsulta
    Pivot (Sum(Quantidade) For Ano in ([2016], [2017], [2018], [2019])) P
	  Order By DESCRICAO





	






