function [s,color_plot]=genera_qam(N,M);
%-------------------------------------------------------------------------
%
% Funcion que genera una secuencia aleatoria de simbolos de una constelacion M-QAM  
%
%  [simbolos_qam,color_plot] = genera_qam(Nsimbolos,M)
%
%    Nsimbolos : numero de simbolos a generar
%            M : orden (numero de simbolos) de la constelacion M-QAM
%                (por defecto M=4)
%
% simbolos_qam : vector con la secuencia de simbolos generados (1 x Nsimbolos)
% color_plot   : permite representacion por colores con plot_symb
%-------------------------------------------------------------------------
%
% Function that generates a random sequence of symbols of a M-QAM
% constellation
%
% [simbolos_qam,color_plot] = genera_qam(Nsimbolos,M)
%
%    Nsimbolos : number of symbols to be generated
%            M : order (number of elements of the alphabet) of the M-QAM
%                constellation (by default, M=4)
%
% simbolos_qam : vector with the sequence of generated symbols (1 x Nsimbolos)
% color_plot   : allow colorfull representation with plot_symb

%-------------------------------------------------------------------------
%
% LABORATORIO DE COMUNICACIONES DIGITALES   
%
%        Version: 1.0
%  Realizado por: Marcelino Lazaro
%                 Departamento de Teoria de la Se�al y Comunicaciones
%                 Universidad Carlos III de Madrid
%      Creacion : octubre 2011
% Actualizacion : octubre 2016
%

if nargin < 2
    M=4;
end

m = log2(M);
m2 = log2(sqrt(M));

if (round(m2) ~= m2)
    error('Constelacion no permitida ....')
end

M2=2^(m2);
S=-(M2-1):2:(M2-1);

L=length(S);
auxr=ceil(L*rand(1,N));
auxi=ceil(L*rand(1,N));
s=S(auxr)+1i*S(auxi);
color_plot=bi2de([de2bi(auxr-1) de2bi(auxi-1)],'left-msb');