%  COMUNICACIONES DIGITALES - Práctica 2 (A)
% 
%  Recursos empleados: DSSS_p.m 
%                      demoP2a.m
%                      sequences11.mat
%--------------------------------------------------------------------------

%% PARTE 1 - TRANSMISIÓN A TIEMPO DE CHIP (1 USUARIO)
%--------------------------------------------------------------------------
% Se considera una constelación 4PAM con niveles normalizados (+/-1, +/--)
% Empleo de una secuencia x0[m] y obtencion de x1[m], x2[m] y x3[m] del
% fichero sequences11.mat.
%--------------------------------------------------------------------------

clc
clear all

% Variables y datos de la constelación
k = 2;      % número de simbolos a dmin (4PAM) 
dmin = 2;   % 4PAM
Amax = 3;    % 4PAM
load sequences11.mat;

% Eficiencia Espectral
EficConst=(dmin/2)/(Amax);

% OBTENCIÓN DE LAS SECUENCIAS
% Secuencia x_o[m]
for m=1:11
    x0(m)=1;
end

% Secuencias restantes obtenidas del fichero .mat
x1=sequences11(1,:);
x2=sequences11(2,:);
x3=sequences11(3,:);

% Canal d[m]
a=9/10;
d(1)=1;
for m=2:51
    d(m)=a^(m-1);
end
EnergiaCanald = sum(d.^2);

% Obtención Canal p[n] según secuencias
p0=DSSS_p(x0,d);
p1=DSSS_p(x1,d);
p2=DSSS_p(x2,d);
p3=DSSS_p(x3,d);

% Energia de los canales p[n] respectivos
EnergiaCanalp0=sum(p0.^2);
EnergiaCanalp1=sum(p1.^2);
EnergiaCanalp2=sum(p2.^2);
EnergiaCanalp3=sum(p3.^2);

% Retardo Optimo
RetOpt0 = 0;
RetOpt1 = 0;
RetOpt2 = 0;
RetOpt3 = 0;

% Calculo Dpico
Dpico0 = sum((abs(p0))/(abs(p0(RetOpt0+1))));
Dpico1 = sum((abs(p1))/(abs(p1(RetOpt1+1))));
Dpico2 = sum((abs(p2))/(abs(p2(RetOpt2+1))));
Dpico3 = sum((abs(p3))/(abs(p3(RetOpt3+1))));

% Valor ISI
gamma_ISI_0 = Dpico0/EficConst;
gamma_ISI_1 = Dpico1/EficConst;
gamma_ISI_2 = Dpico2/EficConst;
gamma_ISI_3 = Dpico3/EficConst;

% Energia Canal
E0=sum(p0.^2);
E1=sum(p1.^2);
E2=sum(p2.^2);
E3=sum(p3.^2);

%--------------------------------------------------------------------------
% Una vez obtenidos los canales junto con los parámetros de Dpico, el nivel 
% de la ISI y las energías de cada canal, se realiza una función para  la
% obtención de la Pe y BER en función de cada varianza y secuencia empleada
% (ver al final del código). 
%--------------------------------------------------------------------------

% Prob. Error Simb - Pe (Varianza = 0) 
[Pe0_var0,BER0_var0]= ProbErrorYBER(x0,d,0);
[Pe1_var0,BER1_var0]= ProbErrorYBER(x1,d,0);
[Pe2_var0,BER2_var0]= ProbErrorYBER(x2,d,0);
[Pe3_var0,BER3_var0]= ProbErrorYBER(x3,d,0);

% Prob. Error Simb - Pe (Varianza = 1)
[Pe0_var1,BER0_var1]= ProbErrorYBER(x0,d,1);
[Pe1_var1,BER1_var1]= ProbErrorYBER(x1,d,1);
[Pe2_var1,BER2_var1]= ProbErrorYBER(x2,d,1);
[Pe3_var1,BER3_var1]= ProbErrorYBER(x3,d,1);

%--------------------------------------------------------------------------
% Se obtiene la correlación de las secuencias x1[m], x2[m] y x3[m]. 
% Se obtiene la figura a continuación para su análisis.
%--------------------------------------------------------------------------

% Correlación Secuencias
r1 = xcorr(x1);
r2 = xcorr(x2);
r3 = xcorr(x3);

figure(1)
hold on
plot(r1,'b-*');
plot(r2,'r-o');
plot(r3,'g-');
title('Funciones de correlación de las secuencias x1, x2 y x3');
legend('Secuencia x1[m]','Secuencia x2[m]','Secuencia x3[m]');

%--------------------------------------------------------------------------
% Se procede a la visualización de todos los parámetros obtenidos.
%--------------------------------------------------------------------------
% VISUALIZACIÓN
disp('COMUNICACIONES DIGITALES - PRÁCTICA 2 (A)');
disp(' ');
disp('FECHA REALIZACIÓN: DICIEMBRE 2020');
disp(' ');


disp('---------------------------------------------------------------');
disp('CONSTELACIÓN 4PAM NORMALIZADA - DATOS');
disp(' ');

disp(['dmin: ',num2str(dmin)]);
disp(['Amax: ',num2str(Amax)]);
disp(['Eficiencia de la Constelación [(dmin/2)/Amax]: ',num2str(EficConst)]);
disp(['Energía del canal d[m]: ',num2str(EnergiaCanald)]);
disp(' ');

disp('---------------------------------------------------------------');
disp('------ PARTE 1: Transmisión a tiempo de xhip (1 usuarios)------');
disp('---------------------------------------------------------------');
disp(' ');

disp('---------------------------------------------------------------');
disp('Datos de Secuencias x[m] y Canales Respectivos p[n]');
disp(' ');

disp('------ SECUENCIA x0[m] ------');
disp(['x0[n] : ',num2str(x0)])
disp(['p0[n] : ',num2str(p0)])
disp(['Energía del canal p0[n]: ',num2str(EnergiaCanalp0)]);
disp(['Retardo Óptimo : ',num2str(RetOpt0)]);
disp(['Distorsión de Pico: ',num2str(Dpico0)]);
disp(['Valor de ISI: ',num2str(gamma_ISI_0)]);
disp(['Pe con Var = 0: ',num2str(Pe0_var0*100)]);
disp(['Pe con Var = 1: ',num2str(Pe0_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER0_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER0_var1*100)]);
disp(' ');

disp('------ SECUENCIA x1[m] ------');
disp(['x1[n] : ',num2str(x1)])
disp(['p1[n] : ',num2str(p1)])
disp(['Energía del canal p1[n]: ',num2str(EnergiaCanalp1)]);
disp(['Retardo Óptimo : ',num2str(RetOpt1)]);
disp(['Distorsión de Pico: ',num2str(Dpico1)]);
disp(['Valor de ISI: ',num2str(gamma_ISI_1)]);
disp(['Pe con Var = 0: ',num2str(Pe1_var0*100)]);
disp(['Pe con Var = 1: ',num2str(Pe1_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER1_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER1_var1*100)]);
disp(' ');

disp('------ SECUENCIA x2[m] ------');
disp(['x2[n] : ',num2str(x2)])
disp(['p2[n] : ',num2str(p2)])
disp(['Energía del canal p2[n]: ',num2str(EnergiaCanalp2)]);
disp(['Retardo Óptimo : ',num2str(RetOpt2)]);
disp(['Distorsión de Pico: ',num2str(Dpico2)]);
disp(['Valor de ISI: ',num2str(gamma_ISI_2)]);
disp(['Pe con Var = 0: ',num2str(Pe2_var0*100)]);
disp(['Pe con Var = 1: ',num2str(Pe2_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER2_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER2_var1*100)]);
disp(' ');

disp('------ SECUENCIA x3[m] ------');
disp(['x3[n] : ',num2str(x3)])
disp(['p3[n] : ',num2str(p3)])
disp(['Energía del canal p3[n]: ',num2str(EnergiaCanalp3)]);
disp(['Retardo Óptimo : ',num2str(RetOpt3)]);
disp(['Distorsión de Pico: ',num2str(Dpico3)]);
disp(['Valor de ISI: ',num2str(gamma_ISI_3)]);
disp(['Pe con Var = 0: ',num2str(Pe3_var0*100)]);
disp(['Pe con Var = 1: ',num2str(Pe3_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER3_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER3_var1*100)]);
disp(' ');

%% PARTE 2 - TRANSMISIÓN CON 2 USUARIOS
%--------------------------------------------------------------------------
% En esta parte, se realiza la transmisión con 2 usuarios A y B. Además,
% se empleará una serie de combincación de cada usuario con cada secuencia
% de las anteriores.
%--------------------------------------------------------------------------
% 3 combinaciones
xA_1=x1;
xB_1=x2;

xA_2=x1;
xB_2=x3;

xA_3=x2;
xB_3=x3;

xA_4=x2;
xB_4=x2;

%--------------------------------------------------------------------------
% Utilizando la función realizada de nuevo para la obtención de los
% parámetros de Pe y BER para cada combinación de secuencias de los
% usuarios sobre un canal ideal.
%--------------------------------------------------------------------------

% Prob. Error Simb - Pe (Varianza = 0) 
[PeA_1_var0,BER_A_1_var0]= ProbErrorYBER(xA_1,1,0);
[PeB_1_var0,BER_B_1_var0]= ProbErrorYBER(xB_1,1,0);
[PeA_2_var0,BER_A_2_var0]= ProbErrorYBER(xA_2,1,0);
[PeB_2_var0,BER_B_2_var0]= ProbErrorYBER(xB_2,1,0);
[PeA_3_var0,BER_A_3_var0]= ProbErrorYBER(xA_3,1,0);
[PeB_3_var0,BER_B_3_var0]= ProbErrorYBER(xB_3,1,0);

% Prob. Error Simb - Pe (Varianza = 1)
[PeA_1_var1,BER_A_1_var1]= ProbErrorYBER(xA_1,1,1);
[PeB_1_var1,BER_B_1_var1]= ProbErrorYBER(xB_1,1,1);
[PeA_2_var1,BER_A_2_var1]= ProbErrorYBER(xA_2,1,1);
[PeB_2_var1,BER_B_2_var1]= ProbErrorYBER(xB_2,1,1);
[PeA_3_var1,BER_A_3_var1]= ProbErrorYBER(xA_3,1,1);
[PeB_3_var1,BER_B_3_var1]= ProbErrorYBER(xB_3,1,1);

%--------------------------------------------------------------------------
% En esta ocasión, ambos usuarios (A y B) utilizan la misma secuencia x2[m].
%--------------------------------------------------------------------------
% AMBOS USUARIOS UTILIZAN MISMA SECUENCIA, x2[m]
% Prob. Error Simb - Pe (Varianza = 0)
[PeA_4_var0,BER_A_4_var0]= ProbErrorYBER(xA_4,1,0);
[PeB_4_var0,BER_B_4_var0]= ProbErrorYBER(xB_4,1,0);

% Prob. Error Simb - Pe (Varianza = 1)
[PeA_4_var1,BER_A_4_var1]= ProbErrorYBER(xA_4,1,1);
[PeB_4_var1,BER_B_4_var1]= ProbErrorYBER(xB_4,1,1);

% Prooducto Escalar
C1=dot(x1,x2);
C2=dot(x1,x3);
C3=dot(x2,x3);
C4=dot(x2,x2);

%--------------------------------------------------------------------------
% Se obtiene las Pe y BER pero empleando en esta ocasión el canal obtenido 
% d[m].
%--------------------------------------------------------------------------
% COMBINACIONES CON CANAL d[m]
% Prob. Error Simb - Pe (Varianza = 0) 
[PeA_1_var0_canald,BER_A_1_var0_canald]= ProbErrorYBER(xA_1,d,0);
[PeB_1_var0_canald,BER_B_1_var0_canald]= ProbErrorYBER(xB_1,d,0);
[PeA_2_var0_canald,BER_A_2_var0_canald]= ProbErrorYBER(xA_2,d,0);
[PeB_2_var0_canald,BER_B_2_var0_canald]= ProbErrorYBER(xB_2,d,0);
[PeA_3_var0_canald,BER_A_3_var0_canald]= ProbErrorYBER(xA_3,d,0);
[PeB_3_var0_canald,BER_B_3_var0_canald]= ProbErrorYBER(xB_3,d,0);

% Prob. Error Simb - Pe (Varianza = 1)
[PeA_1_var1_canald,BER_A_1_var1_canald]= ProbErrorYBER(xA_1,d,1);
[PeB_1_var1_canald,BER_B_1_var1_canald]= ProbErrorYBER(xB_1,d,1);
[PeA_2_var1_canald,BER_A_2_var1_canald]= ProbErrorYBER(xA_2,d,1);
[PeB_2_var1_canald,BER_B_2_var1_canald]= ProbErrorYBER(xB_2,d,1);
[PeA_3_var1_canald,BER_A_3_var1_canald]= ProbErrorYBER(xA_3,d,1);
[PeB_3_var1_canald,BER_B_3_var1_canald]= ProbErrorYBER(xB_3,d,1);

%--------------------------------------------------------------------------
% Se obtiene la correlación de las secuencias x1[m], x2[m] y x3[m] según
% las combinaciones de usuarios.
% Se obtiene la figura a continuación para su análisis.
%--------------------------------------------------------------------------
% Correlación Secuencias
rA_comb1 = xcorr(xA_1);
rB_comb1 = xcorr(xB_1);
rA_comb2 = xcorr(xA_2);
rB_comb2 = xcorr(xB_2);
rA_comb3 = xcorr(xA_3);
rB_comb3 = xcorr(xB_3);

figure(2)
hold on
plot(rA_comb1,'b-*');
plot(rB_comb1,'r-o');
title('Funciones de correlación de las secuencias - Combinación 1');
legend('Secuencia Usu. A','Secuencia Usu. B');

figure(3)
hold on
plot(rA_comb2,'b-*');
plot(rB_comb2,'r-o');
title('Funciones de correlación de las secuencias - Combinación 2');
legend('Secuencia Usu. A','Secuencia Usu. B');

figure(4)
hold on
plot(rA_comb3,'b-*');
plot(rB_comb3,'r-o');
title('Funciones de correlación de las secuencias - Combinación 3');
legend('Secuencia Usu. A','Secuencia Usu. B');

% Producto Escalar en canal d[m]
C1_d=dot(xA_1,xB_1);
C2_d=dot(xA_2,xB_2);
C3_d=dot(xA_3,xB_3);

%--------------------------------------------------------------------------
% Se procede a la visualización de todos los parámetros obtenidos.
%--------------------------------------------------------------------------
% VISUALIZACIÓN
disp('---------------------------------------------------------------');
disp('---------- PARTE 2: CDMA. Transmisión con 2 usuarios ----------');
disp('---------------------------------------------------------------');
disp(' ');

disp(['Secuencia 1 - xA[m] = x1[m] / xB[m] = x2[m]']);
disp(['Usuario A']);
disp(['Pe con Var = 0: ',num2str(PeA_1_var0*100)]);
disp(['Pe con Var = 1: ',num2str(PeA_1_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER_A_1_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER_A_1_var1*100)]);
disp(' ');
disp(['Usuario B']);
disp(['Pe con Var = 0: ',num2str(PeB_1_var0*100)]);
disp(['Pe con Var = 1: ',num2str(PeB_1_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER_B_1_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER_B_1_var1*100)]);
disp(' ');

disp(['Secuencia 2 - xA[m] = x1[m] / xB[m] = x3[m]']);
disp(['Usuario A']);
disp(['Pe con Var = 0: ',num2str(PeA_2_var0*100)]);
disp(['Pe con Var = 1: ',num2str(PeA_2_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER_A_2_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER_A_2_var1*100)]);
disp(' ');
disp(['Usuario B']);
disp(['Pe con Var = 0: ',num2str(PeB_2_var0*100)]);
disp(['Pe con Var = 1: ',num2str(PeB_2_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER_B_2_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER_B_2_var1*100)]);
disp(' ');

disp(['Secuencia 3 - xA[m] = x2[m] / xB[m] = x3[m]']);
disp(['Usuario A']);
disp(['Pe con Var = 0: ',num2str(PeA_3_var0*100)]);
disp(['Pe con Var = 1: ',num2str(PeA_3_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER_A_3_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER_A_3_var1*100)]);
disp(' ');
disp(['Usuario B']);
disp(['Pe con Var = 0: ',num2str(PeB_3_var0*100)]);
disp(['Pe con Var = 1: ',num2str(PeB_3_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER_B_3_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER_B_3_var1*100)]);
disp(' ');




disp('--------------------------------------------------------------');
disp('--- Ambos usuarios deciden usar la misma secuencia (x2[m]) ---');
disp('--------------------------------------------------------------');

disp(['Usuario A']);
disp(['Pe con Var = 0: ',num2str(PeA_4_var0*100)]);
disp(['Pe con Var = 1: ',num2str(PeA_4_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER_A_4_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER_A_4_var1*100)]);
disp(' ');
disp(['Usuario B']);
disp(['Pe con Var = 0: ',num2str(PeB_4_var0*100)]);
disp(['Pe con Var = 1: ',num2str(PeB_4_var1*100)]);
disp(['BER con Var = 0: ',num2str(BER_B_4_var0*100)]);
disp(['BER con Var = 1: ',num2str(BER_B_4_var1*100)]);
disp(' ');

disp('---------------------------------------------------------------');
disp('---------------------- Producto Escalar -----------------------');
disp('---------------------------------------------------------------');

disp(['xA[m] = x1[m] / xB[m] = x2[m]: ',num2str(C1)]);
disp(['xA[m] = x1[m] / xB[m] = x3[m]: ',num2str(C2)]);
disp(['xA[m] = x2[m] / xB[m] = x3[m]: ',num2str(C3)]);
disp(['xA[m] = x2[m] / xB[m] = x2[m]: ',num2str(C4)]);
disp(' ');

disp('---------------------------------------------------------------');
disp('--------------------- Pe & BER con canal d --------------------');
disp('---------------------------------------------------------------');
disp(['Secuencia 1 - xA[m] = x1[m] / xB[m] = x2[m]']);
disp(['Usuario A']);
disp(['Pe con Var = 0: ',num2str(PeA_1_var0_canald*100)]);
disp(['Pe con Var = 1: ',num2str(PeA_1_var1_canald*100)]);
disp(['BER con Var = 0: ',num2str(BER_A_1_var0_canald*100)]);
disp(['BER con Var = 1: ',num2str(BER_A_1_var1_canald*100)]);
disp(' ');
disp(['Usuario B']);
disp(['Pe con Var = 0: ',num2str(PeB_1_var0_canald*100)]);
disp(['Pe con Var = 1: ',num2str(PeB_1_var1_canald*100)]);
disp(['BER con Var = 0: ',num2str(BER_B_1_var0_canald*100)]);
disp(['BER con Var = 1: ',num2str(BER_B_1_var1_canald*100)]);
disp(' ');

disp(['Secuencia 2 - xA[m] = x1[m] / xB[m] = x3[m]']);
disp(['Usuario A']);
disp(['Pe con Var = 0: ',num2str(PeA_2_var0_canald*100)]);
disp(['Pe con Var = 1: ',num2str(PeA_2_var1_canald*100)]);
disp(['BER con Var = 0: ',num2str(BER_A_2_var0_canald*100)]);
disp(['BER con Var = 1: ',num2str(BER_A_2_var1_canald*100)]);
disp(' ');
disp(['Usuario B']);
disp(['Pe con Var = 0: ',num2str(PeB_2_var0_canald*100)]);
disp(['Pe con Var = 1: ',num2str(PeB_2_var1_canald*100)]);
disp(['BER con Var = 0: ',num2str(BER_B_2_var0_canald*100)]);
disp(['BER con Var = 1: ',num2str(BER_B_2_var1_canald*100)]);
disp(' ');

disp(['Secuencia 3 - xA[m] = x2[m] / xB[m] = x3[m]']);
disp(['Usuario A']);
disp(['Pe con Var = 0: ',num2str(PeA_3_var0_canald*100)]);
disp(['Pe con Var = 1: ',num2str(PeA_3_var1_canald*100)]);
disp(['BER con Var = 0: ',num2str(BER_A_3_var0_canald*100)]);
disp(['BER con Var = 1: ',num2str(BER_A_3_var1_canald*100)]);
disp(' ');
disp(['Usuario B']);
disp(['Pe con Var = 0: ',num2str(PeB_3_var0_canald*100)]);
disp(['Pe con Var = 1: ',num2str(PeB_3_var1_canald*100)]);
disp(['BER con Var = 0: ',num2str(BER_B_3_var0_canald*100)]);
disp(['BER con Var = 1: ',num2str(BER_B_3_var1_canald*100)]);
disp(' ');

disp('---------------------------------------------------------------');
disp('-------------- Producto Escalar con canal d -------------------');
disp('---------------------------------------------------------------');

disp(['xA[m] = x1[m] / xB[m] = x2[m]: ',num2str(C1_d)]);
disp(['xA[m] = x1[m] / xB[m] = x3[m]: ',num2str(C2_d)]);
disp(['xA[m] = x2[m] / xB[m] = x3[m]: ',num2str(C3_d)]);
disp(' ');

%--------------------------------------------------------------------------
% FUNCIONES EMPLEADAS.
%--------------------------------------------------------------------------
function [Pe,BER]= ProbErrorYBER(x_num,canalD,varNoise);
    % [Pe,BER]= ProbErrorYBER(x_num,canalD,varNoise)
    %
    % Función que calcula la Pe y BER (devueltas en una matriz)a partir de
    % la secuencia de ensanchado x[m], el canal discreto equivalente a
    % tiempo de chip empleado d[m] y la varianza del ruido usada varNoise.
    %
    % x_num: secuencia de ensanchado (1 x N) 
    % canalD: canal d[m] (1 x (Kd+1))    
    % varNoise: Varianza del ruido (0 ó 1 para este caso).

    %--------------------------------------------------------------------------
    % Parámetros generales de la simulación
    % General parameters for the simulation
    %--------------------------------------------------------------------------
    Nbits=1e5;
    M=4;
    d=canalD;
    x=x_num;
    N=length(x);
    %--------------------------------------------------------------------------
    % Modulation
    %--------------------------------------------------------------------------
    B=genera_bits(Nbits);
    A=codifica_gray_pam(B,M);
    s=kron(A,x);
    %--------------------------------------------------------------------------
    % Transmission
    %--------------------------------------------------------------------------
    Kd=length(d)-1;
    v=conv([zeros(1,Kd),s],d);
    v=v(Kd+1:Kd+length(s));
    v=v+sqrt(varNoise)*randn(size(v));
    %--------------------------------------------------------------------------
    % Demodulation
    %--------------------------------------------------------------------------
    % Periodical extention of the spreading sequence
    xp=repmat(x,1,length(A));
    aux=v.*conj(xp);
    % Serial to parallel
    aux=reshape(aux,N,length(A));
    q=sum(aux);
    
    
    p=DSSS_p(x,canalD);
    % Normalización de la obsevación
    % Normalization of the observation
    qn=q/p(1);
    
    % Decisiones y decodicicación
    % Decision and decoding
    Ae=decisor_pam(qn,M);
    Be=decodifica_gray_pam(Ae,M);
    % Prestaciones / Performance
    Pe=length(find(Ae~=A))/length(A);
    BER=length(find(Be~=B))/length(B);
    
end
