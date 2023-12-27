function intersection_indices = find_curve_intersections(curve1, curve2)
if isrow(curve1)
    curve1 = curve1';
end

if isrow(curve2)
    curve2 = curve2';
end

f = curve1 - curve2;

% Find indices where the two curves intersect
intersection_indices = find(f == 0 | [f(1:end-1) .* f(2:end) < 0;false]);

% Plot the curves and intersections for visualization
% figure;
% plot(curve1, 'b', 'LineWidth', 2);
% hold on;
% plot(curve2, 'r', 'LineWidth', 2);
% plot(intersection_indices, curve1(intersection_indices), 'go', 'MarkerSize', 10);
% legend('Curve 1', 'Curve 2', 'Intersections');
% xlabel('Index');
% ylabel('Value');
% title('Curve Intersection');
% grid on;
% hold off;
end