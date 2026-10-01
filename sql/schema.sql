/* A chave primária deve autoincrementar via BIGSERIAL */

CREATE TABLE tbl_pessoa (
    cp_id_pessoa BIGSERIAL PRIMARY KEY,
    nm_pessoa VARCHAR(200) NOT NULL,
    email_principal VARCHAR(254) NOT NULL UNIQUE,
    cd_orcid VARCHAR(19) UNIQUE,
    pais_pessoa CHAR(2)
);

CREATE TABLE tbl_instituicao (
    cp_id_instituicao BIGSERIAL PRIMARY KEY,
    nm_instituicao VARCHAR (200) NOT NULL,
    pais_instituicao CHAR(2),
    sg_instituicao VARCHAR(30),
    cidade_instituicao VARCHAR(100),
    uf_instituicao CHAR(2)
);

CREATE TABLE tbl_evento (
    cp_id_evento BIGSERIAL PRIMARY KEY, 
    sg_evento VARCHAR(20) NOT NULL UNIQUE,
    nm_evento VARCHAR(200) NOT NULL,
    ds_evento TEXT
);

CREATE TABLE tbl_edicao (
    cd_id_edicao BIGSERIAL PRIMARY KEY,
    ce_evento BIGINT NOT NULL,
    nr_edicao INT,
    ano_edicao SMALLINT NOT NULL,
    dt_inicio DATE NOT NULL,
    dt_fim DATE NOT NULL,
    FOREIGN KEY (ce_evento) REFERENCES tbl_evento (cp_id_evento)
);

CREATE TABLE tbl_trilha (
    cp_id_trilha BIGSERIAL PRIMARY KEY,
    ce_edicao BIGINT NOT NULL,
    nm_trilha VARCHAR(150) NOT NULL,
    ds_trilha TEXT,
    tp_anonimato VARCHAR(20),
    FOREIGN KEY (ce_edicao) REFERENCES tbl_edicao (cd_id_edicao)
);

CREATE TABLE tbl_submissao (
    cp_id_submissao BIGSERIAL PRIMARY KEY,
    ce_trilha BIGINT NOT NULL,
    ce_autor BIGINT NOT NULL,
    titulo_submissao VARCHAR(500) NOT NULL,
    resumo_submissao TEXT NOT NULL,
    idioma_submissao VARCHAR(20) NOT NULL,
    dt_registro TIMESTAMP NOT NULL,
    status_submissao VARCHAR(20),
    FOREIGN KEY (ce_trilha) REFERENCES tbl_trilha (cp_id_trilha),
    FOREIGN KEY (ce_autor) REFERENCES tbl_pessoa (cp_id_pessoa)
);

CREATE TABLE tbl_versao_submissao (
    cp_id_versao BIGSERIAL PRIMARY KEY,
    ce_submissao BIGINT NOT NULL,
    nr_versao INT NOT NULL,
    tp_versao VARCHAR(20),
    dt_envio TIMESTAMP NOT NULL,
    ce_responsavel_envio BIGINT NOT NULL,
    nm_arquivo VARCHAR(200),
    ds_localizacao_arquivo VARCHAR(500),
    hash_arquivo VARCHAR(64),
    FOREIGN KEY (ce_submissao) REFERENCES tbl_submissao (cp_id_submissao),
    FOREIGN KEY (ce_responsavel_envio) REFERENCES tbl_pessoa (cp_id_pessoa)
);

CREATE TABLE tbl_topico (
    cp_id_topico BIGSERIAL PRIMARY KEY,
    ce_trilha BIGINT NOT NULL,
    nm_topico VARCHAR(150) NOT NULL,
    ds_topico TEXT,
    FOREIGN KEY (ce_trilha) REFERENCES tbl_trilha (cp_id_trilha)
);

CREATE TABLE tbl_atribuicao_revisao (
    cp_id_atribuicao BIGSERIAL PRIMARY KEY,
    ce_submissao BIGINT NOT NULL,
    ce_revisor BIGINT NOT NULL,
    dt_atribuicao TIMESTAMP NOT NULL,
    tp_origem_atribuicao VARCHAR(20) NOT NULL,
    status_atribuicao VARCHAR(20),
    dt_resposta TIMESTAMP,
    FOREIGN KEY (ce_submissao) REFERENCES tbl_submissao (cp_id_submissao),
    FOREIGN KEY (ce_revisor) REFERENCES tbl_pessoa (cp_id_pessoa)
);

CREATE TABLE tbl_formulario_avaliacao (
    cp_id_formulario BIGSERIAL PRIMARY KEY,
    ce_trilha BIGINT NOT NULL,
    nm_formulario VARCHAR(200) NOT NULL,
    nr_versao INT,
    dt_inicio_vigencia TIMESTAMP NOT NULL,
    dt_fim_vigencia TIMESTAMP,
    FOREIGN KEY (ce_trilha) REFERENCES tbl_trilha (cp_id_trilha)
);

CREATE TABLE tbl_revisao (
    cp_id_revisao BIGSERIAL PRIMARY KEY,
    ce_atribuicao BIGINT NOT NULL,
    ce_formulario BIGINT NOT NULL,
    dt_inicio TIMESTAMP NOT NULL,
    dt_submissao TIMESTAMP,
    status_revisao VARCHAR(20),
    FOREIGN KEY (ce_atribuicao) REFERENCES tbl_atribuicao_revisao (cp_id_atribuicao),
    FOREIGN KEY (ce_formulario) REFERENCES tbl_formulario_avaliacao (cp_id_formulario)
);

CREATE TABLE tbl_decisao (
    cp_id_decisao BIGSERIAL PRIMARY KEY,
    ce_submissao BIGINT NOT NULL,
    resultado_decisao VARCHAR(20),
    ce_responsavel BIGINT NOT NULL,
    dt_decisao TIMESTAMP,
    ds_justificativa TEXT,
    FOREIGN KEY (ce_submissao) REFERENCES tbl_submissao (cp_id_submissao),
    FOREIGN KEY (ce_responsavel) REFERENCES tbl_pessoa (cp_id_pessoa)
)
