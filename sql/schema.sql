/* A chave primária deve autoincrementar via BIGSERIAL */

CREATE TABLE tbl_instituicao (
    cp_id_instituicao BIGSERIAL PRIMARY KEY,
    nm_instituicao VARCHAR (200) NOT NULL,
    pais_instituicao CHAR(2) NOT NULL,
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

);