% Datos de volumen y pH
volumen = [0, 0.1120, 0.1720, 0.2280, 0.2720, 0.3200, 0.3840, 0.4360, 0.5020, 0.5780, ...
           0.6680, 0.7640, 0.8760, 0.9240, 0.9620, 1.0140, 1.1260, 1.2340, 1.3280, 1.4200, ...
           1.5820, 1.6380, 1.7100, 1.7700, 1.8040, 1.8380, 1.8600, 1.8940, 1.9220, ...
           1.9500, 2.0160, 2.0460, 2.0700, 2.1060, 2.1420, 2.2160, 2.2520, 2.2880, 2.3260, ...
           2.3580, 2.4260, 2.4660, 2.4920, 2.6020, 2.7300, 2.8500, 2.9840, 3.1220, 3.2440, ...
           3.3820, 3.5180, 3.6580, 3.7780, 3.9940, 4.2240, 4.4620, 4.6740, 5.1480, 5.5740, ...
           6.0560, 6.5540, 7.0780, 7.8460, 9.1100, 10.4240, 11.8020, 13.2260, 14.6600, 15.9920, ...
           17.1900, 18.4240, 20.0000];

ph = [1.51, 1.55, 1.62, 1.67, 1.75, 1.82, 1.90, 1.96, 2.03, 2.13, ...
      2.20, 2.29, 2.36, 2.50, 2.55, 2.60, 2.65, 2.74, 2.82, 2.92, ...
      4.06, 5.38, 6.22, 6.67, 6.80, 6.73, 6.91, 7.00, 7.03, ...
      7.08, 7.10, 7.26, 7.21, 7.37, 7.43, 7.84, 8.05, 8.24, 8.35, ...
      8.37, 8.61, 8.67, 8.68, 8.84, 8.93, 9.03, 9.14, 9.21, 9.27, ...
      9.32, 9.38, 9.42, 9.45, 9.51, 9.57, 9.62, 9.66, 9.75, 9.82, ...
      9.88, 9.94, 10.00, 10.06, 10.16, 10.24, 10.32, 10.39, 10.44, 10.52, ...
      10.56, 10.61, 10.68];

% Interpolación cúbica (spline) para suavizar la curva
vol_interp = linspace(min(volumen), max(volumen), 200); % Volumen interpolado
ph_interp = interp1(volumen, ph, vol_interp, 'spline'); % pH interpolado

% Calcular la primera derivada (dpH/dV) de la curva interpolada
dpH_dV = gradient(ph_interp, vol_interp);

% Calcular la segunda derivada (d²pH/dV²) de la curva interpolada
d2pH_dV2 = gradient(dpH_dV, vol_interp);

% Identificar los puntos de inflexión (donde la segunda derivada cruza por cero)
cruce_cero_idx = find(diff(sign(d2pH_dV2)) ~= 0); % Índices donde cruza por cero
cruce_cero_vol = vol_interp(cruce_cero_idx); % Volumen en los puntos de inflexión
cruce_cero_ph = ph_interp(cruce_cero_idx); % pH en los puntos de inflexión

% Seleccionar los dos puntos máximos en la primera derivada
[~, idx_max1] = max(dpH_dV); % Primer punto máximo
dpH_dV_temp = dpH_dV;
dpH_dV_temp(idx_max1) = -Inf; % Excluir el primer máximo para encontrar el segundo
[~, idx_max2] = max(dpH_dV_temp); % Segundo punto máximo

% Asegurarse de que el segundo punto máximo esté alrededor de 2.2 mL
% Buscar el máximo en la región cercana a 2.2 mL
region_2_2 = (vol_interp >= 2.0) & (vol_interp <= 2.4); % Región alrededor de 2.2 mL
[~, idx_max2] = max(dpH_dV(region_2_2)); % Segundo punto máximo en la región
idx_max2 = find(region_2_2, 1) + idx_max2 - 1; % Ajustar el índice

% Puntos máximos en la primera derivada
puntos_maximos_vol = [vol_interp(idx_max1), vol_interp(idx_max2)];
puntos_maximos_ph = [ph_interp(idx_max1), ph_interp(idx_max2)];

% Graficar la curva de pH vs volumen
figure;
plot(vol_interp, ph_interp, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Curva de pH vs Volumen');
hold on;

% Resaltar los puntos de inflexión en la curva de pH vs volumen
plot(puntos_maximos_vol, puntos_maximos_ph, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'DisplayName', 'Puntos de Inflexión');

% Personalización de la gráfica
xlabel('Volumen (mL)');
ylabel('pH');
title('Curva de pH vs Volumen con Puntos de Inflexión');
legend;
grid on;
hold off;

% Mostrar los puntos de inflexión en la consola
disp('Los puntos de inflexión son:');
disp(table(puntos_maximos_vol', puntos_maximos_ph', 'VariableNames', {'Volumen', 'pH'}));
