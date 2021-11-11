function [name] = match_fingerprints(wav_file_name)
%% Matching of Fingerprints of music/song/audio
% Includes: 
% - creates a database of known music/songs/audio Fingerprints
% - for each point in the fingerprint, matches to the closest number
% - the music/song/audio with the most matches is determined to be the
% output


%% generating fingerprint for the input wav file
fingerprint = generate_fingerprint(wav_file_name, false);


%% database creation of known music/songs/audio

% Globals
names = {'Tomar ghore - Bangla', 'She je boshe ache - Arnob'};

% Create Fingerprint 'Datbase'
tomar_ghore_fp =  load('Fingerprint Tomar ghore - Bangla.mat');
arnob_fp = load('Fingerprint She je boshe ache - Arnob.mat');

fp_database = [tomar_ghore_fp, arnob_fp];


%% Matching Fingerprints

% Set up
num_bins = length(fingerprint);
matches = zeros(1,length(fp_database));

% For each point in the fingerprint try to match from database
for i=1:num_bins
	fp_val = fingerprint(i);
	if fp_val ~= 0
		closest_match = 1;
		closest_diff = abs(fp_val - fp_database(1).bins(i));
		for j=1:length(fp_database)
			curr_value = fp_database(j).bins(i);
			diff_curr = abs(fp_val - curr_value);
			if diff_curr < closest_diff
				closest_diff = diff_curr;
				closest_match = j;
			end
		end
		matches(closest_match) = matches(closest_match) + 1;
	end
end

% Return the name of the matching bird
name = names(find(matches==max(matches)));

