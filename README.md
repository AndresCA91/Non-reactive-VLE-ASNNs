# Non-reactive-VLE-ASNNs
This site contains the model implementation of the Open Access paper: "Thermodynamically Consistent Vapor-Liquid Equilibrium Modelling with Artificial Neural Networks"

This work used the Neural Network Programming hybrid modelling to transcript the Wilson and NRTL model to a Neural Network (see the publication Carranza-Abaid and Jakobsen, Comput. Chem. Eng, 2022).

1. The files named as "Structure_VLE_XXXXX" contain the VLE implementation for every model discussed in the paper
2. The file  named as "Structure_NRTL_VLEHEX" contain the VLE+HE implementation of the Dichloromethane (1) - Acetone (2)  system using the NRTL model with polynomial parametrization
3. The file  named as "Structure_NRTL_VLEHEX_ANN" contain the VLE+HE implementation of the Ethanol (1) - Water (2) system using the NRTL model with a neural network parametrization
4. Gen_Data generates the Data.mat file (Open Data.xlsx to see an example on how to arrange the data). 
5. Gen_VLEHEX_Poly generates ASNNs with polynomial parametrization for the Wilson, Wilson (H), Wilson (S), Wilson (S) (H), NRTL, NRTL (H) using the data from the Data.mat file
6. Gen_VLEHEX_ANN generates ASNNs with a neural network parametrization for the NRTL model using the data from the Data.mat file

If the user wants to utilize the optimization framework for making their own ASNN:
1. Open Data.xlsx and fill the experimental data in the Table. 
Note 1: If there is no data available (e.g., there is data for total pressure at given x,T but not for HEX, then use NaN instead of a numeric value.
Note 2: Check the units of the table.
2. Once all the cells are filled with either a numeric value or a NaN, then the table is pasted in the Gen_Data.m file.
3. Run Gen_Data.m
4. Open "Gen_VLE_Poly", "Gen_VLEHEX_Poly", "Gen_VLEHEX_NN"
5. Set-up a "Model", the number of epochs, the input vector function and the derivative of the input vector (if necessary)
6. Run any of "Gen_VLE_Poly", "Gen_VLEHEX_Poly", "Gen_VLEHEX_NN" 

Enjoy :)
