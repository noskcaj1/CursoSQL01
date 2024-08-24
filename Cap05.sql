
set dateformat dmy

-- Subconsulta scalar (uma coluna)

Select 
  (Select Count(*) From TB_CLIENTE) As Total_Clientes,
  (Select Count(*) From TB_Pedido) As Total_Pedidos
  
-- Subconsulta Tabular (uma tabela)

Select Ped.ID_CLIENTE, Ped.VLR_TOTAL,
       Convert(Varchar(10), Ped.DATA_EMISSAO, 103) As DataPedido
  From (Select *
          From TB_PEDIDO
            Where DATA_EMISSAO Between '01/12/2017' And 
			                           '31/12/2017') Ped
	Where Ped.VLR_TOTAL > 4000 
	  Order By Ped.DATA_EMISSAO

-- Subconsulta Condicional

-- Todos os Pedidos de um certo periodo que sejam MAIORES
-- que outro periodo

Select * 
  From TB_PEDIDO
    Where DATA_EMISSAO Between '01/01/2017' And '31/12/2017' And
	      VLR_TOTAL > (Select Max(Vlr_total)
                         From TB_PEDIDO
                           Where DATA_EMISSAO Between 
						         '01/01/2018' and '31/12/2018')
      Order By VLR_TOTAL

-- Traga todos os clientes que NÃO FIZERAM PEDIDO em um certo período

Select *
  From TB_CLIENTE
    Where ID_CLIENTE Not In 
	     (Select Distinct ID_CLIENTE
			   From TB_PEDIDO
			     Where DATA_EMISSAO 
			  	        Between '01/01/2017' And '31/12/2017')

-- Tipos de Condição

-- > < <> >= <= =   Compara com UM VALOR				 Campo > 30
-- In, Not in       Comparo existencia com UMA LISTA	 Está ou Não Está na lista
-- > Any / All      Compara valor com uma LISTA          Any : Qualquer
--														 All : Todos

-- Todos os pedidos que sejam maiores que TODOS os melhores clientes (all)
-- ou maiores que ALGUM dos melhores clientes (any)

Select *
  From TB_PEDIDO
    Where DATA_EMISSAO Between '11/05/2017' And '20/05/2017'
	  And VLR_TOTAL > All 
	             (Select VLR_TOTAL
                    From TB_PEDIDO
                      Where DATA_EMISSAO Between '01/05/2017' And '31/05/2017'
						And ID_EMPREGADO = 3
						And Status = 'E')

-- Subconsulta CoRelacionada
-- Executa uma consulta baseado no valor da externa - UMA PARA CADA EXTERNO

Select C.ID_CLIENTE, C.NOME,
       (Select Count(*) 
	      From TB_PEDIDO P
		    Where P.ID_CLIENTE = C.ID_CLIENTE) As Pedidos
  From TB_CLIENTE C
    Where (Select Count(*) 
	        From TB_PEDIDO P
		      Where P.ID_CLIENTE = C.ID_CLIENTE) > 30
		
-- Sub Consulta como JOIN		

Select C.Nome, C.E_mail, P.Data_Emissao, PR.Descricao, P.Quantidade
  From TB_Cliente C Inner Join 
	       (Select P.ID_CLIENTE, P.ID_PEDIDO, I.ID_PRODUTO, 
			       P.DATA_EMISSAO, I.QUANTIDADE 
			  From TB_Pedido P Inner Join TB_ItensPedido I 
				   On P.ID_Pedido = I.ID_Pedido) P On C.ID_CLIENTE = P.ID_CLIENTE       
	    Inner Join TB_Produto PR On P.ID_Produto = PR.ID_Produto
	       Where C.ID_Cliente = 3
-- = 

Select C.Nome, C.E_mail, P.Data_Emissao, PR.Descricao, I.Quantidade
  From TB_Cliente C 
       Inner Join TB_Pedido P On C.ID_Cliente = P.ID_Cliente
	   Inner Join TB_ItensPedido I On P.ID_Pedido = I.ID_Pedido
	   Inner Join TB_Produto PR On I.ID_Produto = PR.ID_Produto
	     Where C.ID_Cliente = 3