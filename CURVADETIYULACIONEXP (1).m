% Datos de volumen y pH
volumen = [0, 0.1120, 0.1720, 0.2280, 0.2720, 0.3200, 0.3840, 0.4360, 0.5020, 0.5780, ...
           0.6680, 0.7640, 0.8760, 0.9240, 0.9620, 1.0140, 1.1260, 1.2340, 1.3280, 1.4200, ...
           1.5820, 1.6380, 1.6820, 1.7100, 1.7700, 1.8040, 1.8380, 1.8600, 1.8940, 1.9220, ...
           1.9500, 2.0160, 2.0460, 2.0700, 2.1060, 2.1420, 2.2160, 2.2520, 2.2880, 2.3260, ...
           2.3580, 2.4260, 2.4660, 2.4920, 2.6020, 2.7300, 2.8500, 2.9840, 3.1220, 3.2440, ...
           3.3820, 3.5180, 3.6580, 3.7780, 3.9940, 4.2240, 4.4620, 4.6740, 5.1480, 5.5740, ...
           6.0560, 6.5540, 7.0780, 7.8460, 9.1100, 10.4240, 11.8020, 13.2260, 14.6600, 15.9920, ...
           17.1900, 18.4240, 20.0000];

ph = [1.51, 1.55, 1.62, 1.67, 1.75, 1.82, 1.90, 1.96, 2.03, 2.13, ...
      2.20, 2.29, 2.36, 2.50, 2.55, 2.60, 2.65, 2.74, 2.82, 2.92, ...
      4.06, 5.38, 6.28, 6.22, 6.67, 6.80, 6.73, 6.91, 7.00, 6.93, ...
      7.08, 7.10, 7.26, 7.21, 7.47, 7.63, 7.84, 8.05, 8.24, 8.35, ...
      8.37, 8.61, 8.67, 8.68, 8.84, 8.93, 9.03, 9.14, 9.21, 9.27, ...
      9.32, 9.38, 9.42, 9.45, 9.51, 9.57, 9.62, 9.66, 9.75, 9.82, ...
      9.88, 9.94, 10.00, 10.06, 10.16, 10.24, 10.32, 10.39, 10.44, 10.52, ...
      10.56, 10.61, 10.68];

% Interpolación suave de la curva
vol_interp = linspace(min(volumen), max(volumen), 200);
ph_interp = interp1(volumen, ph, vol_interp, 'spline');

% Cálculo de derivadas
d1 = gradient(ph_interp, vol_interp); % Primera derivada
d2 = gradient(d1, vol_interp);        % Segunda derivada

% Encontrar puntos de inflexión (cuando d2 cambia de signo)
inflexion_idx = find(diff(sign(d2)) ~= 0);
inflexion_vol = vol_interp(inflexion_idx);
inflexion_ph = ph_interp(inflexion_idx);

% Graficar la curva de titulación con los puntos de inflexión
figure;
plot(volumen, ph, 'o', 'MarkerSize', 5, 'DisplayName', 'Datos experimentales'); % Datos originales
hold on;
plot(vol_interp, ph_interp, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Interpolación spline'); % Curva suavizada
plot(inflexion_vol, inflexion_ph, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'DisplayName', 'Puntos de inflexión'); % Puntos de inflexión

% Personalización de la gráfica
xlabel('Volumen (mL)');
ylabel('pH');
title('Curva de titulación y puntos de inflexión');
legend;
grid on;
hold off;

% Mostrar puntos de inflexión en la consola
disp('Puntos de inflexión encontrados:');
disp(table(inflexion_vol', inflexion_ph', 'VariableNames', {'Volumen', 'pH'}));
%%%%%%%%%%

% Interpolación suave de la curva
vol_interp = linspace(min(volumen), max(volumen), 200);
ph_interp = interp1(volumen, ph, vol_interp, 'spline');

% Cálculo de derivadas
d1 = gradient(ph_interp, vol_interp); % Primera derivada
d2 = gradient(d1, vol_interp);        % Segunda derivada

% Encontrar puntos de inflexión (cuando d2 cambia de signo)
inflexion_idx = find(diff(sign(d2)) ~= 0);
inflexion_vol = vol_interp(inflexion_idx);
inflexion_ph = ph_interp(inflexion_idx);
inflexion_d2 = abs(d2(inflexion_idx));  % Magnitud de la segunda derivada

% Ordenar por la magnitud de la segunda derivada (los más pronunciados primero)
[~, sort_idx] = sort(inflexion_d2, 'descend');
top_2_idx = sort_idx(1:2);  % Seleccionamos los dos más pronunciados

% Obtener los dos puntos de inflexión más pronunciados
top_inflexion_vol = inflexion_vol(top_2_idx);
top_inflexion_ph = inflexion_ph(top_2_idx);

% Graficar la curva de titulación con los dos puntos de inflexión más pronunciados
figure;
plot(volumen, ph, 'o', 'MarkerSize', 5, 'DisplayName', 'Datos experimentales'); % Datos originales
hold on;
plot(vol_interp, ph_interp, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Interpolación spline'); % Curva suavizada
plot(top_inflexion_vol, top_inflexion_ph, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'DisplayName', '2 Puntos de inflexión más pronunciados'); % Puntos de inflexión

% Personalización de la gráfica
xlabel('Volumen (mL)');
ylabel('pH');
title('Curva de titulación y 2 puntos de inflexión más pronunciados');
legend;
grid on;
hold off;

% Mostrar los dos puntos de inflexión más pronunciados en la consola
disp('Los dos puntos de inflexión más pronunciados son:');
disp(table(top_inflexion_vol', top_inflexion_ph', 'VariableNames', {'Volumen', 'pH'}));

%%%%%%%%%%%%%

% Interpolación de la curva
vol_interp = linspace(min(volumen), max(volumen), 200);
ph_interp = interp1(volumen, ph, vol_interp, 'spline');

% Cálculo de la primera derivada
d1 = gradient(ph_interp, vol_interp); 

% Encontrar los dos valores máximos de la primera derivada
[~, max_idx] = sort(d1, 'descend'); % Ordenar índices de d1 en orden descendente
top_2_idx = max_idx(1:2); % Seleccionar los dos puntos con mayor pendiente

% Obtener los dos puntos de equivalencia
equiv_vol = vol_interp(top_2_idx);
equiv_ph = ph_interp(top_2_idx);

% Graficar la curva de titulación con los puntos de equivalencia
figure;
plot(volumen, ph, 'o', 'MarkerSize', 5, 'DisplayName', 'Datos experimentales'); % Datos originales
hold on;
plot(vol_interp, ph_interp, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Interpolación spline'); % Curva suavizada
plot(equiv_vol, equiv_ph, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'DisplayName', 'Puntos de equivalencia'); % Puntos de equivalencia

% Personalización de la gráfica
xlabel('Volumen (mL)');
ylabel('pH');
title('Curva de titulación y puntos de equivalencia');
legend;
grid on;
hold off;

% Mostrar los valores de los puntos de equivalencia en la consola
disp('Los dos puntos de equivalencia son:');
disp(table(equiv_vol', equiv_ph', 'VariableNames', {'Volumen', 'pH'}));
