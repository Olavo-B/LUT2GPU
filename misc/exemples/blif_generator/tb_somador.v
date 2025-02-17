
module tb_top;

  // Entradas
  reg x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15;

  // Saídas
  wire z0, z1, z2, z3, z4, z5, z6, z7, z8;

  // Instância do módulo a ser testado
  \/app/results/blif_generator/somador uut (
    .x00(x0), .x01(x1), .x02(x2), .x03(x3), .x04(x4), .x05(x5), .x06(x6), .x07(x7), .x08(x8), .x09(x9), .x10(x10), .x11(x11), .x12(x12), .x13(x13), .x14(x14), .x15(x15), .z0(z0), .z1(z1), .z2(z2), .z3(z3), .z4(z4), .z5(z5), .z6(z6), .z7(z7), .z8(z8)
  );

  integer A, B, C;

  initial begin
    $display("Iniciando os testes...");

    // Testando todas as combinações de A e B
    for (A = 0; A < 256; A = A + 1) begin
      for (B = 0; B < 256; B = B + 1) begin
        // Configurar os bits de entrada
        x0 = A[7];
        x1 = A[6];
        x2 = A[5];
        x3 = A[4];
        x4 = A[3];
        x5 = A[2];
        x6 = A[1];
        x7 = A[0];
        x8 = B[7];
        x9 = B[6];
        x10 = B[5];
        x11 = B[4];
        x12 = B[3];
        x13 = B[2];
        x14 = B[1];
        x15 = B[0];

        // Aguardar propagação
        #10;

        // Calcular a soma esperada
        C = A + B;

        // Verificar o resultado]
        if (C != {23'b0, z0, z1, z2, z3, z4, z5, z6, z7, z8}) begin
          $display("Erro: A=%b, B=%b -> Esperado=%b, Obtido=%b", A, B, C, {z8, z7, z6, z5, z4, z3, z2, z1, z0});
        end
      end
    end

    $display("Testes concluídos.");
    $finish;
  end
endmodule
