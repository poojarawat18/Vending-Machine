`timescale 1ns/1ps

module tb_vending_machine;

   
    logic clk;
    logic reset;
    logic coin100, coin150;
    logic dispense, change;

   
    vending_machine dut (
        .clk(clk),
        .reset(reset),
        .coin100(coin100),
        .coin150(coin150),
        .dispense(dispense),
        .change(change)
    );

  
    initial clk = 0;
    always #5 clk = ~clk;

  
    initial begin
        
        $dumpfile("vending_machine.vcd");
        $dumpvars(0, tb_vending_machine);

       
        reset = 1;
        coin100 = 0;
        coin150 = 0;
        #10;
        reset = 0;

        
        coin100 = 1; #10; coin100 = 0; #10;

      
        coin100 = 1; #10; coin100 = 0; #10;

      
        coin150 = 1; #10; coin150 = 0; #10;

        
        #20;
        $finish;
    end

   
    always @(posedge clk) begin
        $display("Time=%0t | coin100=%b coin150=%b | dispense=%b change=%b | state=%b",
                 $time, coin100, coin150, dispense, change, dut.current_state);
    end
