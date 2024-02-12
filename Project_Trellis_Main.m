clc
clear

% To run change Noise and change function call in slider to Decoder not
% Trellis_Decoder

message_length = 10000;
window = 10000;  % split this in half in the slider then output first half

seed = 12345;
rng(seed);

bits = randi([0 1],message_length,1); 
bits(1) = 0;


encoded = Encoder(bits);

SNR = zeros(11); 
biterr = zeros(11);


j = 1;

for i = 0:0.5:10
    
    noisy_signal = Noise(encoded,i); %should be i
    
    %     noisy_signal = Noise(bits,i);
    %     slide = noisy_signal>0; %used in no coding
    
    slide = Slider(noisy_signal, window); %, bits);
    
    % used_bits = bits(1:length(slide));

    

    s = bits==slide; %this is a boolean vector that will be 1 if the entries are the same and 0 if different

    similarity = sum(s)/numel(s);
    BER = 1-similarity;
    biterr(j) = BER;
    SNR(j) = i;
    
    
    j=j+1;
end




semilogy(SNR, biterr, 'linewidth', 2)

hold on


title('BER Vs Eb/No');
 
legend('Convolutional', 'TCM');

axis('tight');
grid on;
xlabel('SNR - Signal to Noise Ratio');
ylabel('BER - Bit Error Rate');

