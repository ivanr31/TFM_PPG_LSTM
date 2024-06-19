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

contador=0
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
    contador=contador+1;
end

nombre_archivo_bbdd='bbdd_ppg.xlsx';

ruta_archivo_bbdd = fullfile(ruta_ficheros, nombre_archivo_bbdd);

[datos, ~, ~] = xlsread(ruta_archivo_bbdd);

X=matriz_series_temporales(:,1:2100);
Y=datos(:,end);
%matriz_series_temporales = [matriz_series_temporales, datos(:, end)];


matriz_completa=[X,Y];


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


% Obtener el número de filas en la matriz
num_filas = size(matriz_completa_filtrada, 1);

% Generar un índice aleatorio de las filas
indice_aleatorio = randperm(num_filas);

% Reorganizar la matriz de acuerdo con el índice aleatorio
matriz_completa_mezclada = matriz_completa_filtrada(indice_aleatorio, :);

% Se separan de nuevo en X e Y:
X=matriz_completa_mezclada(:,1:2100);
Y=matriz_completa_mezclada(:,2101);

% Prueba de normalizacion de datos:

muX = mean(X);
sigmaX = std(X,0);



porcentaje_entrenamiento = 0.8;
indices_entrenamiento = randperm(size(X,1), floor(porcentaje_entrenamiento*size(X,1)));
indices_validacion = setdiff(1:size(X,1), indices_entrenamiento);

X_entrenamiento = num2cell(X(indices_entrenamiento,:),2);
Y_entrenamiento = categorical(Y(indices_entrenamiento,:));

X_validacion = num2cell(X(indices_validacion,:),2);
Y_validacion = Y(indices_validacion,:);


for n = 1:numel(X_entrenamiento)
    X_entrenamiento{n} = (X_entrenamiento{n} - muX) ./ sigmaX;
end

for n = 1:numel(X_validacion)
    X_validacion{n} = (X_validacion{n} - muX) ./ sigmaX;
end

% Parámetros
num_features = 1 % Número de características en tus datos de entrada
num_hidden_units = 8; % Número de unidades ocultas en la capa LSTM
num_classes = 2; % Para clasificación binaria (cero o uno)


layers = [
    sequenceInputLayer(num_features)
    lstmLayer(num_hidden_units, 'OutputMode', 'last')
    fullyConnectedLayer(num_classes)
    softmaxLayer
    classificationLayer('Name', 'clase')
];



%'ValidationData', {X, Y}, ...

% opts = trainingOptions('adam', ...
%     'MaxEpochs', 100, ...
%     'MiniBatchSize', 10, ...
%     'SequenceLength', 10, ...
%     'ValidationFrequency', 5, ...
%     'Shuffle', 'every-epoch', ...
%     'Verbose', 1, ...
%     'Plots', 'training-progress');

% options = trainingOptions("adam", ...
%     MaxEpochs=2000, ...
%     SequencePaddingDirection="left", ...
%     Shuffle="every-epoch", ...
%     Plots="training-progress", ...
%     Verbose=false);

options = trainingOptions("adam", ...
    ExecutionEnvironment="auto", ...
    MaxEpochs=700, ...
    MiniBatchSize=20, ...
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
