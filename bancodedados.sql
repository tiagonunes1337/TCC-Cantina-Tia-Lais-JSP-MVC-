-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CantinaTiaLais
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CantinaTiaLais
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CantinaTiaLais` DEFAULT CHARACTER SET utf8 ;
USE `CantinaTiaLais` ;

-- -----------------------------------------------------
-- Table `CantinaTiaLais`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CantinaTiaLais`.`Perfil` (
  `idPerfil` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`idPerfil`))
ENGINE = InnoDB;
INSERT INTO Perfil(IdPerfil,nome,status) VALUES
(1,'Administrador',1),
(2,'Gerente',1),
(3,'Funcionario',1);

-- -----------------------------------------------------
-- Table `CantinaTiaLais`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CantinaTiaLais`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nome_RazaoSocial` VARCHAR(100) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(18) NOT NULL,
  `RG` INT(8) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `status` INT NOT NULL,
  `Perfil_idPerfil` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) ,
  UNIQUE INDEX `senha_UNIQUE` (`senha` ASC) ,
  INDEX `fk_Usuario_Perfil_idx` (`Perfil_idPerfil` ASC) ,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) ,
  UNIQUE INDEX `RG_UNIQUE` (`RG` ASC) ,
  CONSTRAINT `fk_Usuario_Perfil`
    FOREIGN KEY (`Perfil_idPerfil`)
    REFERENCES `CantinaTiaLais`.`Perfil` (`idPerfil`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO Usuario (idUsuario,nome_RazaoSocial,login,senha,CPF,RG,telefone,endereco,estado,dataNasc,status,Perfil_idPerfil) VALUES
(1,'administrador','admin','123','12345678912',12345678,'6194606518','SDMK quadra 23 conj2 lote 4','Distrito Federal','2007/05/03',1,1),
(2,'Laise Araujo dos Santos','laise','1234','94869302658',84679365,'6197866075','QR 410','Distrito Federal','1982/08/22',1,3);
-- -----------------------------------------------------
-- Table `CantinaTiaLais`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CantinaTiaLais`.`Menu` (
  `idMenu` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `link` VARCHAR(100) NOT NULL,
  `icone` VARCHAR(45),
  `exibir` INT NOT NULL,
  PRIMARY KEY (`idMenu`))
ENGINE = InnoDB;

INSERT INTO Menu (idMenu,nome,link,icone,exibir) VALUES
(1,'Home','index.jsp','',1), -- index
(2,'Perfis','gerenciar_perfil.do?acao=listarTodos','',1), -- Perfil
(3,'Usuarios','gerenciar_usuario.do?acao=listarTodos','',1), -- Usuario
(4,'Produtos','gerenciar_produto.do?acao=listarTodos','',1), -- Produto
(5,'Fornecedores','gerenciar_fornecedor.do?acao=listarTodos','',1), -- Fornecedor
(6,'Clientes','gerenciar_cliente.do?acao=listarTodos','',1), -- Cliente
(7,'Menus','gerenciar_menu.do?acao=listarTodos','',1), -- Menu
(8,'Vendas','gerenciar_venda.do?acao=listarTodos','',1), -- Vendas
(9,'ListarVendaPorCliente','gerenciar_venda.do?acao=listarVendaPorCliente','',2),

(10,'AlterarPerfil','gerenciar_perfil.do?acao=alterar','',2),
(11,'AlterarUsuario','gerenciar_usuario.do?acao=alterar','',2), -- Alterar 
(12,'AlterarProduto','gerenciar_produto.do?acao=alterar','',2),
(13,'AlterarFornecedor','gerenciar_fornecedor.do?acao=alterar','',2),
(14,'AlterarCliente','gerenciar_cliente.do?acao=alterar','',2),
(15,'AlterarMenu','gerenciar_menu.do?acao=alterar','',2),
(16,'AlterarVenda','gerenciar_venda.do?acao=alterar','',2),


(17,'ExcluirPerfil','gerenciar_perfil.do?acao=excluir','',2),
(18,'DesativarUsuario','gerenciar_usuario.do?acao=desativar','',2),
(19,'DesativarProduto','gerenciar_produto.do?acao=desativar','',2),
(20,'DesativarFornecedor','gerenciar_fornecedor.do?acao=desativar','',2),
(21,'DesativarCliente','gerenciar_cliente.do?acao=desativar','',2),
(22,'ExcluirMenu','gerenciar_menu.do?acao=excluir','',2),
(23,'DesativarVenda','gerenciar_venda.do?acao=desativar','',2),
(24,'FinalizarVenda','gerenciar_venda.do?acao=finalizar','',2), -- Finalizar a venda

(25,'GerenciarMenuPerfil','gerenciar_menu_perfil.do?acao=gerenciar','',2), -- Menu_Perfil
(26,'DesvincularMenu','gerenciar_menu_perfil.do?acao=desvincular','',2),

(27,'GravarVenda','gerenciar_venda.do?acao=gravar','',2),
(28,'AdicionarNovaVenda','gerenciar_venda.do?acao=novaVenda','',2),
(29,'AdicionarProduto','gerenciar_venda.do?acao=AdicionarProduto','',2),
(30,'RetirarProduto','gerenciar_venda.do?acao=retirarProduto','',2),

(31,'CadastrarPerfil','form_perfil.jsp','',2), -- form 
(32,'CadastrarUsuario','form_usuario.jsp','',2),  -- form 
(33,'CadastrarProduto','form_produto.jsp','',2), -- form 
(34,'CadastrarFornecedor','form_fornecedor.jsp','',2), -- form 
(35,'CadastrarCliente','form_cliente.jsp','',2), -- form 
(36,'CadastrarMenu','form_menu.jsp','',2), -- form 
(37,'FormularioVenda','form_venda.jsp','',2), -- form 
(38,'FormularioMenuPerfil','form_menu_perfil.jsp','',2), -- form  
(39,'FormularioLogin','form_login.jsp','',2),-- form 
(40,'FormularioVisualizaCarrinho','form_visualizar_carrinho.jsp','',2), -- form

(41,'Clientes_pagina','listar_cliente.jsp','',2), -- Páginas
(42,'Fornecedores_pagina','listar_fornecedor.jsp','',2),
(43,'Menus_pagina','listar_menu.jsp','',2),
(44,'Perfis_pagina','listar_perfil.jsp','',2),
(45,'Produtos_pagina','listar_produto.jsp','',2),
(46,'Usuarios_pagina','listar_usuario.jsp','',2),
(47,'Vendas_pagina','listar_venda.jsp','',2),
(48,'gerenciar_Menus','menu.jsp','',2),

(49,'relatorio_pagina','form_relatorio_venda.jsp','',2),
(50,'Listar o relatorio','listar_relatorio_venda.jsp','',2),
(51,'GerarPDF','gerenciar_relatorio.do?acao=gerarPDF','',2),
(52,'Estoque','gerenciar_estoque.do?acao=listar','',1),
(53,'Formulario de Estoque','form_estoque.jsp',''f,2),
(54,'Listar de Estoque','listar_estoque.jsp','',2),
(55,'Gerar Relatório Venda','gerenciar_relatorio.do','',1);

-- -----------------------------------------------------
-- Table `CantinaTiaLais`.`Fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CantinaTiaLais`.`Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `nome_RazaoSocial` VARCHAR(100) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(18) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) )
ENGINE = InnoDB;
 INSERT INTO Fornecedor (idFornecedor,nome_RazaoSocial,endereco,estado,CNPJ,telefone,status) VALUES
 (1,'Pão de Queijo Casseiro','Qs 124 avenida silvestre','Distrito Federal','26459765000145','6198767689',1),
 (2,'Popas Nacional','Qs 254 avenida Condor 456','Distrito Federal','68956847000178','6195717584',1),
 (3,'Cassiano Salgados','Qs 789 avenida castanha 897','Distrito Federal','89456895000132','6198725728',1);

-- -----------------------------------------------------
-- Table `CantinaTiaLais`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CantinaTiaLais`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `quantidade` INT NOT NULL,
  `valorUnitario` DOUBLE NOT NULL,
  `status` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`idProduto`),
  INDEX `fk_Produto_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) ,
  CONSTRAINT `fk_Produto_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `CantinaTiaLais`.`Fornecedor` (`idFornecedor`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO Produto (idProduto,nome,quantidade,valorUnitario,status,Fornecedor_IdFornecedor) VALUES
(1,'Pão Pizza',20,8.0,1,3),
(2,'Pão Hamburguer',20,8.0,1,3),
(3,'Suco de Uva',20,3.00,1,2),
(4,'Pão de queijo',20,5.00,1,1),
(5,'Moussi',20,5.00,1,2);

-- -----------------------------------------------------
-- Table `CantinaTiaLais`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CantinaTiaLais`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome_RazaoSocial` VARCHAR(100) NOT NULL,
  `tipo` INT NOT NULL,
  `CPF_CNPJ` VARCHAR(18) NOT NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `CPF_CNPJ_UNIQUE` (`CPF_CNPJ` ASC) )
ENGINE = InnoDB;
INSERT INTO Cliente (idCliente,nome_RazaoSocial,tipo,CPF_CNPJ,status) VALUES 
(1,'Kauan',1,'12345678911',1),
(2,'Tiago',1,'11987654321',1),
(3,'David',1,'23456789012',1),
(4,'Luisa',2,'87987905000195',1);

-- -----------------------------------------------------
-- Table `CantinaTiaLais`.`Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CantinaTiaLais`.`Vendas` (
  `idVendas` INT NOT NULL AUTO_INCREMENT,
  `dataVenda` DATE NOT NULL,
  `Total` DOUBLE NOT NULL,
  `status` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVendas`),
  INDEX `fk_Vendas_Usuario1_idx` (`Usuario_idUsuario` ASC) ,
  INDEX `fk_Vendas_Cliente1_idx` (`Cliente_idCliente` ASC) ,
  CONSTRAINT `fk_Vendas_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `CantinaTiaLais`.`Usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Vendas_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `CantinaTiaLais`.`Cliente` (`idCliente`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CantinaTiaLais`.`Menu_Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CantinaTiaLais`.`Menu_Perfil` (
  `Menu_idMenu` INT NOT NULL,
  `Perfil_idPerfil` INT NOT NULL,
  PRIMARY KEY (`Menu_idMenu`, `Perfil_idPerfil`),
  INDEX `fk_Menu_has_Perfil_Perfil1_idx` (`Perfil_idPerfil` ASC) ,
  INDEX `fk_Menu_has_Perfil_Menu1_idx` (`Menu_idMenu` ASC) ,
  CONSTRAINT `fk_Menu_has_Perfil_Menu1`
    FOREIGN KEY (`Menu_idMenu`)
    REFERENCES `CantinaTiaLais`.`Menu` (`idMenu`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Menu_has_Perfil_Perfil1`
    FOREIGN KEY (`Perfil_idPerfil`)
    REFERENCES `CantinaTiaLais`.`Perfil` (`idPerfil`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO `menu_perfil` (`Menu_idMenu`, `Perfil_idPerfil`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 2),
(30, 2),
(31, 2),
(32, 2),
(33, 2),
(34, 2),
(35, 2),
(36, 2),
(37, 2),
(38, 2),
(39, 2),
(40, 2),
(41, 2),
(42, 2),
(43, 2),
(44, 2),
(45, 2),
(46, 2),
(47, 2),
(48, 2),
(49, 2),
(50, 2),
(51, 2),
(52, 2),
(53, 2),
(54, 2),
(55, 2),
(1, 3),
(4, 3),
(6, 3),
(8, 3),
(9, 3),
(12, 3),
(14, 3),
(16, 3),
(19, 3),
(21, 3),
(23, 3),
(24, 3),
(27, 3),
(28, 3),
(29, 3),
(30, 3),
(33, 3),
(35, 3),
(37, 3),
(39, 3),
(40, 3),
(41, 3),
(45, 3),
(47, 3),
(48, 3),
(51, 3),
(52, 3),
(53, 3),
(54, 3);




-- -----------------------------------------------------
-- Table `CantinaTiaLais`.`Vendas_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CantinaTiaLais`.`Vendas_Produto` (
  `Vendas_idVendas` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `valorDeVenda` DOUBLE NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`Vendas_idVendas`, `Produto_idProduto`),
  INDEX `fk_Vendas_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) ,
  INDEX `fk_Vendas_has_Produto_Vendas1_idx` (`Vendas_idVendas` ASC) ,
  CONSTRAINT `fk_Vendas_has_Produto_Vendas1`
    FOREIGN KEY (`Vendas_idVendas`)
    REFERENCES `CantinaTiaLais`.`Vendas` (`idVendas`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Vendas_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `CantinaTiaLais`.`Produto` (`idProduto`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
