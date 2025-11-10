# 🗄️ SYMBIO - Database

Este repositório contém a modelagem e os scripts SQL para a implementação do banco de dados relacional do projeto **SYMBIO**, desenvolvido para o Global Solution FIAP 2025.

## 📝 Sobre o Projeto
A **SYMBIO** é uma plataforma de inteligência corporativa focada em requalificação interna. Este banco de dados Oracle é fundamental para armazenar informações de colaboradores, cargos, riscos de automação e habilidades (skills), permitindo o "match" inteligente de carreiras.

## 📂 Estrutura do Repositório

* `/modelagem`: Contém os diagramas do Modelo Entidade-Relacionamento (MER) lógico e relacional.
* `/clean-database`:
    * `clean_symbio.sql`: Utilitário para **apagar** todas as tabelas do projeto. Use caso precise resetar completamente o ambiente antes de rodar o script principal novamente.
* `symbio.sql`: **Script principal**. Contém a criação (DDL), população (DML) e consultas (DQL) em um único arquivo executável.

## 🛠️ Tecnologias Utilizadas
* **Banco de Dados:** Oracle Database
* **Ferramenta de Modelagem:** Oracle SQL Developer Data Modeler

## 🚀 Como Executar

### Execução Padrão
1.  Abra sua ferramenta de banco de dados (SQL Developer, DBeaver, etc.) e conecte-se ao Oracle.
2.  Execute o arquivo `script_completo_symbio.sql`. Ele foi projetado para criar toda a estrutura, inserir os dados de teste e rodar as consultas de validação de uma só vez.

### Resetando o Banco (Opcional)
Caso precise limpar seu ambiente de testes rapidamente sem recriar as tabelas imediatamente:
1.  Execute o script `/clean-database/clean_symbio.sql`.
2.  Todas as tabelas relacionadas ao SYMBIO serão removidas.
