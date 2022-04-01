%
% DEMO para la modulaci�n y demodulaci�n de una se�al de espectro
% ensanchado por secuencia directa
% -------------------------------------------------------------------------
% DEMO for the modulation and demodulation of a direct sequence spread
% spectrum modulation
%
%--------------------------------------------------------------------------
%
% LABORATORIO DE COMUNICACIONES DIGITALES   
%
%        Versi�n: 1.0
%  Realizado por: Marcelino L�zaro
%                 Departamento de Teor�a de la Se�al y Comunicaciones
%                 Universidad Carlos III de Madrid
%      Creaci�n : noviembre 2018
% Actualizaci�n : noviembre 2018
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Par�metros generales de la simulaci�n
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
% Normalizaci�n de la obsevaci�n
% Normalization of the observation
qn=q/p(1);
figure(5), plot(real(qn),imag(qn),'o')
title('Diagrama de dispersi�n / Scattering diagram')
% Decisiones y decodicicaci�n
% Decision and decoding
Ae=decisor_pam(qn,M);
Be=decodifica_gray_pam(Ae,M);
% Prestaciones / Performance
Pe=length(find(Ae~=A))/length(A);
BER=length(find(Be~=B))/length(B);
disp(['Pe : ',num2str(Pe)])
disp(['BER : ',num2str(BER)])
