%% Code for VLE-HEX NRTL (typical parametrization)

NP          = 100;                      % Number of datapoints for the plot
xv          = linspace(0,1,NP)';        % Molar composition vector for the plot
xv          = [xv,1-xv]';               % Molar composition matrix for the plot
T           = 298.15*ones(1,NP);        % Temperature vector for the plot
nT          = 2;                        % Number of stacked sigmoid functions for calculating tau

%% 

betaB1      = [0	-3.034875731	1.92631252	0	0	1.25895608	-1.847020332	0]'; 
betaC1      = [0	1.153899307	0.975303377	0	0	-0.366927627	-3.37368409	0]'; 
betaf1      = [0	6.379922747	-6.358933125	0	0	-4.033888503	3.755838649	0]'; 
betatau     = [0	0.379796504	0.349399882	0]'; 
betaalpha   = [0	1.523757226	0.189218485	0]';

%% Pure component vapor pressure (Ethanol (1) - Water (2))

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
x           = xv;                                                       % Eq. (8)
t           = (1000./T);                                                % Eq. (72)
tdT         = -1000./T.^2;                                              % Eq. (73)

% DNN
LB1         = betaB1;
LC1         = betaC1;
LB2         = (ME*t).*(MD*LB1);
LBdT        = (ME*tdT).*(MD*LB1);
Lf1         = (MD*LB2) + betaf1;
Lf2         = tanh(MD*Lf1);
Lf3         = (MD*LC1).*(MD*Lf2);
Ldf1        = sech(MD*Lf1).^2;
Ldf2        = (MD*LC1).*(MD*LBdT).*(MD*Ldf1);

Ltau        = (MF*Lf3)+betatau;                                         % Eq. (62)
taudT       = (MF*Ldf2);                                                % Eq. (63)

Lalpha      = betaalpha;                                                % Eq. (30)
LW          = exp((-I2*Lalpha).*(I2*Ltau));                             % Eq. (31)
LV          = (I2*Ltau).*(I2*LW);                                       % Eq. (32) 
L1          = (MA*x).*(I2*LW);                                          % Eq. (33)
L2          = (MB*L1);                                                  % Eq. (34)
L3          = (MA*x).*(I2*LV);                                          % Eq. (35)
L4          = (MB*L3);                                                  % Eq. (36)
L5          = 1./(I1*L2);                                               % Eq. (37)
L6          = (I1*L4).*(I1*L5);                                         % Eq. (38)
L7          = (I1*L5);                                                  % Eq. (39)
L8          = (MC*LW).*(MA*L4);                                         % Eq. (40)
L9          = (MC*LV).*(MA*L2);                                         % Eq. (41)
L10         = (-I2*L8) + (I2*L9);                                       % Eq. (42)
L12         = (MA*x).*(MA*L5).*(MA*L7).*(I2*L10);                       % Eq. (46)
L13         = exp((I1*L6)+(MB*L12));                                    % Eq. (45)

LR          = (I1*x).*(I1*Psat).*(I1*L11);                              % Eq. (50)
LD          = 1./(IV1'*LR);                                             % Eq. (51)
Ly          = (I1*LR).*(IV1*LD);                                        % Eq. (52)

LH1         = (I2*L1).*(MB'*L5).*(I2*taudT);                            % Eq. (64)
LH2         = (I2*L3).*(MB'*L5).*(I2*Lalpha);                           % Eq. (65)
LH3         = (I2*LH2).*(I2*taudT);                                     % Eq. (66)
LH4         = (MB*LH1).*(MB*LH2);                                       % Eq. (67)                                                  
LH5         = (MB*LH1) + (-MB*LH3) + (I1*LH4);                          % Eq. (68)
LH6         = (I1*x).*(I1*LH5);                                         % Eq. (69)
LH7         = (IV1'*LH6);                                               % Eq. (70)

%% Outputs

Pi          = LR;
P           = 1./LD;
y           = Ly;
HERT2       = LH7;

hold on
plot(x(1,:),-8.314*HERT2.*T.^2,'linewidth',2)
xlabel('x_1')
ylabel('H^{E} / J \cdot mol^{-1}')
