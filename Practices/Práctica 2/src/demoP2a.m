%
% DEMO para la modulación y demodulación de una señal de espectro
% ensanchado por secuencia directa
% -------------------------------------------------------------------------
% DEMO for the modulation and demodulation of a direct sequence spread
% spectrum modulation
%
%--------------------------------------------------------------------------
%
% LABORATORIO DE COMUNICACIONES DIGITALES   
%
%        Versión: 1.0
%  Realizado por: Marcelino Lázaro
%                 Departamento de Teoría de la Señal y Comunicaciones
%                 Universidad Carlos III de Madrid
%      Creación : noviembre 2018
% Actualización : noviembre 2018
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Parámetros generales de la simulación
% General parameters for the simulation
%--------------------------------------------------------------------------
Nbits=1e5;
M=4;
d=[1];
x=[+1,-1,+1,-1];
N=length(x);
varNoise=0;
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
%--------------------------------------------------------------------------
% Visualization
%--------------------------------------------------------------------------
figure(1),stem(0:9,A(1:10))
title('A[n]'),xlabel('n')
grid
figure(2),stem(0:10*N-1,s(1:10*N))
title('s[m]'),xlabel('n')
figure(3),stem(0:10*N-1,v(1:10*N))
title('v[m]'),xlabel('n')
grid
figure(4),stem(0:9,q(1:10))
title('q[n]'),xlabel('n')
grid

p=DSSS_p(x,d);
disp(['x[n] : ',num2str(x)])
disp(['p[n] : ',num2str(p)])
% Normalización de la obsevación
% Normalization of the observation
qn=q/p(1);
figure(5), plot(real(qn),imag(qn),'o')
title('Diagrama de dispersión / Scattering diagram')
% Decisiones y decodicicación
% Decision and decoding
Ae=decisor_pam(qn,M);
Be=decodifica_gray_pam(Ae,M);
% Prestaciones / Performance
Pe=length(find(Ae~=A))/length(A);
BER=length(find(Be~=B))/length(B);
disp(['Pe : ',num2str(Pe)])
disp(['BER : ',num2str(BER)])
