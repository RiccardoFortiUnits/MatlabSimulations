
function [R_closer] = closestResistorValue_0603(R)
    resistorTable = [1.1, 1.2, 1.3, 1.5, 1.6, 1.8, 2, 2.2, 2.4, 2.7, 3, 3.3, 3.6, 3.9, 4.3, 4.7, 5.1, 5.6, 6.2, 6.8, 7.5, 8.2, 9.1];
    R = reshape(R,1,length(R));
    scaledValues = resistorTable' * (10 .^(floor(log10(R))));
    [~, idx] = min(abs(R - scaledValues));
    scaledValues = scaledValues';
    R_closer = scaledValues(sub2ind(size(scaledValues), 1:length(idx), idx));
end