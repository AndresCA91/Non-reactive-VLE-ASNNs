%% ANN Architecture

net                           = network;
net.numInputs                 = 3;
net.numLayers                 = 17;
net.biasConnect               = [0	0	0	0	1	0	0	0	0	0	0	0	0	1	1	1	0]';
net.inputConnect(2,1)         = 1; 
net.inputConnect(8,1)         = 1; 
net.inputConnect(11,1)        = 1; 
net.inputConnect(11,2)        = 1; 
net.inputConnect(17,3)        = 1; 
net.layerConnect              = [
0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1
1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0
1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	1	0	1	1	0	0	0	0	0	0	0	0	0	0
0	0	0	0	1	0	0	1	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0
0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0
];
net.outputConnect             = [0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0	0];
net.inputs{1}.size            = n;
net.inputs{2}.size            = n;
net.inputs{3}.size            = p;

%% Hidden layer features

net.layers{1}.size            = n^2;
net.layers{1}.transferFcn     = 'expf';
net.layers{1}.initFcn         = 'initnw';

net.layers{2}.size            = n^2;
net.layers{2}.netInputFcn     = 'netprod';
net.layers{2}.transferFcn     = 'purelin';
net.layers{2}.initFcn         = 'initnw';

net.layers{3}.size            = n;
net.layers{3}.transferFcn     = 'purelin';
net.layers{3}.initFcn         = 'initnw';

net.layers{4}.size            = n;
net.layers{4}.transferFcn     = 'netinv';
net.layers{4}.initFcn         = 'initnw';

net.layers{5}.size            = n;
net.layers{5}.transferFcn     = 'purelin';
net.layers{5}.initFcn         = 'initnw';

net.layers{6}.size            = n;
net.layers{6}.transferFcn     = 'purelin';
net.layers{6}.initFcn         = 'initnw';

net.layers{7}.size            = n^2;
net.layers{7}.transferFcn     = 'purelin';
net.layers{7}.initFcn         = 'initnw';

net.layers{8}.size            = n^2;
net.layers{8}.netInputFcn     = 'netprod';
net.layers{8}.transferFcn     = 'purelin';
net.layers{8}.initFcn         = 'initnw';

net.layers{9}.size            = n;
net.layers{9}.transferFcn     = 'purelin';
net.layers{9}.initFcn         = 'initnw'; 

net.layers{10}.size           = n;
net.layers{10}.netInputFcn    = 'netprod';
net.layers{10}.transferFcn    = 'expf';
net.layers{10}.initFcn        = 'initnw';

net.layers{11}.size           = n;
net.layers{11}.netInputFcn    = 'netprod';
net.layers{11}.transferFcn    = 'purelin';
net.layers{11}.initFcn        = 'initnw';

net.layers{12}.size           = 1;
net.layers{12}.transferFcn    = 'netinv';
net.layers{12}.initFcn        = 'initnw';

net.layers{13}.size           = n;
net.layers{13}.netInputFcn    = 'netprod';
net.layers{13}.transferFcn    = 'purelin';
net.layers{13}.initFcn        = 'initnw';

net.layers{14}.size           = 1;
net.layers{14}.transferFcn    = 'purelin';
net.layers{14}.initFcn        = 'initnw';

net.layers{15}.size           = n*(n-1);
net.layers{15}.transferFcn    = 'purelin';
net.layers{15}.initFcn        = 'initnw';

net.layers{16}.size           = n*(n-1)*p;
net.layers{16}.transferFcn    = 'purelin';
net.layers{16}.initFcn        = 'initnw';

net.layers{17}.size           = n^2*p;
net.layers{17}.netInputFcn    = 'netprod';
net.layers{17}.transferFcn    = 'purelin';
net.layers{17}.initFcn        = 'initnw';

%% Parameter fixing - Fixing of parameters according to the equation decomposition

net                           = init(net);

net.LW{1,15}                  = k2;
net.layerWeights{1,15}.learn  = false;
net.LW{1,17}                  = k4;
net.layerWeights{1,17}.learn  = false;
net.IW{2,1}                   = k6;
net.inputWeights{2,1}.learn   = false;
net.LW{2,1}                   = k5;
net.layerWeights{2,1}.learn   = false;
net.LW{3,2}                   = k7;
net.layerWeights{3,2}.learn   = false;
net.LW{4,3}                   = k8;
net.layerWeights{4,3}.learn   = false;
net.LW{5,4}                   = k8;
net.layerWeights{5,4}.learn   = false;
net.b{5}                      = -k9;
net.biases{5}.learn           = false;
net.LW{6,4}                   = k8;
net.layerWeights{6,4}.learn   = false;
net.LW{7,1}                   = -k10;
net.layerWeights{7,1}.learn   = false;
net.LW{7,3}                   = k6;
net.layerWeights{7,3}.learn   = false;
net.IW{8,1}                   = k6;
net.inputWeights{8,1}.learn   = false;
net.LW{8,4}                   = k6;
net.layerWeights{8,4}.learn   = false;
net.LW{8,6}                   = k6;
net.layerWeights{8,6}.learn   = false;
net.LW{8,7}                   = k5;
net.layerWeights{8,7}.learn   = false;
net.LW{9,5}                   = k8;
net.layerWeights{9,5}.learn   = false;
net.LW{9,8}                   = k7;
net.layerWeights{9,8}.learn   = false;
net.LW{10,9}                  = k8;
net.layerWeights{10,9}.learn  = false;
net.LW{10,14}                 = k9;
net.layerWeights{10,14}.learn = false;
net.IW{11,1}                  = k8;
net.inputWeights{11,1}.learn  = false;
net.IW{11,2}                  = k8;
net.inputWeights{11,2}.learn  = false;
net.LW{11,10}                 = k8;
net.layerWeights{11,10}.learn = false;
net.LW{12,11}                 = k9';
net.layerWeights{12,11}.learn = false;
net.LW{13,11}                 = k8;
net.layerWeights{13,11}.learn = false;
net.LW{13,12}                 = k9;
net.layerWeights{13,12}.learn = false;
net.IW{17,3}                  = k1;
net.inputWeights{17,3}.learn  = false;
net.LW{17,16}                 = k3;
net.layerWeights{17,16}.learn = false;

%% This section assigns the value of the scaling factor for the Wilson and WilsonS formulations

if strcmp(Model,'Wilson')
    if exist('alphan','var')
        net.b{14} = 1;
        net.biases{14}.learn = false;
        fprintf(['The scaling factor (alphan) was set to 1 because this is the original (unscaled) Wilson formulation \n'])
    else
        net.b{14} = 1;
        net.biases{14}.learn = false;
    end
elseif strcmp(Model,'WilsonS')
    if exist('alphan','var')
        if numel(alphan) > 1
            error('The scaling factor (alphan) in the Wilson model must be a scalar vector! \n')
        else
            net.b{14} = alphan;
            net.biases{14}.learn = false;
            fprintf(['The scaling factor (alphan) was set to ',num2str(alphan),'\n'])
        end
    end
end    
