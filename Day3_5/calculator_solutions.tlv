//Calculator with Combinational Logic

\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset; //defining reset

   $val1[31:0] = $rand1[3:0]; //1st input
   $val2[31:0] = $rand2[3:0]; //2nd input
      
   //defininig mathematical operations   
   $sum[31:0] = $val1 + $val2;
   $diff[31:0] = $val1 - $val2;
   $prod[31:0] = $val1 * $val2;
   $quot[31:0] = $val1 / $val2;
   
   //implementing a 4x1 multiplexer using combinational logic
   $out[31:0] = ($op[1:0] == 2'b00) ? $sum : 
                ($op[1:0] == 2'b01) ? $diff : 
                ($op[1:0] == 2'b10) ? $prod : 
                ($op[1:0] == 2'b11) ? $quot: 32'b0;

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
   
   
//Counter with Sequential Logic

\m4_TLV_version 1d: tl-x.org
\SV
   m4_makerchip_module
\TLV
   $reset = *reset; //defining reset
   
   $cnt[31:0] = $reset ? 0 :   // 0 if reset is enabled
                >>1$cnt + 1;  // else add the previous value with 1
\SV
   endmodule
   
//Calculator with Sequential Logic

\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset; //defining reset

   $val1[31:0] = >>1$out[31:0]; //1st input is one state ahead of output
   $val2[31:0] = $rand2[3:0]; //2nd input
      
   //defininig mathematical operations   
   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1[31:0] - $val2[31:0];
   $prod[31:0] = $val1[31:0] * $val2[31:0];
   $quot[31:0] = $val1[31:0] / $val2[31:0];
   
   //implementing a 4x1 multiplexer using sequential logic
   $out[31:0] = $reset ? 32'b0 :
                ($op[1:0] == 2'b00) ? $sum : 
                ($op[1:0] == 2'b01) ? $diff : 
                ($op[1:0] == 2'b10) ? $prod : 
                ($op[1:0] == 2'b11) ? $quot: 32'b0;

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

//Pipeline error code

\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |comp
      @1
         $err1 = $bad_input || $illegal_op;
         
      @3
         $err2 = $over_flow || $err1;
         
      @6
         $err3 = $div_by_zero || $err2;

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
   
\\ Calculator and Counter in Pipeline

\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc
      @0
         $reset = *reset; //defining reset
         
      @1   
         $val1[31:0] = >>1$out[31:0]; //1st input is one state ahead of output
         $val2[31:0] = $rand2[3:0]; //2nd input
          
         //defininig mathematical operations   
         $sum[31:0] = $val1[31:0] + $val2[31:0];
         $diff[31:0] = $val1[31:0] - $val2[31:0];
         $prod[31:0] = $val1[31:0] * $val2[31:0];
         $quot[31:0] = $val1[31:0] / $val2[31:0];
   
         //implementing a 4x1 multiplexer using sequential logic
         $out[31:0] = $reset ? 32'b0 :
                      ($op[1:0] == 2'b00) ? $sum : 
                      ($op[1:0] == 2'b01) ? $diff : 
                      ($op[1:0] == 2'b10) ? $prod : 
                      ($op[1:0] == 2'b11) ? $quot: 32'b0;
                      
         $cnt[31:0] = $reset ? 0 :   // 0 if reset is enabled
                      >>1$cnt + 1;   // else add the previous value with 1

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
   
\\ 2 Cycle Calculator with pipelines

\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc 
      @1 
         $reset = *reset; //defining reset
         $val1[31:0] = $reset ? 32'b0 : >>2$out[31:0]; //1st input is two states ahead of output
         $val2[31:0] = $rand2[3:0]; //2nd input  
         $sum[31:0] = $val1[31:0] + $val2[31:0];
         $diff[31:0] = $val1[31:0] - $val2[31:0];
         $prod[31:0] = $val1[31:0] * $val2[31:0];
         $quot[31:0] = $val1[31:0] / $val2[31:0];
         $valid[31:0] = $reset ? 0 : (>>1$valid + 1);
         //defininig mathematical operations   
         
      @2
         //implementing a 4x1 multiplexer using sequential logic
         $out[31:0] = $reset1 ? 32'b0 :
                      ($op[1:0] == 2'b00) ? $sum : 
                      ($op[1:0] == 2'b01) ? $diff : 
                      ($op[1:0] == 2'b10) ? $prod : 
                      ($op[1:0] == 2'b11) ? $quot: 32'b0;
         $reset1 = (!$valid) || $reset;

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

\\ 2 Cycle Calculator with pipeline and validation

\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc 
      @0
         $reset = *reset; //defining reset
      
      ?$valid_or_reset
      @1 
         $counter[31:0] = $reset ? 0 : (>>1$counter + 1);
         $valid = !($counter);
         $valid_or_reset = $valid || $reset;
         $val1[31:0] = $reset ? 32'b0 : >>2$out[31:0]; //1st input is two states ahead of output
         $val2[31:0] = $rand2[3:0]; //2nd input  
         $sum[31:0] = $val1[31:0] + $val2[31:0];
         $diff[31:0] = $val1[31:0] - $val2[31:0];
         $prod[31:0] = $val1[31:0] * $val2[31:0];
         $quot[31:0] = $val1[31:0] / $val2[31:0];      
         //defininig mathematical operations   
         
      @2
         //implementing a 4x1 multiplexer using sequential logic
         $mem[31:0] = $reset ? 32'b0 : ($op[2:0] == 3'b101) ? >>2$out : >>2$mem;
         $out[31:0] = $reset ? 32'b0 :
                      ($op[2:0] == 3'b000) ? $sum : 
                      ($op[2:0] == 3'b001) ? $diff : 
                      ($op[2:0] == 3'b010) ? $prod : 
                      ($op[2:0] == 3'b011) ? $quot: 32'b0;

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
