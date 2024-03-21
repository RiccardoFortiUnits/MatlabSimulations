function [amplitude_dB, angle_deg] =  bode_fromRaw(f, H)
    % Calculate the magnitude and phase
    magnitude = abs(H);
    phase = angle(H);
    
    % Convert the phase to degrees
    angle_deg = phase * (180/pi);


    amplitude_dB = 20*log10(magnitude);
    
    % Create a new figure
    figure;
    
    % Plot the magnitude
    subplot(2, 1, 1);  % Divide the window into 2 rows, 1 column, and select the first section
    semilogx(f, 20*log10(magnitude));
    title('Bode Diagram');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    xlim([min(f), max(f)]);
    grid on;
    
    % Plot the phase
    subplot(2, 1, 2);  % Divide the window into 2 rows, 1 column, and select the second section
    semilogx(f, angle_deg);
    xlabel('Frequency (Hz)');
    ylabel('Phase (degrees)');
    grid on;
    xlim([min(f), max(f)]);
    hold off;

    
end