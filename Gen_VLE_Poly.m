%% Data

load('Data') % Data generated in the "Gen_Data" file

%% Fixed Model Parameters / Auxiliary Matrices

n_models                      = 1;   % Number of ASNN-based models that will be generated (only the best one will be chosen)
ShowWindow                    = 1;   % Show the neural network interface - 1 for yes and 0 for no
epochs                        = 500; % Maximum number of iterations that the optimizer will perform
Model                         = 'NRTL'; % Possible options: "Wilson", "WilsonH", "WilsonS", WilsonSH", "NRTL", "NRTLH" - The NRTL models use a symmetric non-randomness factor

%% Input Preparation

t1                            = (1000./T);       % 1/T - max(T) is used to scale the temperature values (other scaling values can be used)
tv                            = [t1];            % Preparation of the temperature dependent vector
X                             = {x';Psat';tv'};  % Preparation of the input vectors (liquid molar fraction matrix; saturation pressure of the pure component; temperature dependent vector)
Y                             = {Pi';(1./P)';y'};   % Preparation of the output vectors (partial pressure matrix, inverse of the total pressure, vapor molar fraction matrix)
W                             = {abs(1./Pi.^2)';abs(1./(1./P).^2)';abs(1./y.^2)'}; % Weights used to transform the shape of mean-square-error optimized to an average absolute relative deviation

alphan                        = 0.3;              % For Wilson-based models is the "scaling factor", for NRTL-based is the "non-randomness" factor

%% Fixed parameters required for the construction of the ASNN

n                             = size(x,2); % Number of components
p                             = size(tv,2); % Number of temperature dependent parameters
[k1,k2,k3,k4,k5,k6,k7,k8,k9,k10] = AuxMatrices_Poly(n,p); % Auxiliary matrices of fixed parameters

%% Routines that construct the ASNNs

if strcmp(Model,'Wilson') || strcmp(Model,'WilsonS')
    run('net_VLE_Wilson')
elseif strcmp(Model,'WilsonH') || strcmp(Model,'WilsonSH')
    run('net_VLE_WilsonH')
elseif strcmp(Model,'NRTL')
    run('net_VLE_NRTL') 
elseif strcmp(Model,'NRTLH')
    run('net_VLE_NRTLH') 
end

%% Training options

net.initFcn                   = 'initlay'; % Basic Matlab function for neural networks
net.performFcn                = 'mse'; % Mean square error performance function
net.trainFcn                  = 'trainlm'; % Bayesian regularization optimizer
net.divideFcn                 = 'dividerand'; % Basic Matlab function for neural networks
net.plotFcns                  = {'plotperform','plottrainstate'}; % Makes the performance plots available in the GUI
net.trainParam.showWindow     = ShowWindow; % Hide trainer 0 no, 1 yes
net.divideparam.trainRatio    = 0.8;  % Data used for training
net.divideparam.valRatio      = 0.1; % Data used for validation
net.divideparam.testRatio     = 0.1; % Data used for testing
net.trainParam.lr             = 0.01; % Learning rate
net.trainParam.epochs         = epochs; % Assignation of number of epochs

%% Training of the ASNN and AARD calculation

AARD_Best.Overall = Inf; % Initialization value of the AARD
for nm = 1:n_models
net                           = init(net); % Restart the optimizable parameters
net                           = train(net,X,Y,{},{},W); % Optimization of the "nm" model
genFunction(net,'Marko','ShowLinks','no'); % Generate a candidate function "Marko" whose AARD will be compared against the entire dataset

Y_c                           = Marko(X);     % Function evaluation
Pi_c                          = (Y_c{1})';    % Partial pressure (the AARD is not used for comparing the candidate models)
P_c                           = (1./Y_c{2})'; % Total pressure
y_c                           = (Y_c{3})';    % Vapor molar fraction

idx                           = ~isnan(Pi)  & Pi~=0; % Eliminate NaN values 
AARD.Pi                       = mean(abs((Pi(idx)-Pi_c(idx))./Pi(idx))*100); % AARD calculation
idx                           = ~isnan(P)  & P~=0; % Eliminate NaN values 
AARD.P                        = mean(abs((P(idx)-P_c(idx))./P(idx))*100); % AARD calculation
idx                           = ~isnan(y)  & y~=0; % Eliminate NaN values 
AARD.y                        = mean(abs((y(idx)-y_c(idx))./y(idx))*100); % AARD calculation
AARDs                         = 1/3*(AARD.Pi+AARD.P+mean(AARD.y)); % Average of the AARDs

if AARDs < AARD_Best.Overall
    AARD_Best.P = AARD.P;
    AARD_Best.y = mean(AARD.y);
    AARD_Best.Overall = AARDs;
    genFunction(net,['VLE_',Model],'ShowLinks','no'); % Matlab automatically transcripts the ASNN to a file with the designed name (e.g., VLE_Wilson)
    AARD_Best.Overall = AARDs; % Updates the best AARD value
end 
end
disp(AARD_Best.Overall)
