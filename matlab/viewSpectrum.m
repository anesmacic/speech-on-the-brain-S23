
function viewSpectrum(options)
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

    subplot(212);
    scatter(frequency_bins(x), unwrap(angle(spectrum(x)))/(2*pi),40,'ro','filled');
    xlim([0 4000]);
    xlabel('Frequency [Hz]');
    ylabel('Phase (cycles)');    set(gca,'FontSize',12);
    set(gcf,'Color','w');
    grid on;


end