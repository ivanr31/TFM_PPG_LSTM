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


% Índices de los ceros y unos en la última fila
indices_ceros = find(Y(:,1) == 0);
indices_unos = find(Y(:,:) == 1);

% Si hay más unos que ceros, seleccionamos aleatoriamente la misma cantidad de ceros
if numel(indices_unos) >= numel(indices_ceros)
    indices_unos = indices_unos(randperm(numel(indices_unos), numel(indices_ceros)));
% Si hay más ceros que unos, seleccionamos aleatoriamente la misma cantidad de unos
else
    indices_ceros = indices_ceros(randperm(numel(indices_ceros), numel(indices_unos)));
end

% Filtramos la matriz de datos manteniendo solo los registros seleccionados
matriz_completa_filtrada = matriz_completa([indices_ceros, indices_unos],:);
matriz_completa_filtrada_1 = matriz_completa_1([indices_ceros, indices_unos],:);
matriz_completa_filtrada_3 = matriz_completa_3([indices_ceros, indices_unos],:);




% Se separan de nuevo en X e Y:
X=matriz_completa_filtrada(:,1:2100);
Y=matriz_completa_filtrada(:,2101);

X_1=matriz_completa_filtrada_1(:,1:2100);
Y_1=matriz_completa_filtrada_1(:,2101);

X_3=matriz_completa_filtrada_3(:,1:2100);
Y_3=matriz_completa_filtrada_3(:,2101);

% Prueba de normalizacion de datos:
X_total=[X;X_1;X_3];
muX = mean(X_total);
sigmaX = std(X_total,0);



porcentaje_entrenamiento = 0.8;
indices_entrenamiento = randperm(size(X,1), floor(porcentaje_entrenamiento*size(X,1)));
indices_validacion = setdiff(1:size(X,1), indices_entrenamiento);

X_entrenamiento_pre = [X(indices_entrenamiento,:);X_1(indices_entrenamiento,:);X_3(indices_entrenamiento,:)];
Y_entrenamiento_pre = [Y(indices_entrenamiento,:);Y_1(indices_entrenamiento,:);Y_3(indices_entrenamiento,:)];

X_validacion_pre = [X(indices_validacion,:);X_1(indices_validacion,:);X_3(indices_validacion,:)];
Y_validacion_pre = [Y(indices_validacion,:);Y_1(indices_validacion,:);Y_3(indices_validacion,:)];


% Obtener el número de filas en la matriz
num_filas = size(X_entrenamiento_pre, 1);
% Generar un índice aleatorio de las filas
indice_aleatorio = randperm(num_filas);
% Reorganizar la matriz de acuerdo con el índice aleatorio
X_entrenamiento = num2cell(X_entrenamiento_pre(indice_aleatorio, :),2);

Y_entrenamiento = categorical(Y_entrenamiento_pre(indice_aleatorio,:));


% Obtener el número de filas en la matriz
num_filas = size(X_validacion_pre, 1);
% Generar un índice aleatorio de las filas
indice_aleatorio = randperm(num_filas);
% Reorganizar la matriz de acuerdo con el índice aleatorio
X_validacion = num2cell(X_validacion_pre(indice_aleatorio, :),2);

Y_validacion = Y_validacion_pre(indice_aleatorio,:);


for n = 1:numel(X_entrenamiento)
    X_entrenamiento{n} = (X_entrenamiento{n} - muX) ./ sigmaX;
end

for n = 1:numel(X_validacion)
    X_validacion{n} = (X_validacion{n} - muX) ./ sigmaX;
end

% Definir parámetros
num_nuevas_series = 1000; % Número de nuevas series temporales a generar
amplitud_perturbacion = 0.1; % Amplitud de la perturbación aleatoria

% Inicializar cell para almacenar nuevas series temporales
nuevas_series_cell = cell(num_nuevas_series, 1);
nueva_serie_test = categorical(zeros(num_nuevas_series, size(Y_entrenamiento, 2))); % Inicializar matriz para almacenar nueva_serie_test


% Generar nuevas series temporales perturbando las existentes
for i = 1:num_nuevas_series
    % Seleccionar una serie temporal aleatoria de las existentes
    serie_original_idx = randi(size(X_entrenamiento, 1));
    serie_original = X_entrenamiento{serie_original_idx};
    
    % Generar perturbación aleatoria
    perturbacion = amplitud_perturbacion * randn(size(serie_original));
    
    % Aplicar perturbación a la serie original para generar una nueva serie
    nueva_serie = serie_original + perturbacion;
    
    % Almacenar la nueva serie en la cell de nuevas series
    nuevas_series_cell{i} = nueva_serie;

    nueva_serie_test(i) = Y_entrenamiento(serie_original_idx);

end


X_entrenamiento=[X_entrenamiento;nuevas_series_cell];
Y_entrenamiento=[Y_entrenamiento;nueva_serie_test];

% Parámetros
num_features = 1 % Número de características en tus datos de entrada
num_hidden_units = 4; % Número de unidades ocultas en la capa LSTM
num_classes = 2; % Para clasificación binaria (cero o uno)


layers = [
    sequenceInputLayer(num_features)
    lstmLayer(num_hidden_units, 'OutputMode', 'last')
    fullyConnectedLayer(num_classes)
    softmaxLayer
    classificationLayer('Name', 'clase')
];

options = trainingOptions("adam", ...
    ExecutionEnvironment="auto", ...
    MaxEpochs=1000, ...
    MiniBatchSize=75, ...
    ValidationFrequency=30, ...
    LearnRateDropFactor=0.2, ...
    LearnRateDropPeriod=15, ...
    GradientThreshold=1, ...
    Shuffle="never", ...
    Plots="training-progress", ...
    Verbose=false);


% Crear y compilar el modelo
lstmModel = trainNetwork(X_entrenamiento, Y_entrenamiento, layers, options);

% Evaluar el modelo en datos de prueba (puedes dividir tus datos en entrenamiento y prueba)
% Por ejemplo, si tienes X_test y y_test:
y_pred = classify(lstmModel, X_validacion);
accuracy = sum(y_pred == categorical(Y_validacion)) / numel(Y_validacion);

disp(['Precisión del modelo en datos de prueba: ', num2str(accuracy)]);

[m,order]=confusionmat(categorical(Y_validacion),y_pred);

m
