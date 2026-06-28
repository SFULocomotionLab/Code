clc; clear;
close all

filename = '/Users/surabhisimha/GaTech Dropbox/Surabhi Simha/surabhi/dspace/p01.mf4';

variablenames = {'time','HostService';...
    'Velocity','Model Root/Motor Vel out [deg//s]/In1';...
    'Torque','Model Root/FP torque [Nm]/In1';...
    'Angle','Model Root/Motor Pos out [deg]/In1';...
    'visual_target_angle','Model Root/Visual Sin Target Pos Out [deg]/In1';...
    'emg_ch1','Model Root/EMG Ch1 out [V]/In1';...
    'emg_ch2','Model Root/EMG Ch2 out [V]/In1';...
    'emg_ch3','Model Root/EMG Ch3 out [V]/In1';...
    'emg_ch4','Model Root/EMG Ch4 out [V]/In1';...
    'US_sync','Model Root/Gain10/Out1';...
    'CoP_x','Model Root/CP X [mm]/In1';...
    'CoP_y','Model Root/CP Y [mm]/In1'};


% dat = mdfRead(filename);

m = mdf('yourfile.mf4');
dat = read(m);

dat = dat{1};

for v = 1:length(variablenames(:,1))
    if v == 1
        alldata.(variablenames{v,1}) = seconds(dat.(variablenames{v,2}));
    else
        alldata.(variablenames{v,1}) = dat.(variablenames{v,2});

    end
end


10hz cutoff for motor