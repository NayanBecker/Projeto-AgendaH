CREATE TABLE `tdah_databasemant`.`Conta`(
  `idUsuario` INT NULL auto_increment,
  `nomeConta` VARCHAR(45) NOT NULL,
  `emailConta` VARCHAR(45) NOT NULL,
  `senhaConta` VARCHAR(100) NOT NULL,
  `dataNasc` DATE NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `email_UNIQUE` (`emailConta`),
  UNIQUE INDEX `senhaConta_UNIQUE` (`senhaConta`))
;
CREATE TABLE `tdah_databasemant`.`Perfil` (
  `idPerfil` INT NOT NULL auto_increment,
  `tipoPerfil` ENUM('Criança', 'Resposavel') NOT NULL,
  `nomePerfil` VARCHAR(45) NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,

  PRIMARY KEY (`idPerfil`),
  INDEX `fk_Perfil_Usuario_idx` (`Usuario_idUsuario`),
  
  CONSTRAINT `fk_Perfil_Usuario`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `tdah_databasemant`.`Conta` (`idUsuario`)
    );
    
CREATE TABLE `tdah_databasemant`.`Notificacao` (
  `idNotificacao` INT NOT NULL auto_increment,
  `mensagem` VARCHAR(200) NULL,
  `dataEnvio` TIMESTAMP(6) NULL,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`idNotificacao`)
);



CREATE TABLE `tdah_databasemant`.`Recompensa` (
  `idRecompensa` INT NOT NULL auto_increment,
  `tipoRecompensa` VARCHAR(50) NULL,
  `quantidadeRecompensa` INT NULL,
  `descricaoRecompensa` VARCHAR(500) NULL,
  PRIMARY KEY (`idRecompensa`)
);

CREATE TABLE IF NOT EXISTS `tdah_databasemant`.`StatusTarefa` (
  `idStatusTarefa` INT NOT NULL auto_increment,
  `statusTarefa` ENUM('PENDENTE', 'CONCLUIDO', 'ATRASADO') NULL DEFAULT 'PENDENTE' COMMENT 'constraint',
  `dataConclusao` TIMESTAMP(6) NULL,
  PRIMARY KEY (`idStatusTarefa`)
  );
  
  CREATE TABLE IF NOT EXISTS `tdah_databasemant`.`Tarefa` (
  `idTarefa` INT NOT NULL auto_increment,
  `titulo` VARCHAR(200) NOT NULL,
  `descricao` VARCHAR(500) NULL,
  `dataInclusao` TIMESTAMP(6) not NULL default current_timestamp,
  `dataVencimento` TIMESTAMP(6) NULL,
  `Notificacao_idNotificacao` INT NOT NULL,
  `Recompensa_idRecompensa` INT NOT NULL,
  `StatusTarefa_idStatusTarefa` INT NOT NULL,
  PRIMARY KEY (`idTarefa`),
  
  CONSTRAINT `fk_Tarefa_Notificacao1`
    FOREIGN KEY (`Notificacao_idNotificacao`)
    REFERENCES `tdah_databasemant`.`Notificacao` (`idNotificacao`),

  CONSTRAINT `fk_Tarefa_Recompensa1`
    FOREIGN KEY (`Recompensa_idRecompensa`)
    REFERENCES `tdah_databasemant`.`Recompensa` (`idRecompensa`),
    
  CONSTRAINT `fk_Tarefa_StatusTarefa1`
    FOREIGN KEY (`StatusTarefa_idStatusTarefa`)
    REFERENCES `tdah_databasemant`.`StatusTarefa` (`idStatusTarefa`)
);





