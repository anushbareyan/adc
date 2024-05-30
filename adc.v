`timescale 1ps/1ps
module prior_encoder8x3 (in, out);
    input [7:0] in;
    output reg [2:0] out;
    integer i;
    integer count = 0;

    always @(in) begin
        count = 0;
        for (i = 7; i >= 0; i = i - 1) begin
            if (in[i] == 1) begin
                out = i;
                count = count + 1;
                i = -1;
            end
        end
        if (count == 0) begin
            out = count;
        end
    end
endmodule

module comparator (in1, in2, out);
    input real in1;
    input real in2;
    output reg out;

    always @(*) begin
        if (in1 < in2) begin
            out = 1'b1;
        end else begin
            out = 1'b0;
        end
    end
endmodule

module voltage_divider8 (v_in, v_out);
    input real v_in;
    output real v_out[0:7];
    real R = 1;
    integer N = 8;
    integer i;

    always @(v_in) begin
        for (i = 0; i < N; i = i + 1) begin
            v_out[i] = v_in * i * R / (N * R);
        end
    end
endmodule

module adc1x3 (in, out);
    input real in;
    output [2:0] out;
    real out_vd[0:7];
    real v_in = 1.2;

    voltage_divider8 vd (v_in, out_vd);
    wire [7:0] comp_out;

    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1) begin
            wire out_temp;
            comparator comp (out_vd[i], in, out_temp);
            assign comp_out[i] = out_temp;
        end
    endgenerate

    prior_encoder8x3 enc (comp_out, out);
endmodule

module test;
    real out[0:7];
    real v_in = 1.2;

    voltage_divider8 d(v_in, out);

    initial begin
        integer i;
        #50;
        for (i = 0; i < 8; i = i + 1) begin
            $display("v_out[%0d] = %f", i, out[i]);
        end
    end

    reg [7:0] in_enc = 8'b11000000;
    reg [2:0] out_enc;

    prior_encoder8x3 enc (in_enc, out_enc);

    initial begin
        #50;
        $display("enc_out = %b", out_enc);
    end

    real in_adc;
    wire [2:0] out_adc;

    adc1x3 adc (in_adc, out_adc);

    initial begin
        for (in_adc = 0; in_adc <= 1.2; in_adc = in_adc + 0.001) begin
            #100;
            $display("adc_out = %b when input = %f", out_adc, in_adc);
        end
        $finish;
    end
endmodule
