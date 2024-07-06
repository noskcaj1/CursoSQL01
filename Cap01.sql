
-- Versões

-- Enterprise / Standard  (Comercial)
-- Express : até 10 GB
-- Developer : Grátis, completo, NÃO PODE USO COMERCIAL (estudo apenas)

-- Linguagem : T-SQL (Transact SQL)
-- RDBMS (Sistema de Gerenciamento de Banco de Dados Relacional) => SQL, Oracle, MySql...
-- ANSI SQL 92 (Padrão) + Personalição Específica

Use db_Ecommerce_sa23

Select * From TB_CLIENTE

-- Objetos
-- Tabelas (Indices = Lista Ordenada para Busca)
-- Chave Primária : PK / Chave Estrangeira => Relacionam Tabelas

codcli	nome
1		joao
2		maria
3		andre
4		joao 2

codcli	codped	produto
1		123		pneu

-- View = Imagem da Tabela(s)

-- Comando Basico

Select * From TB_CLIENTE						--	Tabela inteira com tudo

Select ID_Cliente, Nome, CNPJ From TB_CLIENTE	--	Alguns campos

Select ID_Cliente, Nome, CNPJ From TB_CLIENTE	--  Alguns campos com busca de PK
  Where ID_CLIENTE = 6

Go

-- Exemplo de View

Create View dbo.vCliInativo1 As
  Select Nome, CNPJ, Fone1, Fone2 
    From TB_CLIENTE Where SN_ATIVO = 'N'

Go

Select * From vCliInativo1

Go

-- Procedures (rotinas que executam)

sp_who
sp_helptext vCliInativo1
sp_help TB_Cliente

-- Funcoes (rotinas que executam)

Select GetDate(), DATEADD(Day, 10, Getdate())

-- Data no SQL = Numero
-- 1 = 01/01/1900

Print 'Oi'



-- Comentário

/*
	sdf
	dsf
	sfd
	sdf
*/

-- Ver o dia da data atual

set dateformat dmy   -- utilizar data brasileira   

Select CONVERT(int, Getdate())

Select CONVERT(float, Getdate())











































