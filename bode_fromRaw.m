function bode_fromRaw(f, H)
    % Calculate the magnitude and phase
    magnitude = abs(H);
    phase = unwrap(angle(H));
    
    % Convert the phase to degrees
    phase = phase * (180/pi);
    
    % Create a new figure
    figure;
    
    % Plot the magnitude
    subplot(2, 1, 1);  % Divide the window into 2 rows, 1 column, and select the first section
    semilogx(f, 20*log10(magnitude));
    title('Bode Diagram');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    xlim([min(f), max(f)]);
    ylim([min(20*log10(magnitude)), max(20*log10(magnitude))]);
    grid on;
    
    % Plot the phase
    subplot(2, 1, 2);  % Divide the window into 2 rows, 1 column, and select the second section
    semilogx(f, phase);
    xlabel('Frequency (Hz)');
    ylabel('Phase (degrees)');
    grid on;
    xlim([min(f), max(f)]);
    ylim([min(phase), max(phase)]);
    hold off;
end