-- Tabela Clientes PJ
CREATE TABLE clientes_pj (
    id SERIAL PRIMARY KEY,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Produtos
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) UNIQUE NOT NULL,
    tipo VARCHAR(50) NOT NULL, -- Ex: Fundos de Investimento, CDB, Renda Fixa, etc.
    descricao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
 
);

-- Tabela Investimentos
CREATE TABLE investimentos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes_pj(id),
    produto_id INTEGER REFERENCES produtos(id),
    data_investimento DATE NOT NULL,
    valor DECIMAL(15, 2) NOT NULL,
    data_resgate DATE, -- Pode ser nulo até o resgate
    valor_resgate DECIMAL(15, 2),
    status VARCHAR(20) NOT NULL, -- Ex: Ativo, Resgatado
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- Tabela Fundos Investimento
CREATE TABLE fundos_investimento (
    produto_id INTEGER PRIMARY KEY REFERENCES produtos(id),
    risco VARCHAR(10) NOT NULL CHECK (risco IN ('baixo', 'médio', 'alto')),
    classificacao VARCHAR(50) NOT NULL CHECK (classificacao IN ('juros pós-fixados', 'juros prefixados', 'ações', 'multimercados')),
    resgate VARCHAR(20) NOT NULL CHECK (resgate IN ('mesmo dia', 'em 1 dia', 'entre 2 e 5 dias', 'acima de 5 dias')),
    taxa_administracao DECIMAL(5, 2),
    aplicacao_minima DECIMAL(15, 2),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);