function [spectrum, frequency_bins] = FFT(signal, sampling_rate)
    N = length(signal);
    spectrum = fft(signal) / N;
    spectrum = spectrum(1:floor(N/2)+1);
    spectrum(2:end-1) = 2 * spectrum(2:end-1);
    frequency_bins = sampling_rate * (0:(N/2)) / N;

end