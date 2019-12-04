use web_escola

SELECT		A.cod_escola, A.cod_aluno, A.nome, MC.ano, MC.cod_serie, MC.data_matricula, MC.tipo_pgto, MC.parcelas, T.cod_servico, T.valor, TU.turno, MC.cod_turma,

isnull(sum(case	when s.gratuidade = 1 then TA.percentual else 0 end),0), 
isnull(sum(case	when s.gratuidade is null or s.gratuidade = 0	then TA.percentual	else 0 end),0),	
isnull(sum(case	when s.gratuidade is null or s.gratuidade = 0	then TA.valor else 0 end),0) 
				
FROM		Web_Escola.dbo.Aluno as A

 inner join	Web_Escola.dbo.Matricula_Curso as MC on	
 							A.cod_aluno		= MC.cod_aluno		AND 
							A.cod_escola	= MC.cod_escola		AND 
							A.entidade		= MC.entidade		AND
							MC.eh_default	= 1					AND
							MC.ano			> 2018				AND
							MC.cod_motivo_matricula	<>23		AND 
							MC.data_desligamento				Is Null
 inner join	web_Escola.dbo.Taxas as T on		
 							T.entidade		= MC.entidade		AND 
							T.cod_escola	= MC.cod_escola		AND 
							T.cod_serie		= MC.cod_serie		AND
							T.ano			= MC.ano			AND 
							T.cod_tipo		= MC.cod_tipo		AND 
							T.mes			= 3
							
 left join	Web_Escola.dbo.Taxas_Aluno as TA on	
 							MC.entidade		= TA.entidade		AND 
							MC.cod_escola	= TA.cod_escola		AND 
							MC.cod_aluno	= TA.cod_aluno		AND
							MC.cod_serie	= TA.cod_serie		AND
							MC.ano			= TA.ano			AND
							TA.cod_servico	<> 245
							
 left join	Web_Escola.dbo.Servicos S on	
 							TA.cod_servico	= S.cod_servico		AND
							S.NATUREZA		= 'D'
							
 inner join web_Escola.dbo.turma as TU on
							MC.cod_escola 		= TU.cod_escola AND
							MC.cod_serie  		= TU.cod_serie  AND
							MC.cod_turma  		= TU.cod_turma 


group by	A.cod_escola, MC.cod_serie, A.cod_aluno, A.nome, MC.ano, MC.data_matricula, MC.tipo_pgto, MC.parcelas, T.cod_servico, T.valor, TU.turno, MC.cod_turma
order by	A.cod_escola, MC.cod_serie, A.cod_aluno, A.nome, MC.ano