function [Psat] = psatf(T)
%% System: Ethanol (1) - Water (2)
% Parameters taken from Aspen Plus v8.6
Parameters = [
    66.39624472	44.17924472
    -7122.3	-5226.4
    0	0
    0	0
    -7.1424	-4.2278
    2.8853E-06	9.7554E-18
    2	6
    159.05	279.69
    514	553.8
];
Psat = exp(Parameters(1,:)+Parameters(2,:)./(T'+Parameters(3,:)) + Parameters(4,:).*T' + Parameters(5,:).*log(T') + Parameters(6,:).*T'.^(Parameters(7,:)))'; % kPa
end

