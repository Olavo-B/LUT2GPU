# /*****************************************************************************/
#  * File: sumConstructor.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-02-02
#  * License: [License Type]
#  * Description: This file is responsible for generating the sum of the ripple
# * carry adder.
# /*****************************************************************************/


from ultils.style import Mensage

class RippleAdderGenerator:
    """
    Class to generate Verilog code for a parameterized N-bit Ripple Carry Adder
    and its corresponding testbench.

    Attributes:
        n_bits (int): Number of bits for the adder
        debug (bool): Flag to enable debug messages
        style (Style): Style class for colored output
    """

    def __init__(self, n_bits, debug=False):
        """
        Initialize the generator with the number of bits.

        Args:
            n_bits (int): Number of bits for the adder
            debug (bool): Enable debug messages (default: False)
        """
        self.n_bits = n_bits
        self.max_value = 2**n_bits - 1
        self.debug = debug
        self.mensage = Mensage()
        
        # Initial debug message
        if self.debug: self.mensage.debug(f"Initializing {n_bits}-bit Ripple Adder Generator")


    def generate_adder(self):
        """
        Generates Verilog code for an N-bit Ripple Carry Adder.

        Returns:
            str: Verilog code for the adder module
        
        Example:
            generator = RippleAdderGenerator(4)
            adder_code = generator.generate_adder()
        """

        module_template = """/*
 * N-bit Ripple Carry Adder
 * ------------------------
 * Author: RippleAdderGenerator
 * 
 * Description:
 * This module implements a parameterized N-bit ripple carry adder
 * using a chain of full adders.
 *
 * Parameters:
 * - N_BITS: Width of input and output buses
 *
 * Ports:
 * - a[N_BITS-1:0]: First input operand
 * - b[N_BITS-1:0]: Second input operand
 * - cin: Carry input
 * - sum[N_BITS-1:0]: Sum output
 * - cout: Carry output
 */

module ripple_adder_{}bit(
    input [{}-1:0] a,
    input [{}-1:0] b,
    input cin,
    output [{}-1:0] sum,
    output cout
);

    // Internal carry wires between full adders
    wire [{}:0] carry;
    assign carry[0] = cin;
    assign cout = carry[{}];
    
    // Full adder instantiations
{}
    
endmodule

/*
 * Single-bit Full Adder
 * --------------------
 * Description:
 * Basic building block that adds three single-bit inputs
 * and produces a sum and carry output.
 *
 * Ports:
 * - a: First input bit
 * - b: Second input bit
 * - cin: Carry input
 * - sum: Sum output
 * - cout: Carry output
 */
module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule
"""
        
        # Generate full adder instances
        fa_instances = []
        for i in range(self.n_bits):
            instance = f"    // Bit {i} full adder\n" + \
                      f"    full_adder fa{i}(\n" + \
                      f"        .a(a[{i}]),\n" + \
                      f"        .b(b[{i}]),\n" + \
                      f"        .cin(carry[{i}]),\n" + \
                      f"        .sum(sum[{i}]),\n" + \
                      f"        .cout(carry[{i}+1])\n" + \
                      f"    );"
            fa_instances.append(instance)
        
        return module_template.format(
            self.n_bits,
            self.n_bits, self.n_bits,
            self.n_bits,
            self.n_bits,
            self.n_bits,
            "\n\n".join(fa_instances)
        )

    def generate_testbench(self):
        """
        Generates Verilog code for an exhaustive testbench.

        Returns:
            str: Verilog code for the testbench module
        
        Example:
            generator = RippleAdderGenerator(4)
            testbench_code = generator.generate_testbench()
        """
        
        testbench_template = """/*
 * Ripple Carry Adder Testbench
 * ---------------------------
 * Author: RippleAdderGenerator
 *
 * Description:
 * This testbench performs exhaustive testing of the ripple carry adder
 * by checking all possible input combinations.
 *
 * Test Coverage:
 * - All possible values for input a
 * - All possible values for input b
 * - Both values for carry input
 * - Total combinations: (2^N_BITS * 2^N_BITS * 2)
 */

module ripple_adder_tb();
    // Parameters and constants
    parameter N_BITS = {0};
    parameter DELAY = 2;  // Propagation delay between tests
    
    // DUT signals
    reg [N_BITS-1:0] a;
    reg [N_BITS-1:0] b;
    reg cin;
    wire [N_BITS-1:0] sum;
    wire cout;
    
    // Test variables
    integer i, j, k;
    integer errors;
    integer num_tests;
    integer total_combinations;
    
    // Instantiate Device Under Test (DUT)
    ripple_adder_{0}bit dut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );
    
    // Test stimulus and verification
    initial begin
        // Initialize test counters
        errors = 0;
        num_tests = 0;
        total_combinations = (2**N_BITS) * (2**N_BITS) * 2;
        
        // Print test header
        $display("\\n=== {0}-bit Ripple Carry Adder Exhaustive Test ===");
        $display("Total combinations to test: %0d", total_combinations);

        // Exhaustive testing of all input combinations
        for(i = 0; i <= {1}; i = i + 1) begin
            for(j = 0; j <= {1}; j = j + 1) begin
                for(k = 0; k <= 1; k = k + 1) begin
                    test_case(i[N_BITS-1:0], j[N_BITS-1:0], k[0]);
                    
                    // Progress update every 10% or on errors
                    if((errors > 0)) begin
                        $display("%0t:\\t%0d%%\\t\\t%0d\\t%0t", 
                                $time,
                                (num_tests * 100) / total_combinations,
                                errors,
                                $time);
                    end
                end
            end
        end
        
        // Final test report
        $display("------------------------------------------------");
        $display("Test Summary:");
        $display("  Combinations tested: %0d", num_tests);
        $display("  Errors found: %0d", errors);
        $display("  Success rate: %0.2f%%", 
                ((num_tests-errors)*100.0)/num_tests);
        $display("  Simulation time: %0t\\n", $time);
        
        if(errors == 0) begin
            $display("SUCCESS: All combinations verified without errors!\\n");
        end else begin
            $display("FAILURE: %0d errors detected.\\n", errors);
        end
        
    end
    
    // Test case task
    task test_case;
        input [N_BITS-1:0] test_a;
        input [N_BITS-1:0] test_b;
        input test_cin;
        
        reg [N_BITS:0] expected;
        begin
            // Apply test vectors
            a = test_a;
            b = test_b;
            cin = test_cin;
            num_tests = num_tests + 1;
            
            // Wait for propagation
            #DELAY;
            
            // Calculate expected result
            expected = test_a + test_b + test_cin;
            
            // Check result
            if({{cout, sum}} !== expected) begin
                $display("\\nERROR at %0t:", $time);
                $display("  a     = %b (%0d)", test_a, test_a);
                $display("  b     = %b (%0d)", test_b, test_b);
                $display("  cin   = %b", test_cin);
                $display("  Expected: %b (%0d)", expected, expected);
                $display("  Got:      %b (%0d)\\n", {{cout, sum}}, {{cout, sum}});
                errors = errors + 1;
            end
        end
    endtask

endmodule"""
        
        return testbench_template.format(
            self.n_bits,
            self.max_value
        )

    def generate_optimized_testbench(self):
        """
        Generates an optimized Verilog testbench with the following improvements:
        - Parallel test execution using fork-join
        - Smart test case selection
        - Efficient result checking
        - Memory-optimized reporting
        - Early error detection
        """
        
        
        testbench_template = """/*
 * Optimized Ripple Carry Adder Testbench
 * -------------------------------------
 * Description: High-performance testbench using parallel testing
 * and optimized verification strategies
 */

module ripple_adder_tb();
    // Timing parameters
    parameter DELAY = 1;    // Minimal delay for stability
    parameter N_BITS = {0}; // Adder width
    
    // Simulation control
    parameter TEST_VECTORS = {1};  // Number of test vectors per process
    parameter NUM_PARALLEL = 4;    // Number of parallel test processes
    
    // Shared variables
    reg [31:0] error_count;
    reg [31:0] test_count;
    reg testing_done;
    event trigger_report;
    
    // Test signals for each parallel process
    reg [N_BITS-1:0] a [NUM_PARALLEL];
    reg [N_BITS-1:0] b [NUM_PARALLEL];
    reg cin [NUM_PARALLEL];
    wire [N_BITS-1:0] sum [NUM_PARALLEL];
    wire cout [NUM_PARALLEL];
    
    // Performance metrics
    time start_time;
    time end_time;
    
    // Generate multiple instances of the DUT
    genvar i;
    generate
        for(i = 0; i < NUM_PARALLEL; i = i + 1) begin : dut_inst
            ripple_adder_{0}bit dut(
                .a(a[i]),
                .b(b[i]),
                .cin(cin[i]),
                .sum(sum[i]),
                .cout(cout[i])
            );
        end
    endgenerate
    
    // Initialize test environment
    initial begin
        error_count = 0;
        test_count = 0;
        testing_done = 0;
        start_time = $time;
        
        $display("\\n%c[1;34m=== Optimized {0}-bit Ripple Carry Adder Test ===\\n%c[0m", 27, 27);
        
        fork
            test_process(0);
            test_process(1);
            test_process(2);
            test_process(3);
            monitor_process();
        join
        
        end_time = $time;
        
        // Final report
        $display("\\n%c[1;36m=== Test Summary ===\\n%c[0m", 27, 27);
        $display("Total tests     : %0d", test_count);
        $display("Total errors    : %0d", error_count);
        $display("Success rate    : %0.2f%%", 
                ((test_count-error_count)*100.0)/test_count);
        $display("Simulation time : %0t", end_time - start_time);
        $display("Tests per second: %0d", 
                (test_count*1000000)/(end_time - start_time));
        
        if(error_count == 0)
            $display("\\n%c[1;32mAll tests passed successfully!%c[0m\\n", 27, 27);
        else
            $display("\\n%c[1;31mFound %0d errors!%c[0m\\n", 27, 27, error_count);
            
        $finish;
    end
    
    // Task to verify a single test case
    task automatic check_result;
        input integer pid;
        reg [N_BITS:0] expected;
        begin
            expected = a[pid] + b[pid] + cin[pid];
            
            if({{cout[pid], sum[pid]}} !== expected) begin
                error_count = error_count + 1;
                
                // Only print first 10 errors to avoid log flooding
                if(error_count <= 10) begin
                    $display("\\n%c[1;31mError in process %0d:%c[0m", 27, pid, 27);
                    $display("  a   = %b (%0d)", a[pid], a[pid]);
                    $display("  b   = %b (%0d)", b[pid], b[pid]);
                    $display("  cin = %b", cin[pid]);
                    $display("  Expected: %b (%0d)", expected, expected);
                    $display("  Got     : %b (%0d)\\n", 
                            {{cout[pid], sum[pid]}}, {{cout[pid], sum[pid]}});
                end
            end
            
            test_count = test_count + 1;
        end
    endtask
    
    // Individual test process
    task automatic test_process;
        input integer pid;
        integer i;
        reg [N_BITS*2:0] state;
        begin
            // Initialize LFSR state for this process
            state = (pid + 1) * 1234567;
            
            for(i = 0; i < TEST_VECTORS; i = i + 1) begin
                // Generate pseudo-random test vectors using LFSR
                state = lfsr_next(state);
                a[pid] = state[N_BITS-1:0];
                b[pid] = state[N_BITS*2-1:N_BITS];
                cin[pid] = state[N_BITS*2];
                
                #DELAY;
                check_result(pid);
                
                // Early termination on error if needed
                if(error_count > 100) begin
                    $display("\\n%c[1;31mToo many errors, terminating...%c[0m\\n", 
                            27, 27);
                    -> trigger_report;
                    $finish;
                end
            end
            
            if(pid == 0) testing_done = 1;
        end
    endtask
    
    // Monitor process for progress reporting
    task automatic monitor_process;
        integer last_count;
        integer progress;
        begin
            last_count = 0;
            while(!testing_done) begin
                #10000;
                progress = (test_count * 100) / (TEST_VECTORS * NUM_PARALLEL);
                if(test_count - last_count > 0) begin
                    $write("\\rProgress: %0d%% (%0d tests)\\n", progress, test_count);
                    $fflush();
                    last_count = test_count;
                end
            end
            $write("\\n");
        end
    endtask
    
    // LFSR function for pseudo-random number generation
    function [N_BITS*2:0] lfsr_next;
        input [N_BITS*2:0] state;
        begin
            lfsr_next = {{state[N_BITS*2-1:0], state[N_BITS*2] ^ state[0]}};
        end
    endfunction

endmodule"""


        test_vectors = 2**(2 * self.n_bits)


        return testbench_template.format(
            self.n_bits,
            test_vectors
        )
    

    def save_files(self, path:str = '.'):
        """
        Saves all generated files (adder, testbench, and test script).

        Args:
            path (str): Path to save the files (default: current directory)
        
        Example:
            generator = RippleAdderGenerator(4)
            generator.save_files()
        """
        try:
            if self.debug: self.mensage.debug("Starting file generation process")
            
            # Save adder module
            if self.debug: self.mensage.debug(f"Generating ripple_adder_{self.n_bits}bit.v")
            with open(f"{path}/ripple_adder_{self.n_bits}bit.v", 'w') as f:
                f.write(self.generate_adder())
            self.mensage.success(f"Generated ripple_adder_{self.n_bits}bit.v")
            
            # # Save testbench
            # if self.debug: self.mensage.debug("Generating ripple_adder_tb.v")
            # with open(f"{path}/general_testbench.v", 'w') as f:
            #     f.write(self.generate_testbench())
            # self.mensage.success("Generated testbench.v")

            # # Save optimized testbench
            # if self.debug: self.mensage.debug("Generating optimized testbench")
            # with open(f"{path}/ripple_adder_optimized_tb.v", 'w') as f:
            #     f.write(self.generate_optimized_testbench())
            # self.mensage.success("Generated optimized testbench")


                        
        except IOError as e:
            self.mensage.error(f"Failed to save files: {str(e)}")
            raise
        except Exception as e:
            self.mensage.error(f"Unexpected error: {str(e)}")
            raise

    def validate_inputs(self):
        """
        Validate the input parameters.

        Returns:
            bool: True if inputs are valid, False otherwise
        """
        try:
            if not isinstance(self.n_bits, int):
                self.mensage.error("Number of bits must be an integer")
                return False
            
            if self.n_bits <= 0:
                self.mensage.error("Number of bits must be positive")
                return False
            
            if self.n_bits > 64:
                self.mensage.warning("Large bit width may result in long simulation times")
            
            if self.debug: self.mensage.debug("Input validation passed")
            return True
            
        except Exception as e:
            self.mensage.error(f"Validation error: {str(e)}")
            return False