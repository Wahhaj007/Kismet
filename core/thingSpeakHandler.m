classdef thingSpeakHandler
    %ThingSpeakHandler - Performs read and write of data to ThingSpeak for
    %dice Game
    %
    %   
    
    properties (Constant)
        chID = 1320909;
        readKey = 'M6SZD5XH8HFAHL8J';
        writeKey = 'CTNUG1XNFHPO73QM';
    end
    
    methods         
        function [names, idx] = writeName(obj,playerName)
            data = obj.readData();
            names = data{1};
            if(isa(names, 'char'))
                if(string(names) == "")
                    names = playerName;
                else
                    names = strcat(names, ',', playerName);
                end
            elseif(isa(names,'numeric') && isnan(names))
                names = playerName;
            end
            
            data{1} = names;
            names = split(names,',');
            idx = length(names);
            
            data{4} = 0;
            data{5} = 0;
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, 'Values',data);
        end
        
        function [names, round] = readNames(obj)
            data  = obj.readData();
            if(~isnan(data{1})) 
                names = split(data{1}, ',');
            else
                names = data{1};
            end
            round = data{4};
        end
        
        function writeScoreIdx(obj, score, idx,round, turn)
            data = obj.readData();
            data{2} = score;
            data{3} = idx;
            data{4} = round;
            data{5} = turn;
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey,'Values', data);
        end
        
        function [score, idx, round, turn] = readScoreIdx(obj)
            data = obj.readData();
            score = data{2};
            idx = data{3};
            round = data{4};
            turn = data{5};
        end
        
        function writeGameStart(obj)
            data = obj.readData();
            data{4} = 1;
            data{5} = 1;
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, 'Values',data);
        end
        
        function reset(obj)
            data = {'', NaN, NaN, 0, 0};
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, "Values", data);
        end
    end
    
    methods (Access = private)
        function data = readData(obj)
            data = thingSpeakRead(obj.chID, 'ReadKey', obj.readKey, 'Fields', 1:5, 'OutputFormat', 'table');
            %Get columns 2-5 (everything but time stamps
            data = data(:, 2:6);
            %Return as cell array
            data = table2cell(data);
        end
    end
end

