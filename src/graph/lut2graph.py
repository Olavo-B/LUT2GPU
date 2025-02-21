# /*****************************************************************************/
#  * File: lut2graph.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-01-27
#  * License: [License Type]
#  * Description: This script converts a LUT graph to a graph using netwowrkx 
#  * library.
# /*****************************************************************************/


import matplotlib.pyplot as plt
from itertools import product
import networkx as nx
import os
import re


from ultils.style import Style, Mensage


class Graph():
    """
    Class that represents a LUT graph.

    Attributes:
    - G: nx.DiGraph
        A directed graph representing the LUT.
    - debug: bool
        A flag that indicates if debug messages should be printed.
    """
    def __init__(self, blif_path:str, verilog_path:str, debug:bool = False):
        self.G = nx.DiGraph()
        self.debug = debug

        self.__parse_blif(blif_path, verilog_path)

        self.mensage = Mensage()    

        self.mensage.success("Graph created successfully!")

    
    def __getitem__(self, node):
        return self.G[node]
    
    #====================#
    # Getters and Setters#
    #====================#

    @property
    def graph(self):
        return self.G
    
    @property
    def operations(self):
        return sum([data.get('operations', 0) for node, data in self.G.nodes(data=True)])
    
    @property
    def inputs(self):
        return [node for node, data in self.G.nodes(data=True) if data.get('type') == 'input']
    
    @property
    def outputs(self):
        return [node for node, data in self.G.nodes(data=True) if data.get('type') == 'output']
    
    @property
    def intermediaries(self):
        return [node for node, data in self.G.nodes(data=True) if data.get('type') == 'intermediary']
    
    #====================#
    #  Private Methods   #
    #====================#

    def __binary_to_decimal(self, binary_str: str) -> int:
        """
        Convert a binary string to a decimal integer.

        Args:
        ------

        - binary_str: str
            A binary string.
        
        Returns:
        ------

        - decimal: int
            A decimal integer.

        Example:
        ------

        binary_str = "1011"
        decimal = 11

        """
        return int(binary_str, 2)


    def __pla_to_binary_vector(self, pla_table: list[dict], num_vars: int) -> list:
        """
        Convert a PLA table to a binary vector.

        Args:
        ------
        - pla_table: list
            A list of dictionaries representing the PLA table.
        - num_vars: int
            The number of variables in the truth table.
        
        Returns:
        ------
        - binary_vector: list
            A list of integers representing the binary vector.

        Example:
        ------

        pla_table = [
            {"input": "00-", "output": "1"},
            {"input": "01-", "output": "0"},
            {"input": "1--", "output": "1"}
        ]

        binary_vector = [1, 0, 1, 1]
        """
        vector_size = 2 ** num_vars
        binary_vector = [0 if int(pla_table[0]['output'])==1 else 1] * vector_size

        
        
        for entry in pla_table:
            pattern, output = ''.join(entry["input"]), entry["output"]  # Garante que input seja tratado como string
            positions = [i for i, char in enumerate(pattern) if char == '-']
            base_pattern = list(pattern)
            
            for replacements in product('01', repeat=len(positions)):
                temp_pattern = base_pattern[:]
                for pos, char in zip(positions, replacements):
                    temp_pattern[pos] = char
                expanded_pattern = ''.join(temp_pattern)
                try:
                    index = int(expanded_pattern, 2)  # Garante que a ordem dos bits seja respeitada
                    binary_vector[index] = int(output)  # Armazena o valor correto
                except ValueError:
                    print(f"Erro ao converter: {expanded_pattern}")
        
        binary_vector.reverse()
        return binary_vector
    

    def __extract_equations(self, verilog_path:str) -> dict:
        """
        Extract the equations from a Verilog file.

        Args:
        ------
        - verilog_path: str
            The path to the Verilog file.
        
        Returns:
        ------
        - equations: dict
            A dictionary containing the equations.
        
        Example:
        ------
        verilog_content = ```
        module somador(
            input a,
            input b,
            output z
        );
        assign z = a ^ b;
        endmodule
        ```
        equations = {"z": "a ^ b"}

        """
        with open(verilog_path, 'r') as file:
            verilog_content = file.read()
        

        equations = {}
        lines = verilog_content.split('\n')
        for line in lines:
            stripped_line = line.strip()
            if stripped_line.startswith('assign') and '=' in stripped_line:
                # Split into variable and equation parts
                var_part, eq_part = stripped_line.split('=', 1)
                var_name = var_part.replace('assign', '').strip()
                # Clean the equation part
                equation = eq_part.replace(';', '').strip()

                # 2025-02-01 12:31:36
                # Count all types of operations
                operation_count = (
                    equation.count('&') +  # Bitwise AND
                    equation.count('|') +  # Bitwise OR
                    equation.count('~') +  # Bitwise NOT
                    equation.count('^') +  # XOR
                    equation.count('+') +  # Addition
                    equation.count('-') +  # Subtraction
                    equation.count('*') +  # Multiplication
                    equation.count('/') +  # Division
                    equation.count('%') +  # Modulus
                    equation.count('==') + # Equality
                    equation.count('!=') + # Inequality
                    equation.count('>') +  # Greater than
                    equation.count('<') +  # Less than
                    equation.count('>=') + # Greater than or equal
                    equation.count('<=') + # Less than or equal
                    equation.count('<<') + # Left shift
                    equation.count('>>') + # Right shift
                    equation.count('?')    # Ternary operator
                )

                # 2025-01-28 19:43:23
                # Change Verilog sintax to C/C++ sintax
                equation = equation.replace('^', '^')
                equation = equation.replace('&', '&&')
                equation = equation.replace('|', '||')
                equation = equation.replace('~', '!')


                # Store the equation and the operation count
                equations[var_name] = {
                    "equation": equation,
                    "operations": operation_count
                }

        return equations


    def __rename_ports(self, input_file, output_file, file_type='blif'):
        """
        Rename input, output, and internal port names in BLIF or Verilog files, 
        removing brackets, zero-padding single-digit indices.
        """
        with open(input_file, 'r') as f:
            content = f.read()
        
        # Remove line continuation backslashes
        content = re.sub(r'\\\n\s*', '', content)
        
        # Replace port references with brackets
        content = re.sub(r'(\\?[a-zA-Z]+)\[(\d+)\]', 
                        lambda m: f"{m.group(1).replace('\\', '')}{'0' if len(m.group(2)) == 1 else ''}{m.group(2)}", 
                        content)
        
        with open(output_file, 'w') as f:
            f.write(content)


    def __parse_blif(self, blif_path:str, verilog_path:str) -> None:
        """
        Parse a BLIF file and create a graph.

        Args:
        ------
        - blif_path: str
            The path to the BLIF file.
        - verilog_path: str
            The path to the Verilog file.
        
        Returns:
        -------
        - None

        """
    
        # 2025-02-03 13:22:03
        # Rename ports in BLIF and Verilog files
        self.__rename_ports(blif_path, blif_path)
        self.__rename_ports(verilog_path, verilog_path, file_type='verilog')
    
        with open(blif_path, 'r') as file:
            lines = file.readlines()



        equations = self.__extract_equations(verilog_path)
        
        inputs, outputs = [], []
        parsing_names = False
        current_node = None
        node_data = {}
        input_order = {}
        
        for line in lines:
            tokens = line.strip().split()

            if len(tokens) == 0:
                continue
            elif tokens[0] == ".inputs":
                inputs = tokens[1:]
                self.G.add_nodes_from(inputs, type="input")
            elif tokens[0] == ".outputs":
                outputs = tokens[1:]
                self.G.add_nodes_from(outputs, type="output")
            elif tokens[0] == ".names":

                # 2025-02-03 13:22:03
                # Continue if the node is not in the equations
                if tokens[-1] not in equations.keys():
                    continue

                parsing_names = True
                current_node = tokens[-1]
                dependencies = tokens[1:-1]

                for dep in dependencies:
                    if dep not in self.G.nodes():
                        self.G.add_node(dep, type="intermediary", input_order=[], truth_value=None)
                    self.G.add_edge(dep, current_node)
        
                node_data[current_node] = []
    
                input_order[current_node] = dependencies

                self.G.nodes[current_node]['input_order'] = dependencies
                self.G.nodes[current_node]['truth_value'] = None

            elif parsing_names and current_node is not None and len(tokens) > 1:
                input_values = tokens[:-1]
                output_value = tokens[-1]
                node_data[current_node].append({"input": input_values, "output": output_value})
            else:
                parsing_names = False
        
        for node, partial_truth_table in node_data.items():
            num_vars = len(input_order[node])
            full_truth_table = self.__pla_to_binary_vector(partial_truth_table, num_vars)
            self.G.nodes[node]['truth_value'] = self.__binary_to_decimal("".join(map(str, full_truth_table)))
            if node in equations.keys():
                self.G.nodes[node]['equation'] = equations[node]['equation']
                self.G.nodes[node]['operations'] = equations[node]['operations']
        # if self.debug:
        #     import pprint 
        #     pprint.pprint(list(self.G.nodes(data=True)))