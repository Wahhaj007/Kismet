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
            names = obj.readNames();
            names = strcat(names, ', ', playerName);
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, 'Fields', 1, names);
        end
        
        function names = readNames(obj)
            names = thingSpeakRead(obj.chID, 'ReadKey', obj.readKey, 'Fields', 1);
        end
        
        function writeScoreIdx(obj, score, idx)
            scoreIdx = {score, idx};
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, 'Fields', [2, 3], scoreIdx);
        end
        
        function [score, idx] = readScoreIdx(obj)
            read = thingSpeakRead(obj.chID, 'ReadKey', obj.readKey, 'Fields', [2, 3]);
            score = read{1};
            idx = read{2};
        end
        
        function writeGameStart(obj)
            start = obj.readGameStart();
            thingSpeakWrite(obj.chID, 'WriteKey', obj.writeKey, 'Fields', 4, ~start);
        end
        
        function gameStart = readGameStart(obj)
            gameStart = thingSpeakRead(obj.chID, 'ReadKey', obj.readKey, 'Fields', 4);
        end
    end
end

