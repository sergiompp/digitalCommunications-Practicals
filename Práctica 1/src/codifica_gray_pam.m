function [simbolos_pam,bits_simbolo,color_plot]=codifica_gray_pam(bits,M);
%-------------------------------------------------------------------------
% Funcion que transforma una secuencia de bits en una secuencia de s�mbolos
% de una constelaci�n M-PAM siguiendo una codificaci�n de Gray
%
%  [simbolos_pam,bits_simbolo,color_plot]=codifica_gray_pam(bits,M);
%
%          bits : secuencia de bits a codificar (1 x Nbits)
%                 Nbits debe ser un multiplo entero de m=log2(M), 
%                 ya que en la asignacion binaria hay m bits por simbolo
%             M : orden (numero de simbolos) de la constelacion M-PAM
%
%  simbolos_pam : simbolos M-PAM codificados (1 x Nsimbolos)
%                 Nsimbolos = Nbits / m
%  bits_simbolo : bits asignados a cada s�mbolo (m x Nsimbolos)
%  color_plot      : permite representacion por colores con plot_symb
%
%-------------------------------------------------------------------------
%
% Function that converts a binary sequence (bits) in a sequence of symbols
% of a M-PAM constellation using Gray encoding
%
%  [simbolos_pam,bits_simbolo,color_plot]=codifica_gray_pam(bits,M);
%
%          bits : sequence of bits to be decoded (1 x Nbits)
%                 Nbits must to be an integer multiple of m=log2(M), 
%                 because in the binary assignment there are m bits per symbol
%             M : order (number of elements of the alphabet) of the M-PAM
%
%  simbolos_pam : encoded M-PAM symbols (1 x Nsimbolos)
%                 Nsimbolos = Nbits / m
%  bits_simbolo : bits assigned to each symbol (m x Nsimbolos)
%  color_plot   : allow colorfull representation with plot_symb
%-------------------------------------------------------------------------
%
% LABORATORIO DE COMUNICACIONES DIGITALES   
%
%        Version: 1.0
%  Realizado por: Marcelino Lazaro
%                 Departamento de Teoria de la Se�al y Comunicaciones
%                 Universidad Carlos III de Madrid
%      Creacion : octubre 2011
% Actualizacion : octubre 2014
% Actualizacion : octubre 2020 Javier Céspedes Martín

L=length(bits);
m=log2(M);

bits_simbolo = zeros(m,L/m);
bits_simbolo(:)=bits;
indices_bits = bi2de(transpose(bits_simbolo),'left-msb');

[color_plot,~]=bin2gray(indices_bits,'pam',M);
simbolos_pam = transpose( color_plot*2 - (M-1) );
