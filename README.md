# aircraft-optimization-regularClass for 2019-2022 Old ruleset
SAE Aero design Regular Class Take-Off and Scoring Performance Estimation

%% Inputs %%

The code starts with importing the following paramters:

Spans ranging from 60-120 at a step of 10 inches to reduce the computation time and easily locate the
global optimum in a vast domain.

Varied Root Chords, Tip Chords and Rectangular Percentages are selected such that the respective planform falls in the
in the aspect ratio range of 3-6.

Static Thrust and Exit velocity for dynamic performance calculations.

Empty weights are allocated to each set of spans keeping in mind the increase in weights due to increment in
span and the resulting increase in tail moment arm and tail area.



%% Planform Selection %%

The solver gets inputs from the excel database having aerodynamic coefficients of multiple design points obtained from the vortex lattice method solver implemented in the matlab code (will commit soon) for a chosen airfoil S1223 RTL in this case. 

The solver then calculates the take off distance for the empty weight of that aircraft configuration
If the takeoff distance is less than 100 feet, it increments payload by 0.01 lbs in the loop until the take 
off distance comes out to be 100 feet. This increment determines the payload that can be lifted within 100ft (take off limit)

The solver then adds this payload to the empty weight and calculates the allup weight for that Planform.
After running multiple combinations of planforms , a trend of Aspect ratio VS allup and Span Vs allup is Noted
Planforms are then filtered based on the payload lifting capacity keeping in mind the aspect ratio is not too low.

Top planform configurations from each Span set are then selected on which CFD analysis is done for accurate results.
Score being the fitness function is calculated for each planform to determine the Score trend due to variation in
span since it is in the demoninator of the scoring equation.


%% Ball Configurations %% (brute force method)

Having Selected the Planform, An exhaustive search is run on varying combinations of ball stackings like horizontal, vertical and trapezoidal.

