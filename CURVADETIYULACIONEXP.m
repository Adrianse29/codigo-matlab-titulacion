% Datos experimentales
volumen = [0, 0.112, 0.172, 0.228, 0.272, 0.32, 0.384, 0.436, 0.502, 0.578, 0.668, 0.764, 0.876, 0.924, 0.962, 1.014, 1.126, 1.234, 1.328, 1.42, 1.946, 1.582, 1.638, 1.682, 1.71, 1.77, 1.804, 1.838, 1.86, 1.894, 1.922, 1.95, 2.016, 2.046, 2.07, 2.106, 2.142, 2.216, 2.252, 2.288, 2.326, 2.358, 2.426, 2.466, 2.492, 2.602, 2.73, 2.85, 2.984, 3.122, 3.244, 3.382, 3.518, 3.658, 3.778, 3.994, 4.224, 4.462, 4.674, 5.148, 5.574, 6.056, 6.554, 7.078, 7.846, 9.11, 10.424, 11.802, 13.226, 14.66, 15.992, 17.19, 18.424, 20];
pH = [1.51, 1.55, 1.62, 1.67, 1.75, 1.82, 1.9, 1.96, 2.03, 2.13, 2.2, 2.29, 2.36, 2.5, 2.55, 2.6, 2.65, 2.74, 2.82, 2.92, 3.08, 4.06, 5.38, 6.28, 6.22, 6.67, 6.8, 6.73, 6.91, 7, 6.93, 7.08, 7.1, 7.26, 7.21, 7.47, 7.63, 7.84, 8.05, 8.24, 8.35, 8.37, 8.61, 8.67, 8.68, 8.84, 8.93, 9.03, 9.14, 9.21, 9.27, 9.32, 9.38, 9.42, 9.45, 9.51, 9.57, 9.62, 9.66, 9.75, 9.82, 9.88, 9.94, 10, 10.06, 10.16, 10.24, 10.32, 10.39, 10.44, 10.52, 10.56, 10.61, 10.68];

% Suavizar los datos de pH usando un filtro de media móvil
window_size = 5; % Tamaño de la ventana para el filtro de media móvil
pH_suavizado = movmean(pH, window_size);

% Calcular la derivada numérica (dpH/dV) con los datos suavizados
dpH_dV = diff(pH_suavizado) ./ diff(volumen); % Derivada de pH respecto al volumen
volumen_derivada = volumen(1:end-1) + diff(volumen)/2; % Puntos medios para la derivada

% Graficar la curva de titulación original y suavizada
figure;
subplot(2, 1, 1);
plot(volumen, pH, '-o', 'LineWidth', 1.5, 'DisplayName', 'Datos originales');
hold on;
plot(volumen, pH_suavizado, '-', 'LineWidth', 2, 'DisplayName', 'Datos suavizados');
xlabel('Volumen (mL)');
ylabel('pH');
title('Curva de Titulación');
legend;
grid on;

% Graficar la derivada de los datos suavizados
subplot(2, 1, 2);
plot(volumen_derivada, dpH_dV, '-o', 'LineWidth', 1.5);
xlabel('Volumen (mL)');
ylabel('dpH/dV');
title('Derivada de la Curva de Titulación (Datos Suavizados)');
grid on;

% Encontrar los máximos de la derivada (puntos de equivalencia)
[~, idx1] = max(dpH_dV(1:20)); % Primer punto de equivalencia
[~, idx2] = max(dpH_dV(20:end)); % Segundo punto de equivalencia
idx2 = idx2 + 19; % Ajustar el índice para el segundo punto

% Mostrar los puntos de equivalencia
fprintf('Primer punto de equivalencia:\n');
fprintf('Volumen: %.3f mL, pH: %.2f\n', volumen_derivada(idx1), pH_suavizado(idx1));

fprintf('Segundo punto de equivalencia:\n');
fprintf('Volumen: %.3f mL, pH: %.2f\n', volumen_derivada(idx2), pH_suavizado(idx2));

% Marcar los puntos de equivalencia en la gráfica
subplot(2, 1, 1);
plot(volumen_derivada(idx1), pH_suavizado(idx1), 'ro', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Puntos de equivalencia');
plot(volumen_derivada(idx2), pH_suavizado(idx2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold off;

subplot(2, 1, 2);
hold on;
plot(volumen_derivada(idx1), dpH_dV(idx1), 'ro', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Puntos de equivalencia');
plot(volumen_derivada(idx2), dpH_dV(idx2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold off;