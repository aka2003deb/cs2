M_values = [2, 4, 8, 16];
M_values_FSK = [2, 4, 8, 16, 32];
EbN0_dB = 0:1:20;
EbN0 = 10.^(EbN0_dB/10);

% Probability of Error for M-PSK
[EbN0_grid, M_grid] = meshgrid(EbN0, M_values);
Pe_PSK = 2 * qfunc(sqrt(2 * EbN0_grid .* log2(M_grid)) .* sin(pi ./ M_grid));

figure;
semilogy(EbN0_dB, Pe_PSK'); grid on;
xlabel('E_b/N_0 (dB)'); ylabel('Probability of Error');
title('Probability of Error for M-PSK');
legend(arrayfun(@(M) sprintf('%d-PSK', M), M_values, 'UniformOutput', false));

% Probability of Error for M-FSK (Coherent and Non-Coherent)
[EbN0_grid_FSK, M_grid_FSK] = meshgrid(EbN0, M_values_FSK);
Pe_coh_FSK = 0.5 * erfc(sqrt(EbN0_grid_FSK .* log2(M_grid_FSK) ./ M_grid_FSK));
Pe_noncoh_FSK = 0.5 * exp(-EbN0_grid_FSK ./ (2 * (M_grid_FSK - 1)));

figure;
semilogy(EbN0_dB, Pe_coh_FSK'); grid on;
xlabel('E_b/N_0 (dB)'); ylabel('Probability of Error');
title('Coherent M-FSK');
legend(arrayfun(@(M) sprintf('M = %d', M), M_values_FSK, 'UniformOutput', false));

figure;
semilogy(EbN0_dB, Pe_noncoh_FSK', '--'); grid on;
xlabel('E_b/N_0 (dB)'); ylabel('Probability of Error');
title('Non-Coherent M-FSK');
legend(arrayfun(@(M) sprintf('M = %d', M), M_values_FSK, 'UniformOutput', false));

% Probability of Error for M-QAM
[EbN0_grid_QAM, M_grid_QAM] = meshgrid(EbN0, M_values);
Pe_QAM = 4 * (1 - 1 ./ sqrt(M_grid_QAM)) .* qfunc(sqrt(3 * EbN0_grid_QAM .* log2(M_grid_QAM) ./ (M_grid_QAM - 1)));
Pe_QAM = Pe_QAM - ( (4 * (1 - 1 ./ sqrt(M_grid_QAM)).^2) .* qfunc(sqrt(3 * EbN0_grid_QAM .* log2(M_grid_QAM) ./ (M_grid_QAM - 1))).^2 );

figure;
semilogy(EbN0_dB, Pe_QAM'); grid on;
xlabel('E_b/N_0 (dB)'); ylabel('Probability of Error');
title('Probability of Error for M-QAM');
legend(arrayfun(@(M) sprintf('%d-QAM', M), M_values, 'UniformOutput', false));

% Probability of Error for M-PAM
[EbN0_grid_PAM, M_grid_PAM] = meshgrid(EbN0, M_values);
Pe_PAM = 2 * (1 - 1 ./ M_grid_PAM) .* qfunc(sqrt(6 * EbN0_grid_PAM .* log2(M_grid_PAM) ./ (M_grid_PAM.^2 - 1)));

figure;
semilogy(EbN0_dB, Pe_PAM'); grid on;
xlabel('E_b/N_0 (dB)'); ylabel('Probability of Error');
title('Probability of Error for M-PAM');
legend(arrayfun(@(M) sprintf('%d-PAM', M), M_values, 'UniformOutput', false));
