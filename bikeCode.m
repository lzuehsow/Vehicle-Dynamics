function res = bikeCode()
% This code finds the motor torque necessary to maintain a constant velocity tangent to a slope of angle initAngle.
% Michael Costello and Lydia Zuehsow, IEVD Fall 2017

initAngle = 0; %Degrees
wheelbase = 1.4; %Meters
tireRad = 0.4; %Meters/ The radius of a freely rotating tire.
mass = 250; %kg; Rider and Motorcycle
COMy = 0.25; %Position of center of mass, measured from the rear axel. Measured in meters.
initVel = 5; %m/s. The total velocity of the motorcycle.
aGrav = 9.8; %m/s^2; univeral gravitational acceleration constant.

Fx = findFx(mass, aGrav, initAngle)
Fy = findFy(mass, aGrav, initAngle)
moments = findMoments(Fy, COMy, Fx(2), Fx(3))
inputTorque = findInputTorque(initVel, tireRad, Fy)
end


function res = findFx(m, g, ang)
    %Finding Fx, the net force perpendicular to the slope
    %Fx = F_normalFront + F_normalBack

    F_normalF = m * g * cosd(ang)/2; %N
    F_normalB = m * g * cosd(ang)/2; %N
    Fx = (F_normalF + F_normalB) - (m * g);
    
    res = [Fx F_normalF F_normalB];
end

function res = findFy(m, g, ang)
    %Finding Fy, the net force tangent to the slope.
    
    res = m * g * sind(ang);
end

function res = findMoments(Fy, y, F_nF, F_nR)
    %With respect to the motorcycle's coordinate plane, COM is at x = 0, y = COMy.
    
    res = Fy * y + F_nF - F_nR; %Moments from drag vs moment from thrust on rear wheel.
end

function res = findInputTorque(vel, rad, Fthrust) 
    %Finds forward thrust vector of rear tire.
    
    angVel = vel * rad; %Unit conversions
    rL = vel / angVel; %radius of loaded tire.

    res = Fthrust * rL; %The force of torque is equal to the radius of loaded tire times the previously derived force of thrust.
end