SELECT e.nome, a.cod_escola  ,a.cod_aluno,r.e_mail,c.data_vencimento,c.valor,c.cod_cc_quitacao
FROM Aluno AS a 
INNER JOIN Responsavel AS r ON a.CPF_resp_financeiro = r.CPF
INNER JOIN Carne AS c ON c.cod_aluno = a.cod_aluno AND c.cod_escola = a.cod_escola
INNER JOIN Escola AS e ON e.cod_escola = a.cod_escola
WHERE  a.cod_escola = 205 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 209 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 210 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 214 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 216 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 218 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 221 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 245 and c.data_vencimento > '2019' and c.valor > 0
or a.cod_escola = 246 and c.data_vencimento > '2019' and c.valor > 0

