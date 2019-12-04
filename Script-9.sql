use web_escola

SELECT  e.nome,A.cod_aluno,A.nome,MC.ano,MC.cod_serie,MC.data_matricula,MC.tipo_pgto,MC.parcelas,T.cod_servico,T.valor,R.descricao,TU.turno,MC.cod_motivo_matricula,
isnull(sum(case  when s.gratuidade = 1 then TA.percentual else 0 end),0),
isnull(sum(case  when s.gratuidade is null or s.gratuidade = 0 then TA.percentual else 0 end),0) ,
isnull(sum(case  when s.gratuidade is null or s.gratuidade = 0 then TA.valor else 0 end),0) 
FROM    Web_Escola.dbo.Aluno A


inner join  Web_Escola.dbo.Matricula_Curso MC on  
A.cod_aluno   = MC.cod_aluno   AND
A.cod_escola  = MC.cod_escola  AND
A.entidade    = MC.entidade    AND
MC.eh_default = 1              AND
MC.ano        > 2018           AND
MC.cod_motivo_matricula  <>23  AND
MC.cod_serie <> 150            AND
MC.data_desligamento           Is Null

inner join web_Escola.dbo.Taxas T on    
T.entidade    = MC.entidade   AND 
T.cod_escola  = MC.cod_escola AND 
T.cod_serie   = MC.cod_serie  AND
T.ano         = MC.ano        AND 
T.cod_tipo    = MC.cod_tipo   AND 
T.mes         = 3

inner join web_Escola.dbo.religiao R on 
R.cod_religiao  = a.cod_religiao

inner join web_Escola.dbo.turma as TU on
MC.cod_escola = TU.cod_escola AND
MC.cod_serie  = TU.cod_serie  AND
MC.cod_turma  = TU.cod_turma 

INNER JOIN Escola AS e ON e.cod_escola = a.cod_escola

left join  Web_Escola.dbo.Taxas_Aluno TA on  
MC.entidade    = TA.entidade    AND 
MC.cod_escola  = TA.cod_escola  AND 
MC.cod_aluno   = TA.cod_aluno   AND
MC.cod_serie   = TA.cod_serie   AND
MC.ano         = TA.ano         AND
TA.cod_servico <> 245           
left join  Web_Escola.dbo.Servicos S on    
TA.cod_servico    = S.cod_servico    AND
S.NATUREZA    = 'D'

group by  A.cod_escola,MC.cod_serie,A.cod_aluno,A.nome,MC.ano,MC.data_matricula,MC.tipo_pgto,MC.parcelas,T.cod_servico,T.valor,R.descricao,e.nome,tu.turno,MC.cod_motivo_matricula
order by  A.cod_escola,MC.cod_serie,A.cod_aluno,A.nome,MC.ano,MC.data_matricula,MC.tipo_pgto,MC.parcelas,T.cod_servico,T.valor,R.descricao