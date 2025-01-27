`include "/app/notebooks/results/blif_generator/somador.v"

module tb_somador;

  // Entradas
  reg x0, x1, x2, x3;

  // Saídas
  wire z0, z1, z2;

  // Instância do módulo a ser testado
  \/app/results/blif_generator/somador uut (
    .x0(x0), .x1(x1), .x2(x2), .x3(x3), .z0(z0), .z1(z1), .z2(z2)
  );

  integer A, B, C;

  initial begin
    $display("Iniciando os testes...");

    // Testando todas as combinações de A e B
    for (A = 0; A < 4; A = A + 1) begin
      for (B = 0; B < 4; B = B + 1) begin
        // Configurar os bits de entrada
        x0 = A[1];
        x1 = A[0];
        x2 = B[1];
        x3 = B[0];

        // Aguardar propagação
        #10;

        // Calcular a soma esperada
        C = A + B;

        // Verificar o resultado
        if (C !== { z0, z1, z2 }) begin
          $display("Erro: A=%b, B=%b -> Esperado=%b, Obtido=%b", A, B, C, { z2, z1, z0 });
        end
      end
    end

    $display("Testes concluídos.");
    $finish;
  end
endmodule
