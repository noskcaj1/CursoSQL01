
-- Update (alterações)
-- Sem WHERE = ALTERA TUDO

Select * From AlgumaTabela
  Where Cod = 4

Update AlgumaTabela Set Idade = 15
    Where Cod = 4

-- TB_Cliente

Select * From TB_CLIENTE
  Where ID_CLIENTE = 8

Update TB_CLIENTE Set Nome = 'A', FANTASIA = 'AA', E_MAIL = 'AAA'
  Where ID_CLIENTE = 8

Update TB_CLIENTE Set ICMS = ICMS + 1
  Where ID_CLIENTE = 8

Update TB_CLIENTE Set ICMS += 1
  Where ID_CLIENTE = 8

-- Update com subconsulta

Update TB_CLIENTE 
  Set ICMS = (Select Max(ICMS) From TB_CLIENTE)
    Where ID_CLIENTE = 8

Update TB_CLIENTE 
  Set STATUS_CLI = 'M'
    Where ICMS = (Select Max(ICMS) From TB_CLIENTE)

-- Delete (apagar)
-- SEM WHERE = APAGAR TUDO

Drop Table ABC      -- estrutura + conteudo

Truncate Table ABC  -- conteudo total

Delete			    -- conteudo parcial OU total


Select * From TB_CLIENTE Where ID_CLIENTE = 12

Delete From TB_CLIENTE Where ID_CLIENTE = 12

--Delete From TB_CLIENTE 
--  Where ICMS <= (Select Max(ICMS) From TB_CLIENTE)

-- Transação = .ldf (log transacional)

-- Oracle
Delete From ABC

Begin Tran
Delete From ABC

-- SQL  (Transação Implicita)
Delete From ABC

Begin Tran
Delete From ABC
Commit

-- SEMPRE com transação explicita

select * from TB_CLIENTE

Begin Tran		   -- Inicio da Transação	ACID						

Delete From TB_CLIENTE Where ID_CLIENTE = 3

Rollback    -- Desfaz a Transação
Commit		-- Confirma a Transação

-- Try...Catch

Begin Try
	Begin Tran
	-- Insert
	-- Update
	-- Delete
	Commit
End Try
Begin Catch
    Rollback
	Print 'Deu pau'
End Catch

-- Output

Insert... Output Inserted.*

Delete... Output Deleted.*

Update... Output Inserted.*, Deleted.*






























