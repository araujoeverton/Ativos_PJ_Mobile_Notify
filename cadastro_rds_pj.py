import pip install 
from faker import Faker
from datetime import date, timedelta
import random
import psycopg2

# Detalhes da conexão com o banco de dados Aurora RDS
DB_HOST = "ativos-pj-rds-cluster-instance-1.c07gis2620tg.us-east-1.rds.amazonaws.com"
DB_NAME = "ativospjdb"
DB_USER = "postgres"
DB_PASSWORD = "postgres"

# Lista de produtos fornecida
produtos_data = [
    {
        "nome": "Itaú Kinea Oportunidade Renda Fixa Crédito Privado",
        "juros": "pós-fixados",
        "risco": "médio",
        "tipo": "Fundos de Investimento",
        "valor_minimo": 1000.00,
        "tempo_resgate_dias": 90,
    },
    {
        "nome": "Absolute Creta Seleção Renda Fixa Crédito Privado",
        "juros": "pós-fixados",
        "risco": "médio",
        "tipo": "Fundos de Investimento",
        "valor_minimo": 1.00,
        "tempo_resgate_dias": 30,
    },
    {
        "nome": "Itaú Active Fix 5 Crédito Privado Renda Fixa",
        "juros": "pós-fixados",
        "risco": "médio",
        "tipo": "Fundos de Investimento",
        "valor_minimo": 1.00,
        "tempo_resgate_dias": 6,
    },
    {
        "nome": "Absolute Hidra CDI Plus Seleção Infra Renda Fixa",
        "juros": "pós-fixados",
        "risco": "alto",
        "tipo": "Fundos de Investimento",
        "valor_minimo": 1.00,
        "tempo_resgate_dias": 30,
    },
    {
        "nome": "Itaú Debêntures Incentivadas CDI Mix Renda Fixa",
        "juros": "pós-fixados",
        "risco": "alto",
        "tipo": "Fundos de Investimento",
        "valor_minimo": 1.00,
        "tempo_resgate_dias": 44,
    },
]

# Mapeamento do tempo de resgate para a coluna 'resgate'
resgate_mapping = {
    range(1, 2): "em 1 dia",
    range(2, 6): "entre 2 e 5 dias",
    range(6, 91): "acima de 5 dias",  # Incluindo até 90 dias
    90: "acima de 5 dias", # Tratamento específico para 90 dias
    30: "acima de 5 dias", # Tratamento específico para 30 dias
    44: "acima de 5 dias", # Tratamento específico para 44 dias
}

def map_resgate(dias):
    if dias == 1:
        return "em 1 dia"
    elif 2 <= dias <= 5:
        return "entre 2 e 5 dias"
    else:
        return "acima de 5 dias"

# Inicializa o Faker para dados aleatórios em português do Brasil
fake = Faker('pt_BR')

def connect_db():
    """Conecta ao banco de dados PostgreSQL."""
    conn = None
    try:
        conn = psycopg2.connect(host=DB_HOST, database=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        return conn
    except psycopg2.Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

def insert_cliente(conn):
    """Insere um cliente PJ fictício e retorna o ID."""
    cursor = conn.cursor()
    cnpj = fake.cnpj()
    razao_social = fake.company()
    nome_fantasia = fake.company_suffix() + " " + fake.company_noun()
    query = "INSERT INTO clientes_pj (cnpj, razao_social, nome_fantasia) VALUES (%s, %s, %s) RETURNING id;"
    cursor.execute(query, (cnpj, razao_social, nome_fantasia))
    cliente_id = cursor.fetchone()[0]
    conn.commit()
    cursor.close()
    print(f"Cliente PJ inserido com ID: {cliente_id}")
    return cliente_id

def insert_produto(conn, nome, tipo):
    """Insere um produto e retorna o ID."""
    cursor = conn.cursor()
    query = "INSERT INTO produtos (nome, tipo) VALUES (%s, %s) RETURNING id;"
    cursor.execute(query, (nome, tipo))
    produto_id = cursor.fetchone()[0]
    conn.commit()
    cursor.close()
    print(f"Produto '{nome}' inserido com ID: {produto_id}")
    return produto_id

def insert_fundo_investimento(conn, produto_id, risco, juros, valor_minimo, tempo_resgate_dias):
    """Insere os detalhes de um fundo de investimento."""
    cursor = conn.cursor()
    # Mapeia a classificação com base nos juros
    classificacao = ""
    if "pós-fixados" in juros.lower():
        classificacao = "juros pós-fixados"
    elif "prefixados" in juros.lower():
        classificacao = "juros prefixados"
    elif "ações" in juros.lower():
        classificacao = "ações"
    else:
        classificacao = "multimercados" # Caso não se encaixe nas outras

    resgate = map_resgate(tempo_resgate_dias)

    query = """
        INSERT INTO fundos_investimento (produto_id, risco, classificacao, resgate, aplicacao_minima)
        VALUES (%s, %s, %s, %s, %s);
    """
    cursor.execute(query, (produto_id, risco.lower(), classificacao, resgate, valor_minimo))
    conn.commit()
    cursor.close()
    print(f"Detalhes do fundo de investimento (ID Produto: {produto_id}) inseridos.")

def insert_investimento(conn, cliente_id, produto_id, produto_nome, tempo_resgate_dias):
    """Insere um investimento fictício para o cliente no produto, com lógica especial para o Itaú Kinea."""
    cursor = conn.cursor()
    data_investimento = fake.date_between(start_date='-1y', end_date='today')
    valor = round(random.uniform(100, 10000), 2)
    status = 'Ativo'  # Definindo como ativo para facilitar o cálculo da data de resgate

    if produto_nome == "Itaú Kinea Oportunidade Renda Fixa Crédito Privado":
        data_resgate = data_investimento + timedelta(days=tempo_resgate_dias - 2)
    else:
        data_resgate = None # Para os outros produtos, a data de resgate pode ser nula ou calculada aleatoriamente depois

    valor_resgate = None # Inicialmente nulo para investimentos ativos

    query = """
        INSERT INTO investimentos (cliente_id, produto_id, data_investimento, valor, data_resgate, valor_resgate, status)
        VALUES (%s, %s, %s, %s, %s, %s, %s);
    """
    cursor.execute(query, (cliente_id, produto_id, data_investimento, valor, data_resgate, valor_resgate, status))
    conn.commit()
    cursor.close()
    print(f"Investimento para Cliente {cliente_id} no Produto '{produto_nome}' inserido.")

if __name__ == "__main__":
    conn = connect_db()
    if conn:
        cliente_id = insert_cliente(conn)
        for produto in produtos_data:
            produto_id = insert_produto(conn, produto["nome"], produto["tipo"])
            if produto["tipo"] == "Fundos de Investimento":
                insert_fundo_investimento(
                    conn,
                    produto_id,
                    produto["risco"],
                    produto["juros"],
                    produto["valor_minimo"],
                    produto["tempo_resgate_dias"],
                )
            insert_investimento(conn, cliente_id, produto_id, produto["nome"], produto["tempo_resgate_dias"])
        conn.close()
        print("Script de inserção de dados concluído.")
    else:
        print("Não foi possível conectar ao banco de dados.")