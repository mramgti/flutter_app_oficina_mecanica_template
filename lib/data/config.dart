class Config {
  static const String sql = '''
      -- TABLE TipoStatus
      CREATE TABLE IF NOT EXISTS TipoStatus (
          idTipoStatus INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT
      );

      -- TABLE TipoFuncionario
      CREATE TABLE IF NOT EXISTS TipoFuncionario (
          idTipoFuncionario INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT
      );

      -- TABLE TipoPecaServico
      CREATE TABLE IF NOT EXISTS TipoPecaServico (
          idTipoPecaServico INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT
      );

      -- TABLE TipoPagamento
      CREATE TABLE IF NOT EXISTS TipoPagamento (
          idTipoPagamento INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT
      );

      -- TABLE Clientes
      CREATE TABLE IF NOT EXISTS Clientes (
          idCliente INTEGER PRIMARY KEY AUTOINCREMENT,
          cpf TEXT,
          nome TEXT,
          email TEXT,
          dataNascimento DATE
      );

      -- TABLE Veiculos
      CREATE TABLE IF NOT EXISTS Veiculos (
          idVeiculo INTEGER PRIMARY KEY AUTOINCREMENT,
          placa TEXT,
          marca TEXT,
          modelo TEXT,
          cor TEXT,
          ano INTEGER,
          idCliente INTEGER,
          FOREIGN KEY(idCliente) REFERENCES Clientes(idCliente) ON DELETE CASCADE ON UPDATE CASCADE
      );

      -- TABLE Funcionarios
      CREATE TABLE IF NOT EXISTS Funcionarios (
          idFuncionario INTEGER PRIMARY KEY AUTOINCREMENT,
          senha TEXT,
          cpf TEXT,
          nome TEXT,
          dataNascimento DATE,
          dataContratacao DATE,
          salario REAL,
          dataDemissao DATE,
          idTipoFuncionario INTEGER,
          FOREIGN KEY(idTipoFuncionario) REFERENCES TipoFuncionario(idTipoFuncionario) ON DELETE RESTRICT ON UPDATE CASCADE
      );

      -- TABLE Fornecedor
      CREATE TABLE IF NOT EXISTS Fornecedor (
          idFornecedor INTEGER PRIMARY KEY AUTOINCREMENT,
          cnpj TEXT,
          nome TEXT
      );

      -- TABLE EstoquePecaServico
      CREATE TABLE IF NOT EXISTS EstoquePecaServico (
          idPecaServico INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          precoCompra REAL,
          precoVenda REAL,
          quantidade INTEGER,
          idTipoPecaServico INTEGER,
          FOREIGN KEY(idTipoPecaServico) REFERENCES TipoPecaServico(idTipoPecaServico) ON DELETE RESTRICT ON UPDATE CASCADE
      );

      -- TABLE Endereco
      CREATE TABLE IF NOT EXISTS Endereco (
          idEndereco INTEGER PRIMARY KEY AUTOINCREMENT,
          rua TEXT,
          numero TEXT,
          complemento TEXT,
          bairro TEXT,
          cidade TEXT,
          estado TEXT,
          cep TEXT,
          pontoReferencia TEXT,
          telefone TEXT,
          idCliente INTEGER,
          idFornecedor INTEGER,
          FOREIGN KEY(idCliente) REFERENCES Clientes(idCliente) ON DELETE CASCADE ON UPDATE CASCADE,
          FOREIGN KEY(idFornecedor) REFERENCES Fornecedor(idFornecedor) ON DELETE CASCADE ON UPDATE CASCADE
      );

      -- TABLE OrdemServico
      CREATE TABLE IF NOT EXISTS OrdemServico (
          idOrdemServico INTEGER PRIMARY KEY AUTOINCREMENT,
          dataHoraEntregaVeiculo DATETIME,
          dataHoraInicioServico DATETIME,
          dataHoraFimServico DATETIME,
          quilometragem INTEGER,
          valorPago REAL,
          idCliente INTEGER,
          idVeiculo INTEGER,
          idFuncionario INTEGER,
          idTipoPagamento INTEGER,
          idTipoStatus INTEGER,
          FOREIGN KEY(idCliente) REFERENCES Clientes(idCliente) ON DELETE CASCADE ON UPDATE CASCADE,
          FOREIGN KEY(idVeiculo) REFERENCES Veiculos(idVeiculo) ON DELETE CASCADE ON UPDATE CASCADE,
          FOREIGN KEY(idFuncionario) REFERENCES Funcionarios(idFuncionario) ON DELETE CASCADE ON UPDATE CASCADE,
          FOREIGN KEY(idTipoPagamento) REFERENCES TipoPagamento(idTipoPagamento) ON DELETE RESTRICT ON UPDATE CASCADE,
          FOREIGN KEY(idTipoStatus) REFERENCES TipoStatus(idTipoStatus) ON DELETE RESTRICT ON UPDATE CASCADE
      );

      -- TABLE OrdemServicoEstoquePecas
      CREATE TABLE IF NOT EXISTS OrdemServicoEstoquePecas (
          idOrdemServicoEstoquePecas INTEGER PRIMARY KEY AUTOINCREMENT,
          idOrdemServico INTEGER,
          idEstoquePecaServico INTEGER,
          preco REAL,
          quantidade INTEGER,
          FOREIGN KEY(idOrdemServico) REFERENCES OrdemServico(idOrdemServico) ON DELETE CASCADE ON UPDATE CASCADE,
          FOREIGN KEY(idEstoquePecaServico) REFERENCES EstoquePecaServico(idPecaServico) ON DELETE CASCADE ON UPDATE CASCADE
      );

      -- TABLE FornecedorEstoquePecas
      CREATE TABLE IF NOT EXISTS FornecedorEstoquePecas (
          idFornecedorEstoquePecas INTEGER PRIMARY KEY AUTOINCREMENT,
          idFornecedor INTEGER,
          idPecaServico INTEGER,
          FOREIGN KEY(idFornecedor) REFERENCES Fornecedor(idFornecedor) ON DELETE CASCADE ON UPDATE CASCADE,
          FOREIGN KEY(idPecaServico) REFERENCES EstoquePecaServico(idPecaServico) ON DELETE CASCADE ON UPDATE CASCADE
      );
  ''';
}
