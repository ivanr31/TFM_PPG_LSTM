% Especifica la ruta donde se encuentran tus archivos
ruta_ficheros = fullfile(pwd, 'Ficheros/');

% Lista todos los archivos en la ruta especificada
archivos = dir(fullfile(ruta_ficheros, '*_2.*'));
% Extrae los números de los nombres de archivo para ordenar
numeros = cellfun(@(x) str2double(extractBefore(x, strfind(x, '_2'))), {archivos.name});

% Ordena los archivos según los números extraídos
[~, idx] = sort(numeros);
archivos = archivos(idx);
disp(['Número de archivos encontrados: ' num2str(numel(archivos))]);

% Determina el número total de archivos
num_archivos = numel(archivos);

% Inicializa la matriz para almacenar las series temporales
matriz_series_temporales = [];


max_num_columnas = 0;
for i = 1:numel(archivos)
    nombre_archivo = archivos(i).name;
    ruta_archivo = fullfile(ruta_ficheros, nombre_archivo);
    
    % Intenta cargar el archivo
    try
        datos = load(ruta_archivo);
        max_num_columnas = max(max_num_columnas, size(datos, 2));
    catch
        disp(['Error al cargar el archivo: ' nombre_archivo]);
    end
end

% Itera sobre cada archivo seleccionado
for i = 1:num_archivos
    nombre_archivo = archivos(i).name;
    ruta_archivo = fullfile(ruta_ficheros, nombre_archivo);
    
    % Realiza la lectura del archivo (suponiendo que son datos de series temporales)
    datos = load(ruta_archivo); % Suponiendo que los datos son cargados correctamente
    num_columnas = size(datos, 2);
    if i==1
        matriz_series_temporales = [datos(1:2100)];
    else
    % Asegúrate de que los datos tienen exactamente 20 columnas
    % Concatena los datos a la matriz de series temporales
    disp(['Archivo cargado exitosamente: ' nombre_archivo]);
    matriz_series_temporales = [matriz_series_temporales; datos(1:2100)];
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Repito el codigo para leer los ficheros terminados en _1:


% Lista todos los archivos en la ruta especificada
archivos = dir(fullfile(ruta_ficheros, '*_1.*'));
% Extrae los números de los nombres de archivo para ordenar
numeros = cellfun(@(x) str2double(extractBefore(x, strfind(x, '_1'))), {archivos.name});

% Ordena los archivos según los números extraídos
[~, idx] = sort(numeros);
archivos = archivos(idx);
disp(['Número de archivos encontrados: ' num2str(numel(archivos))]);

% Determina el número total de archivos
num_archivos = numel(archivos);

% Inicializa la matriz para almacenar las series temporales
matriz_series_temporales_1 = [];


max_num_columnas = 0;
for i = 1:numel(archivos)
    nombre_archivo = archivos(i).name;
    ruta_archivo = fullfile(ruta_ficheros, nombre_archivo);
    
    % Intenta cargar el archivo
    try
        datos = load(ruta_archivo);
        max_num_columnas = max(max_num_columnas, size(datos, 2));
    catch
        disp(['Error al cargar el archivo: ' nombre_archivo]);
    end
end

% Itera sobre cada archivo seleccionado
for i = 1:num_archivos
    nombre_archivo = archivos(i).name;
    ruta_archivo = fullfile(ruta_ficheros, nombre_archivo);
    
    % Realiza la lectura del archivo (suponiendo que son datos de series temporales)
    datos = load(ruta_archivo); % Suponiendo que los datos son cargados correctamente
    num_columnas = size(datos, 2);
    if i==1
        matriz_series_temporales_1 = [datos(1:2100)];
    else
    % Asegúrate de que los datos tienen exactamente 20 columnas
    % Concatena los datos a la matriz de series temporales
    disp(['Archivo cargado exitosamente: ' nombre_archivo]);
    matriz_series_temporales_1 = [matriz_series_temporales_1; datos(1:2100)];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Repito el codigo para leer los ficheros terminados en _3:


% Lista todos los archivos en la ruta especificada
archivos = dir(fullfile(ruta_ficheros, '*_3.*'));
% Extrae los números de los nombres de archivo para ordenar
numeros = cellfun(@(x) str2double(extractBefore(x, strfind(x, '_3'))), {archivos.name});

% Ordena los archivos según los números extraídos
[~, idx] = sort(numeros);
archivos = archivos(idx);
disp(['Número de archivos encontrados: ' num2str(numel(archivos))]);

% Determina el número total de archivos
num_archivos = numel(archivos);

% Inicializa la matriz para almacenar las series temporales
matriz_series_temporales_3 = [];


max_num_columnas = 0;
for i = 1:numel(archivos)
    nombre_archivo = archivos(i).name;
    ruta_archivo = fullfile(ruta_ficheros, nombre_archivo);
    
    % Intenta cargar el archivo
    try
        datos = load(ruta_archivo);
        max_num_columnas = max(max_num_columnas, size(datos, 2));
    catch
        disp(['Error al cargar el archivo: ' nombre_archivo]);
    end
end

% Itera sobre cada archivo seleccionado
for i = 1:num_archivos
    nombre_archivo = archivos(i).name;
    ruta_archivo = fullfile(ruta_ficheros, nombre_archivo);
    
    % Realiza la lectura del archivo (suponiendo que son datos de series temporales)
    datos = load(ruta_archivo); % Suponiendo que los datos son cargados correctamente
    num_columnas = size(datos, 2);
    if i==1
        matriz_series_temporales_3 = [datos(1:2100)];
    else
    % Asegúrate de que los datos tienen exactamente 20 columnas
    % Concatena los datos a la matriz de series temporales
    disp(['Archivo cargado exitosamente: ' nombre_archivo]);
    matriz_series_temporales_3 = [matriz_series_temporales_3; datos(1:2100)];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



nombre_archivo_bbdd='bbdd_ppg.xlsx';

ruta_archivo_bbdd = fullfile(ruta_ficheros, nombre_archivo_bbdd);

[datos, ~, ~] = xlsread(ruta_archivo_bbdd);

X=matriz_series_temporales(:,1:2100);
Y=datos(:,end);
%matriz_series_temporales = [matriz_series_temporales, datos(:, end)];

X_1=matriz_series_temporales_1(:,1:2100);
Y_1=datos(:,end);

X_3=matriz_series_temporales_3(:,1:2100);
Y_3=datos(:,end);

matriz_completa=[X,Y];
matriz_completa_1=[X_1,Y_1];
matriz_completa_3=[X_3,Y_3];

%Conunto de series temporales:
data=[X;X_1;X_3];

% Se selecciona una serie temporal específica, por ejemplo la 1ª
serie = data(1, :);

% Se representa esa serie temporal
figure;
plot(serie);
title('Serie temporal 1');
xlabel('Tiempo');
ylabel('Valor');

% Se crean los histogramas para las primeras 5 series temporales
figure;
for i = 1:6
    subplot(3, 2, i);
    histogram(data(i, :));
    title(['Histograma de la serie ' num2str(i)]);
    xlabel('Valor');
    ylabel('Frecuencia');
end

% Se calculan las medias y las varianzas
medias = mean(data, 2);
varianzas = var(data, 0, 2);

% Gráfico de la media de cada serie temporal
figure;
subplot(2, 1, 1);
plot(medias);
title('Media de cada serie temporal');
xlabel('Serie temporal');
ylabel('Media');

% Gráfico de la varianza de cada serie temporal
subplot(2, 1, 2);
plot(varianzas);
title('Varianza de cada serie temporal');
xlabel('Serie temporal');
ylabel('Varianza');




