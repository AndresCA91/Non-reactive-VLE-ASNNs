function [Psat] = psatf2(T)
%% System: Ethanol (1) - Water (2)
% Parameters taken from Aspen Plus v8.6
Parameters = [
    51.03924472	97.74224472
    -5355.3	-6995.5
    0	0
    0	0
    -5.2106	-12.702
    1.24E-14	1.24E-05
    5	2
];
Psat = exp(Parameters(1,:)+Parameters(2,:)./(T'+Parameters(3,:)) + Parameters(4,:).*T' + Parameters(5,:).*log(T') + Parameters(6,:).*T'.^(Parameters(7,:)))'; % kPa
end

