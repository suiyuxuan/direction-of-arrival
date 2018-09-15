% Federal University of Rio Grande do Norte
% Author: Danilo Pena
% Title: Evaluation
% Description: Performace evaluation of algorithms for synthetic or real data
% data: struct of data
% angles: known angle (correct angles)
% delta: acceptable angle deviation for detection

function performance_metrics = evaluation(data, algorithms, angles, varargin)

defaultDelta = 6;
defaultRepeat = 1;

%if (nargin > 10), error('parameters number incorrect.');, end

inputs = inputParser;
addRequired(inputs, 'data');
addRequired(inputs, 'algorithms');
addRequired(inputs, 'angles');
addOptional(inputs, 'delta', defaultDelta);
addParameter(inputs, 'repeat', defaultRepeat);

parse(inputs, data, algorithms, angles, varargin{:});

data.delta = inputs.Results.delta;
data.iterations = inputs.Results.repeat;

PD = [];
RMSE = [];
absolute_error = [];

%length_snapshots = data.properties.snapshots;
%[M,N] = size(data.signal);
%L = floor(N/length_snapshots);

for n_tod = 1:length(data.type_of_data)
for n_a = 1:length(data.angles)
for n_m = 1:length(data.M)
for n_d = 1:length(data.d)
for n_f = 1:length(data.f)
for n_fs = 1:length(data.fs)
for n_n = 1:length(data.N)
for n_u = 1:length(data.u)
for n_s = 1:length(data.snapshots)

for n_noise = 1:numel(data.noise)
for n_channel = 1:numel(data.channel)


% TODO: create a variable "parameters" for the current parameters

%for i = 1:iterations
    signal = selection_data(data.type_of_data(n_tod), data.angles(n_a), data.M(n_m), data.d(n_d), data.f(n_f), data.fs(n_fs), data.N(n_n), data.u(n_u), data.noise{n_noise}, data.channel{n_channel});
    
    angle_algorithm = snapshots(data, signal, data.snapshots(n_s), data.d(n_d), data.f(n_f), data.u(n_u));

    % Detection Probability calculus
%        PD = [PD (sum((abs(angle_of_algorithm - correct_angle)) < delta))/L];
    PD = [PD (sum((abs(angle_of_algorithm - correct_angle)) < delta))];

    % Root Mean Square Error calculus
    % FIXIT: Check problem with RMSE
    RMSE = [RMSE sqrt( immse(angle_of_algorithm,correct_angle*ones(1,length(angle_of_algorithm))) )];

    % Absolute Error calculus
    absolute_error = [absolute_error mean( abs(angle_of_algorithm - correct_angle) )];

    % TODO: Variance calculus
    %variancia = var();

    % TODO: Resolution Probability
    %PR

%end

performance_metrics.algorithms(current_algorithm).RMSE = RMSE;
performance_metrics.algorithms(current_algorithm).AE = absolute_error;
performance_metrics.algorithms(current_algorithm).PD = PD;
RMSE = [];
AE = [];
PD = [];

%end
end
end
end
end
end
end
end
end
end

end
end

end
