SELECT Aluno.cod_escola, Escola.nome, Aluno.cod_aluno, Aluno.nome, Matricula_Curso.cod_serie, Matricula_Curso.cod_motivo_matricula, Motivo_Matricula.descricao, Matricula_Curso.data_matricula, Matricula_Curso.eh_default

FROM Web_Escola.dbo.Aluno Aluno, Web_Escola.dbo.Escola Escola, Web_Escola.dbo.Matricula_Curso Matricula_Curso, Web_Escola.dbo.Motivo_Matricula Motivo_Matricula

WHERE 

Matricula_Curso.cod_aluno = Aluno.cod_aluno  								 AND 
Matricula_Curso.cod_escola = Aluno.cod_escola 								 AND 
Matricula_Curso.entidade = Aluno.entidade     								 AND 
Motivo_Matricula.cod_motivo_matricula = Matricula_Curso.cod_motivo_matricula AND 
Escola.cod_escola = Aluno.cod_escola 										 AND 
Escola.cod_escola = Matricula_Curso.cod_escola 								 AND
Escola.entidade = Aluno.entidade 										     AND 
Escola.entidade = Matricula_Curso.entidade 									 AND 
Matricula_Curso.ano = 2020 												     AND 
Matricula_Curso.cod_serie <> 150            								 AND
Motivo_Matricula.cod_motivo_matricula <> 23 								 AND 
Matricula_Curso.data_desligamento 											 Is Null

Group by Aluno.cod_escola, Escola.nome, Aluno.cod_aluno, Aluno.nome, Matricula_Curso.cod_serie, Matricula_Curso.cod_motivo_matricula, Motivo_Matricula.descricao, Matricula_Curso.data_matricula,Matricula_Curso.eh_default
order by Aluno.cod_escola, Escola.nome, Aluno.cod_aluno, Aluno.nome, Matricula_Curso.cod_serie, Matricula_Curso.cod_motivo_matricula, Motivo_Matricula.descricao, Matricula_Curso.data_matricula