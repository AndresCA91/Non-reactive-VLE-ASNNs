%% Code for NRTL

NP          = 100;                      % Number of datapoints for the plot
xv          = linspace(0,1,NP)';        % Molar composition vector for the plot
xv          = [xv,1-xv]';               % Molar composition matrix for the plot
T           = 283.15*ones(1,NP);        % Temperature vector for the plot

%% Fitting Parameter Assignation

betaalphas  = [0;0.45;0.45;0];          % Non-randomness factor
betaW       = [0;-0.8319;1.1896;0];     % Binary interaction parameters (Constant)
muW         = [0        0;              % Binary interaction parameters (Temperature dependent)
               0.6677   0
               0.3564   0
               0        0
               ];

%% Pure component vapor pressure (Ethanol (1) - Cyclohexane (2))

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

%% Artificial Neural Network

% Input 
x           = xv;                                                       % Eq. (11)
t           = [1000./T;0.001*T];                                        % Eq. (12)

% DNN
Ltau        = betaW + muW*t;                                            % Eq. (32)
Lalpha      = betaalphas;                                               % Eq. (33)
LW          = exp((I2*Ltau).*(-I2*Lalpha));                             % Eq. (34)
LV          = (I2*Ltau).*(I2*LW);                                       % Eq. (35)
L1          = (MA*x).*(I2*LW);                                          % Eq. (36)
L2          = (MB*L1);                                                  % Eq. (37)
L3          = (MA*x).*(I2*LV);                                          % Eq. (38) 
L4          = (MB*L3);                                                  % Eq. (39)
L5          = 1./(I1*L2);                                               % Eq. (40)
L6          = ((I1*L4).*(I1*L5));                                       % Eq. (41) - linear transfer function
L7          = (I1*L5);                                                  % Eq. (42)
L8          = (MC*LW).*(MA*L4);                                         % Eq. (43)
L9          = (MC*LV).*(MA*L2);                                         % Eq. (44)
L10         = (-I2*L8) + (I2*L9);                                       % Eq. (45)
L12         = (MA*x).*(MA*L5).*(MA*L7).*(I2*L10);                       % Eq. (49)
L13         = exp((I1*L6)+(MB*L12));                                    % Eq. (48) - activity coefficients

LR          = (I1*x).*(I1*Psat).*(I1*L11);                              % Eq. (50)
LD          = 1./(IV1'*LR);                                             % Eq. (51)
Ly          = (I1*LR).*(IV1*LD);                                        % Eq. (52)

%% Plot

hold on
plot(x(1,:),1./LD,'-r','linewidth',2)
plot(Ly(1,:),1./LD,'-b','linewidth',2)
xlabel('x_1')
ylabel('P / kPa')


