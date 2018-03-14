function direction = get_direction(C_moving, C_static)
if C_moving(1) >= C_static(1)
    if C_moving(2) <= C_static(2)
        degree = 90 - atand(abs(C_moving(2) - C_static(2)) / abs(C_moving(1) - C_static(1)));      
    else
        degree = 90 + atand(abs(C_moving(2) - C_static(2)) / abs(C_moving(1) - C_static(1))); 
    end
else
    if C_moving(2) <= C_static(2)
        degree = 270 + atand(abs(C_moving(2)-C_static(2))/abs(C_moving(1) - C_static(1) )); 
    else
        degree = 270 - atand(abs(C_moving(2)-C_static(2))/abs(C_moving(1) - C_static(1) ));
    end
end

if degree < 22.5 || degree >= 337.5
    direction = 'Move Forward';
elseif degree >= 22.5 && degree < 67.5
    direction = 'Move Forward Right';
elseif degree >= 67.5 && degree < 112.5
    direction = 'Move Right';
elseif degree >= 112.5 && degree < 157.5
    direction = 'Move Backward Right';
elseif degree >= 157.5 && degree < 202.5
    direction = 'Move Backward'; 
elseif degree >= 202.5 && degree < 247.5
    direction = 'Move Backward Left';
elseif degree >= 247.5 && degree < 292.5
    direction = 'Move Left';
elseif degree >= 292.5 && degree <= 337.5
    direction = 'Move Forward Left';   
end