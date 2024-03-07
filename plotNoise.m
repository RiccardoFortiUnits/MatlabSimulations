function plotNoise(f, H)
    % Calculate the magnitude and phase
    magnitude = abs(H);
        
    % Create a new figure
    figure;
    
    % Plot the magnitude
    semilogx(f, magnitude);
    title('Noise');
    xlabel('Frequency (Hz)');
    ylabel('NSD (V/√Hz)');
    xlim([min(f), max(f)]);
    ylim([min(H), max(H)]);
    grid on;
    
end