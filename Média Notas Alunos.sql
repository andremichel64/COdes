select

  sum 	  (case when (IsNumeric(ab.media_informada02) = 1) and (ab.media_informada02 Is Not Null)   then convert(float,ab.media_informada02)
           when (IsNumeric(ab.media_informada01) = 1) And (ab.media_informada01 Is Not Null)        then convert(float,ab.media_informada01)
           when (IsNumeric(ab.media_calculada) = 1) And (ab.media_calculada Is Not Null)            then convert(float,ab.media_calculada)
           else Null
           end) / count(*) AS media, ab.cod_disciplina, d.nome,  d.abreviatura, ab.cod_turma, bimestre, ab.cod_aluno, ab.cod_escola, ab.ano, ab.cod_serie, A.nome
           
           from
           
  		   Avaliacao_Bimestral ab
  
  		   
  inner join v_matricula mc on
  mc.entidade       = ab.entidade          and
  mc.cod_escola     = ab.cod_escola        and
  mc.cod_serie      = ab.cod_serie         and
  mc.cod_turma      = ab.cod_turma         and
  mc.cod_aluno      = ab.cod_aluno         and
  mc.ano            = ab.ano
                               
                               
  inner join Abertura_ano aa on 
  aa.ano           = mc.ano               and
  aa.entidade      = mc.entidade          and
  aa.cod_escola    = mc.cod_escola
                                
                                
  inner join Turma_Disciplina_Ano tda on 
  ab.entidade       = tda.entidade        and
  ab.cod_escola     = tda.cod_escola      and
  ab.cod_serie      = tda.cod_serie       and
  ab.cod_turma      = tda.cod_turma       and
  ab.ano            = tda.ano             and
  ab.cod_disciplina = tda.cod_disciplina
                                         
  inner join Disciplina_Nivel dn on 
  tda.cod_disciplina  = dn.cod_disciplina and
  tda.cod_escola      = dn.cod_escola     and
  tda.entidade        = dn.entidade
                                    
  inner join Disciplina d on 
  tda.cod_disciplina  = d.cod_disciplina  and
  tda.cod_escola      = d.cod_escola      and
  tda.entidade        = d.entidade
                             
  inner join Escola_Serie es on 
  tda.cod_serie    = es.cod_serie       and
  tda.entidade     = es.entidade        and
  tda.cod_escola   = es.cod_escola      and
  es.cod_nivel     = dn.cod_nivel
  
  INNER JOIN Aluno as A on 
  mc.entidade       = A.entidade           and
  mc.cod_escola     = A.cod_escola         and
  mc.cod_aluno      = A.cod_aluno          
  
                                
where
  isnull(tda.BOLETIM, 1) = 1  
  and  ab.entidade       = 1522         
  and  ab.ano between 2016 and 2019
  and  ab.bimestre  between 1 and 4
  and  ab.media_calculada is not null  
  and  (((  mc.cod_motivo_desligamento is  null               )     or
  ((  mc.cod_motivo_desligamento = aa.cod_motivo_aprovacao   ))     or
  (  mc.cod_motivo_desligamento = aa.cod_motivo_reprovacao  )))

  
group by   ab.entidade,  ab.cod_escola,  ab.cod_serie,  ab.cod_turma,  ab.ano,  ab.bimestre,  ab.cod_disciplina,  d.nome,  dn.ordem,  d.abreviatura,  ab.cod_aluno,  ab.cod_escola,  ab.ano, ab.cod_serie, A.nome

order by  dn.ordem
