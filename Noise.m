%Function to add noise, used in both simulations, so must run with
%corresponding noise function uncommented

%% BPSK AWGN

function noisy_channel = Noise(channel, snr_dB)
% ADD_AWGN Add Additive White Gaussian Noise (AWGN) to a channel

    bpsk_signal = 2*channel - 1;

%     Convert SNR from dB to linear scale
    snr = 10^(snr_dB/10);

%     Calculate the power of the channel channel
    channel_power = mean(abs(bpsk_signal.^2));

%     Calculate the noise power based on SNR
    noise_power = channel_power / snr;

%     Generate Gaussian noise with zero mean and calculated noise power
    noise = sqrt(noise_power) .* randn(size(channel));

%     Add the generated noise to the channel channel
    noisy_channel = bpsk_signal + noise;
end

 %% Generate complex noise for 8-PSK

% function noisy_channel = Noise(channel, SNR_dB)
% % Signal parameters
% % SNR_dB = 10; % Signal-to-Noise Ratio in dB
% SNR = 10^(SNR_dB/10); % Convert SNR from dB to linear scale
% 
% % Calculate noise variance
% signal_power = mean(abs(channel).^2); % Average power of the channel
% noise_power = signal_power / SNR; % Power of noise to be added
% noise_variance = noise_power / 2; % Since the channel is complex, noise is added to both real and imaginary parts,
%                                   %hence dividing by 2
% 
% % Generate complex Gaussian noise
% % samples of complex Gaussian noise with specified variance
% noise = sqrt(noise_variance) * (randn(length(channel), 1) + 1i * randn(length(channel), 1));
% 
% % Add noise to channel
% noisy_channel = channel + noise; % Add noise to the original channel
% 
% end
