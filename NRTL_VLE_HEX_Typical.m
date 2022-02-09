%% Code for VLE-HEX NRTL (typical parametrization)

NP          = 100;                      % Number of datapoints for the plot
xv          = linspace(0,1,NP)';        % Molar composition vector for the plot
xv          = [xv,1-xv]';               % Molar composition matrix for the plot
T           = 313.15*ones(1,NP);        % Temperature vector for the plot
nT          = 2;                        % Number of stacked sigmoid functions for calculating tau

%% 

betatau     = [0;-1;1;0]; 
betaB1      = [0;1;-1;0]; 
betaC1      = [0;0;0;0]; 
betaalpha   = [0; 0.3; 0.3; 0];

%% Pure component vapor pressure

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

%% Auxiliary Matrices

nc          = size(xv,1);
I1          = eye(nc);
I2          = eye(nc^2);
IV1         = ones(nc,1);
IV2         = ones(nc^2,1);
MA          = repelem(I1,nc,1);
MB          = repmat(I1,1,nc);
MC          = zeros(nc^2);
for k = 1:nc
    MC(nc^3*(k-1)+k:nc^2+nc:nc^3*k) = 1;
end
MD          = eye(nc^2*nT);
ME          = ones(nc^2*nT,1);
MF          = repmat(I2,1,nT);

%% NRTL - Deep Neural Network

% Inputs
x           = xv;                                                       % Eq. (11)
tB          = (1000./T);                                                % Eq. (56)
tBdT        = -1000./T.^2;                                              % Eq. (57)
tC          = 1E-2*(T);                                                 % Eq. (58)
tCdT        = (1E-2*(T./T));                                            % Eq. (59)

% DNN
LB1         = betaB1;                                                   % Eq. (60)
LB2         = (I2*LB1).*(IV2*tB);                                       % Eq. (61)
LBdT        = (I2*LB1).*(IV2*tBdT);                                     % Eq. (62)

LC1         = betaC1;                                                   % Eq. (63)
LC2         = (I2*LC1).*(IV2*tC);                                       % Eq. (64)
LCdT        = (I2*LC1).*(IV2*tCdT);                                     % Eq. (65)

Ltau        = (I2*LB2+I2*LC2)+betatau;                                  % Eq. (66)
taudT       = (I2*LBdT+I2*LCdT);                                        % Eq. (67)

Lalpha      = betaalpha;                                                % Eq. (33)
LW          = exp((-I2*Lalpha).*(I2*Ltau));                             % Eq. (34)
LV          = (I2*Ltau).*(I2*LW);                                       % Eq. (35) 
L1          = (MA*x).*(I2*LW);                                          % Eq. (36)
L2          = (MB*L1);                                                  % Eq. (37)
L3          = (MA*x).*(I2*LV);                                          % Eq. (38)
L4          = (MB*L3);                                                  % Eq. (39)
L5          = 1./(I1*L2);                                               % Eq. (40)
L6          = (I1*L4).*(I1*L5);                                         % Eq. (41)
L7          = (I1*L5);                                                  % Eq. (42)
L8          = (MC*LW).*(MA*L4);                                         % Eq. (43)
L9          = (MC*LV).*(MA*L2);                                         % Eq. (44)
L10         = (-I2*L8) + (I2*L9);                                       % Eq. (45)
L12         = (MA*x).*(MA*L5).*(MA*L7).*(I2*L10);                       % Eq. (49)
L13         = exp((I1*L6)+(MB*L12));                                    % Eq. (48)

LR          = (I1*x).*(I1*Psat).*(I1*L11);                              % Eq. (50)
LD          = 1./(IV1'*LR);                                             % Eq. (51)
Ly          = (I1*LR).*(IV1*LD);                                        % Eq. (52)

LH1         = (I2*L1).*(MB'*L5).*(I2*taudT);                            % Eq. (68)
LH2         = (I2*L3).*(MB'*L5).*(I2*Lalpha);                           % Eq. (69)
LH3         = (I2*LH2).*(I2*taudT);                                     % Eq. (70)
LH4         = (MB*LH1).*(MB*LH2);                                       % Eq. (71)                                                  
LH5         = (MB*LH1) + (-MB*LH3) + (I1*LH4);                          % Eq. (72)
LH6         = (I1*x).*(I1*LH5);                                         % Eq. (73)
LH7         = (IV1'*LH6);                                               % Eq. (74)

%% Outputs

Pi          = LR;
P           = 1./LD;
y           = Ly;
HERT2       = LH7;

hold on
plot(x(1,:),-8.314*HERT2.*T.^2,'linewidth',2)
xlabel('x_1')
ylabel('H^{E} / J \cdot mol^{-1}')

