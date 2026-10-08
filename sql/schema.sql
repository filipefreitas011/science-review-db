/* A chave primária deve autoincrementar via BIGSERIAL */

/*
ESTRATÉGIA DE TRADUÇÃO DO MODELO CONCEITUAL (PDF) PARA O RELACIONAL:
- Relacionamento 1:1 ou 1:N -> vira FK direto numa das tabelas existentes (lado "N" recebe a FK).
- Relacionamento N:M (ambos os lados podem ter mais de uma ocorrência) -> vira uma tabela própria
  (tabela associativa), com uma FK pra cada entidade participante + os atributos que são do
  PRÓPRIO relacionamento (não pertencem a nenhuma das duas entidades isoladamente).
  Tabelas associativas deste arquivo: tbl_pessoa_submissao (É_Autor), tbl_submissao_topico (Aborda),
  tbl_pessoa_topico (Tem_Expertise) e tbl_atribuicao_revisao (É_Revisor).
*/

CREATE TABLE tbl_instituicao (
    cp_id_instituicao BIGSERIAL PRIMARY KEY,
    nm_instituicao VARCHAR (200) NOT NULL,
    pais_instituicao CHAR(2),
    sg_instituicao VARCHAR(30),
    cidade_instituicao VARCHAR(100),
    uf_instituicao CHAR(2)
);

CREATE TABLE tbl_pessoa (
    cp_id_pessoa BIGSERIAL PRIMARY KEY,
    nm_pessoa VARCHAR(200) NOT NULL,
    email_principal VARCHAR(254) NOT NULL UNIQUE,
    cd_orcid VARCHAR(19) UNIQUE,
    pais_pessoa CHAR(2),
    ce_instituicao BIGINT, /* FK do relacionamento 'Pertence' (pessoa -> instituição). Cardinalidade (obrigatório x opcional) ainda precisa ser confirmada no diagrama; por ora está opcional (aceita NULL) */
    FOREIGN KEY (ce_instituicao) REFERENCES tbl_instituicao (cp_id_instituicao)
);

CREATE TABLE tbl_evento (
    cp_id_evento BIGSERIAL PRIMARY KEY,
    ce_evento_pai BIGINT, /* Relacionamento recursivo: trilha é tratada como um "sub-evento", ou seja, uma linha de tbl_evento cujo ce_evento_pai aponta para o evento principal. NULL = evento raiz; preenchido = linha que representa uma trilha */
    sg_evento VARCHAR(20) NOT NULL UNIQUE,
    nm_evento VARCHAR(200) NOT NULL,
    ano_edicao SMALLINT NOT NULL,
    dt_inicio DATE NOT NULL,
    dt_fim DATE NOT NULL,
    ds_evento TEXT,
    dt_fim_submissao DATE NOT NULL, 
    dt_inicio_submissao DATE NOT NULL, 
    ce_coordenador BIGINT NOT NULL, /*Adicionei pois trilha pede coordenador*/
    FOREIGN KEY (ce_coordenador) REFERENCES tbl_pessoa (cp_id_pessoa),
    FOREIGN KEY (ce_evento_pai) REFERENCES tbl_evento (cp_id_evento)
);

CREATE TABLE tbl_submissao (
    cp_id_submissao BIGSERIAL PRIMARY KEY,
    ce_trilha BIGINT NOT NULL,
    titulo_submissao VARCHAR(500) NOT NULL,
    resumo_submissao TEXT NOT NULL,
    idioma_submissao VARCHAR(20) NOT NULL,
    dt_registro TIMESTAMP NOT NULL,
    status_submissao VARCHAR(20),
    nm_arquico_pdf VARCHAR(200), /* nome do arquivo PDF do manuscrito (atributo nm_arquivo_pdf do modelo conceitual) */
    FOREIGN KEY (ce_trilha) REFERENCES tbl_evento (cp_id_evento) /* ce_trilha referencia tbl_evento pq a trilha é uma linha de tbl_evento (ver comentário em ce_evento_pai) */
);

/* TABELA DE RELACIONAMENTO 'É_Autor' ENTRE PESSOA E SUBMISSÃO, POIS UMA PESSOA PODE TER VÁRIAS SUBMISSÕES E UMA SUBMISSÃO PODE TER VÁRIOS AUTORES */
CREATE TABLE tbl_pessoa_submissao ( 
    ce_pessoa BIGINT NOT NULL,
    ce_submissao BIGINT NOT NULL,
    ordem_autoria INT NOT NULL, /* posição do autor na lista de autoria (1º, 2º, 3º autor...) */
    is_responsavel BOOLEAN NOT NULL, /* marca o(s) autor(es) responsável(is) pela submissão (quem gerencia o envio, recebe notificações etc. - RF7). Atenção: o banco não garante sozinho que pelo menos um autor por submissão tenha TRUE; isso precisa ser checado na aplicação */
    PRIMARY KEY (ce_pessoa, ce_submissao),
    FOREIGN KEY (ce_pessoa) REFERENCES tbl_pessoa (cp_id_pessoa),
    FOREIGN KEY (ce_submissao) REFERENCES tbl_submissao (cp_id_submissao)
);

CREATE TABLE tbl_topico (
    cp_id_topico BIGSERIAL PRIMARY KEY,
    nm_topico VARCHAR(150) NOT NULL,
    ds_topico TEXT
);

/* TABELA DE RELACIONAMENTO 'Aborda' ENTRE SUBMISSÃO E TÓPICO, POIS UMA SUBMISSÃO PODE TER VÁRIOS TÓPICOS E UM TÓPICO PODE TER VÁRIAS SUBMISSÕES */
CREATE TABLE tbl_submissao_topico (
    ce_submissao BIGINT NOT NULL,
    ce_topico BIGINT NOT NULL,
    PRIMARY KEY (ce_submissao, ce_topico),
    FOREIGN KEY (ce_submissao) REFERENCES tbl_submissao (cp_id_submissao),
    FOREIGN KEY (ce_topico) REFERENCES tbl_topico (cp_id_topico)
);

/* TABELA DE RELACIONAMENTO 'Tem_Expertise' ENTRE PESSOA E TÓPICO, POIS UMA PESSOA PODE TER VÁRIOS TÓPICOS E UM TÓPICO PODE TER VÁRIAS PESSOAS */
CREATE TABLE tbl_pessoa_topico (
    ce_pessoa BIGINT NOT NULL,
    ce_topico BIGINT NOT NULL,
    nivel_expertise VARCHAR(20), /*VARCHAR para baixo/medio/alto e SMALLINT para escala de 1-5, por exemplo*/
    PRIMARY KEY (ce_pessoa, ce_topico),
    FOREIGN KEY (ce_pessoa) REFERENCES tbl_pessoa (cp_id_pessoa),
    FOREIGN KEY (ce_topico) REFERENCES tbl_topico (cp_id_topico)
);

/*TABELA DE RELACIONAMENTO 'É_Revisor' ENTRE PESSOA E SUBMISSÃO, POIS UMA PESSOA PODE SER REVISOR DE VÁRIAS SUBMISSÕES E UMA SUBMISSÃO PODE TER VÁRIOS REVISORES */
CREATE TABLE tbl_atribuicao_revisao (
    cp_id_atribuicao BIGSERIAL PRIMARY KEY, /* PK substituta (em vez de chave composta ce_pessoa+ce_submissao) pois tbl_imp_revisao precisa referenciar uma atribuição específica (relacionamento Gera_Parecer) */
    ce_pessoa BIGINT NOT NULL,
    ce_submissao BIGINT NOT NULL,
    dt_atribuicao TIMESTAMP NOT NULL,
    status_aceite VARCHAR(20),
    flag_conflito BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (ce_pessoa) REFERENCES tbl_pessoa (cp_id_pessoa),
    FOREIGN KEY (ce_submissao) REFERENCES tbl_submissao (cp_id_submissao)
);

CREATE TABLE tbl_imp_revisao (
    cp_id_revisao BIGSERIAL PRIMARY KEY,
    nota_metodologia FLOAT NOT NULL,
    nota_originalidade FLOAT NOT NULL,
    nota_relevancia FLOAT NOT NULL,
    parecer_texto TEXT NOT NULL,
    dt_revisao TIMESTAMP NOT NULL,
    recomendacao_final TEXT, /* ta certo ser TEXT?*/
    ce_atribuicao BIGINT NOT NULL, /* FK do relacionamento 'Gera_Parecer': o parecer vem de uma atribuição específica (não referencia pessoa/submissão direto, pra não duplicar o que já está em tbl_atribuicao_revisao) */
    FOREIGN KEY (ce_atribuicao) REFERENCES tbl_atribuicao_revisao (cp_id_atribuicao)
);

/* Materializa dois relacionamentos do modelo conceitual: Recebe_Veredito (submissão -> decisão, 1:1)
   e Emite (pessoa -> decisão, 1:N) */
CREATE TABLE tbl_imp_decisao (
    cp_id_decisao BIGSERIAL PRIMARY KEY,
    resultado_decisao VARCHAR(20),
    ds_justificativa TEXT,
    dt_decisao TIMESTAMP,
    ce_submissao BIGINT NOT NULL, /* FK do relacionamento Recebe_Veredito */
    ce_revisor BIGINT NOT NULL, /* FK do relacionamento Emite: pessoa que emite/decide o veredito */
    FOREIGN KEY (ce_submissao) REFERENCES tbl_submissao (cp_id_submissao),
    FOREIGN KEY (ce_revisor) REFERENCES tbl_pessoa (cp_id_pessoa)
);



