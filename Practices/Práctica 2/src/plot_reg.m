function plot_reg(M,type)
%-------------------------------------------------------------------------
% Función que representa las líneas de las regiones de decisión  
%
% M : orden (numero de elementos del alfabeto) de la constelacion
%                M-PAM (por defecto M=2).
%
% type: tipo de constelación utilizada. 'PAM' o 'QAM'.
%            
%
% 
%
%-------------------------------------------------------------------------
%
% Function that generates decision regions
%
%
%            M : order (number of elements of the alphabet) of the M-PAM
%                constellation 
%
%            type: type of constellation. 'PAM' or 'QAM'.
%-------------------------------------------------------------------------
%
% LABORATORIO DE COMUNICACIONES DIGITALES   
%
%        Version: 1.0
%  Realizado por: Javier Céspedes Martín
%                 Departamento de Teoria de la Señal y Comunicaciones
%                 Universidad Carlos III de Madrid
%      Creacion : Noviembre 2018
%      Actualizado: Septiembre 2020
%
   if strcmp(type,'PAM')
    
   alf=-(M-2):2:M-2;
   x1=[alf;alf];
   y1=repmat([min(alf);max(alf)],1,M-1);
   line(x1,y1,'Color','red','LineStyle','--','LineWidth',3) 
        
   else
       
       alf=-(sqrt(M)-2):2:sqrt(M)-2;
       x1=[alf;alf];
       y1=repmat([min(alf)-2;max(alf)+2],1,sqrt(M)-1);
       line(x1,y1,'Color','red','LineStyle','--','LineWidth',3) 
       line(y1,x1,'Color','red','LineStyle','--','LineWidth',3)
   end