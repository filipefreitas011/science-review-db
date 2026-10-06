# Estrutura do Relatório — Entrega 1 (MIBD)

P1 é a delimitação do minimundo e P2 é a modelagem e implantação. Referências e Anexos atendem às regras gerais da seção 4.1.

| # | Seção | O que deve conter | Rubrica |
| --- | --- | --- | --- |
| — | Resumo e Introdução | Contexto da SBTC e do ScienceReview; recorte escolhido em uma frase | P1 Q1 |
| 1 | Descritivo do Projeto | Descrição original resumida; **extensão proposta** do caso; objetivo geral e objetivos específicos | P1 Q1; item 2.1 do caso |
| 2 | Requisitos | RFs no escopo (originais e estendidos); tabela de status (Atendido, Parcial, Fora do escopo) com justificativa de cada exclusão | P1 Q2 |
| 3 | Minimundo | Texto do minimundo delimitado; decisões tomadas sobre o texto base; respostas às questões da seção 1.5 do caso que o grupo resolveu | P1 Q2 |
| 4 | Modelagem | Diagramas conceitual e lógico legíveis, feitos no brModelo (notação de Chen); explicação de cada entidade, relacionamento, cardinalidade, atributo, tipo e chave, ligando cada escolha ao minimundo | P2 Q1, Q2 |
| 5 | Rastreabilidade | Tabela entidades × relacionamentos × requisitos, com colunas para todas as entidades e todos os relacionamentos | P1 Q3 |
| 6 | Implantação | Script DDL e a estratégia de tradução do MER para o relacional: como cada N:N virou tabela, onde ficaram as FKs, quais constraints implementam quais RFs | P2 Q1 |
| 7 | População e metadados | Volume de dados (pelo menos 3 tabelas com 5 mil registros ou mais); exploração dos metadados no catálogo do PostgreSQL, como mostrado em aula | P2 Q1, Q2 |
| 8 | Referências | No estilo SBC | Regra 4 |
| 9 | Anexos | Scripts DDL e de população; tutorial de reprodução usando só PostgreSQL e pgAdmin; links públicos, sem login | Regras 2, 5 |
