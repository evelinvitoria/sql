CREATE DATABASE reserva_hotel;
USE reserva_hotel;

CREATE TABLE cliente (
  cod_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome_cliente VARCHAR(100) NOT NULL,
  telefone VARCHAR(20),
  sexo CHAR(1),
  cpf VARCHAR(15),
  passaporte VARCHAR(9),
  documento VARCHAR(10)
);

CREATE TABLE nacionalidade (
  sigla CHAR(2) NOT NULL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL
);

CREATE TABLE operadoras_cartao (
  cod_ope INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome_ope VARCHAR(50) NOT NULL
);

CREATE TABLE quartos (
  numero INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  andar INT,
  tipo_quarto VARCHAR(50)
);

CREATE TABLE tipo_quartos (
  cod_tipo_quarto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  desc_tipo VARCHAR(10),
  valor_quarto DECIMAL(10,2)
);

CREATE TABLE reserva (
  num_reserva INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  num_cartao VARCHAR(16),
  qtd_dia INT(2),
  data_reserva DATE,
  data_checkin DATE,
  status_reserva ENUM('confirmada', 'cancelada', 'utilizada'),
  cod_cliente INT NOT NULL,
  cod_tipo_quarto INT NOT NULL,
  cod_ope INT NOT NULL,
  FOREIGN KEY (cod_cliente) REFERENCES cliente (cod_cliente),
  FOREIGN KEY (cod_tipo_quarto) REFERENCES tipo_quartos (cod_tipo_quarto),
  FOREIGN KEY (cod_ope) REFERENCES operadoras_cartao (cod_ope)
);

INSERT INTO cliente (nome_cliente, telefone, sexo, cpf, passaporte, documento, sigla_nacionalidade)
VALUES ('Beto da Silva', '(11) 9999-9991', 'M', '123456789-00', '123456789', '1012345678', 'BR');
INSERT INTO cliente (nome_cliente, telefone, sexo, cpf, passaporte, documento, sigla_nacionalidade)
VALUES ('Silvana dos Santos', '(21) 9999-9990', 'F', '987654321-00', '987654321', '2024681012', 'US');

INSERT INTO nacionalidade (sigla, nome)
VALUES ('BR', 'Brasil');
INSERT INTO nacionalidade (sigla, nome)
VALUES ('US', 'Estados Unidos');

INSERT INTO operadoras_cartao (nome_ope)
VALUES ('Visa');
INSERT INTO operadoras_cartao (nome_ope)
VALUES ('MasterCard');

INSERT INTO quartos (andar, tipo_quarto)
VALUES (1, 'Standard');
INSERT INTO quartos (andar, tipo_quarto)
VALUES (2, 'Luxo');

INSERT INTO tipo_quartos (desc_tipo, valor_quarto)
VALUES ('Standard', 100.00);
INSERT INTO tipo_quartos (desc_tipo, valor_quarto)
VALUES ('Luxo', 200.00);

INSERT INTO reserva (num_cartao, qtd_dia, data_reserva, data_checkin, status_reserva, cod_cliente, cod_tipo_quarto, cod_ope)
VALUES ('1234-5678-9012-3456', 3, '2023-11-11', '2023-11-15', 'confirmada', 1, 1, 1);
INSERT INTO reserva (num_cartao, qtd_dia, data_reserva, data_checkin, status_reserva, cod_cliente, cod_tipo_quarto, cod_ope)
VALUES ('9876-5432-1098-7654', 5, '2023-11-12', '2023-11-17', 'pendente', 2, 2, 2);

UPDATE cliente
SET telefone = '(81) 9999-9999'
WHERE cod_cliente = 2;

DELETE FROM cliente WHERE cod_cliente = 1;

SELECT cliente.nome_cliente, cliente.telefone, nacionalidade.nome
FROM cliente
INNER JOIN nacionalidade ON cliente.sigla_nacionalidade = nacionalidade.sigla;

DELETE FROM cliente WHERE cod_cliente = 1;

SELECT cliente.nome_cliente, cliente.telefone, nacionalidade.nome
FROM cliente
INNER JOIN nacionalidade ON cliente.sigla_nacionalidade = nacionalidade.sigla;

SELECT reserva.num_reserva, cliente.nome_cliente, tipo_quartos.desc_tipo, operadoras_cartao.nome_ope
FROM reserva
INNER JOIN cliente ON reserva.cod_cliente = cliente.cod_cliente
INNER JOIN tipo_quartos ON reserva.cod_tipo_quarto = tipo_quartos.cod_tipo_quarto
INNER JOIN operadoras_cartao ON reserva.cod_ope = operadoras_cartao.cod_ope;
