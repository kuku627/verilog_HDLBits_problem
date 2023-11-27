`timescale 1ns / 1ps

module tb_one_sec_gen;

    reg clk;
    reg reset;
    reg i_run_en;
    reg [29:0] i_freq;// 이거 왜 30비트로?
    wire o_one_sec_tick;
    reg [5:0] r_sec; 
    
    one_sec_gen DUT(
        .clk(clk),
        .reset(reset),
        .i_run_en(i_run_en),
        .i_freq(i_freq),
        .o_one_sec_tick(o_one_sec_tick)// 이거 왜 30비트로?
    );



    always 
        #5 clk= ~clk;


  


    always @(posedge clk) begin
        if(reset) begin
            r_sec <= 6'b0;
        end else if (o_one_sec_tick) begin
            if(r_sec == 6'd59) begin
                r_sec <= 0;
            end else begin
                r_sec <= r_sec + 1'b1;
            end
        end
    end



    initial begin

    // $display("initialize value [%d]",$time);
        reset 		<= 0;
        clk     	<= 0;
        i_run_en 	<= 0;
    // $display("Reset! [%d]", $time);
    # 100
        reset 		<= 1;

    # 10
        reset 		<= 0;
        i_run_en 	<= 1;

        
        i_freq		<= 100; // 100Hz
        // assert(i_freq <= 1000*1000*1000); // 10비트씩 3개
    # 10
    // @(posege clk)

    #100000 =//10의 5승 100

        i_run_en    <= 0;
    $finish;
    end




    initial begin
        $dumpfile("one_sec_gen.vcd");
        $dumpvars(0,tb_one_sec_gen);

    end

endmodule

