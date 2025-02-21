import unittest
import context
import os
import csv


from src.ultils.runMethods import RunMethods

class TestRunMethods(unittest.TestCase):
    def setUp(self):
        """
        Set up test environment before each test method.
        """
        self.blif_path = "results/blif_generator/somador.blif"
        self.verilog_path = "results/blif_generator/somador.v"
        self.name = "test"
        self.debug = False  # Enable debug for test visibility

        # Ensure test directories exist
        os.makedirs("results/test/cuda", exist_ok=True)
        os.makedirs("results/test/verilog", exist_ok=True)

    def test_initialization(self):
        """
        Test the initialization of RunMethods class
        """
        run_methods = RunMethods(
            name=self.name, 
            verilog_path=self.verilog_path, 
            blif_path=self.blif_path, 
            debug=self.debug
        )

        # Check if folder was created
        self.assertTrue(os.path.exists(f'results/{self.name}'))
        self.assertTrue(os.path.exists(f'results/{self.name}/cuda'))
        self.assertTrue(os.path.exists(f'results/{self.name}/verilog'))

        # Check results file creation
        self.assertTrue(os.path.exists(run_methods.results_file))

    def test_run_cuda(self):
        """
        Test CUDA run method
        """
        run_methods = RunMethods(
            name=self.name, 
            verilog_path=self.verilog_path, 
            blif_path=self.blif_path, 
            debug=self.debug
        )

        cuda_path = f'results/{self.name}/cuda'
        
        # Run CUDA with reduced parameters for testing
        run_methods.run_cuda(
            cuda_path=cuda_path, 
            threads_per_block=32, 
            blocks_per_grid=64, 
            num_runs=3,
            profile=False
        )

        # Verify results file has been updated
        with open(run_methods.results_file, 'r') as f:
            reader = csv.DictReader(f)
            results = list(reader)
        
        cuda_results = [r for r in results if r['implementation'] == 'cuda']
        self.assertEqual(len(cuda_results), 3)  # 3 runs as specified
        
        # Check that all results have valid data
        for result in cuda_results:
            self.assertNotEqual(float(result['execution_time_ms']), 0)
            self.assertNotEqual(float(result['throughput_combinations_per_sec']), 0)

    def test_run_iverilog(self):
        """
        Test Iverilog run method
        """
        run_methods = RunMethods(
            name=self.name, 
            verilog_path=self.verilog_path, 
            blif_path=self.blif_path, 
            debug=self.debug
        )

        verilog_path = f'results/{self.name}/verilog'
        
        # Run Iverilog with reduced runs for testing
        run_methods.run_iverilog(
            verilog_path=verilog_path, 
            exe_name='test_iverilog', 
            num_runs=3
        )

        # Verify results file has been updated
        with open(run_methods.results_file, 'r') as f:
            reader = csv.DictReader(f)
            results = list(reader)
        
        iverilog_results = [r for r in results if r['implementation'] == 'iverilog']
        self.assertEqual(len(iverilog_results), 3)  # 3 runs as specified
        
        # Check that all results have valid data
        for result in iverilog_results:
            self.assertNotEqual(float(result['execution_time_ms']), 0)
            self.assertNotEqual(float(result['throughput_combinations_per_sec']), 0)

    def test_analyze_results(self):
        """
        Test result analysis method
        """
        run_methods = RunMethods(
            name=self.name, 
            verilog_path=self.verilog_path, 
            blif_path=self.blif_path, 
            debug=self.debug
        )

        # Generate some test data
        run_methods.run_cuda(
            cuda_path=f'results/{self.name}/cuda', 
            threads_per_block=32, 
            blocks_per_grid=64, 
            num_runs=3,
            profile=False
        )
        run_methods.run_iverilog(
            verilog_path=f'results/{self.name}/verilog', 
            exe_name='test_iverilog', 
            num_runs=3
        )

        # Attempt to analyze results
        try:
            run_methods.analyze_results()
        except Exception as e:
            self.fail(f"analyze_results() raised {type(e).__name__} unexpectedly!")

    def tearDown(self):
        """
        Clean up test files and directories after each test
        """
        # Optional: Uncomment if you want to remove test directories after tests
        import shutil
        shutil.rmtree(f'results/{self.name}', ignore_errors=True)

if __name__ == '__main__':
    unittest.main()
