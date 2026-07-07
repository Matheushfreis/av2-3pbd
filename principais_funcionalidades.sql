-- Inserindo um candidato em um concurso específico
INSERT INTO inscricoes (
    concursoID, 
    candidatoID, 
    local_provaID, 
    cargo, 
    nota, 
    isencao, 
    status_isencao
) 
VALUES (
    1,                       -- ID do Concurso
    2,                       -- ID do Candidato
    1,                       -- ID do Local de Prova escolhido
    'Engenheiro de Dados',   -- Cargo pretendido
    0.00,                    -- Nota inicial é zero
    0,                       -- 0 para Não Isento, 1 para Isento
    'indeferido'             -- Status inicial da isenção caso não tenha pedido
);

-- Atualizando o status do pagamento e do boleto simultaneamente
UPDATE boleto b
INNER JOIN pagamento p ON b.pagamentoID = p.pagamentoID
SET 
    b.status = 'pago', 
    p.status = 'pago'
WHERE b.boletoID = 12345; -- ID do boleto retornado pelo banco

-- Gerando a lista de candidatos por local e sala para assinatura
SELECT 
    lp.endereco AS Local_Prova,
    s.salaID AS Numero_Sala,
    s.fiscal AS Nome_Fiscal,
    c.nome AS Candidato,
    pres.presente AS Status_Presenca
FROM lista_presenca pres
INNER JOIN sala s ON pres.salaID = s.salaID
INNER JOIN local_prova lp ON s.local_provaID = lp.local_provaID
INNER JOIN candidato c ON pres.candidatoID = c.candidatoID
WHERE lp.concursoID = 1 
ORDER BY lp.endereco, s.salaID, c.nome;

-- Calculando a nota final baseada nos acertos e no peso da prova
UPDATE inscricoes i
INNER JOIN candidato_prova cp ON i.candidatoID = cp.candidatoID
INNER JOIN prova p ON cp.provaID = p.provaID
SET i.nota = (cp.acertos * p.peso)
WHERE i.concursoID = 1;

-- Ranking de candidatos para um determinado concurso e cargo
SELECT 
    c.nome AS Candidato,
    i.cargo AS Cargo,
    i.nota AS Nota_Final
FROM inscricoes i
INNER JOIN candidato c ON i.candidatoID = c.candidatoID
WHERE i.concursoID = 1 
  AND i.cargo = 'Analista de Sistemas'
ORDER BY i.nota DESC;

-- Relatório estatístico por cargo dentro de um concurso
SELECT 
    i.cargo AS Cargo,
    COUNT(i.inscricaoID) AS Total_Candidatos,
    ROUND(AVG(i.nota), 2) AS Media_Geral,
    MAX(i.nota) AS Nota_Mais_Alta,
    
    -- Conta como 1 se a nota for maior ou igual a 60 (Aprovado)
    SUM(CASE WHEN i.nota >= 60.00 THEN 1 ELSE 0 END) AS Qtd_Aprovados,
    
    -- Conta como 1 se a nota for menor que 60 (Reprovado)
    SUM(CASE WHEN i.nota < 60.00 THEN 1 ELSE 0 END) AS Qtd_Reprovados,
    
    -- Calcula a taxa de aprovação em porcentagem
    ROUND((SUM(CASE WHEN i.nota >= 60.00 THEN 1 ELSE 0 END) / COUNT(i.inscricaoID)) * 100, 2) AS Percentual_Aprovacao
    
FROM inscricoes i
WHERE i.concursoID = 1
GROUP BY i.cargo
ORDER BY Qtd_Aprovados DESC;
