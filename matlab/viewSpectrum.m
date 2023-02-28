
function [f, c] = viewSpectrum(options)
    arguments
        options.path = './sounds/vowel_i.wav'
    end
    [vowel, sampling_rate] = audioread(options.path);
    
    [spectrum, frequency_bins] = FFT(vowel, sampling_rate);

    [y,x] = findpeaks(abs(spectrum),'Threshold',0.005);

    figure,
    subplot(211);
    semilogy(frequency_bins, abs(spectrum),'k-' , 'LineWidth', 0.5);
    hold on;
    scatter(frequency_bins(x), y, 40, 'ro','filled');
    grid on;
    xlim([0 4000]);
    xlabel('Frequency [Hz]');
    ylabel('Amplitude');


    % get phase with DFT
    phases = 0*x;
    tt = 0:numel(vowel)-1;
    tt = tt/sampling_rate;

    for i = 1:numel(x)
        f = frequency_bins(x(i));
        basis = exp(1j*tt*2*pi*f);
        max_n_of_cycles = floor(numel(tt)/f);
        idx_end = round(max_n_of_cycles*f);
        basis = basis(1:idx_end);
        signal = vowel(1:idx_end);
        phases(i) = angle(mean(basis.*signal'));
    end
    subplot(212);
    scatter(frequency_bins(x), unwrap(phases)/(2*pi),40,'ro','filled');
    hold on;
        scatter(frequency_bins(x), unwrap(angle(spectrum(x)))/(2*pi),40,'bo','filled');

    xlim([0 4000]);
    xlabel('Frequency [Hz]');
    ylabel('Phase (cycles)');    set(gca,'FontSize',12);
    set(gcf,'Color','w');
    grid on;

    f = frequency_bins(x);
    c = spectrum(x);

end