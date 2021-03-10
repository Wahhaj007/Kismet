classdef thingSpeakHandler
    %ThingSpeakHandler - Performs read and write of data in a static
    %context
    %   Detailed explanation goes here
    
    properties (Constant)
        chID = 1320909;
        readKey = 'M6SZD5XH8HFAHL8J';
        writeKey = 'CTNUG1XNFHPO73QM';
    end
    
    methods         
        function [names, idx] = writeName(obj,playerName)
            data = obj.readData();
            names = data{1};
            if(names == "")
                names = playerName;
            else
                names = strcat(names, ', ', playerName);
            end
            
            idx = length(split(names, ', '));
            
            data{1} = names;
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, data);
        end
        
        function [names, gameStart] = readNames(obj)
            data  = obj.readData();
            names = data{1};
            gameStart = data{4};
        end
        
        function writeScoreIdx(obj, score, idx)
            data = obj.readData();
            data{2} = score;
            data{3} = idx;
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, data);
        end
        
        function [score, idx, gameStart] = readScoreIdx(obj)
            data = obj.readData();
            score = data{2};
            idx = data{3};
            gameStart = data{4};
        end
        
        function writeGameStart(obj)
            data = obj.readData();
            data{4} = 1;
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, data);
        end
        
        function writeGameEnd(obj)
            data = obj.readData();
            data{4} = 0;
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, data); 
        end
    end
    
    methods (Access = private)
        function data = readData(obj)
            data = thingSpeakRead(obj.chID, 'ReadKey', obj.readKey, 'Fields', 1:4, 'OutputFormat', 'table');
            %Get columns 2-5 (everything but time stamps
            data = data(:, 2:5);
            %Return as cell array
            data = table2cell(data);
        end
    end
end

