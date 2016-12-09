function OHM3d2E4D(inputname,outputname,esterror)
% OHM3d2E4D(inputname,outputname,esterror)
%
% Transforms a file in Thomas Gunther's .ohm format 
% (see www.resistivity.net) into a .srv file that can be read by E4D
%
% INPUT:
%
% inputname     Filename (including extension) of the .ohm or .dat file
% outputname    Filename for the .srv file (no extension)
% esterror      [needed if not in ohm file] estimated error in 
%               percent (e.g. 1 = 1%) 
%
% Last modified by plattner-at-alumni.ethz.ch, 12/09/2016


outputname = [outputname '.srv'];

fin=fopen(inputname,'r');
fout=fopen(outputname,'w');

% Read and write number of electrodes

strin=fgets(fin);
red=sscanf(strin,'%d%s');
nelec=red(1);
fprintf(fout,'%d    Number of electrodes\n',nelec);
electrodes=nan(nelec,3);


% Skip the next line in .ohm
strin=fgetl(fin);

% Now the electrodes
% Assuming all electrodes on the surface (flag 1). For burried electrodes:
% flag 0
for counter=1:nelec
    eleflag=1;
    strin=fgets(fin);
    red=sscanf(strin,'%f %f %f');
    fprintf(fout,'%d %f %f %f %d\n',counter+elecnumshift,red(1),red(2),red(3),eleflag);
end

% Skip a line in the .srv file
fprintf(fout,'\n');

% Now the measurements
strin=fgets(fin);
red=sscanf(strin,'%d%s');
nmeas=red(1);
fprintf(fout,'%d    Number of data\n',nmeas);

% Skip the line in the input file
strin=fgetl(fin);

for counter=1:nmeas    
    strin=fgets(fin);
    %red=sscanf(strin,'%d %d %d %d %g');
    red=sscanf(strin,'%d %d %d %d %f %f');        
    VdI=red(5);
    if esterror
        stdd=VdI*esterror/100;
    else
        stdd=red(6);
    end
    % Now write it into the outfile
    %fprintf(fout,'%d %d %d %d %d %g %g\n',...
    %    counter,red(1),red(2),red(3),red(4),VdI,stdd);
    fprintf(fout,'%d %d %d %d %d %f %f\n',...
        counter+measnumshift,red(1)+elecnumshift,red(2)+elecnumshift,red(3)+elecnumshift,red(4)+elecnumshift,VdI,stdd);
end
    

fclose(fout);
fclose(fin);


