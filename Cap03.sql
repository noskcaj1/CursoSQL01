
-- Tipos de Comandos

-- DML : Data Manipulation Language
-- Select, Insert, Update, Delete	:  SQL I

-- DDL : Definition
-- Create, Alter, Drop  :  SQL III

-- DCL : Control
-- Grant, Deny, Revoke  : SQL II

-- DTL : Transaction 
-- Begin Transaction, Commit, Rollback  :  SQL I

-- Comandos SELECT

Select * 
  From TB_CARGO
    Where / Order By / Group By / Having / Rollup / Cube
	Inner Join / Left Outer Join / RIGHT Outer Join
	Max() / Min() / Sum() / Avg()
	Distinct / Top / Union / Except / Intersect
	Pivot
	(SubConsulta) = Coluna, Tabela, Condição Where

-- Dados Básicos

Select * From TB_Cliente

Select 'Joao' As Nome, 12 As Qtd, 
      (10+15) As Total, GETDATE() As Data,
	  12.47 As Numero

-- Buscas básicas

Select CARGO, SALARIO_INIC As [Salario Inicial]
  From TB_Cargo
    Order By SALARIO_INIC Desc, CARGO Asc

Select Nome, DATA_NASCIMENTO As DataNasc, SALARIO
  From TB_EMPREGADO
    Where SINDICALIZADO = 'S'   -- condição de filtro
      Order By SALARIO, Nome 

Set Dateformat DMY  -- Mudança de Formato de Data

-- Where
-- SINDICALIZADO = 'S'            IGUAL A
-- SINDICALIZADO <> 'S'           DIFERENTE DE
-- SALARIO > 100                  MAIOR...  >   <   >=   <=
-- DATA_NASCIMENTO >= '20/01/1975'

Select Nome, Salario, (Salario * 0.11) As INSS,
       (SALARIO * 0.15) As IR,
	   IIf(SINDICALIZADO = 'S', 'Sim', 'Não') As Sindicato,
	   Convert(Varchar(10), DATA_NASCIMENTO, 103) As DataNasc
  From TB_EMPREGADO
    Where Year(DATA_NASCIMENTO) >= 2000
	  Order By DataNasc
	  
-- IIf() : Retorna resultado de acordo com a condição
-- Convert : Formata a saida e converte o tipo
-- Year, Month, Day, Week, WeekDay : Extrai parte da data

-- TOP : Apenas quantidade exatamente pedida
-- With Ties : Inclui o empate baseado na ordenação

Select Top 4 With Ties Nome, Salario 
  From TB_EMPREGADO
    Where Salario <= 5000
      Order By Salario Desc

-- IN = Conjunto de Possibilidades
-- Between = Entre um conjunto

Select Nome, Salario, PREMIO_MENSAL, 
       (Salario + PREMIO_MENSAL) As SalarioTotal
  From TB_EMPREGADO
    Where SALARIO In (550, 880, 1230, 9100)

Select Nome, Salario, PREMIO_MENSAL, 
       (Salario + PREMIO_MENSAL) As SalarioTotal
  From TB_EMPREGADO
    Where Salario Between 2000 And 3000

-- AND  : Diminui o resultado (Restringe a quantidade)
-- OR   : Aumenta o resultado

Select Nome, DATA_ADMISSAO, SALARIO
  From TB_EMPREGADO
    Where ID_DEPARTAMENTO <> 11 AND
	      NUM_DEPEND > 0 AND
		  Salario < 2000 AND
		  SINDICALIZADO = 'S'

Select Nome, DATA_ADMISSAO, SALARIO
  From TB_EMPREGADO
    Where (ID_DEPARTAMENTO = 2 OR ID_DEPARTAMENTO = 4 OR
	       ID_DEPARTAMENTO = 5) AND
		   NUM_DEPEND > 0 AND
		   Salario < 2000 

-- NULL : Inexistencia de Valor
--        Diferente de 0 ou Vazio

Select Nome, SINDICALIZADO 
  From TB_EMPREGADO
    Where (SINDICALIZADO = '' OR SINDICALIZADO Is Null)

Select Nome, IsNull(SINDICALIZADO, '') As Sindicato
  From TB_EMPREGADO

  Joao		100	
  Maria		200
  Manoel	  0		=  Média = 100

  Joao		100	
  Maria		200
  Manoel	NULL    =  Média = 150

  Joao		R. Nada
  Maria		
  Manoel	NULL	= Where Endereco = '' = MARIA

-- Funções de Data

Select Nome, DATA_ADMISSAO, DATENAME(Month, DATA_ADMISSAO) As Mes,
       DateName(WeekDay, DATA_ADMISSAO) As DiaSemana
  From TB_EMPREGADO
    Where Year(Data_Nascimento) < 1980 AND
	      DATEPART(WeekDay, Data_Nascimento) = 1

-- Diferença de Datas

Select DATEDIFF(Day, DATA_EMISSAO, GetDate()),
	   DATEDIFF(Month, DATA_EMISSAO, GetDate()),
       DATEDIFF(Year, DATA_EMISSAO, GetDate())
  From TB_PEDIDO

-- Adicionar valores em datas

-- Pedido, Cliente, DataPedido                    : 15/02
-- Vencimento do Pagamento = 30 Dias após emissão : 15/03
-- Data de Protesto = 3 Meses após a emissao      : 15/06
-- Ultimo dia do mês que eu posso protestar       : 30/06

Select ID_PEDIDO, ID_CLIENTE, 
       Convert(Varchar(10), DATA_EMISSAO, 103) As DtEmissao,
       DATEADD(Day, 30, DATA_EMISSAO) As DtVencimento,
	   DateAdd(Month, 3, DATA_EMISSAO) As DtProtesto,
	   EOMONTH(DateAdd(Month, 3, DATA_EMISSAO)) As LimiteProtesto
  From TB_PEDIDO


-- LIKE : Parecido com

Select * From TB_DEPARTAMENTO
    Where DEPARTAMENTO Like 'P%'  -- Inicio com

Select * From TB_DEPARTAMENTO
    Where DEPARTAMENTO Like '%AL'  -- Fim com

Select * From TB_DEPARTAMENTO
    Where DEPARTAMENTO Like '_RE%'  -- 1° Letra Qualquer
