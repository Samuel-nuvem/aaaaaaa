-- =============================================
-- SCRIPT PARA CRIAR O BANCO DE DADOS ainnovate_db
-- =============================================
-- Este script cria o banco, as tabelas e insere dados de exemplo.
-- Execute em um ambiente MySQL (versão 5.7+ recomendada).
-- =============================================

-- 1. Criar o banco de dados (se não existir)
CREATE DATABASE IF NOT EXISTS ainnovate_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- 2. Usar o banco de dados criado
USE ainnovate_db;

-- 3. Criar tabela para mensagens de contato (do formulário #contactForm)
CREATE TABLE IF NOT EXISTS contatos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    mensagem TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Criar tabela para registros de planos escolhidos (ex.: após clique em "Escolher Plano" ou pós-Stripe)
CREATE TABLE IF NOT EXISTS planos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email_usuario VARCHAR(255) NOT NULL,  -- Email do usuário que escolheu o plano
    tipo_plano ENUM('basico', 'premium', 'enterprise') NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,  -- Ex.: 5000.00
    status ENUM('pendente', 'pago', 'cancelado') DEFAULT 'pendente',
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    stripe_session_id VARCHAR(255) NULL,  -- ID da sessão Stripe para rastreio (opcional)
    INDEX idx_email (email_usuario),
    INDEX idx_tipo (tipo_plano)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Inserir dados de exemplo (opcional, para testar as tabelas)
-- Exemplos para tabela contatos
INSERT INTO contatos (email, mensagem) VALUES 
('exemplo1@email.com', 'Olá, estou interessado em consultoria de IA para minha empresa.'),
('exemplo2@email.com', 'Preciso de um chatbot customizado. Qual o prazo?');

-- Exemplos para tabela planos
INSERT INTO planos (email_usuario, tipo_plano, preco, status) VALUES 
('cliente1@example.com', 'basico', 5000.00, 'pendente'),
('cliente2@example.com', 'premium', 15000.00, 'pago'),
('cliente3@example.com', 'enterprise', 30000.00, 'pendente');

-- =============================================
-- FIM DO SCRIPT
-- =============================================
-- Para verificar: Execute "SHOW TABLES;" para ver as tabelas.
-- Para ver dados: "SELECT * FROM contatos;" ou "SELECT * FROM planos;".
