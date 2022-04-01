%% PARTE 2 - EFECTO RUIDO. RELACIÓN Eb/No

L = 1000;           % Muestras a generar
Nsimbolos = L;      % Símbolos a generar
M = 16;             % Orden de la constelación (16QAM)
m = log2(M);        % Bits por símbolo.
Es = 2*(M - 1 )/3;  % Energia/Símbolo
Eb_16QAM = Es/m;    % Energia/Bit


s = genera_qam(Nsimbolos, M);                 % Función que genera los símbolos de la constelación 16QAM

N0_24dB = Eb_16QAM / (10^(24/10));            % Valores de No para relación de 24 dB
N0_16dB = Eb_16QAM / (10^(16/10));            % Para 16 dB
N0_4dB = Eb_16QAM / (10^(4/10));              % Para 4 dB

ruido_24dB = genera_ruido(L,N0_24dB, 'PB');  % Genera ruido AWGN para relación de 30dB
ruido_16dB = genera_ruido(L,N0_16dB, 'PB');  % Para 15dB
ruido_4dB = genera_ruido(L,N0_4dB, 'PB');    % Para 5dB

% REPRESENTACIÓN

% Representación de la constelación 16QAM en ausencia de ruido
scatterplot(s);                
title('REPRESENTACIÓN DE 16QAM & REJILLA DE DECISIÓN');
xlabel('Fase - Regiones de Decisión');
ylabel('Cuadratura - Regiones de Decisión');
plot_reg(M,'QAM');

% Representación de la constelación 16QAM con ruido de 24dB
scatterplot(s + ruido_24dB);    
title('REPRESENTACIÓN DE 16QAM & REJILLA DE DECISIÓN');
xlabel('Fase - Regiones de Decisión');
ylabel('Cuadratura - Regiones de Decisión');
plot_reg(M,'QAM');

% Representación de la constelación 16QAM con ruido de 16dB
scatterplot(s + ruido_16dB);    
title('REPRESENTACIÓN DE 16QAM & REJILLA DE DECISIÓN');
xlabel('Fase - Regiones de Decisión');
ylabel('Cuadratura - Regiones de Decisión');
plot_reg(M,'QAM');

% Representación de la constelación 16QAM con ruido de 4dB
scatterplot(s + ruido_4dB);     
title('REPRESENTACIÓN DE 16QAM & REJILLA DE DECISIÓN');
xlabel('Fase - Regiones de Decisión');
ylabel('Cuadratura - Regiones de Decisión');
plot_reg(M,'QAM');


%% PARTE 3 - EFECTO DE ISI (INTERFERENCIA INTERSIMBÓLICA)

% PARÁMETROS
L = 50;                              % Número de muestras a generar
Nsimbolos = L;                       % Número de símbolos a generar
M_4QAM = 4;                          % Orden de la constelación 4QAM
M_16QAM = 16;                        % Orden de la constelación 16QAM
m_4QAM = log2(M_4QAM);               % Número de bits por símbolo (4QAM).
m_16QAM = log2(M_16QAM);             % Número de bits por símbolo (16QAM).
Es_4QAM = 2*(M_4QAM - 1 )/3;         % Energia Por Simbolo Constelación 4QAM
Es_16QAM = 2*(M_16QAM - 1)/3;        % Energia Por Simbolo Constelación 16QAM
Eb_4QAM = Es_4QAM/m_4QAM;            % Energia Por Bit Constelación 4QAM
Eb_16QAM = Es_16QAM/m_16QAM;         % Energia Por Bit Constelación 16QAM
a0 = 1/16;                           % Valor de a0
a1 = 1/8;                            % Valor de a1
a2 = 1/4;                            % Valor de a2
Kp_canal1 = 1;                       % Memoria del Sistema
Kp_canal2 = 2;                       % Memoria del Sistema

% FUNCIONES

% Constelaciones
s_4QAM = genera_qam(L, M_4QAM);         % Función que genera los símbolos de la constelación 4QAM
s_16QAM = genera_qam(L, M_16QAM);       % Función que genera los símbolos de la constelación 16QAM

% Valor de No en 4QAM
N0_25dB_4QAM = Eb_16QAM / (10^(30/10));            % Valores de No para relación de 25 dB

% Valor de No en 16QAM
N0_25dB_16QAM = Eb_16QAM / (10^(30/10));            % Valores de No para relación de 25 dB

% Canal 1 (p[n] = &[n] + a&[n - 1])
canal1_a0 = [1 a0];                      % Canal con valor de a = 1/16
canal1_a1 = [1 a1];                      % Canal con valor de a = 1/8
canal1_a2 = [1 a2];                      % Canal con valor de a = 1/4

% Canal 2 (p[n] = &[n] + a&[n - 1] + a/4&[n - 2])
canal2_a0 = [1 a0 (a0)/4];               % Canal con valor de a = 1/16
canal2_a1 = [1 a1 (a1)/4];               % Canal con valor de a = 1/8
canal2_a2 = [1 a2 (a2)/4];               % Canal con valor de a = 1/4

% Generación de Ruido en 4QAM
ruido_25dB_4QAM = genera_ruido(L,N0_25dB_4QAM, 'PB');   % Genera ruido AWGN para relación de 30dB

% Generación de Ruido en 16QAM
ruido_25dB_16QAM = genera_ruido(L,N0_25dB_16QAM, 'PB');   % Genera ruido AWGN para relación de 30dB

% CONVOLUCIÓN
% Convolución de la constelación 4QAM con el canal 1
convolucion_a0_4QAM_canal1 = conv(s_4QAM,canal1_a0);        % Convolución de la constelación 4QAM con el canal 1 a0
convolucion_a1_4QAM_canal1 = conv(s_4QAM,canal1_a1);        % Convolución de la constelación 4QAM con el canal 1 a1
convolucion_a2_4QAM_canal1 = conv(s_4QAM,canal1_a2);        % Convolución de la constelación 4QAM con el canal 1 a2

convolucion_a0_16QAM_canal1 = conv(s_16QAM,canal1_a0);      % Convolución de la constelación 16QAM con el canal 1 a0
convolucion_a1_16QAM_canal1 = conv(s_16QAM,canal1_a1);      % Convolución de la constelación 16QAM con el canal 1 a1
convolucion_a2_16QAM_canal1 = conv(s_16QAM,canal1_a2);      % Convolución de la constelación 16QAM con el canal 1 a2

% Convolución de la constelación 16QAM con el canal 2
convolucion_a0_4QAM_canal2 = conv(s_4QAM,canal2_a0);        % Convolución de la constelación 4QAM con el canal 2 a0
convolucion_a1_4QAM_canal2 = conv(s_4QAM,canal2_a1);        % Convolución de la constelación 4QAM con el canal 2 a1
convolucion_a2_4QAM_canal2 = conv(s_4QAM,canal2_a2);        % Convolución de la constelación 4QAM con el canal 2 a2

convolucion_a0_16QAM_canal2 = conv(s_16QAM,canal2_a0);      % Convolución de la constelación 16QAM con el canal 2 a0
convolucion_a1_16QAM_canal2 = conv(s_16QAM,canal2_a1);      % Convolución de la constelación 16QAM con el canal 2 a1
convolucion_a2_16QAM_canal2 = conv(s_16QAM,canal2_a2);      % Convolución de la constelación 16QAM con el canal 2 a2

% REPRESENTACIÓN
% REPRESENTACIÓN CONSTELACIÓN 4QAM EN EL CANAL 1

scatterplot(convolucion_a0_4QAM_canal1(1:end - Kp_canal1) + ruido_25dB_4QAM);     % Representación de la constelación 4QAM y canal 1 con ruido
plot_reg(M_4QAM,'QAM');

title('4 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/16');

scatterplot(convolucion_a1_4QAM_canal1(1:end - Kp_canal1) + ruido_25dB_4QAM);     % Representación de la constelación 4QAM y canal 1 con ruido
plot_reg(M_4QAM,'QAM');

title('4 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/8');

scatterplot(convolucion_a2_4QAM_canal1(1:end - Kp_canal1) + ruido_25dB_4QAM);     % Representación de la constelación 4QAM y canal 1 con ruido
plot_reg(M_4QAM,'QAM');

title('4 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/4');


% REPRESENTACIÓN CONSTELACIÓN 16QAM EN EL CANAL 1

scatterplot(convolucion_a0_16QAM_canal1(1:end - Kp_canal1) + ruido_25dB_16QAM);    % Representación de la constelación 16QAM y canal 1 con ruido
plot_reg(M_16QAM,'QAM');

title('16 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/16');

scatterplot(convolucion_a1_16QAM_canal1(1:end - Kp_canal1) + ruido_25dB_16QAM);    % Representación de la constelación 16QAM y canal 1 con ruido
plot_reg(M_16QAM,'QAM');

title('16 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/8');

scatterplot(convolucion_a2_16QAM_canal1(1:end - Kp_canal1) + ruido_25dB_16QAM);    % Representación de la constelación 16QAM y canal 1 con ruido
plot_reg(M_16QAM,'QAM');

title('16 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/4');


% REPRESENTACIÓN CONSTELACIÓN 4QAM EN EL CANAL 2

scatterplot(convolucion_a0_4QAM_canal2(1:end - Kp_canal2) + ruido_25dB_4QAM);     % Representación de la constelación 4QAM y canal 2 con ruido
plot_reg(M_4QAM,'QAM');

title('4 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/16');

scatterplot(convolucion_a1_4QAM_canal2(1:end - Kp_canal2) + ruido_25dB_4QAM);     % Representación de la constelación 4QAM y canal 2 con ruido
plot_reg(M_4QAM,'QAM');

title('4 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/8');

scatterplot(convolucion_a2_4QAM_canal2(1:end - Kp_canal2) + ruido_25dB_4QAM);     % Representación de la constelación 4QAM y canal 2 con ruido
plot_reg(M_4QAM,'QAM');

title('4 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/4');


% REPRESENTACIÓN CONSTELACIÓN 16QAM EN EL CANAL 2

scatterplot(convolucion_a0_16QAM_canal2(1:end - Kp_canal2) + ruido_25dB_16QAM);    % Representación de la constelación 16QAM y canal 2 con ruido
plot_reg(M_16QAM,'QAM');

title('16 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/16');

scatterplot(convolucion_a1_16QAM_canal2(1:end - Kp_canal2) + ruido_25dB_16QAM);    % Representación de la constelación 16QAM y canal 2 con ruido
plot_reg(M_16QAM,'QAM');

title('16 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/8');

scatterplot(convolucion_a2_16QAM_canal2(1:end - Kp_canal2) + ruido_25dB_16QAM);    % Representación de la constelación 16QAM y canal 2 con ruido
plot_reg(M_16QAM,'QAM');

title('16 QAM Diagrama de dispersión para Eb/N0 = 25dB, y a = 1/4');


%% PARTE 4 - EFECTO DE RUIDO EN LAS PROBABILIDADES DE ERROR

%4.1 Modulaciones PAM - Codificación Gray
Nsimbolos = 1000;
M_PAM_GRAY = [2 4 8 16];


Eb_No_db = 0:1:20;
BER_PAM_GRAY=zeros(length(M_PAM_GRAY),length(Eb_No_db));

for l=1:length(M_PAM_GRAY)
    m=log2(M_PAM_GRAY(l));
    Nbits=Nsimbolos*m;   
    Es = calc_Es(M_PAM_GRAY(l),'PAM');
    Eb= Es/m;
    Eb_db = 10*log10(Eb);
    bits = genera_bits(Nbits);
    [simbolos_pam_gray,bits_simbolo_PAM_GRAY] = codifica_gray_pam(bits,M_PAM_GRAY(l)); 
 
    for k=1:length(Eb_No_db)    
        for j=1:100

            No_db = Eb_db - Eb_No_db(k) ;
            No = 10^(No_db/10);
            z1 = genera_ruido(Nsimbolos,No,'BB'); 
            simbolos_salida = simbolos_pam_gray+z1;
            Ae = decisor_pam(simbolos_salida,M_PAM_GRAY(l));

            X_gray  = decodifica_gray_pam(Ae, M_PAM_GRAY(l));
            BER_a(j,k)=sum((X_gray~=bits))/Nbits;
        end
    end
    
    BER_PAM_GRAY(l,:) = mean(BER_a);

end

figure
semilogy(Eb_No_db, BER_PAM_GRAY, '-*');
title('Modulaciones PAM-Codificación Gray');
xlabel('Eb/No (db)');
ylabel('BER');
legend('2-PAM','4-PAM','8-PAM','16-PAM');
grid on

%4.2 Modulaciones QAM - Codificación Gray
Nsimbolos = 1000;
M_QAM_GRAY = [4 16 64];


Eb_No_db = 0:1:20;
BER_QAM_GRAY=zeros(length(M_QAM_GRAY),length(Eb_No_db));

for l=1:length(M_QAM_GRAY)
    m=log2(M_QAM_GRAY(l));
    Nbits=Nsimbolos*m;   
    Es = calc_Es(M_QAM_GRAY(l),'QAM');
    Eb= Es/m;
    Eb_db = 10*log10(Eb);
    bits = genera_bits(Nbits);
    [simbolos_qam_gray,bits_simbolo_QAM_GRAY] = codifica_gray_qam(bits,M_QAM_GRAY(l)); 
 
    for k=1:length(Eb_No_db)    
        for j=1:100

            No_db = Eb_db - Eb_No_db(k) ;
            No = 10^(No_db/10);
            z1 = genera_ruido(Nsimbolos,No,'PB'); 
            simbolos_salida = simbolos_qam_gray+z1;
            Ae = decisor_qam(simbolos_salida,M_QAM_GRAY(l));
        
            [X_gray , bits_simbolo_dec] = decodifica_gray_qam(Ae, M_QAM_GRAY(l));
    
            BER_a(j,k)=sum(X_gray~=bits)/Nbits;
        end
    end
    
    BER_QAM_GRAY(l,:) = mean(BER_a);
end

figure
semilogy(Eb_No_db, BER_QAM_GRAY,'-*');
title('Modulaciones QAM-Codificación Gray');
xlabel('Eb/No (db)');
ylabel('BER');
legend('4-QAM','16-QAM','64-QAM');
grid on

%4.3 Relación PE-BER EN 64QAM

Nsimbolos = 1000;
M_64QAM_GRAY =64;
Eb_No_db = 0:1:20;
BER_64QAM_GRAY =zeros(length(M_64QAM_GRAY),length(Eb_No_db));

m=log2(M_64QAM_GRAY);
Nbits=Nsimbolos*m;   
Es = calc_Es(M_64QAM_GRAY,'QAM');
Eb= Es/m;
Eb_db = 10*log10(Eb);
bits = genera_bits(Nbits);
[simbolos_qam_gray,bits_simbolo_64QAM_GRAY] = codifica_gray_qam(bits,M_64QAM_GRAY); 
 
for k=1:length(Eb_No_db)    
    
    for j=1:100

        No_db = Eb_db - Eb_No_db(k) ;
        No = 10^(No_db/10);
        z1 = genera_ruido(Nsimbolos,No,'PB'); 
        simbolos_salida = simbolos_qam_gray+z1;
        Ae = decisor_qam(simbolos_salida,M_64QAM_GRAY);
    
        [X_gray ,bits_simbolo_dec ] = decodifica_gray_qam(Ae, M_64QAM_GRAY);
    
        BER_a(j,k)=sum((X_gray~=bits))/Nbits;
        Pe_a(j,k)=sum(Ae~=simbolos_qam_gray)/Nsimbolos;
    end
 
end

BER_64QAM_GRAY = mean(BER_a);
Pe = mean(Pe_a);
relacion = Pe./BER_64QAM_GRAY;

figure
plot(Eb_No_db, relacion);
xlabel('Eb/No (db)');
title('Pe/BER (64-QAM)');
grid on

%4.4 Modulaciones PAM - Asinación binaria secuencial

Nsimbolos = 1000;
M_PAM_SEC = [2 4 8 16];

Eb_No_db = 0:1:20;
BER_PAM_SEC=zeros(length(M_PAM_SEC),length(Eb_No_db));

for l=1:length(M_PAM_SEC)
    m=log2(M_PAM_SEC(l));
    Nbits=Nsimbolos*m;   
    Es = calc_Es(M_PAM_SEC(l),'PAM');
    Eb= Es/m;
    Eb_db = 10*log10(Eb);
    bits = genera_bits(Nbits);
    [simbolos_pam_secuencial,bits_simbolo_PAM_SEC] = codifica_secuencial_pam(bits,M_PAM_SEC(l)); 
 
    for k=1:length(Eb_No_db)    
    
        for j=1:100

            No_db = Eb_db - Eb_No_db(k) ;
            No = 10^(No_db/10);
            z1 = genera_ruido(Nsimbolos,No,'BB'); 
            simbolos_salida = simbolos_pam_secuencial+z1;
            Ae = decisor_pam(simbolos_salida,M_PAM_SEC(l));    

            [X_secuencial ,bits_simbolo_dec ] = decodifica_secuencial_pam(Ae, M_PAM_SEC(l));
    
            BER_a(j,k)=sum((X_secuencial~=bits))/Nbits;
        end

    end
    
    BER_PAM_SEC(l,:) = mean(BER_a);
   
end

figure
semilogy(Eb_No_db, BER_PAM_SEC,'-*');
title('Modulciones PAM-Asignación binaria secuencial');
xlabel('Eb/No (db)');
ylabel('BER');
legend('2-PAM','4-PAM','8-PAM','16-PAM');
grid on

% 4.5 Modulaciones QAM - Asinación binaria secuencial

Nsimbolos = 1000;
M_QAM_SEC = [4 16 64];


Eb_No_db = 0:1:20;
BER_QAM_SEC=zeros(length(M_QAM_SEC),length(Eb_No_db));

for l=1:length(M_QAM_SEC)
    m=log2(M_QAM_SEC(l));
    Nbits=Nsimbolos*m;   
    Es = calc_Es(M_QAM_SEC(l),'QAM');
    Eb= Es/m;
    Eb_db = 10*log10(Eb);
    bits = genera_bits(Nbits);
    [simbolos_qam_secuencial,bits_simbolo] = codifica_secuencial_qam(bits,M_QAM_SEC(l)); 
 
    for k=1:length(Eb_No_db)    

        for j=1:100
            No_db = Eb_db - Eb_No_db(k) ;
            No = 10^(No_db/10);
            z1 = genera_ruido(Nsimbolos,No,'PB'); 
            simbolos_salida = simbolos_qam_secuencial+z1;
            Ae = decisor_qam(simbolos_salida,M_QAM_SEC(l));

            X_secuencial  = decodifica_secuencial_qam(Ae, M_QAM_SEC(l));

            BER_a(j,k)=sum(X_secuencial~=bits)/Nbits;
        end

    end
    
    BER_QAM_SEC(l,:) = mean(BER_a);
 
end

figure
semilogy(Eb_No_db, BER_QAM_SEC,'-*');
title('Modulciones QAM-Asignación binaria secuencial');
xlabel('Eb/No (db)');
ylabel('BER');
legend('4-QAM','16-QAM','64-QAM');
grid on

% 4.6 Relación PE-BER EN 64QAM - Asignación Binaria Secuencial
Nsimbolos = 1000;
M_64QAM_SEC =16;
Eb_No_db = 0:1:20;
BER_64QAM_SEC=zeros(length(M_64QAM_SEC),length(Eb_No_db));

m=log2(M_64QAM_SEC);
Nbits=Nsimbolos*m;   
Es = calc_Es(M_64QAM_SEC,'QAM');
Eb= Es/m;
Eb_db = 10*log10(Eb);
bits = genera_bits(Nbits);
[simbolos_qam_secuencial,bits_simbolo] = codifica_secuencial_qam(bits,M_64QAM_SEC); 
 
for k=1:length(Eb_No_db)    
    
    for j=1:100
        No_db = Eb_db - Eb_No_db(k) ;
        No = 10^(No_db/10);
        z1 = genera_ruido(Nsimbolos,No,'PB'); 
        simbolos_salida = simbolos_qam_secuencial+z1;
        Ae = decisor_qam(simbolos_salida,M_64QAM_SEC);

        X_secuencial = decodifica_secuencial_qam(Ae, M_64QAM_SEC);

        BER_a(j,k)=sum((X_secuencial~=bits))/Nbits;
        Pe_a(j,k)=sum(Ae~=simbolos_qam_secuencial)/Nsimbolos;
    end
    
end

BER_64QAM_SEC = mean(BER_a);
Pe = mean(Pe_a);
relacion = Pe./BER_64QAM_SEC;

figure
plot(Eb_No_db, relacion);
xlabel('Eb/No (db)');
title('Pe/BER (64-QAM)');
grid on

%% 5. PROBABILIDAD DE ERROR CON RECEPTORES NO COHERENTES 

Nsims = 1000;
M_16QAM = 16;
m = log2(M_16QAM);
Es = calc_Es(M_16QAM, 'QAM');
Eb= Es/m;
Nbits = Nsims*m;
Eb_No_dB = 12;
EbNo_nats = 10^(Eb_No_dB/10);
No = Eb/EbNo_nats;
desfase_grados = 0:5:360;
desfase_rad = (desfase_grados).*(pi/180);
BER_Pe = zeros(1, length(desfase_rad));

for j = 1:length(desfase_rad)
    for i = 1:100
        bits = genera_bits(Nbits);
        qam = codifica_gray_qam(bits, M_16QAM);
        desfase = desfase_rad(j);
        z = genera_ruido(Nsims, No, 'PB');
        salida = (qam + z)*exp(-1i*desfase);
        decisor = decisor_qam(salida, M_16QAM);
        
        X_dec = decodifica_gray_qam(decisor, M_16QAM);
        BER_Pe(i,j) = sum(X_dec~=bits)/Nbits;
    
    end
    BER_m_Pe = mean(BER_Pe);
end

figure
semilogy(desfase_grados, BER_m_Pe, '-*');
title('BER - Desfase Portadoras');
xlabel('Desfase entre portadoras (º)');
ylabel('BER');

grid on
 
%% EJERCICIO 6 EFECTO DE LA ISI EN PROBABILIDADES DE ERROR

Nsims = 1000;
M_16QAM = 16;
Eb_No_dB = 0:1:20;
m = log2(M_16QAM);
Es = calc_Es(M_16QAM, 'QAM');
Eb= Es/m;
Nbits = Nsims*m;
Eb_db = 10*log10(Eb);

bits = genera_bits(Nbits);
[qam, ~] = codifica_gray_qam(bits, M_16QAM);
aM = [1/16 1/8 1/4 0];

BER_ISI=zeros(length(aM),length(Eb_No_dB));

for i=1:length(aM)
    for k = 1:length(Eb_No_dB)
        for j = 1:100

            No_db = Eb_db - Eb_No_dB(k);
            No = 10^(No_db/10);
            hn = [1 aM(i)];               
            s = conv(qam, hn);
            z = genera_ruido(Nsims, No, 'PB');
            y = s(1:Nsims) +  z;
            decisor = decisor_qam(y,M_16QAM);
            [X_gray , ~] = decodifica_gray_qam(decisor, M_16QAM);
            BER_ISI(j,k) = sum((X_gray~=bits))/Nbits;
        end
    end
    BER_m_ISI(i,:) = mean(BER_ISI);
end 
   
figure
semilogy(Eb_No_dB, BER_m_ISI, '-*');
title('Relación BER - Eb/No');
xlabel('Eb/No (dB)');
ylabel('BER');
legend('a = 1/16','a = 1/8','a = 1/4', 'a = 0 (Sin ISI)');
grid on
 

function Es = calc_Es(ordenConstelacion, modulacion)
    if strcmp(modulacion,'PAM')
        Es = ((ordenConstelacion.^2)-1)/3;
    elseif strcmp(modulacion,'QAM')
        Es = (2*(ordenConstelacion - 1))/3;
    else
        error('La modulación no es ni M-PAM ni M-QAM');
    end
end
