# /*****************************************************************************/
#  * File: style.py
#  * Author: Olavo Alves Barros Silva
#  * Contact: olavo.barros@ufv.com
#  * Date: 2025-01-27
#  * License: [License Type]
#  * Description: Style class to color the output.
# /*****************************************************************************/


class Style():
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    BRIGHT = '\033[1m'
    YELLOW = '\033[93m'
    RESET = '\033[0m'

class Mensage():
    @staticmethod
    def debug(message):
        print(f"{Style.OKCYAN}[DEBUG] {message}{Style.ENDC}")

    @staticmethod
    def success(message):
        print(f"{Style.OKGREEN}[SUCCESS] {message}{Style.ENDC}")
    
    @staticmethod
    def error(message):
        print(f"{Style.FAIL}[ERROR] {message}{Style.ENDC}")
    
    @staticmethod
    def warning(message):
        print(f"{Style.WARNING}[WARNING] {message}{Style.ENDC}")
    
    @staticmethod
    def info(message):
        print(f"{Style.OKBLUE}[INFO] {message}{Style.ENDC}")
    
    @staticmethod
    def bold(message):
        print(f"{Style.BOLD}{message}{Style.ENDC}")
    
    @staticmethod
    def title():
        print(rf"""
{Style.BRIGHT}      ___           ___     
     /  /\         /  /\    
    /  /:/_       /  /::\   
   /  /:/ /\     /  /:/\:\  
  /  /:/_/::\   /  /:/  \:\ 
 /__/:/__\/\:\ /__/:/ \__\:\
 \  \:\ /~~/:/ \  \:\ /  /:/
  \  \:\  /:/   \  \:\  /:/ 
   \  \:\/:/     \  \:\/:/  
    \  \::/       \  \::/   
     \__\/         \__\/    
      ___         ___           ___                 
     /  /\       /  /\         /  /\          ___   
    /  /:/_     /  /::\       /  /:/_        /  /\  
   /  /:/ /\   /  /:/\:\     /  /:/ /\      /  /:/  
  /  /:/ /:/  /  /:/~/::\   /  /:/ /::\    /  /:/   
 /__/:/ /:/  /__/:/ /:/\:\ /__/:/ /:/\:\  /  /::\   
 \  \:\/:/   \  \:\/:/__\/ \  \:\/:/~/:/ /__/:/\:\  
  \  \::/     \  \::/       \  \::/ /:/  \__\/  \:\ 
   \  \:\      \  \:\        \__\/ /:/        \  \:\
    \  \:\      \  \:\         /__/:/          \__\/
     \__\/       \__\/         \__\/                

{Style.RESET}""")
    
