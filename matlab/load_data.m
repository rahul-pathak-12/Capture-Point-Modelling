
%% 
%   Removes Trailing \t 
%   Creates New files 
%   Will need to remove header and ensure 1:1 col to data mapping

function load_data(path)
    FILE_PATH = path;
    contents = fileread( FILE_PATH );
    fid = fopen( FILE_PATH );
    processed_filename = strcat(FILE_PATH, '.proc');
    
    fin = fopen(FILE_PATH,'r');
    fout = fopen(processed_filename,'w');
    while ~feof(fin);
      str = fgetl(fin);
      endchar = str(end);
      if endchar == '	' % this bullshit is \t for some fucked up reason
          str = str(1:end-1 );
      end
      fprintf(fout, '%s\n', str);
    end
    fclose(fin);
    fclose(fout);
end


