module vending_machine(
  input logic clk,reset,
  input logic coin100,coin150,
  output logic dispense,
  output logic change
);
     // State Encoding
    typedef enum logic [2:0] {
        IDLE  = 3'b000,
        S100  = 3'b001,
        S150  = 3'b010,
        S200  = 3'b011,
        S250  = 3'b100
    } state_t;
  state_t current_state,next_state;
  
  //sequential block
  always_ff@(posedge clk or posedge reset)begin
    if (reset)
      current_state<=IDLE;
    else
      current_state<=next_state;
  end
  
  //combinational block
  always_comb begin
    //default ouputs
    dispense=0;
    change=0;
    next_state=current_state;
   
    case(current_state)
      IDLE:begin 
        if (coin100) next_state=S100;
        else if (coin150) next_state=S150;
            end
            
      S100:begin
              if (coin100) next_state=S200;
              else if (coin150) next_state=S250;
            end
      
      S150:begin
        dispense=1;
        next_state=IDLE;
      end
      
      S200:begin
        dispense=1;
        change=1;
        next_state=IDLE;
      end
        
      S250:begin
          dispense=1;
          change=1;
          next_state=IDLE;
      end
    endcase
  end
endmodule
          
