// Benchmark "/app/notebooks/results/blif_generator/somador" written by ABC on Fri Jan 24 13:12:46 2025

module \/app/notebooks/results/blif_generator/somador  ( 
    x0, x1, x2, x3,
    z0, z1, z2  );
  input  x0, x1, x2, x3;
  output z0, z1, z2;
  assign z0 = (x0 & (x2 | (x1 & x3))) | (x2 & x1 & x3);
  assign z1 = (x1 & x3 & (~x0 ^ x2)) | ((x0 ^ x2) & (~x1 | ~x3));
  assign z2 = x1 ^ x3;
endmodule


