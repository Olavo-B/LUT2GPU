import os
import subprocess
import pandas as pd
from datetime import datetime
import csv
import time

from ultils.style  import Mensage


def analyze_results(results_path):
    """Analyze results from the CUDA execution."""
    df = pd.read_csv(results_path)
    
    # Get non-zero results
    non_zero = df[df['match_count'] > 0]
    
    if len(non_zero) == 0:
        return None, 0, 0, 0, 0, 0
    
    num_comparisons = 2**14

    # Calculate statistics
    best_idx = non_zero['thread_index'].iloc[non_zero['match_count'].argmax()]
    best_result = non_zero['match_count'].max()
    er = (num_comparisons - best_result) / (num_comparisons) 
    q1 = non_zero['match_count'].quantile(0.25)
    q2 = non_zero['match_count'].quantile(0.5)
    q3 = non_zero['match_count'].quantile(0.75)
    q0 = non_zero['match_count'].quantile(0.02)
    q4 = non_zero['match_count'].quantile(0.98)
    min_val = non_zero['match_count'].min()
    non_zero_count = len(non_zero)
    percentage_non_zero = non_zero_count / len(df) * 100
    
    return best_idx, best_result, er, q0, q1, q2, q3, q4, min_val, non_zero_count, percentage_non_zero

def main():
    # Configuration
    PROBABILITIES = range(1, 101)  # 1, 4, 7, ..., 28
    for BENCHMARK in ["c880"]:
        ERROR_BOUND = 0.05
        BASE_DIR = f"results/complete_probability_results_{BENCHMARK}_custom3"

        # Create results directory
        os.makedirs(BASE_DIR, exist_ok=True)
        
        # Create output CSV file
        results_csv = os.path.join(BASE_DIR, "probability_analysis.csv")
        with open(results_csv, 'w', newline='') as f:
            writer = csv.writer(f)
            writer.writerow(['timestamp', 'percentage', 'best_thread_id', 
                            'best_result', 'percentage_best', 
                            'q0', 'q1', 'q2', 'q3','q4','min', 
                            'non_zero_count', 'percentage_non_zero'])
        
        # Run for each probability
        for prob in PROBABILITIES:
            print(f"\nRunning {BENCHMARK} with probability {prob}%")
            
            
            
            # Run the CUDA program
            cmd = [
                "python3", 
                "src/flexible-verilog-runner.py",
                "-v", f"misc/data/Benchmarks/ISCAS85/{BENCHMARK}/{BENCHMARK}.v",  # Update with your Verilog file
                "-t", f"{BENCHMARK}",  # Update with your top module name
                "--cuda",
                "--method", "pruned",
                "--name", f"prob_{prob}",
                "--probability", str(prob),
                "--num-runs", "2",
                "--output", BASE_DIR,
                "--lut-size", "4",
                "--error-function", "misc/error_functions/c880_custon.txt",
            ]
            
            try:
                subprocess.run(cmd, check=True)
                
                # Analyze results
                results_path = os.path.join(BASE_DIR, f"prob_{prob}/cuda/results.csv")
                stats = analyze_results(results_path)
                
                if stats:
                    best_idx, best_result, er, q0, q1, q2, q3, q4, min, non_zero_count, percentage_non_zero = stats

                    # 2025-04-09 11:16:39: Set error bound
                    if er > ERROR_BOUND:
                        print(f"Warning: Best result {best_result} is below the error bound.")
                        exit(1)
                    
                    # Save to CSV
                    with open(results_csv, 'a', newline='') as f:
                        writer = csv.writer(f)
                        writer.writerow([
                            datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
                            prob,
                            best_idx,
                            best_result,
                            er,
                            q0,
                            q1,
                            q2,
                            q3,
                            q4,
                            min,
                            non_zero_count,
                            percentage_non_zero
                        ])
                
                print(f"Completed probability {prob}%")
                
            except subprocess.CalledProcessError as e:
                print(f"Error running CUDA program for probability {prob}%: {e}")
                continue
            
            # Small delay between runs to ensure file system operations complete
            time.sleep(1)
        
        print("\nAll runs completed. Results saved in", results_csv)

if __name__ == "__main__":
    main()