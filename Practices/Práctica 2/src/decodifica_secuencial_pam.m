function [bits_dec,bits_simbolo_dec]=decodifica_secuencial_pam(simbolos_pam,M);
%-------------------------------------------------------------------------
% Funcion que realiza la conversion de simbolos de una constelacion M-PAM a
% bits siguiendo una asignacion binaria secuencial
%
%  bits_dec=decodifica_secuencial_pam(simbolos_pam,M)
%
%    simbolos_pam : vector de simbolos M-PAM a decodificar (1 x Nsimbolos)
%               M : orden (numero de simbolos de la constelacion)
%
%        bits_dec : bits decodificados a partir de los simbolos (1 x Nbits)
%                   Nbits = Nsimbolos x m, siendo m=log2(M) el numero de
%                   bits por simbolo de la constelacion
%
%-------------------------------------------------------------------------
%
% Function that converts symbols from a M-PAM constellation to a binary
% sequence (bits) using a sequential encoding
%
%  bits_dec=decodifica_secuencial_pam(simbolos_pam,M)
%
%    simbolos_pam : vector with M-PAM symbols (1 x Nsimbolos)
%               M : order (numero elements of the alphabet) of the M-PAM
%
%        bits_dec : decoded bits obtained from M-PAM symbols (1 x Nbits)
%                   Nbits = Nsimbolos x m, with m=log2(M) being the number
%                   of bits per symbol in the constellation
%-------------------------------------------------------------------------
%
% LABORATORIO DE COMUNICACIONES DIGITALES   
%
%        Version: 1.0
%  Realizado por: Marcelino Lazaro
%                 Departamento de Teoria de la Se–al y Comunicaciones
%                 Universidad Carlos III de Madrid
%      Creacion : octubre 2011
% Actualizacion : octubre 2014
%
%

indices_pam=(simbolos_pam+(M-1))/2;
indices_bits=indices_pam;
bits_simbolo_dec = transpose(de2bi(indices_bits,log2(M),'left-msb'));
bits_dec = transpose(bits_simbolo_dec(:));