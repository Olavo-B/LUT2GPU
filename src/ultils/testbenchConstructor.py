# /*****************************************************************************/
#  * File: testbenchConstructor.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-02-03
#  * License: [License Type]
#  * Description: This file is responsible for generating the testbench files.
# /*****************************************************************************/


import os
import re
from itertools import product
from src.ultils.style import Mensage

class VerilogTestbenchGenerator:
    """
    Class to generate Verilog testbench for a given module.

    Attributes:
        module_path (str): Path to the source Verilog module
        module_name (str): Name of the module
        inputs (List[str]): List of input port names
        outputs (List[str]): List of output port names
        debug (bool): Flag to enable debug messages
        style (Mensage): Style class for colored output
    """

    def __init__(self, module_path: str, debug: bool = False):
        """
        Initialize the testbench generator.

        Args:
            module_path (str): Path to the source Verilog module
            debug (bool): Enable debug messages (default: False)
        """
        self.module_path = module_path
        self.module_name = ""
        self.dut_name = ""  # Actual module name in the design
        self.inputs = []
        self.outputs = []
        self.debug = debug
        self.mensage = Mensage()

        # Initial setup
        self._parse_verilog_module()

        # Initial debug message
        if self.debug:
            self.mensage.debug(f"Initializing Testbench Generator for {self.module_name}")

    def _parse_verilog_module(self):
        """
        Parse the Verilog module to extract module name, inputs, and outputs.
        """
        try:
            with open(self.module_path, 'r') as f:
                content = f.read()

            # Extract module name
            module_match = re.search(r'module\s+(\w+)\s*\(', content)
            if module_match:
                self.dut_name = module_match.group(1)
                self.module_name = f"{self.dut_name}_tb"


            # Process inputs
            input_matches = re.findall(r'input\s+([^;]+);', content)
            self.inputs = []
            for match in input_matches:
                # Split by spaces and filter out empty strings
                inputs = [inp.strip() for inp in match.split() if inp.strip()]
                # Remove type specifiers like 'wire' if present
                inputs = [inp for inp in inputs if not inp in ['input', 'wire']]
                # Remove inputs like ',' or ';'
                inputs = [inp for inp in inputs if not inp in [',', ';']]
                inputs = [inp.replace(',', '') for inp in inputs]

                self.inputs.extend(inputs)

            # Process outputs
            output_matches = re.findall(r'output\s+([^;]+);', content)
            self.outputs = []
            for match in output_matches:
                # Split by spaces and filter out empty strings
                outputs = [out.strip() for out in match.split() if out.strip()]
                # Remove type specifiers like 'wire' if present
                outputs = [out for out in outputs if not out in ['output', 'wire']]
                # Remove outputs like ',' or ';'
                outputs = [out for out in outputs if not out in [',', ';']]
                # Remove ',' from each output
                outputs = [out.replace(',', '') for out in outputs]
                self.outputs.extend(outputs)

            if self.debug:
                self.mensage.debug(f"Parsed module: {self.dut_name}")
                self.mensage.debug(f"Inputs: {self.inputs}")
                self.mensage.debug(f"Outputs: {self.outputs}")

        except FileNotFoundError:
            self.mensage.error(f"Module file not found: {self.module_path}")
            raise
        except Exception as e:
            self.mensage.error(f"Error parsing Verilog module: {str(e)}")
            raise
        
    def generate_basic_testbench(self) -> str:
        """
        Generate a basic Verilog testbench using grouped inputs from counters.
        """
        GROUP_SIZE = min(30, len(self.inputs))  # Size of each group (8 bits = 256 combinations)
        input_count = len(self.inputs)
        num_groups = (input_count + GROUP_SIZE) // GROUP_SIZE  # Ceiling division
        
        # Generate the counter assignments for each group
        counter_assignments = []
        for group in range(num_groups):
            start_idx = group * GROUP_SIZE
            end_idx = min((group + 1) * GROUP_SIZE, input_count)
            
            assignments = []
            for i, input_name in enumerate(self.inputs[start_idx:end_idx]):
                assignments.append(f"                {input_name} = counter_{group}[{i}];\n")
            counter_assignments.extend(assignments)

        if self.debug:
            self.mensage.debug(f"Generated {num_groups} groups of {GROUP_SIZE} inputs each")

        testbench_template = f"""/*
    * Testbench for {self.dut_name}
    * Generated automatically
    * Description: Testing using grouped inputs from counters
    */

    module tb_top();
        // Testbench signals
    {self._generate_testbench_signals()}

        // Error and test tracking
        integer errors = 0;
        integer tests_run = 0;
        
        // Group counters
        {"    ".join([f"integer counter_{i};\n" for i in range(num_groups)])}

        // Device Under Test (DUT) instantiation
        {self.dut_name} dut(
    {self._generate_dut_port_mapping()}
        );

        // Test stimulus and verification
        initial begin
            $display("Starting grouped input test for {self.dut_name}");
            
            
                {"".join([f'''
                for (counter_{i} = 0; counter_{i} < {2**GROUP_SIZE}; counter_{i} = counter_{i} + 1) begin''' for i in range(num_groups)])}
                    
                    // Assign inputs from counters
    {"".join(counter_assignments)}
                    
                    // Allow signals to propagate
                    #1;
                    
                    // Track test execution
                    tests_run = tests_run + 1;
                    
                    // Add verification logic here
                    // Example:
                    // if (output_doesnt_match_expected)
                    //     errors = errors + 1;
                    
                {"end\n            ".join(["" for _ in range(num_groups)])}
            end

            // Test summary
            $display("Test Summary:");
            $display("  Total Tests: %0d", tests_run);
            $display("  Errors Found: %0d", errors);

            if (errors == 0)
                $display("PASSED: All tests successful!");
            else
                $display("FAILED: %0d errors detected", errors);

            $finish;
        end

    endmodule
    """
        return testbench_template

    def _generate_testbench_signals(self) -> str:
        """
        Generate signal declarations for testbench.

        Returns:
            str: Verilog signal declarations
        """
        signals = []
        for input_port in self.inputs:
            signals.append(f"    reg {input_port};")
        for output_port in self.outputs:
            signals.append(f"    wire {output_port};")
        return "\n".join(signals)

    def _generate_dut_port_mapping(self) -> str:
        """
        Generate port mapping for Device Under Test.

        Returns:
            str: Verilog port mapping
        """
        port_mappings = []
        for input_port in self.inputs:
            port_mappings.append(f"        .{input_port}({input_port})")
        for output_port in self.outputs:
            port_mappings.append(f"        .{output_port}({output_port})")
        return ",\n".join(port_mappings)

    def _generate_exhaustive_test_cases(self) -> str:
        """
        Generate exhaustive test cases for all possible input combinations.

        Returns:
            str: Verilog test case generation code
        """
        # Create test case generation using itertools
        test_cases = [
            "        // Exhaustive testing of all input combinations"
        ]

        # Generate all possible binary combinations
        def generate_combinations(num_inputs):
            if self.debug: self.mensage.debug(f"Generating all possible combinations for {num_inputs} inputs")
            return 2 ** num_inputs

        # Generate total input combinations
        input_combinations = generate_combinations(len(self.inputs))

        # Add test case generation code
        test_cases.append(f"        // Total test combinations: {input_combinations}")

        # Nested loops or direct generation of all combinations
        test_cases.append("        // Test every possible input combination")
        
        # Begin test loop
        test_cases.append("        begin")
        
        # Variables for iteration
        test_cases.append(f"            for (test_index = 0; test_index < {input_combinations}; test_index = test_index + 1) begin")
        
        # Assign inputs based on combination
        for i, input_port in enumerate(self.inputs):
            test_cases.append(f"                {input_port} = test_index[{i}];")
        
        # Test tracking and delay
        test_cases.extend([
            "                tests_run = tests_run + 1;",
            "                #1;  // Allow signal propagation",
            "                // Add your specific verification logic here",
            "                // Example:",
            "                // if (output_doesnt_match_expected)",
            "                //     errors = errors + 1;"
        ])
        
        # Close loops
        test_cases.append("            end")
        test_cases.append("        end")

        return "\n".join(test_cases)

    def save_testbench(self, output_path: str = '.'):
        """
        Save generated testbench to a file.

        Args:
            output_path (str): Directory to save the testbench
        """
        try:
            # Generate testbench
            testbench_content = self.generate_basic_testbench()
            filename = f"testbench.v"

            # Save testbench file
            full_path = os.path.join(output_path, filename)
            with open(full_path, 'w') as f:
                f.write(testbench_content)

            if self.debug:
                self.mensage.debug(f"Saved testbench to {full_path}")
            self.mensage.success(f"Testbench saved: {filename}")

        except IOError as e:
            self.mensage.error(f"Failed to save testbench: {str(e)}")
            raise
        except Exception as e:
            self.mensage.error(f"Unexpected error: {str(e)}")
            raise
