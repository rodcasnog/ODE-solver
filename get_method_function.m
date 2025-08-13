function method_func = get_method_function(method_name)
% Get method function handle

    switch lower(method_name)
        case {'euler', 'meuler'}
            method_func = @meuler;
        case {'eulermej', 'meulermej'}
            method_func = @meulermej;
        case {'eulermod', 'meulermod'}
            method_func = @meulermod;
        case {'rk3', 'mrk3'}
            method_func = @mrk3;
        case {'rk4', 'mrk4'}
            method_func = @mrk4;
        case {'ab2', 'mab2'}
            method_func = @mab2;
        case {'ab3', 'mab3'}
            method_func = @mab3;
        case {'ab4', 'mab4'}
            method_func = @mab4;
        case {'ab5', 'mab5'}
            method_func = @mab5;
        case {'ab2am2', 'mab2am2'}
            method_func = @mab2am2;
        case {'ab3am3', 'mab3am3'}
            method_func = @mab3am3;
        case {'ab4am4', 'mab4am4'}
            method_func = @mab4am4;
        case {'milne4', 'mmilne4'}
            method_func = @mmilne4;
        case {'mmilne4bdf5', 'mmmilne4bdf5'}
            method_func = @mmilne4bdf5;
        case {'puntomedio', 'mpuntomedio'}
            method_func = @mpuntomedio;
        otherwise
            error('Unknown method: %s', method_name);
    end
end
