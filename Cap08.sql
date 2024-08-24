
-- Recursos em Tabelas

-- Metadados (Informações Internas)

select * from sys.objects   -- tabelas do BD
  where type = 'U'

select * from sys.indexes   -- consulta com ID de Objeto
  where object_id = object_id('TB_Produto')

select * from sys.syscomments  -- objetos de texto

-- CTE (Common Table Expression)
-- View que existe apenas durante a execução

With Vendas (Codigo, DataPed, StatusPed) As
(
  Select ID_PEDIDO, DATA_EMISSAO, STATUS
    From TB_PEDIDO
)

Select * From Vendas 

-- Types (Tipos de Dados)
-- Int, Numeric(10, 2), DateTime, Char/Varchar

Create Table dbo.ABC (Codigo Int)

Declare @Valor Int
Set @Valor = 10
Print @Valor

Create Type dbo.Codigo From Int

Create Table dbo.TesteTipo (CodCliente Codigo, Nome Varchar(10))

Insert Into TesteTipo (CodCliente, Nome) Values (1, 'A')

Select * From TesteTipo

-- Criar tipo tabela

Create Type dbo.TabelaPesq As Table (Cod Int)

Declare @MinhaPesquisa TabelaPesq

Insert Into @MinhaPesquisa (Cod) Values (1)

Select * From @MinhaPesquisa

-- Sequencia

Create Sequence dbo.ProximoCodigoPar
  Start With 2 Increment By 2

Create Table dbo.TesteSeq (Cod Int)

Insert Into TesteSeq (Cod)
  Values (Next Value For ProximoCodigoPar)

Select * From TesteSeq 

-- Sinonimos

Create Synonym dbo.MeusPedidos For TB_Pedido

Select * From MeusPedidos

-- Colunas Calculadas

Create Table dbo.TesteColuna (Cod Int, Qtd Int, Valor Numeric(10, 2))

Insert Into TesteColuna (Cod, Qtd, Valor) Values (1, 10, 14.7)
Insert Into TesteColuna (Cod, Qtd, Valor) Values (1, 15, 18.8)

Select Cod, Qtd, Valor, (Qtd * Valor) As Total From TesteColuna

Alter Table TesteColuna Add Total As (Qtd * Valor)

Select * From TesteColuna

-- NO SQL : Mongo DB -> Pode guardar documentos

-- Criar Tabela com campo binário

Create Table dbo.DocsProf (Cod Int Identity(1, 1), Nome Varchar(100),
						   Arquivo Varbinary(Max))

Insert Into DocsProf (Nome, Arquivo) 
  Select 'Planilha', BulkColumn 
    From OpenRowset(Bulk 'C:\B\planilha.xlsx', Single_Blob) As Image 

Insert Into DocsProf (Nome, Arquivo) 
  Select 'Foto', BulkColumn 
    From OpenRowset(Bulk 'C:\B\foto.jpg', Single_Blob) As Image 

Select * From DocsProf

-- Leitura e deserialização de binário

exec sp_configure 'show advanced options', 1	
reconfigure 

exec sp_configure 'Ole Automation Procedures', 1
reconfigure 

-- salvar arquivo

DECLARE @pctStr INT
DECLARE @image VARBINARY(MAX)
SET @image = (SELECT arquivo FROM docsprof WHERE cod = 2)
DECLARE @filePath VARCHAR(8000)
SET @filePath = 'C:\\b\\novafoto.jpg'
EXEC sp_OACreate 'ADODB.Stream', @pctStr OUTPUT
EXEC sp_OASetProperty @pctStr, 'Type', 1
EXEC sp_OAMethod @pctStr, 'Open'
EXEC sp_OAMethod @pctStr, 'Write', NULL, @image
EXEC sp_OAMethod @pctStr, 'SaveToFile', NULL,@filePath, 2
EXEC sp_OAMethod @pctStr, 'Close'
EXEC sp_OADestroy @pctStr

