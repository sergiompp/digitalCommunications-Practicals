function [s,color_plot]=genera_pam(N,M);
%-------------------------------------------------------------------------
% Funcion que genera una secuencia aleatoria de simbolos de una 
% constelacion M-PAM  
%
%  [simbolos_pam,color_plot] = genera_pam(Nsimbolos,M)
%
%    Nsimbolos : numero de simbolos a generar
%            M : orden (numero de elementos del alfabeto) de la constelacion
%                M-PAM (por defecto M=2)
%
% simbolos_pam : vector con la secuencia de simbolos generados (1 x Nsimbolos)
% color_plot   : permite representacion por colores con plot_symb
%-------------------------------------------------------------------------
%
% Function that generates a random sequence of symbols of a M-PAM
% constellation
%
% [simbolos_pam,color_plot] = genera_pam(Nsimbolos,M)
%
%    Nsimbolos : number of symbols to be generated
%            M : order (number of elements of the alphabet) of the M-PAM
%                constellation (by default, M=2)
%
% simbolos_pam : vector with the sequence of generated symbols (1 x Nsimbolos)
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
% Actualizacion : octubre 2020 Javier Céspedes Martín



if nargin < 2
    M=2;
end
m=log2(M);
if (round(m) ~= m)
    error('Tamano incorrecto de la constelaci�n ...')
end

Alfabeto = -(M-1):2:(M-1);


L=length(Alfabeto);
auxr=ceil(L*rand(1,N));
s=Alfabeto(auxr);
color_plot=auxr-1;