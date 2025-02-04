module ripple_adder_tb();
    // Parâmetros
    parameter N_BITS = 9;
    parameter DELAY = 10;
    
    // Sinais de teste
    reg [N_BITS-1:0] a;
    reg [N_BITS-1:0] b;
    reg cin;
    wire [N_BITS-1:0] sum;
    wire cout;
    
    // Instância do módulo a ser testado
    ripple_adder #(.N_BITS(N_BITS)) uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    // Variáveis para verificação
    integer i, j, k;
    integer errors;
    
    initial begin
        // Inicialização
        errors = 0;
        $display("Iniciando testes do somador de %0d bits", N_BITS);
        $display("Tempo\ta\tb\tcin\tsum\tcout");
        $display("----------------------------------------");
        
        // Teste 1: Alguns casos básicos
        test_case(4'b0000, 4'b0000, 1'b0); // 0 + 0 + 0
        test_case(4'b0001, 4'b0001, 1'b0); // 1 + 1 + 0
        test_case(4'b1111, 4'b0001, 1'b0); // 15 + 1 + 0
        test_case(4'b1111, 4'b1111, 1'b0); // 15 + 15 + 0
        test_case(4'b1111, 4'b1111, 1'b1); // 15 + 15 + 1
        
        // Teste 2: Teste exaustivo (opcional - comentado para economizar tempo de simulação)
        /*
        for(i = 0; i < 16; i = i + 1) begin
            for(j = 0; j < 16; j = j + 1) begin
                for(k = 0; k < 2; k = k + 1) begin
                    test_case(i[3:0], j[3:0], k[0]);
                end
            end
        end
        */
        
        // Relatório final
        $display("----------------------------------------");
        $display("Testes concluídos com %0d erros", errors);
        $finish;
    end
    
    // Task para realizar um caso de teste
    task test_case;
        input [N_BITS-1:0] test_a;
        input [N_BITS-1:0] test_b;
        input test_cin;
        
        reg [N_BITS:0] expected;
        begin
            // Aplica os valores
            a = test_a;
            b = test_b;
            cin = test_cin;
            
            // Espera a propagação
            #DELAY;
            
            // Calcula o resultado esperado
            expected = test_a + test_b + test_cin;
            
            // Verifica o resultado
            if({cout, sum} !== expected) begin
                $display("ERRO em %0t:", $time);
                $display("  a=%b (%0d)", test_a, test_a);
                $display("  b=%b (%0d)", test_b, test_b);
                $display("  cin=%b", test_cin);
                $display("  Esperado: sum=%b, cout=%b", expected[N_BITS-1:0], expected[N_BITS]);
                $display("  Obtido:   sum=%b, cout=%b", sum, cout);
                errors = errors + 1;
            end else begin
                $display("%0t:\t%b\t%b\t%b\t%b\t%b", $time, test_a, test_b, test_cin, sum, cout);
            end
        end
    endtask

endmodule
