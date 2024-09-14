
-- 09 : Insert
-- 10 : Update / Delete

-- Inserção

'Joao'			-- Texto (char/varchar)     A = 1 Byte (65)
N'Joao'			-- Texto Unicode			A = 2 Bytes (F3A1)
0x13			-- Binário  (precedido de 0x)
'01/01/2001'	-- Data
12				-- Inteiro
12.44			-- Numerico
$12.44			-- Money

-- Inserir Dados

Create Table dbo.AlgumaTabela (Cod Int Identity(1, 1),
							   Nome Varchar(100),
							   DtCadastro DateTime,
							   Idade Int)

Insert Into AlgumaTabela (Nome, DtCadastro, Idade) Values ('B', '01/01/2002', 14)

Select * From AlgumaTabela

-- Inserção em lote

Truncate Table AlgumaTabela		-- Zera a tabela inteira

Insert Into AlgumaTabela (Nome, DtCadastro, Idade)
  Select Nome, DATA_ADMISSAO, COD_SUPERVISOR 
    From TB_EMPREGADO

Insert Into AlgumaTabela (Nome, DtCadastro, Idade)
  Output inserted.*   -- mostra as linhas inseridas
    Select Nome, DATA_ADMISSAO, COD_SUPERVISOR 
      From TB_EMPREGADO

Insert Top(5) AlgumaTabela (Nome, DtCadastro, Idade)  -- inserção parcial
  Select Nome, DATA_ADMISSAO, COD_SUPERVISOR 
    From TB_EMPREGADO

-- Identity Insert

delete from AlgumaTabela where cod = 6

Select * From AlgumaTabela

Insert Into AlgumaTabela (Cod, Nome, DtCadastro, Idade) 
  Values (2, 'B', '01/01/2002', 14)

Set Identity_Insert AlgumaTabela On
Set Identity_Insert AlgumaTabela Off

-- Inserção em Tabela Temporária = Igual

-- Incremento gerado

Insert Into AlgumaTabela (Nome, DtCadastro, Idade) Values ('MMM', '01/01/2002', 14)

select @@IDENTITY   -- Traz o ultimo auto incremento gerado na sessao

-- select cod from AlgumaTabela where nome = 'DDD'






