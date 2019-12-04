use web_escola

SELECT  A.cod_escola,A.cod_aluno,A.nome,MC.ano,MC.cod_serie,MC.data_matricula,MC.tipo_pgto,MC.parcelas,T.cod_servico,T.valor,R.descricao,A.cod_escola,A.cod_aluno,c.data_vencimento,c.valor,c.cod_cc_quitacao,MC.cod_motivo_matricula,
isnull(sum(case  when s.gratuidade = 1 then TA.percentual else 0 end),0),
isnull(sum(case  when s.gratuidade is null or s.gratuidade = 0 then TA.percentual else 0 end),0) ,
isnull(sum(case  when s.gratuidade is null or s.gratuidade = 0 then TA.valor else 0 end),0) 
FROM    Web_Escola.dbo.Aluno A

INNER JOIN Carne AS c ON c.cod_aluno = a.cod_aluno AND c.cod_escola = a.cod_escola
INNER JOIN Escola AS e ON e.cod_escola = a.cod_escola


inner join  Web_Escola.dbo.Matricula_Curso MC on  
A.cod_aluno   = MC.cod_aluno   AND
A.cod_escola  = MC.cod_escola  AND
A.entidade    = MC.entidade    AND
MC.eh_default = 1              AND
MC.cod_motivo_matricula <> 23   AND
MC.ano        > 2019           AND
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

left join  Web_Escola.dbo.Taxas_Aluno TA on  
MC.entidade    = TA.entidade    AND 
MC.cod_escola  = TA.cod_escola  AND 
MC.cod_aluno   = TA.cod_aluno   AND
MC.cod_serie   = TA.cod_serie   AND
MC.ano         = TA.ano           
left join  Web_Escola.dbo.Servicos S on    
TA.cod_servico    = S.cod_servico    AND
S.NATUREZA    = 'D'

WHERE  a.cod_escola = 205 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 209 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 210 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 214 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 216 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 218 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 221 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 245 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 246 and c.data_vencimento > '2019' and c.valor > 0

group by  A.cod_escola,MC.cod_serie,A.cod_aluno,A.nome,MC.ano,MC.data_matricula,MC.tipo_pgto,MC.parcelas,T.cod_servico,T.valor,R.descricao,A.cod_escola,A.cod_aluno,c.data_vencimento,c.valor,c.cod_cc_quitacao,MC.cod_motivo_matricula
order by  A.cod_escola,MC.cod_serie,A.cod_aluno,A.nome,MC.ano,MC.data_matricula,MC.tipo_pgto,MC.parcelas,T.cod_servico,T.valor,R.descricao
