INSERT INTO tbl_evento (sg_evento, nm_evento, ano_edicao, dt_inicio, dt_fim, ds_evento, dt_inicio_submissao, dt_fim_submissao, ce_coordenador)
VALUES
('SBBD', 'Simpósio Brasileiro de Banco de Dados', 2025, '2025-10-06', '2025-10-09', 'Edição 2025', '2025-04-01', '2025-06-15', 1),
('SBES', 'Simpósio Brasileiro de Engenharia de Software', 2025, '2025-09-22', '2025-09-26', 'Edição 2025', '2025-04-01', '2025-06-15', 2),
('SBRC', 'Simpósio Brasileiro de Redes de Computadores', 2025, '2025-11-10', '2025-11-13', 'Edição 2025', '2025-04-01', '2025-06-15', 3),
('SBBD', 'Simpósio Brasileiro de Banco de Dados', 2026, '2026-10-05', '2026-10-08', 'Edição 2026', '2026-04-01', '2026-06-15', 4),
('SBES', 'Simpósio Brasileiro de Engenharia de Software', 2026, '2026-09-21', '2026-09-25', 'Edição 2026', '2026-04-01', '2026-06-15', 5),
('SBRC', 'Simpósio Brasileiro de Redes de Computadores', 2026, '2026-11-09', '2026-11-12', 'Edição 2026', '2026-04-01', '2026-06-15', 6);

/* Trilhas: linhas de tbl_evento cujo ce_evento_pai aponta para o evento principal (ids 1 a 6 acima) */
INSERT INTO tbl_evento (ce_evento_pai, sg_evento, nm_evento, ano_edicao, dt_inicio, dt_fim, ds_evento, dt_inicio_submissao, dt_fim_submissao, ce_coordenador)
VALUES
(1, 'SBBD-P', 'Trilha Principal do SBBD', 2025, '2025-10-06', '2025-10-09', NULL, '2025-04-01', '2025-06-15', 7),
(1, 'SBBD-F', 'Trilha de Ferramentas do SBBD', 2025, '2025-10-06', '2025-10-09', NULL, '2025-04-01', '2025-06-15', 8),
(2, 'SBES-P', 'Trilha Principal do SBES', 2025, '2025-09-22', '2025-09-26', NULL, '2025-04-01', '2025-06-15', 9),
(2, 'SBES-F', 'Trilha de Ferramentas do SBES', 2025, '2025-09-22', '2025-09-26', NULL, '2025-04-01', '2025-06-15', 10),
(3, 'SBRC-P', 'Trilha Principal do SBRC', 2025, '2025-11-10', '2025-11-13', NULL, '2025-04-01', '2025-06-15', 11),
(3, 'SBRC-F', 'Trilha de Ferramentas do SBRC', 2025, '2025-11-10', '2025-11-13', NULL, '2025-04-01', '2025-06-15', 12),
(4, 'SBBD-P', 'Trilha Principal do SBBD', 2026, '2026-10-05', '2026-10-08', NULL, '2026-04-01', '2026-06-15', 13),
(4, 'SBBD-F', 'Trilha de Ferramentas do SBBD', 2026, '2026-10-05', '2026-10-08', NULL, '2026-04-01', '2026-06-15', 14),
(5, 'SBES-P', 'Trilha Principal do SBES', 2026, '2026-09-21', '2026-09-25', NULL, '2026-04-01', '2026-06-15', 15),
(5, 'SBES-F', 'Trilha de Ferramentas do SBES', 2026, '2026-09-21', '2026-09-25', NULL, '2026-04-01', '2026-06-15', 16),
(6, 'SBRC-P', 'Trilha Principal do SBRC', 2026, '2026-11-09', '2026-11-12', NULL, '2026-04-01', '2026-06-15', 17),
(6, 'SBRC-F', 'Trilha de Ferramentas do SBRC', 2026, '2026-11-09', '2026-11-12', NULL, '2026-04-01', '2026-06-15', 18);
