function Ae = decisor_qam(q,M);
%-------------------------------------------------------------------------
% Funcion que implementa el decisor para una modulacion M-QAM
%
%   Ae = decisor_pam(q,M);
%
%      q : vector de observaciones a la salida del demodulador (1 x Nsimbolos)
%      M : orden (numero de simbolos) de la constelacion M-QAM
%
%     Ae : decisiones tomadas a partir del vector q (1 x Nsimbolos)
%
%-------------------------------------------------------------------------
%
% Function implementing a detector for a M-QAM constellation
%
%   Ae = decisor_qam(q,M);
%
%      q : vector observations at the demodulator output (1 x Nsimbolos)
%      M : order (number of elements of the alphabet) of the M-QAM
%          constellation 
%
%     Ae : decisions that are taken from vector q (1 x Nsimbolos)
%
%-------------------------------------------------------------------------
%
% LABORATORIO DE COMUNICACIONES DIGITALES   
%
%        Version: 1.0
%  Realizado por: Marcelino Lazaro
%                 Departamento de Teoria de la Señal y Comunicaciones
%                 Universidad Carlos III de Madrid
%      Creacion : octubre 2011
% Actualizacion : octubre 2014
%

M2 = sqrt(M);
Ae = decisor_pam(real(q),M2)+i*decisor_pam(imag(q),M2);