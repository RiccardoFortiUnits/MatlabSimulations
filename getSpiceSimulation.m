function [x, y] = getSpiceSimulation(NetFilePath, netLable, varargin)
    ltSpiceFilePath = "C:\Users\lastline\AppData\Local\Programs\ADI\LTspice\LTspice.exe";
    
    [folder, name, ~] = fileparts(NetFilePath);
    rawFilePath = fullfile(folder, name) + ".raw";

    if ~isempty(varargin)
        try
            text = fileread(NetFilePath);
        catch
            ascFilePath = fullfile(folder, name) + ".asc";
            if(isfile(ascFilePath))
                system('"' + ltSpiceFilePath + '" -netlist "' + ascFilePath + '"');
                text = fileread(NetFilePath);
            else
                print("files " + fullfile(folder, name) + "not found!!!");
            end
        end
        finalTextPosition = strfind(text, ".backanno");%let's add undefined parameter commands here
        finalPart = text(finalTextPosition:end);
        text = text(1:finalTextPosition - 1);
        for i = 1:2:length(varargin)
            varName = char(string(varargin{i}));
            varValue = char(string(varargin{i + 1}));
            paramPosition = strfind(text, ".param " + varName);
            if isempty(paramPosition)
                %let's add a new line to the net
                text = [text '.param ' varName ' = ' varValue char(0x0D) newline];
            else
                paramPosition = paramPosition(end);
                equal_idx = strfind(text(paramPosition:end), "=");
                equal_idx = equal_idx(1);
                eol_idx = strfind(text(paramPosition:end), char(0x0D));
                if isempty(eol_idx)
                    eol_idx = strfind(text(paramPosition:end), newline);
                end
                eol_idx = eol_idx(1);
                text = [text(1:paramPosition+equal_idx-1), ' ', varValue, ' ', text(paramPosition+eol_idx-1:end)];
            end
        end
    
        text = [text, finalPart];
    
        fileId = fopen(NetFilePath, 'w');
        fwrite(fileId, text);
        fclose(fileId);
    end



    system('"' + ltSpiceFilePath + '" -b "' + NetFilePath + '"');
    rawData = LTspice2Matlab(rawFilePath);
    
    if isfield(rawData, 'freq_vect')
        x = rawData.freq_vect;
    elseif isfield(rawData, 'time_vect')
        x = rawData.time_vect;
    end
    y = rawData.variable_mat(find(ismember(string(rawData.variable_name_list), netLable)), :);

    % % system('taskkill /IM "LTspice.exe"');
end