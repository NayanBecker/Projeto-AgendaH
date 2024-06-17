  <head><h1>Estrutura do Banco de Dados para o Projeto TDAH</h1></head>
<body>
  <h2>Descrição Geral</h2>
    <p>
        Este projeto utiliza o MySQL como sistema de gerenciamento de banco de dados para armazenar e gerenciar informações 
        relacionadas a contas de usuário, perfis, notificações, recompensas e tarefas. Optamos pelo MySQL devido à sua robustez, 
        eficiência e flexibilidade no gerenciamento de grandes volumes de dados, além da sua ampla adoção e suporte pela comunidade. 
        O banco de dados está integrado a um servidor local para facilitar o desenvolvimento e a manutenção do sistema.
    </p>

  <h2>Estrutura do Banco de Dados</h2>

  <h3>Tabela <code>Conta</code></h3>
    <p>
        A tabela <code>Conta</code> é responsável por armazenar informações sobre as contas de usuário. Cada conta possui um 
        identificador único (<code>idUsuario</code>), um nome (<code>nomeConta</code>), um e-mail (<code>emailConta</code>), 
        uma senha (<code>senhaConta</code>) e uma data de nascimento (<code>dataNasc</code>). As restrições de chave primária 
        e índices exclusivos garantem a integridade e a segurança dos dados.
    </p>
    <pre>
<code>
CREATE TABLE `tdah_databasemant`.`Usuario`(
  `idUsuario` INT NOT NULL auto_increment,
  `nomeConta` VARCHAR(45) NOT NULL,
  `emailConta` VARCHAR(45) NOT NULL,
  `senhaConta` VARCHAR(100) NOT NULL,
  `dataNasc` DATE NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `email_UNIQUE` (`emailConta`),
  UNIQUE INDEX `senhaConta_UNIQUE` (`senhaConta`)
);
</code>
    </pre>

  <h3>Tabela <code>Perfil</code></h3>
  <p>
        A tabela <code>Perfil</code> armazena informações sobre os diferentes perfis associados a cada conta. Um perfil pode 
        ser de tipo <code>Criança</code> ou <code>Responsável</code>, e está vinculado a um usuário específico 
        (<code>Usuario_idUsuario</code>). Essa tabela permite a criação de perfis personalizados para cada usuário, 
        facilitando a gestão de permissões e acessos.
  </p>
    <pre>
<code>
CREATE TABLE `tdah_databasemant`.`Perfil` (
  `idPerfil` INT NOT NULL auto_increment,
  `tipoPerfil` ENUM('Criança', 'Responsável') NOT NULL,
  `nomePerfil` VARCHAR(45) NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idPerfil`),
  INDEX `fk_Perfil_Usuario_idx` (`Usuario_idUsuario`),
  CONSTRAINT `fk_Perfil_Usuario`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `tdah_databasemant`.`Usuario` (`idUsuario`)
);
</code>
    </pre>

  <h3>Tabela <code>Notificacao</code></h3>
    <p>
        A tabela <code>Notificacao</code> é utilizada para armazenar mensagens de notificação que são enviadas aos usuários. 
        Cada notificação contém um identificador único (<code>idNotificacao</code>), uma mensagem (<code>mensagem</code>), 
        uma data de envio (<code>dataEnvio</code>) e um tipo (<code>tipo</code>), permitindo uma gestão eficiente das comunicações 
        dentro do sistema.
    </p>
    <pre>
<code>
CREATE TABLE `tdah_databasemant`.`Notificacao` (
  `idNotificacao` INT NOT NULL auto_increment,
  `mensagem` VARCHAR(200) NULL,
  `dataEnvio` TIMESTAMP(6) NULL,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`idNotificacao`)
);
</code>
    </pre>

<h3>Tabela <code>Recompensa</code></h3>
  <p>
        A tabela <code>Recompensa</code> armazena informações sobre as recompensas que podem ser atribuídas aos usuários 
        como incentivo. Cada recompensa possui um identificador único (<code>idRecompensa</code>), um tipo 
        (<code>tipoRecompensa</code>), uma quantidade (<code>quantidadeRecompensa</code>) e uma descrição detalhada 
        (<code>descricaoRecompensa</code>).
  </p>
    <pre>
<code>
CREATE TABLE `tdah_databasemant`.`Recompensa` (
  `idRecompensa` INT NOT NULL auto_increment,
  `tipoRecompensa` VARCHAR(50) NULL,
  `quantidadeRecompensa` INT NULL,
  `descricaoRecompensa` VARCHAR(500) NULL,
  PRIMARY KEY (`idRecompensa`)
);
</code>
    </pre>

<h3>Tabela <code>StatusTarefa</code></h3>
    <p>
        A tabela <code>StatusTarefa</code> é responsável por gerenciar o status das tarefas. Cada status de tarefa possui 
        um identificador único (<code>idStatusTarefa</code>) e pode ter um dos seguintes valores: <code>PENDENTE</code>, 
        <code>CONCLUÍDO</code> ou <code>ATRASADO</code>. Também armazena a data de conclusão (<code>dataConclusao</code>), 
        permitindo o acompanhamento do progresso das tarefas.
    </p>
    <pre>
<code>
CREATE TABLE IF NOT EXISTS `tdah_databasemant`.`StatusTarefa` (
  `idStatusTarefa` INT NOT NULL auto_increment,
  `statusTarefa` ENUM('PENDENTE', 'CONCLUÍDO', 'ATRASADO') NULL DEFAULT 'PENDENTE' COMMENT 'constraint',
  `dataConclusao` TIMESTAMP(6) NULL,
  PRIMARY KEY (`idStatusTarefa`)
);
</code>
    </pre>

<h3>Tabela <code>Tarefa</code></h3>
  <p>
        A tabela <code>Tarefa</code> armazena informações detalhadas sobre as tarefas a serem realizadas pelos usuários. 
        Cada tarefa possui um identificador único (<code>idTarefa</code>), um título (<code>titulo</code>), uma descrição 
        (<code>descricao</code>), a data de inclusão (<code>dataInclusao</code>), a data de vencimento 
        (<code>dataVencimento</code>), e está vinculada a uma notificação (<code>Notificacao_idNotificacao</code>), 
        a uma recompensa (<code>Recompensa_idRecompensa</code>) e a um status de tarefa 
        (<code>StatusTarefa_idStatusTarefa</code>).
  </p>
    <pre>
<code>
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
</code>
    </pre>

  <h2>Motivo da Escolha do MySQL</h2>
    <p>
        Optamos por utilizar o MySQL como banco de dados devido a vários fatores:
    </p>
    <ul>
        <li><strong>Desempenho e Escalabilidade</strong>: O MySQL é conhecido por sua capacidade de lidar com grandes volumes 
            de dados e suportar um alto número de transações.</li>
        <li><strong>Flexibilidade</strong>: O MySQL oferece flexibilidade na definição de esquemas e na gestão de dados, 
            permitindo fácil adaptação às necessidades do sistema.</li>
        <li><strong>Suporte e Comunidade</strong>: O MySQL possui uma vasta comunidade de desenvolvedores, o que facilita 
            o acesso a recursos, documentação e suporte técnico.</li>
        <li><strong>Integração Fácil</strong>: A integração do MySQL com servidores locais é simples, o que facilita o 
            desenvolvimento e o teste do sistema em ambientes controlados.</li>
    </ul>

  <h2>Integração com Servidor Local</h2>
    <p>
        A integração do banco de dados MySQL com um servidor local permite que o sistema seja desenvolvido e testado em um 
        ambiente que simula a produção. Isso garante que os desenvolvedores possam identificar e corrigir problemas de maneira 
        eficiente antes de implantar o sistema em um ambiente de produção real.
    </p>

  <p>Se precisar de mais informações ou de alguma atualização, estou à disposição para ajudar!</p>
</body>
</html>
