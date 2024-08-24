
-- 07 : Modelagem de Dados

-- Modelos: Descritivo, Conceitual, Lógico, Físico
-- Normalização : 1°, 2°, 3° Formas Normais

-- 1° Análise de Requisitos (Lean Inception, Discovery...)
-- Modelo Ágil (Scrum / Kanban)

-- Temporárias (durante a conexão atual)
--  # = Local / ## = Global

Create Table ##Temp2 (Codigo Int)

Insert Into ##Temp2 (Codigo) Values (1)

Select * From ##Temp2

-- Por consulta

Select * Into #TempCliente From TB_CLIENTE

Select * From #TempCliente 

-- Criação de Tabelas

set dateformat dmy

Create Table dbo.Alunos (CodAluno	Int		Not Null	Primary Key,
						 Nome		Varchar(100),
						 DtNasc		DateTime,
						 ValorMen	Numeric(10,2) )

Insert Into Alunos (CodAluno, Nome, DtNasc, ValorMen)
  Values (2, 'Maria', '01/01/1970', 120.34)

Select * From Alunos 

-- Tabela Relacionada   1 -> N

Create Table dbo.Enderecos (CodAluno	Int		Not Null,
						    CodEndereco	Int		Not Null,
							Endereco	Varchar(100),
							CEP			Char(8))

Alter Table Enderecos Add Constraint pkEnd Primary Key (CodAluno, CodEndereco)

Alter Table Enderecos Add Constraint fkEnd Foreign Key (CodAluno)
    References Alunos(CodAluno)

Insert Into Enderecos (CodAluno, CodEndereco, Endereco, Cep)
		Values (1, 3, 'r. algo', '1212512')
Select * From Enderecos

-- Constraints

-- Drop Table Teste  (apaga a tabela)

Create Table dbo.Teste (Codigo Int Identity(1, 1),
                        Nome Varchar(50),
						CPF Char(11) Unique,
						DtCadastro DateTime Default GetDate(),
						Status Char(1))

Alter Table Teste
  Add Constraint ckStatus Check (Status In ('A', 'I'))

Insert Into Teste (Nome, cpf, Status) Values ('Abc', '2', 'B')

select * from teste



