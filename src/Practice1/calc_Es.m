function Es = calc_Es(ordenConstelacion, modulacion)
    if strcmp(modulacion,'PAM')
        Es = ((ordenConstelacion.^2)-1)/3;
    elseif strcmp(modulacion,'QAM')
        Es = (2*(ordenConstelacion - 1))/3;
    else
        error('La modulación no es ni M-PAM ni M-QAM');
    end
end