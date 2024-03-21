function plotNoise(f, H)
    % Calculate the magnitude and phase
    magnitude = abs(H);
        
    % Create a new figure
    figure;
    
    % Plot the magnitude
    loglog(f, magnitude);
    title('Noise');
    xlabel('Frequency (Hz)');
    ylabel('NSD (V/√Hz)');
    xlim([min(f), max(f)]);
    grid on;
    
end