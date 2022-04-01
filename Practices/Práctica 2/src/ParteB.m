%  COMUNICACIONES DIGITALES - Práctica 2 (B)
%  
%  Recursos empleados: OFDM_p.m 
%                      demoP2b.m
%                      
%--------------------------------------------------------------------------

%% PARTE 1 - SISTEMA OFDM SIN PREFIJO CÍCLICO
%--------------------------------------------------------------------------
% Se considera una constelación 16QAM con niveles normalizados en un
% sistema de comunicaciones digital en la que se empleará una modulación
% OFDM en tiempo discreto con características (en referencia al número de 
% portadoras usadas así como el prefijo cíclico)que se detallan más
% adelante.
%--------------------------------------------------------------------------

clc
clear all


% Variables y datos de la constelación
M = 4;       % Orden de la Constelación
N = 16;     % número de portadoras

% Canal d[m]
a=9/10;
d(1)=1;
for m=2:6
    d(m)=a^(m-1);
end

%--------------------------------------------------------------------------
% Sobre el canal ideal d[m] = δ[m]
%--------------------------------------------------------------------------

% Canales Discretos p_ki[n]
for numPortadoras=1:N
    canalp_P1_d_Ideal = OFDM_p(1,numPortadoras,0,1);
end

% Prob. Error Simb - Pe (Varianza = 4) 
[Pe_P1_canalIdeal]=ProbError(16,1,N,1,4); 

%--------------------------------------------------------------------------
% Sobre el canal d[m]
%--------------------------------------------------------------------------

% Canales Discretos p_ki[n]
for numPortadoras=1:N
    canalp_P1_d = OFDM_p(d,numPortadoras,1,4);
end

% Prob. Error Simb - Pe (Varianza = 4) 
[Pe_P1_canald]=ProbError(16,d,N,1,4);

%--------------------------------------------------------------------------
% Se procede a la visualización de todos los parámetros obtenidos.
%--------------------------------------------------------------------------
% VISUALIZACIÓN
disp('COMUNICACIONES DIGITALES - PRÁCTICA 2 (B)');
disp(' ');
disp('FECHA REALIZACIÓN: DICIEMBRE 2020');
disp(' ');


disp('---------------------------------------------------------------');
disp('CONSTELACIÓN 16QAM NORMALIZADA');
disp(' ');

disp('---------------------------------------------------------------');
disp('---------- PARTE 1: Sistema OFDM Sin Prefijo Cíclico ----------');
disp('---------------------------------------------------------------');
disp(' ');

disp('--------------------------------------------------------------');
disp('Canales p_i,k[n] - Sobre el canal ideal d[m] = δ[m]:');
disp(' ');

valoresCanalp_P1_d_Ideal = cell2table(canalp_P1_d_Ideal)


disp('--------------------------------------------------------------');
disp('Pe - Sobre el canal ideal d[m] = δ[m]:');
disp(' ');

for k=1:N
    disp(['      Pe (k=',num2str(k-1),') = ',num2str(Pe_P1_canalIdeal(k))]);
    disp(['          Sobre 100% -> Pe (k=',num2str(k-1),') = ',num2str(Pe_P1_canalIdeal(k)*100)]);
end
disp(' ');
disp(['      Pe (mean) = ',num2str(mean(Pe_P1_canalIdeal))]);
disp(['          Sobre 100% -> Pe (k=',num2str(k-1),') = ',num2str(mean(Pe_P1_canalIdeal)*100)]);
disp(' ');

disp('--------------------------------------------------------------');
disp('Canales p_i,k[n] - Sobre el canal d[m]:');
disp(' ');

valoresCanalp_P1_d = cell2table(canalp_P1_d)

disp('--------------------------------------------------------------');
disp('Pe - Sobre el canal d[m]:');
disp(' ');
for k=1:N
    disp(['      Pe (k=',num2str(k-1),') = ',num2str(Pe_P1_canald(k))]);
    disp(['          Sobre 100% -> Pe (k=',num2str(k-1),') = ',num2str(Pe_P1_canald(k)*100)]);
end

disp(' ');
disp(['      Pe (mean) = ',num2str(mean(Pe_P1_canald))]);
disp(['          Sobre 100% -> Pe (k=',num2str(k-1),') = ',num2str(mean(Pe_P1_canald)*100)]);
disp(' ');

%% PARTE 2 - SISTEMA OFDM CON PREFIJO CÍCILO
%--------------------------------------------------------------------------
% Utilizando la función realizada de nuevo para la obtención de los
% parámetros de Pe y BER para cada combinación de secuencias de los
% usuarios sobre un canal ideal.
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Sobre el canal d[m]
%--------------------------------------------------------------------------


% Prob. Error Simb - Pe (Varianza = 0) 
[Pe_P2_1_conC] = ProbErrorPromedio(16,d,N,10,1,0);
PeProm_var0=zeros(1,10);
for indice=1:10
    PeProm_var0(indice)=mean(Pe_P2_1_conC(indice,:));
end

% Prob. Error Simb - Pe (Varianza = 4) 
[Pe_P2_2_conC] = ProbErrorPromedio(16,d,N,10,1,4);
PeProm_var4=zeros(1,10);
for indice=1:10
    PeProm_var4(indice)=mean(Pe_P2_1_conC(indice,:));
end

%--------------------------------------------------------------------------
% Se procede a la visualización de todos los parámetros obtenidos.
%--------------------------------------------------------------------------
% VISUALIZACIÓN
disp('---------------------------------------------------------------');
disp('---------- PARTE 2: Sistema OFDM cON Prefijo Cíclico ----------');
disp('---------------------------------------------------------------');
disp(' ');

disp('--------------------------------------------------------------');
disp('------------------- Sobre el canal d[m] ----------------------');
disp('--------------------------------------------------------------');
disp(' ');

disp('--------------------------------------------------------------');
disp('Sin Ruido - Varianza: 0');
disp(' ');
for c=1:10
    disp(['      Pe (mean) (Con Prefijo Cíciclo C = ',num2str(c),') = ',num2str(PeProm_var0(c)/100)]);
    disp(['          Sobre 100% -> Pe (mean) = ',num2str(PeProm_var0(c))]);
end
disp(' ');

disp('--------------------------------------------------------------');
disp('Sin Ruido - Varianza: 4');
disp(' ');

for c=1:10
    disp(['      Pe (mean) (Con Prefijo Cíciclo C = ',num2str(c),') = ',num2str(PeProm_var4(c)/100)]);
    disp(['          Sobre 100% -> Pe (mean) = ',num2str(PeProm_var4(c))]);
end
disp(' ');

%--------------------------------------------------------------------------
% Sobre el canal d[m], Kd=6 (último valor para el que d[m] != <-> m=Kd).
% El prefíjo ciclico C debe ser tal que C >= Kd. En este caso, C = 6.
%--------------------------------------------------------------------------
prefijoCiclicoOptimo=5;

[Pe_conCOptimo] = ProbErrorConCOptimo(16,d,N,prefijoCiclicoOptimo,1,0);

%--------------------------------------------------------------------------
% Se procede a la visualización de las Pe obtenidas.
%--------------------------------------------------------------------------
% VISUALIZACIÓN
disp('--------------------------------------------------------------');
disp('Pe - Con el Prefijo Cíclico Óptimo: ');
disp(' ');

disp(['El prefijo cícilo óptimo es: ', num2str(prefijoCiclicoOptimo)]);
disp(' ');
for k=1:N
    disp(['      Pe (k=',num2str(k-1),') = ',num2str(Pe_conCOptimo(k)/100)]);
    disp(['          Sobre 100% -> Pe (k=',num2str(k-1),') = ',num2str(Pe_conCOptimo(k))]);
end
disp(' ');
disp(['      Pe (mean) = ',num2str(mean(Pe_conCOptimo)/100)]);
disp(['          Sobre 100% -> Pe (k=',num2str(k-1),') = ',num2str(mean(Pe_conCOptimo))]);
disp(' ');

%--------------------------------------------------------------------------
% FUNCIONES EMPLEADAS.
%--------------------------------------------------------------------------
function [Pe]= ProbError(OrdenConstelacion,canalD,NumPortadoras,Tsimb,varNoise);
    % [Pe]= ProbError(OrdenConstelacion,canalD,NumPortadoras,Tsimb,varNoise)
    %
    % Función que calcula la Pe (devuelta en una matriz)a partir de:
    % 
    % OrdenConstelacion: Orden de la Constelación empleada 
    % canalD: canal d[m] (1 x (Kd+1))    
    % NumPortadoras: Número de Portadoras.
    % Tsimb: Tiempo de Símbolos
    % varNoise: Varianza del ruido (0).

    %--------------------------------------------------------------------------
    % Parámetros generales de la simulación
    % General parameters for the simulation
    %--------------------------------------------------------------------------
    T=Tsimb;                % Tiempo de símbolo / Symbol length
    M=OrdenConstelacion;    % Orden de la constelación / Constellation order
    N=NumPortadoras;        % Número de portadoras / Number of carriers
    Nblocks=1e5;            % Número de bloques / Number of blocks
    Nsymb=Nblocks*N;
    Nbits=Nsymb*log2(M);
    d=canalD;

    varNoise=varNoise;      % Varianza de Ruido
    %--------------------------------------------------------------------------
    % Modulation
    %--------------------------------------------------------------------------
    B=genera_bits(Nbits);
    A=codifica_gray_qam(B,M);
    % Conversión serie a paralelo / Serial to parallel conversion
    Ak=reshape(A,N,Nblocks);
    sb=N/sqrt(T)*ifft(Ak,N,1);
    % Conversión paralelo a serie / Parallel to serial conversion
    s=reshape(sb,1,Nsymb);
    %--------------------------------------------------------------------------
    % Transmission
    %--------------------------------------------------------------------------
    Kd=length(d)-1;
    v=conv([zeros(1,Kd),s],d);
    v=v(Kd+1:Kd+length(s));
    v=v+sqrt(varNoise/2)*randn(size(v))+j*sqrt(varNoise/2)*randn(size(v));
    %--------------------------------------------------------------------------
    % Demodulation
    %--------------------------------------------------------------------------
    % Serial to parallel
    vp=reshape(v,N,Nblocks);
    qk=1/sqrt(T)*fft(vp,N,1);
    %--------------------------------------------------------------------------
    % Visualization
    %--------------------------------------------------------------------------
    p=OFDM_p(d,N);
    Pe=zeros(1,N);
    for k=1:N
        pk=p{k,k};
        qn=qk(k,:)/pk(1);
        Ake=decisor_qam(qn,M);
        Pe(k)=length(find(Ake~=Ak(k,:)))/length(Ake);
    end
   
end

function [Pe_conC]= ProbErrorPromedio(OrdenConstelacion,canalD,NumPortadoras,prefijoCiclico,Tsimb,varNoise);
    % [Pe_conC]= ProbErrorPromedio(OrdenConstelacion,canalD,NumPortadoras,prefijoCiclico,Tsimb,varNoise)
    %
    % Función que calcula la Pe (devuelta en una tabla de 'prefijoCiclico' 
    % filas por 'NumPortadoras' Column)para después obtener el valor 
    % promedio de estos valores de Pe teniendo en cuenta el valor del 
    % prefijo cíciclo (recorre en un bucle for por todos los valores de C y
    % calcula los canales p_k,i respectivos).
    %
    % Los parámtetros son:
    %
    % OrdenConstelacion: Orden de la Constelación empleada 
    % canalD: canal d[m] (1 x (Kd+1))    
    % NumPortadoras: Número de Portadoras.
    % prefijoCiclico: Prefijo Cíclico
    % Tsimb: Tiempo de Símbolos
    % varNoise: Varianza del ruido.

    %--------------------------------------------------------------------------
    % Parámetros generales de la simulación
    % General parameters for the simulation
    %--------------------------------------------------------------------------
    T=Tsimb;                % Tiempo de símbolo / Symbol length
    M=OrdenConstelacion;    % Orden de la constelación / Constellation order
    N=NumPortadoras;        % Número de portadoras / Number of carriers
    Nblocks=1e5;            % Número de bloques / Number of blocks
    Nsymb=Nblocks*N;
    Nbits=Nsymb*log2(M);
    d=canalD;

    %--------------------------------------------------------------------------
    % Modulation
    %--------------------------------------------------------------------------
    B=genera_bits(Nbits);
    A=codifica_gray_qam(B,M);
    % Conversión serie a paralelo / Serial to parallel conversion
    Ak=reshape(A,N,Nblocks);
    sb=N/sqrt(T)*ifft(Ak,N,1);
    % Conversión paralelo a serie / Parallel to serial conversion
    s=reshape(sb,1,Nsymb);
    %--------------------------------------------------------------------------
    % Transmission
    %--------------------------------------------------------------------------
    Kd=length(d)-1;
    v=conv([zeros(1,Kd),s],d);
    v=v(Kd+1:Kd+length(s));
    v=v+sqrt(varNoise/2)*randn(size(v))+j*sqrt(varNoise/2)*randn(size(v));
    %--------------------------------------------------------------------------
    % Demodulation
    %--------------------------------------------------------------------------
    % Serial to parallel
    vp=reshape(v,N,Nblocks);
    qk=1/sqrt(T)*fft(vp,N,1);
    %--------------------------------------------------------------------------
    % Visualization
    %--------------------------------------------------------------------------
    Pe_conC=zeros(prefijoCiclico,N);
    
    for c=1:prefijoCiclico    
        p=OFDM_p(d,N,c,Tsimb);
       
        for k=1:N
            pk=p{k,k};
            qn=qk(k,:)/pk(1);
            Ake=decisor_qam(qn,M);
            Pe_conC(c,k)=(length(find(Ake~=Ak(k,:)))/length(Ake)).*100;
        end
        
    end
 
end

function [Pe_conCOptimo]= ProbErrorConCOptimo(OrdenConstelacion,canalD,NumPortadoras,prefijoCiclicoOptimo,Tsimb,varNoise);
    % [Pe_conCOptimo]= ProbErrorConCOptimo(OrdenConstelacion,canalD,NumPortadoras,prefijoCiclicoOptimo,Tsimb,varNoise)
    %
    % Función que calcula la Pe (devuelta en una matriz) teniendo en cuenta 
    % el valor del prefijo cíciclo óptimo.
    % La diferencia con la función anterior radica en que ProbErrorConCOptimo
    % propociorna al canal discreto p_k,i[n] (función OFDM_p) el valor de C
    % a emplear (que por defecto es 0)que se proporciona como parámetro.
    %
    % Después, funciona igual que ProbErrorPromedio.
    %
    % Los parámetros de entrada son:
    % 
    % OrdenConstelacion: Orden de la Constelación empleada 
    % canalD: canal d[m] (1 x (Kd+1))    
    % NumPortadoras: Número de Portadoras.
    % prefijoCiclicoOptimo: Prefijo Cíclico Óptimo
    % Tsimb: Tiempo de Símbolos
    % varNoise: Varianza del ruido
    %
    %--------------------------------------------------------------------------
    % Parámetros generales de la simulación
    % General parameters for the simulation
    %--------------------------------------------------------------------------
    T=Tsimb;                % Tiempo de símbolo / Symbol length
    M=OrdenConstelacion;    % Orden de la constelación / Constellation order
    N=NumPortadoras;        % Número de portadoras / Number of carriers
    Nblocks=1e5;            % Número de bloques / Number of blocks
    Nsymb=Nblocks*N;
    Nbits=Nsymb*log2(M);
    d=canalD;

    %--------------------------------------------------------------------------
    % Modulation
    %--------------------------------------------------------------------------
    B=genera_bits(Nbits);
    A=codifica_gray_qam(B,M);
    % Conversión serie a paralelo / Serial to parallel conversion
    Ak=reshape(A,N,Nblocks);
    sb=N/sqrt(T)*ifft(Ak,N,1);
    % Conversión paralelo a serie / Parallel to serial conversion
    s=reshape(sb,1,Nsymb);
    %--------------------------------------------------------------------------
    % Transmission
    %--------------------------------------------------------------------------
    Kd=length(d)-1;
    v=conv([zeros(1,Kd),s],d);
    v=v(Kd+1:Kd+length(s));
    v=v+sqrt(varNoise/2)*randn(size(v))+j*sqrt(varNoise/2)*randn(size(v));
    %--------------------------------------------------------------------------
    % Demodulation
    %--------------------------------------------------------------------------
    % Serial to parallel
    vp=reshape(v,N,Nblocks);
    qk=1/sqrt(T)*fft(vp,N,1);
    %--------------------------------------------------------------------------
    % Visualization
    %--------------------------------------------------------------------------
     
    p=OFDM_p(d,N,prefijoCiclicoOptimo,Tsimb);
       
    for k=1:N
        pk=p{k,k};
        qn=qk(k,:)/pk(1);
        Ake=decisor_qam(qn,M);
        Pe_conCOptimo(k)=(length(find(Ake~=Ak(k,:)))/length(Ake)).*100;
    end
 
end
