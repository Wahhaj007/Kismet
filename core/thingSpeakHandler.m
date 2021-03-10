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
        function writeName(obj,playerName)
            data = obj.readData();
            names = data{1};
            names = strcat(names, ', ', playerName);
            data{1} = names;
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, data);
        end
        
        function names = readNames(obj)
            data  = obj.readData();
            names = data{1};
        end
        
        function writeScoreIdx(obj, score, idx)
            data = obj.readData();
            data{2} = score;
            data{3} = idx;
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, data);
        end
        
        function [score, idx] = readScoreIdx(obj)
            data = obj.readData();
            score = data{2};
            idx = data{3};
        end
        
        function writeGameStart(obj)
            data = obj.readData();
            data{4} = ~logical(data{4});
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, data);
        end
        
        function gameStart = readGameStart(obj)
            data = obj.readData();
            gameStart = data{4};
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

