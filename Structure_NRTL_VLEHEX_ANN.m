clear
clc

%% Fitting Parameter Assignation

% NRTL parameters for Ethanol (1) - Water (2) 
alpha0 = [1.6830;0.1951]; % alpha
A0 = [0.8750;5.4679;-0.0039;6.9744]; % Binary interaction parameters (Constant)
B0 = [1.5013;-2.1492;-0.4357;-2.1980]; % Binary interaction parameters (T-dependent)
C0 = [1.1558;-0.8690;3.8923;-0.5611]; % Binary interaction parameters (Constant)
D0 = [1.5563;2.5896]; % Binary interaction parameters (T-dependent)

%% Fixed Model Parameters / Auxiliary Matrices

n  = 2; % Number of components
p  = 1; % Number of temperature dependent parameters
q  = 2; % Number of stacked sigmoid functions
[k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16] = AuxMatrices_NN(n,p,q); % Auxiliary matrices

%% Input preparation

NP = 100; % Number of datapoints for the plot
x  = linspace(0,1,NP)'; % Molar composition vector for the plot
x  = [x,1-x]'; % Input vector #1
T  = 393.15*ones(1,NP); % Temperature values - Between 273 and 393
t  = [1000./T]; % Input vector # 2
psat = psatf2(T); % Input vector #3 (Table S1)
tdT = [-1000./T.^2]; % Input vector # 4

%% Algorithmically Structure Neural Network (ASNN)

alpha = alpha0; % Eq. 30
A   = A0; 
B   = B0; %
C   = C0;
D   = D0;

BT  = (k11*t).*(k12*B); 
BdT = (k11*tdT).*(k12*B); 
Q1  = (k13*A)+(k14*BT);
Q2  = tanh(k15*Q1);
Q3  = (k13*C).*(k15*Q2);
Q4  = sech(k15*Q1).^2;
Q5  = (k13*C).*(k14*BdT).*(k15*Q4);
tau = (k16*Q3)+(k2*D);
taudT = (k16*Q5);

W   = exp((-k2*alpha).*(k5*tau)); % Eq. 35
V   = (k5*tau).*(k5*W); % Eq. 36
L1  = (k6*x).*(k5*W); % Eq. 37
L2  = (k7*L1); % Eq. 38
L3  = (k6*x).*(k5*V); % Eq. 39
L4  = (k7*L3); % Eq. 40
L5  = 1./(k8*L2); % Eq. 41
L6  = (k8*L4).*(k8*L5); % Eq. 42
L7  = (k8*L5); % Eq. 43
L8  = (k10*W).*(k6*L4); % Eq. 44
L9  = (k10*V).*(k6*L2); % Eq. 45
L10 = (-k5*L8) + (k5*L9); % Eq. 46
L12 = (k6*x).*(k6*L5).*(k6*L7).*(k5*L10); % Eq. 50
L13 = exp((k8*L6)+(k7*L12)); % Eq. 49

LR  = (k8*x).*(k8*psat).*(k8*L13); % Eq. 78
LD  = 1./(k9'*LR); % Eq. 79
Ly  = (k8*LR).*(k9*LD); % Eq. 80

H1  = (k5*L1).*(k7'*L5).*(k5*taudT); % Eq. 54 
H2  = (k5*L3).*(k7'*L5).*(k2*alpha); % Eq. 55 
H3  = (k5*H2).*(k5*taudT); % Eq. 56 
H4  = (k7*H1).*(k7*H2); % Eq. 57 
H5  = k7*H1-k7*H3+k8*H4; % Eq. 58 
H6  = (k8*x).*(k8*H5); % Eq. 59 
H7  = (k9'*H6); % Eq. 60 

%% Thermodynamic Functions

GEX = (8.314*sum(x.*L4).*T.^2)'; % Excess molar Gibbs energy
pi  = LR'; % Partial pressure
P   = 1./LD'; % Total pressure
y   = Ly'; % Vapor molar fractions
HEX = 8.314*H7.*T.^2; % Excess enthalpy in J/mol

%% P-xy plot

figure(1)
hold on
box on
A = plot(x(1,:),1./LD,'-r','linewidth',2);
B = plot(Ly(1,:),1./LD,'-b','linewidth',2);
xlabel('{\itx_1},{\ity_1}')
ylabel('{\itP} / kPa')
legend([A,B],'Liquid phase', 'Vapor phase','Location','Southeast','NumColumns',1)
set(gca,'FontSize',18)
set(gca,'linewidth',1.5)

%% HEX plot

figure(2)
hold on
box on
A = plot(x(1,:),HEX,'-','linewidth',2);
xlabel('{\itx_1}')
ylabel('{\itH}^E / J \cdot mol^{-1}')
set(gca,'FontSize',18)
set(gca,'linewidth',1.5)