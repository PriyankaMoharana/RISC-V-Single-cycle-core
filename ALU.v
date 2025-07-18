
module ALU(A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);
    //Declaring inputs
    input [31:0]A,B;
    input [2:0]ALUControl;
    //Declaring outputs
    output Carry,OverFlow,Zero,Negative;
    output [31:0]Result;
    //Declaring interim wires
    wire Cout;
    wire [31:0]Sum;
   //Addition Subtraction Operation
    assign {Cout,Sum} = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign Result = (ALUControl == 3'b000) ? Sum :
                    (ALUControl == 3'b001) ? Sum :
                    (ALUControl == 3'b010) ? A & B :
                    (ALUControl == 3'b011) ? A | B :
                    (ALUControl == 3'b101) ? {{31{1'b0}},(Sum[31])} : {32{1'b0}}; //Zero Extension
    //Flags Assignment
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = &(~Result);       //Reduction and to ake the reult Zero
    assign Negative = Result[31];   //if 1 then negative otherwise positive

endmodule
