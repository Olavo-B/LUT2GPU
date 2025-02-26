# /*****************************************************************************/
#  * File: runScripts.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-02-02
#  * License: [License Type]
#  * Description: This code is responsible for build and run the scripts for yosys
#  * and abc tools.
# /*****************************************************************************/

from jinja2 import Template
import subprocess
import time
import os

from ultils.style import Mensage, Style
from codegen.sumConstructor import RippleAdderGenerator

class RunScripts():

    def __init__(self, path:str, verilog_path:str, top_module:str,args:dict, debug:bool=False):
        self.path = path
        self.verilog = f"{path}/verilog/{verilog_path}"
        self.top_module = top_module
        self.args = args
        self.mensage = Mensage()
        self.debug = debug
        
        self.__create_folder()

    def __create_folder(self):
        
            
        if not os.path.exists(f"{self.path}/verilog"):
            self.mensage.info("Creating folders")

            os.makedirs(f"{self.path}/verilog")
        
    def __generate_scripts(self):

         # Template do arquivo ABC
        with open(f"/app/templates/read_pla.jinja") as file:
            template_yosys = Template(file.read())

        with open(f"/app/templates/abc_sript.jinja") as file:
            template_abc = Template(file.read())

        # Renderiza o template com o PLA gerado
        abc_script = template_abc.render(blif_file=f"{self.path}/somador.blif",
                                        otimizations= self.args['otimizations'],
                                        lut_k = self.args['lut_k'],
                                        verilog_output=f"{self.path}/verilog/somador.v",
                                        dot_output=f"{self.path}/somador.dot",
                                        blif_output=f"{self.path}/somador.blif",
                                        )
                                        
        with open(f"{self.path}/abc_script.rc", "w") as file:
            file.write(abc_script)

        yosys_script = template_yosys.render(verilog_path=self.verilog,
                                            top_module=self.top_module,
                                            abc_script=f"{self.path}/abc_script.abc",
                                            output_path=self.path,
                                        )

        with open(f"{self.path}/yosys_script.ys", "w") as file:
            file.write(yosys_script)

    def __run_yosys(self):
        # Executa o script do Yosys
        try:
            command = f'yosys -s {self.path}/yosys_script.ys'
            process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
        
            stdout, stderr = process.communicate()  # Captura a saída e o erro


            self.mensage.success(f"Yosys finished...saved at {self.path}/yosys_script.ys")

        except subprocess.CalledProcessError as e:
            # 2024-11-17 00:36:59
            # trow an error if the Yosys was not executed successfully
            raise Exception(self.mensage.error(f"Error in Yosys: {e}")) 

    def __run_abc(self):
        # Executa o script do ABC
        try:
            command = f'yosys-abc -f {self.path}/abc_script.rc'
            process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
        
            stdout, stderr = process.communicate()  # Captura a saída e o erro

            self.mensage.success(f"ABC finished...saved at {self.path}/abc_script.rc")

        except subprocess.CalledProcessError as e:
            # 2024-11-17 00:36:59
            # trow an error if the Yosys was not executed successfully
            raise Exception(self.mensage.error(f"Error in ABC: {e}"))

    def run_yosys(self):
        self.__generate_scripts()
        self.__run_yosys()

    def run_abc(self):
        self.__generate_scripts()
        self.__run_abc()   

    def run(self):
        self.__generate_scripts()
        self.__run_yosys()
        self.__run_abc()

