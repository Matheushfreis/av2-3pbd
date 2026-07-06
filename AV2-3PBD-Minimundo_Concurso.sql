-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 29/06/2026 às 04:06
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `concurso`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `boleto`
--

CREATE TABLE `boleto` (
  `boletoID` int(11) NOT NULL,
  `inscricaoID` int(11) NOT NULL,
  `pagamentoID` int(11) NOT NULL,
  `valor` decimal(11,0) NOT NULL,
  `status` enum('pago','pendente') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `candidato`
--

CREATE TABLE `candidato` (
  `candidatoID` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `email` varchar(40) NOT NULL,
  `login` varchar(40) NOT NULL,
  `hashSenha` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `candidato_prova`
--

CREATE TABLE `candidato_prova` (
  `candidato_provaID` int(11) NOT NULL,
  `candidatoID` int(11) NOT NULL,
  `provaID` int(11) NOT NULL,
  `respostas` varchar(100) NOT NULL,
  `acertos` int(11) NOT NULL,
  `erros` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `concurso`
--

CREATE TABLE `concurso` (
  `concursoID` int(11) NOT NULL,
  `data_inicio_inscricao` date NOT NULL,
  `data_final_inscricao` date NOT NULL,
  `taxa_inscricao` decimal(10,0) NOT NULL,
  `abrangencia` enum('federal','estadual','municipal') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `inscricoes`
--

CREATE TABLE `inscricoes` (
  `inscricaoID` int(11) NOT NULL,
  `concursoID` int(11) NOT NULL,
  `candidatoID` int(11) NOT NULL,
  `local_provaID` int(11) NOT NULL,
  `cargo` varchar(40) NOT NULL,
  `nota` decimal(10,0) NOT NULL,
  `isencao` tinyint(1) NOT NULL,
  `status_isencao` enum('pendente','deferido','indeferido') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `lista_presenca`
--

CREATE TABLE `lista_presenca` (
  `lista_presencaID` int(11) NOT NULL,
  `salaID` int(11) NOT NULL,
  `candidatoID` int(11) NOT NULL,
  `presente` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `local_prova`
--

CREATE TABLE `local_prova` (
  `local_provaID` int(11) NOT NULL,
  `concursoID` int(11) NOT NULL,
  `endereco` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagamento`
--

CREATE TABLE `pagamento` (
  `pagamentoID` int(11) NOT NULL,
  `valor` double NOT NULL,
  `status` enum('pago','pendente') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `prova`
--

CREATE TABLE `prova` (
  `provaID` int(11) NOT NULL,
  `concursoID` int(11) NOT NULL,
  `cargo` varchar(40) NOT NULL,
  `gabarito` varchar(40) NOT NULL,
  `peso` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `prova_questao`
--

CREATE TABLE `prova_questao` (
  `prova_questaoID` int(11) NOT NULL,
  `provaID` int(11) NOT NULL,
  `questaoID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `questao`
--

CREATE TABLE `questao` (
  `questaoID` int(11) NOT NULL,
  `questao` varchar(100) NOT NULL,
  `gabarito` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `recurso`
--

CREATE TABLE `recurso` (
  `recursoID` int(11) NOT NULL,
  `prova_questaoID` int(11) NOT NULL,
  `candidatoID` int(11) NOT NULL,
  `status` enum('pendente','em analise','deferido','indeferido') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sala`
--

CREATE TABLE `sala` (
  `salaID` int(11) NOT NULL,
  `provaID` int(11) NOT NULL,
  `local_provaID` int(11) NOT NULL,
  `fiscal` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `boleto`
--
ALTER TABLE `boleto`
  ADD PRIMARY KEY (`boletoID`),
  ADD KEY `inscricaoID` (`inscricaoID`),
  ADD KEY `pagamentoID` (`pagamentoID`);

--
-- Índices de tabela `candidato`
--
ALTER TABLE `candidato`
  ADD PRIMARY KEY (`candidatoID`);

--
-- Índices de tabela `candidato_prova`
--
ALTER TABLE `candidato_prova`
  ADD PRIMARY KEY (`candidato_provaID`),
  ADD KEY `candidatoID` (`candidatoID`),
  ADD KEY `provaID` (`provaID`);

--
-- Índices de tabela `concurso`
--
ALTER TABLE `concurso`
  ADD PRIMARY KEY (`concursoID`);

--
-- Índices de tabela `inscricoes`
--
ALTER TABLE `inscricoes`
  ADD PRIMARY KEY (`inscricaoID`),
  ADD KEY `candidatoID` (`candidatoID`),
  ADD KEY `concursoID` (`concursoID`),
  ADD KEY `local_provaID` (`local_provaID`);

--
-- Índices de tabela `lista_presenca`
--
ALTER TABLE `lista_presenca`
  ADD PRIMARY KEY (`lista_presencaID`),
  ADD KEY `candidatoID` (`candidatoID`),
  ADD KEY `salaID` (`salaID`);

--
-- Índices de tabela `local_prova`
--
ALTER TABLE `local_prova`
  ADD PRIMARY KEY (`local_provaID`),
  ADD KEY `concursoID` (`concursoID`);

--
-- Índices de tabela `pagamento`
--
ALTER TABLE `pagamento`
  ADD PRIMARY KEY (`pagamentoID`);

--
-- Índices de tabela `prova`
--
ALTER TABLE `prova`
  ADD PRIMARY KEY (`provaID`),
  ADD KEY `concursoID` (`concursoID`);

--
-- Índices de tabela `prova_questao`
--
ALTER TABLE `prova_questao`
  ADD PRIMARY KEY (`prova_questaoID`),
  ADD KEY `provaID` (`provaID`),
  ADD KEY `questaoID` (`questaoID`);

--
-- Índices de tabela `questao`
--
ALTER TABLE `questao`
  ADD PRIMARY KEY (`questaoID`);

--
-- Índices de tabela `recurso`
--
ALTER TABLE `recurso`
  ADD PRIMARY KEY (`recursoID`),
  ADD KEY `candidatoID` (`candidatoID`),
  ADD KEY `prova_questaoID` (`prova_questaoID`);

--
-- Índices de tabela `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`salaID`),
  ADD KEY `provaID` (`provaID`),
  ADD KEY `local_provaID` (`local_provaID`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `boleto`
--
ALTER TABLE `boleto`
  MODIFY `boletoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `candidato`
--
ALTER TABLE `candidato`
  MODIFY `candidatoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `candidato_prova`
--
ALTER TABLE `candidato_prova`
  MODIFY `candidato_provaID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `concurso`
--
ALTER TABLE `concurso`
  MODIFY `concursoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `inscricoes`
--
ALTER TABLE `inscricoes`
  MODIFY `inscricaoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lista_presenca`
--
ALTER TABLE `lista_presenca`
  MODIFY `lista_presencaID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `local_prova`
--
ALTER TABLE `local_prova`
  MODIFY `local_provaID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pagamento`
--
ALTER TABLE `pagamento`
  MODIFY `pagamentoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `prova`
--
ALTER TABLE `prova`
  MODIFY `provaID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `prova_questao`
--
ALTER TABLE `prova_questao`
  MODIFY `prova_questaoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `questao`
--
ALTER TABLE `questao`
  MODIFY `questaoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `recurso`
--
ALTER TABLE `recurso`
  MODIFY `recursoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sala`
--
ALTER TABLE `sala`
  MODIFY `salaID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `boleto`
--
ALTER TABLE `boleto`
  ADD CONSTRAINT `boleto_ibfk_1` FOREIGN KEY (`inscricaoID`) REFERENCES `inscricoes` (`inscricaoID`),
  ADD CONSTRAINT `boleto_ibfk_2` FOREIGN KEY (`pagamentoID`) REFERENCES `pagamento` (`pagamentoID`);

--
-- Restrições para tabelas `candidato_prova`
--
ALTER TABLE `candidato_prova`
  ADD CONSTRAINT `candidato_prova_ibfk_1` FOREIGN KEY (`candidatoID`) REFERENCES `candidato` (`candidatoID`),
  ADD CONSTRAINT `candidato_prova_ibfk_2` FOREIGN KEY (`provaID`) REFERENCES `prova` (`provaID`);

--
-- Restrições para tabelas `inscricoes`
--
ALTER TABLE `inscricoes`
  ADD CONSTRAINT `inscricoes_ibfk_1` FOREIGN KEY (`candidatoID`) REFERENCES `candidato` (`candidatoID`),
  ADD CONSTRAINT `inscricoes_ibfk_2` FOREIGN KEY (`concursoID`) REFERENCES `concurso` (`concursoID`),
  ADD CONSTRAINT `inscricoes_ibfk_3` FOREIGN KEY (`local_provaID`) REFERENCES `local_prova` (`local_provaID`);

--
-- Restrições para tabelas `lista_presenca`
--
ALTER TABLE `lista_presenca`
  ADD CONSTRAINT `lista_presenca_ibfk_1` FOREIGN KEY (`candidatoID`) REFERENCES `candidato` (`candidatoID`),
  ADD CONSTRAINT `lista_presenca_ibfk_2` FOREIGN KEY (`salaID`) REFERENCES `sala` (`salaID`);

--
-- Restrições para tabelas `local_prova`
--
ALTER TABLE `local_prova`
  ADD CONSTRAINT `local_prova_ibfk_1` FOREIGN KEY (`concursoID`) REFERENCES `concurso` (`concursoID`);

--
-- Restrições para tabelas `prova`
--
ALTER TABLE `prova`
  ADD CONSTRAINT `prova_ibfk_1` FOREIGN KEY (`concursoID`) REFERENCES `concurso` (`concursoID`);

--
-- Restrições para tabelas `prova_questao`
--
ALTER TABLE `prova_questao`
  ADD CONSTRAINT `prova_questao_ibfk_1` FOREIGN KEY (`provaID`) REFERENCES `prova` (`provaID`),
  ADD CONSTRAINT `prova_questao_ibfk_2` FOREIGN KEY (`questaoID`) REFERENCES `questao` (`questaoID`);

--
-- Restrições para tabelas `recurso`
--
ALTER TABLE `recurso`
  ADD CONSTRAINT `recurso_ibfk_1` FOREIGN KEY (`candidatoID`) REFERENCES `candidato` (`candidatoID`),
  ADD CONSTRAINT `recurso_ibfk_2` FOREIGN KEY (`prova_questaoID`) REFERENCES `prova_questao` (`prova_questaoID`);

--
-- Restrições para tabelas `sala`
--
ALTER TABLE `sala`
  ADD CONSTRAINT `sala_ibfk_1` FOREIGN KEY (`provaID`) REFERENCES `prova` (`provaID`),
  ADD CONSTRAINT `sala_ibfk_2` FOREIGN KEY (`local_provaID`) REFERENCES `local_prova` (`local_provaID`);
COMMIT;

-- 1. Criar um Candidato
INSERT INTO candidato (nome, endereco, email, login, hashSenha) 
VALUES ('Ana Souza', 'Rua das Flores, 123', 'ana.souza@email.com', 'anasouza', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a');

-- 2. Criar um Concurso (Edital aberto)
INSERT INTO concurso (data_inicio_inscricao, data_final_inscricao, taxa_inscricao, abrangencia) 
VALUES ('2026-08-01', '2026-08-30', 120.00, 'estadual');

-- 3. Criar um Local de Prova para o Concurso 1
INSERT INTO local_prova (concursoID, endereco) 
VALUES (1, 'Escola Estadual Central - Av. Principal, 1000');

-- 4. Inscrever o Candidato no Concurso
INSERT INTO inscricoes (concursoID, candidatoID, local_provaID, cargo, nota, isencao, status_isencao) 
VALUES (1, 1, 1, 'Analista de Sistemas', 0.00, 1, 'pendente');

-- 5. Preparar ambiente para Recurso: Criar Questão, Prova e Relacionar
INSERT INTO prova (concursoID, cargo, gabarito, peso) VALUES (1, 'Analista de Sistemas', 'A-B-C-D', 2.5);
INSERT INTO questao (questao, gabarito) VALUES ('O que é SQL?', 'D');
INSERT INTO prova_questao (provaID, questaoID) VALUES (1, 1);

-- 6. Candidato abre um recurso contra a questão
INSERT INTO recurso (prova_questaoID, candidatoID, status) 
VALUES (1, 1, 'pendente');


-- -------------------------------------------------------------------------
-- READ (Consultas Funcionais)
-- -------------------------------------------------------------------------

-- Visualizar inscrições cruzando com dados do candidato
SELECT i.inscricaoID, c.nome, i.cargo, i.isencao, i.status_isencao, i.nota
FROM inscricoes i
INNER JOIN candidato c ON i.candidatoID = c.candidatoID
WHERE i.concursoID = 1;

-- Consultar os recursos abertos e seus respectivos status
SELECT r.recursoID, c.nome AS candidato, q.questao, r.status 
FROM recurso r
INNER JOIN candidato c ON r.candidatoID = c.candidatoID
INNER JOIN prova_questao pq ON r.prova_questaoID = pq.prova_questaoID
INNER JOIN questao q ON pq.questaoID = q.questaoID;


-- -------------------------------------------------------------------------
-- UPDATE (Atualização de Registros)
-- -------------------------------------------------------------------------

-- Banca analisou a isenção de taxa e deferiu
UPDATE inscricoes SET status_isencao = 'deferido' WHERE inscricaoID = 1;

-- Atualizar nota final do candidato
UPDATE inscricoes SET nota = 85.50 WHERE inscricaoID = 1;

-- Banca avalia o recurso e decide anular a questão (deferido)
UPDATE recurso SET status = 'deferido' WHERE recursoID = 1;


-- -------------------------------------------------------------------------
-- DELETE (Remoção de Registros)
-- -------------------------------------------------------------------------
-- NOTA: Execute estes deletes na ordem inversa para evitar erros de FK

-- 1. Candidato desiste e exclui seu próprio recurso
DELETE FROM recurso WHERE recursoID = 1;

-- 2. Sistema cancela a inscrição do candidato
DELETE FROM inscricoes WHERE inscricaoID = 1;

-- 3. Concurso é revogado (precisa limpar locais e provas antes)
DELETE FROM local_prova WHERE local_provaID = 1;
DELETE FROM prova WHERE provaID = 1;
DELETE FROM concurso WHERE concursoID = 1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
