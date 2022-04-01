function bits = genera_bits(Nbits);
%-------------------------------------------------------------------------
% Funcion que genera una secuencia aleatoria de Nbits bits  
%
%  bits = genera_bits(Nbits)
%
%    Nbits : numero de bits a generar
%
%     bits : vector con la secuencia de bits generados (1 x Nbits)
%-------------------------------------------------------------------------
%  
% Function that generates a random sequence of Nbits bits
%
%  bits = genera_bits(Nbits)
%
%    Nbits : number of bits to be generated
%
%     bits : vector with the sequence of generated bits (1 x Nbits)
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
% Actualizacion : octubre 2016
%
%

%bits = randint(1,Nbits);
bits = randi([0 1],1,Nbits);
