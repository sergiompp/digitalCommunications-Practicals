function Es = calc_Es(ordenConstelacion, modulacion)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Función que determina la energia por simbolo (Es)
% 
% PARAMETROS ENTRADA:
% ordenConstelacion: Valor de M de la modulacion (Ej. 2-PAM -> M=2)
% modulacion: Si se emplea modulación de tipo 'PAM' o 'QAM' 
%
% PARAMETROS SALIDA:
% Es: Energia (J)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(modulacion,'PAM')
        Es = ((ordenConstelacion.^2)-1)/3;
    elseif strcmp(modulacion,'QAM')
        Es = (2*(ordenConstelacion - 1))/3;
    else
        error('La modulación no es ni M-PAM ni M-QAM');
    end
end
