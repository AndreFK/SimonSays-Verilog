module Simon(
    input clk,
    input rst,
    input gen,
    input in1,
    input in2,
    input in3,
    input in4,
    output reg rgen,
    output reg led1,
    output reg led2,
    output reg led3,
    output reg led4,
    output reg win,
    output reg lose
);

reg [7:0] cs;
reg [7:0] ns;

reg [31:0] counter, counterP, timer, timerP, timerOFF, timerOFFP;
reg [2:0] reg1, reg2, reg3, reg4, leds;

always @ (posedge clk) begin
    if(rst)
        cs <= 4'd0;
    else
	cs <= ns;
end

always @ (*) begin
    case(cs)
        7'd0: ns <= 7'd1;
	7'd1: begin
	    if (counter > 31'd16000)
		ns <= 7'd2;
	    else if(gen && reg1 == 0)
		ns <= 7'd3;
	    else if(gen && reg2 == 0)
		ns <= 7'd4;
	    else if(gen && reg3 == 0)
		ns <= 7'd5;
	    else if(gen && reg4 == 0)
	    	ns <= 7'd6;
	    else 
		ns <= 7'd1;
	end
	7'd2: ns <= 7'd1;
	7'd3: begin 
	    if(timer > 200)
		ns <= 7'd2;
	    else
		ns <= 7'd3;
	end
	7'd4: begin 
	    if(timer > 200)
		ns <= 7'd2;
	    else
		ns <= 7'd4;
	end
	7'd5: begin 
	    if(timer > 200)
		ns <= 7'd2;
	    else
		ns <= 7'd5;
	end
	7'd6: begin
        if(timer > 200)
            ns <= 7'd7;
        else
            ns <= 7'd6;
	end
    7'd7: ns <= 7'd8;
    7'd8: begin
        if(timer > 200)
            ns <= 7'd9;
	else if(in1 == 1 || in2 == 1 || in3 == 1 || in4 == 1)
	   ns <= 8'd14;
    else
           ns <= 7'd8;
    end
    7'd9: begin
        if(timerOFF > 200) begin
            case(leds)
            4'd1: ns <= 7'd10;
            4'd2: ns <= 7'd11;
            4'd3: ns <= 7'd12;
            endcase
        end
        else    
            ns <= 7'd9;
    end
    7'd10: begin
        if(timer > 200)
            ns <= 7'd9;
        else if(in1 == 1 || in2 == 1 || in3 == 1 || in4 == 1)
	        ns <= 8'd14;
        else 
            ns <= 7'd10;
    end
    7'd11: begin
         if(timer > 200)
            ns <= 7'd9;
        else if(in1 == 1 || in2 == 1 || in3 == 1 || in4 == 1)
	        ns <= 8'd14;
        else 
            ns <= 7'd11;
    end
    7'd12: begin
        if(timer > 200)
            ns <= 7'd13;
        else if(in1 == 1 || in2 == 1 || in3 == 1 || in4 == 1)
	        ns <= 8'd14;
        else 
            ns <= 7'd12;
    end
    7'd13: begin
        if(timerOFF > 200)
            ns <= 7'd7;
        else 
            ns <= 7'd13;
    end
    8'd14: begin
        case(reg1)
            3'd1: begin 
                if(in1 == 1)
                    ns <= 8'd15;
                else
                    ns <= 8'd16;
            end
            3'd2: begin 
                if(in2 == 1)
                    ns <= 8'd15;
                else
                    ns <= 8'd16;
            end
            3'd3: begin 
                if(in3 == 1)
                    ns <= 8'd15;
                else
                    ns <= 8'd16;
            end
            3'd4: begin 
                if(in4 == 1)
                    ns <= 8'd15;
                else
                    ns <= 8'd16;
            end
        endcase
    end
    8'd15: begin
        if(in1 == 0 && in2 == 0 && in3 == 0 && in4 == 0)
            ns <= 8'd17;
        else
            ns <= 8'd15;
    end
    8'd16: ns <= 8'd16;
    8'd17: begin
        if(in1 == 0 && in2 == 0 && in3 == 0 && in4 == 0)
            ns <= 8'd17;
        else
            ns <= 8'd18;
    end
    8'd18: ns <= 8'd19;
    8'd19: begin
        case(reg2)
            3'd1: begin 
                if(in1 == 1 && in2 == 0 && in3 == 0 && in4 == 0)
                    ns <= 8'd20;
                else
                    ns <= 8'd16;
            end
            3'd2: begin 
                if(in1 == 0 && in2 == 1 && in3 == 0 && in4 == 0)
                    ns <= 8'd20;
                else
                    ns <= 8'd16;
            end
            3'd3: begin 
                if(in1 == 0 && in2 == 0 && in3 == 1 && in4 == 0)
                    ns <= 8'd20;
                else
                    ns <= 8'd16;
            end
            3'd4: begin 
                if(in1 == 0 && in2 == 0 && in3 == 0 && in4 == 1)
                    ns <= 8'd20;
                else
                    ns <= 8'd16;
            end
            default: ns <= 8'd17;
        endcase
    end 
    8'd20: begin
        if(in1 == 0 && in2 == 0 && in3 == 0 && in4 == 0)
            ns <= 8'd21;
        else
            ns <= 8'd20;
    end
    8'd21:begin
        if(in1 == 0 && in2 == 0 && in3 == 0 && in4 == 0)
            ns <= 8'd21;
        else
            ns <= 8'd22;
    end
    8'd22: ns <= 8'd23;
    8'd23: begin
        case(reg3)
            3'd1: begin 
                if(in1 == 1 && in2 == 0 && in3 == 0 && in4 == 0)
                    ns <= 8'd24;
                else
                    ns <= 8'd16;
            end
            3'd2: begin 
                if(in1 == 0 && in2 == 1 && in3 == 0 && in4 == 0)
                    ns <= 8'd24;
                else
                    ns <= 8'd16;
            end
            3'd3: begin 
                if(in1 == 0 && in2 == 0 && in3 == 1 && in4 == 0)
                    ns <= 8'd24;
                else
                    ns <= 8'd16;
            end
            3'd4: begin 
                if(in1 == 0 && in2 == 0 && in3 == 0 && in4 == 1)
                    ns <= 8'd24;
                else
                    ns <= 8'd16;
            end
            default: ns <= 8'd17;
        endcase
    end 
    8'd24: begin
        if(in1 == 0 && in2 == 0 && in3 == 0 && in4 == 0)
            ns <= 8'd25;
        else
            ns <= 8'd24;
    end
    8'd25:begin
        if(in1 == 0 && in2 == 0 && in3 == 0 && in4 == 0)
            ns <= 8'd25;
        else
            ns <= 8'd26;
    end
    8'd26: ns <= 8'd27;
    8'd27: begin
        case(reg4)
            3'd1: begin 
                if(in1 == 1 && in2 == 0 && in3 == 0 && in4 == 0)
                    ns <= 8'd28;
                else
                    ns <= 8'd16;
            end
            3'd2: begin 
                if(in1 == 0 && in2 == 1 && in3 == 0 && in4 == 0)
                    ns <= 8'd28;
                else
                    ns <= 8'd16;
            end
            3'd3: begin 
                if(in1 == 0 && in2 == 0 && in3 == 1 && in4 == 0)
                    ns <= 8'd28;
                else
                    ns <= 8'd16;
            end
            3'd4: begin 
                if(in1 == 0 && in2 == 0 && in3 == 0 && in4 == 1)
                    ns <= 8'd28;
                else
                    ns <= 8'd16;
            end
            default: ns <= 8'd17;
        endcase
    end 
    8'd28: ns <= 8'd29;
    8'd29: ns <= 8'd29;
	default:
	    ns <= 7'dx;
    endcase
end

always @ (*) begin
    case(cs)
	7'd0: begin
	    counterP = 4'd0;
	    timerP = 0;
	    reg1 = 0;
	    reg2 = 0;
        reg3 = 0;
	    reg4 = 0;
	    led1 = 0;
	    led2 = 0;
        led3 = 0;
        led4 = 0;
        rgen = 0;
	win = 0;
	lose = 0;
	end
	7'd1: counterP = counter + 1;
	7'd2: begin
	    timerP = 4'd0;
	    counterP = 4'd0;
        rgen = 0;
	end
	7'd3: begin 
        timerP = timer + 1;
        reg1 = (counter%4)+1;
        rgen = 1;
	end
    7'd4: begin 
        timerP = timer + 1;
        reg2 = (counter%4)+1;
        rgen = 1;
	end
    7'd5: begin 
        timerP = timer + 1;
        reg3 = (counter%4)+1;
        rgen = 1;
	end
    7'd6:begin 
        timerP = timer + 1;
        reg4 = (counter%4)+1;
        rgen = 1;
    end
    7'd7: begin
        rgen = 0;
        timerP = 0;
        leds = 3'd0;
	end
    7'd8: begin
        timerP = timer + 1;
        timerOFFP = 0;
        leds = 3'd1;
        case(reg1)
        4'd1: led1 = 1;
        4'd2: led2 = 1;
        4'd3: led3 = 1;
        4'd4: led4 = 1;
        default: rgen = 1;
        endcase
    end
    7'd9: begin
        timerP = 0;
        timerOFFP = timerOFF + 1;
        led1 = 0;
        led2 = 0;
        led3 = 0;
        led4 = 0;
    end
    7'd10: begin
        timerP = timer + 1;
        timerOFFP = 0;
        leds = 3'd2;
        case(reg2)
        4'd1: led1 = 1;
        4'd2: led2 = 1;
        4'd3: led3 = 1;
        4'd4: led4 = 1;
        default: rgen = 1;
        endcase
    end
    7'd11: begin
        timerP = timer + 1;
        timerOFFP = 0;
        leds = 3'd3;
        case(reg3)
        4'd1: led1 = 1;
        4'd2: led2 = 1;
        4'd3: led3 = 1;
        4'd4: led4 = 1;
        default: rgen = 1;
        endcase
    end
    7'd12: begin
        timerP = timer + 1;
        timerOFFP = 0;
        case(reg4)
        4'd1: led1 = 1;
        4'd2: led2 = 1;
        4'd3: led3 = 1;
        4'd4: led4 = 1;
        default: rgen = 1;
        endcase
    end
    7'd13: begin
        timerOFFP = timerOFF + 1;
	    rgen = 1;
        led1 = 0;
        led2 = 0;
        led3 = 0;
        led4 = 0;
    end
    8'd14: begin
    rgen = 0;
    timerP = 0;
    end
    8'd15: begin
        case(reg1)
            4'd1: led1 = 1;
            4'd2: led2 = 1;
            4'd3: led3 = 1;
            4'd4: led4 = 1;
	endcase
    end
    8'd16: lose = 1;
    8'd18: begin
        led1 = 0;
        led2 = 0;
        led3 = 0;
        led4 = 0;
    end
    8'd20:begin
        case(reg2)
            4'd1: led1 = 1;
            4'd2: led2 = 1;
            4'd3: led3 = 1;
            4'd4: led4 = 1;
	    endcase
    end
    8'd23:begin
        led1 = 0;
        led2 = 0;
        led3 = 0;
        led4 = 0;
    end
    8'd24:begin
        case(reg3)
            4'd1: led1 = 1;
            4'd2: led2 = 1;
            4'd3: led3 = 1;
            4'd4: led4 = 1;
	    endcase
    end
    8'd27:begin
        case(reg4)
            4'd1: led1 = 1;
            4'd2: led2 = 1;
            4'd3: led3 = 1;
            4'd4: led4 = 1;
	    endcase
    end
    8'd29: begin 
	win = 1;
        led1 = 1;
	led2 = 1;
	led3 = 1;
	led4 = 1;
    end
   endcase
end

always @ (posedge clk) begin
    counter = counterP;
    timer = timerP;
    timerOFF = timerOFFP;
end

endmodule