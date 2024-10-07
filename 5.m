% 16-QAM Simulation with Receiver Impairments
M = 16; N = 1e5; SNRdB = 0:2:20; EbNo = SNRdB - 10*log10(log2(M));
gainImb = 0.1; phaseMis = 0.05; dcI = 0.05; dcQ = 0.05; SER = zeros(size(SNRdB));
for k = 1:length(SNRdB)
    data = randi([0 M-1], N, 1);
    tx = qammod(data, M, 'UnitAveragePower', true);
    % Apply receiver impairments
    rx = ((1 + gainImb) * real(tx) + dcI) + 1i * ((1 - gainImb) * imag(tx) + dcQ);
    rx = rx .* exp(1i * phaseMis);
    rx = awgn(rx, SNRdB(k), 'measured');
    rxData = qamdemod(rx, M, 'UnitAveragePower', true);
    SER(k) = mean(data ~= rxData);
end
% Plot SER vs. E_b/N_0
semilogy(EbNo, SER, 'b-o'); grid on;
xlabel('E_b/N_0 (dB)'); ylabel('Symbol Error Rate (SER)');
title('SER vs E_b/N_0 for 16-QAM with Receiver Impairments');
scatterplot(rx);
title('Received Signal Constellation with Receiver Impairments (SNR = 20 dB)');
grid on; 
