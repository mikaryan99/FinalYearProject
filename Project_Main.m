%% Main
clc
clear


message_length = 20000;
window = 20000 ;
% split this in half in the slider then output first half

seed = 12345;
rng(seed);

bits = randi([0 1],message_length,2); 

% data = randi([0 8-1],message_length,1);

[PSKsymbols, labels] = Trellis_Encoder(bits);

% PSKsymbols = pskmod(data,8);

SNR = zeros(11);
biterr = zeros(11);
EbN0 = zeros(11);

j = 1;

for i = 0:1:10
    noisy_signal = Noise(PSKsymbols,i);
    
    slide = Slider(noisy_signal, window);
    
    % slide = pskdemod(noisy_signal,8)
    % s = data==slide
    % similarity = sum(s)/numel(s);
    % BER = 1-similarity;
    
    %calculates no. of bit errors and BER
    wrongbits = xor(labels, slide);
    num_errors = sum(wrongbits);
    BER = sum(num_errors)/(length(wrongbits)*3);
    
    biterr(j) = BER;
%     SNR(j) = i;
    
    % Calculate EbN0
    Eb = sum(abs(PSKsymbols).^2)/(length(PSKsymbols).*2); % Energy per bit THIS?
    noise = noisy_signal - PSKsymbols;
    N0 = sum(abs(noise).^2)/length(noise); % Noise power spectral density
    EbN0(j) = Eb/N0; % Eb/N0 ratio
    
%     % Display the results
%     fprintf('Eb/N0 = %.2f dB\n', 10*log10(EbN0));
%     fprintf('Number of bit errors = %d\n', num_errors);

    j=j+1;
end


semilogy(EbN0, biterr, 'linewidth', 2)

hold on

title('BER Vs SNR');

legend('Convolutional','TCM');

axis('tight');
grid on;
xlabel('SNR');
ylabel('BER - Bit Error Rate');

%% EB/N0

% % Generate a random signal
% data = randi([0 1], 1, 1000);
% 
% % Modulate the signal using QPSK
% modulated_signal = qammod(data, 4);
% 
% % Add noise to the signal
% EbNo = 10; % in dB
% noise = sqrt(1/(2*10^(EbNo/10))) * randn(size(modulated_signal)); % Gaussian noise with given Eb/No
% noisy_signal = modulated_signal + noise;
% 
% % Demodulate the signal
% demodulated_signal = qamdemod(noisy_signal, 4);

%% Calculate the number of bit errors
% num_errors = sum(xor(data, demodulated_signal));

% Calculate the Eb/N0 of the signal
% Eb = sum(abs(PSKsymbols).^2)/(length(PSKsymbols).*3); % Energy per bit
% noise = noisy_signal - PSKsymbols;
% N0 = sum(abs(noise).^2)/(length(noise).*3); % Noise power spectral density
% EbN0 = Eb/N0; % Eb/N0 ratio
% 
% % Display the results
% fprintf('Eb/N0 = %.2f dB\n', 10*log10(EbN0));
% fprintf('Number of bit errors = %d\n', num_errors);
