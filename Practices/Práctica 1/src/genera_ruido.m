function ruido = genera_ruido(L,N0,banda);
%-------------------------------------------------------------------------
% Funcion que genera una secuencia discreta aleatoria de ruido gausiano 
% y blanco con densidad espectral de potencia N0/2, bien en banda base 
% (señal real) o bien en paso banda (señal compleja)  
%
%  ruido = genera_ruido(Nmuestras,N0,banda)
%
%    Nmuestras : numero de muestras de ruido a generar
%           N0 : valor del parametro N0
%        banda : especifica si es para una modulacion en banda base ('BB')
%                o para una modulacion paso banda ('PB')
%                (por defecto banda='BB')
%
%        ruido : vector con las muestras de ruido generadas (1 x Nsimbolos)
%
%-------------------------------------------------------------------------
%
% Function that generates a random discrete sequence of white and Gaussian
% noise with power spectral density N0/2, for a baseband system (real
% signal) or for a bandpass system (complex signal)
%
%  ruido = genera_ruido(Nmuestras,N0,banda)
%
%    Nmuestras : number of samples of noise to be generated
%           N0 : value for parameter N0
%        banda : indicates if noise is used to simulate a baseband system ('BB')
%                or a bandpass system ('PB')
%                (by default, 'BB')
%
%        ruido : vector with the generated noise samples (1 x Nsimbolos)
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

if nargin < 3, banda='BB';end

if strcmp(banda,'BB')
    ruido = sqrt(N0/2)*randn(1,L);
elseif strcmp(banda,'PB')
    ruido_I = sqrt(N0/2)*randn(1,L);
    ruido_Q = sqrt(N0/2)*randn(1,L);
    ruido = ruido_I + i*ruido_Q;
else
    error('Par‡metro de banda incorrecto ...')
end
