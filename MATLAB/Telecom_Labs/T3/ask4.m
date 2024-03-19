function []=ask4(bit_pattern,n)

Cf = 1.2E6; % Carrier frequency 1.2 MHz;
            % We will represent the signal using samples taken at intervals of le−8 S
            % i.e., a sampling frequency of 100 MHz
            % and a bit rate of 400 kbps i.e. 250 samples per bit

delt = 1E-8;
fs = 1/delt; %#ok<*NASGU>
samples_per_bit=250;
tmax = (samples_per_bit*length(bit_pattern)-1)*delt;
t= 0:delt:tmax; % Time window we are interested in
% Generation of the binary info signal
bits=zeros(1,length(t));
for bit_no=1:1:length(bit_pattern)
    for sample=1:1:samples_per_bit
        bits((bit_no-1)*samples_per_bit+sample)=bit_pattern(bit_no);
    end
end

% See what it looks like
figure;
subplot(2,1,1);plot(t,bits);
ylabel('Amplitude');
title('Info signal');
axis([0 tmax -2 2]);

% ASK modulation
ASK=[];
if n==4
    for bit_no=1:2:length(bit_pattern)
        if bit_pattern(bit_no)==1
            if bit_pattern(bit_no+1)==1
                t_bit = (bit_no-1)*samples_per_bit*delt:delt:((bit_no+1)*samples_per_bit-1)*delt;
                Wc = Cf*2*pi*t_bit;
                mod = (1)*sin(Wc);
            elseif bit_pattern(bit_no+1)==0 
                t_bit = (bit_no-1)*samples_per_bit*delt:delt:((bit_no+1)*samples_per_bit-1)*delt;
                Wc = Cf*2*pi*t_bit;
                mod = (0.67)*sin(Wc);
            end


        elseif bit_pattern(bit_no)==0

            if bit_pattern(bit_no+1)==1
                t_bit = (bit_no-1)*samples_per_bit*delt:delt:((bit_no+1)*samples_per_bit-1)*delt;
                Wc = Cf*2*pi*t_bit;
                mod = (0.33)*sin(Wc);
            elseif bit_pattern(bit_no+1)==0
                t_bit = (bit_no-1)*samples_per_bit*delt:delt:((bit_no+1)*samples_per_bit-1)*delt;
                Wc = Cf*2*pi*t_bit;
                mod = (0)*sin(Wc);
            end
        end
        ASK=[ASK mod];
    end
    subplot(2,1,2); plot(t,ASK);
    ylabel('Amplitude');
    title('ASK Modulated Signal');
    axis([0 tmax -2 2]);
 

end
end
