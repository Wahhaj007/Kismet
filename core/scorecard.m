classdef scorecard 
% Class - SCORECARD - Represents a single player scorecard. 
%   
% Created by Wahhaj Malik on 2/17/2021
% Last updated by Koby Taswell on 2/22/2021
%
% Properties:
%   - name: Holds the name of the player
%   - basicSection: Holds the basic section scores for each category
%   - basicBonus: The added bonus scores based on sum of basicSection
%   - kismetSection: Holds the kismet section scores for each category
%   - totalScore: Calculates the sum of all individual scores
%
% Functions:
%   - scorecard(): default constructor
%   - setBasicSection(score,idx): attempts to set the score 
%   - CalculateBasicBonus(): returns a basicBonus based on the sum of
%   basicSection
%
    properties 
        name;
    end
    
    properties(SetAccess = protected)
        scores;
    end
    
    properties (Dependent)
        totalScore;
        basicBonus;
        fullCard;
    end
    
    methods
        function obj = scorecard(name)
            if(nargin == 1)
                obj.name = name;
            else
                obj.name = "";
            end
             obj.scores = ones(1,15) * -1;
        end
        
        function obj = inputScores(obj, scoresIn, idx)
            scoresIn = scoresIn(end:-1:1);
            idx = idx(end:-1:1);
            
            for i = 1:15
                [obj, test] = setScore(obj, scoresIn(i), idx(i));
                if(test)
                    break;
                elseif(scoresIn(i) == -1)
                    idx = findLowestEmptyScore(obj);
                    obj.scores(idx) = 0;
                    break;
                end
            end
        end
        
        function basicBonus = get.basicBonus(obj)
            
            basic = obj.scores(1:6);
            basic = sum(basic(basic ~= -1));
            
            if(basic <= 62)
                basicBonus = 0;
            elseif(basic >= 63 && basic <= 70)
                basicBonus = 35;
            elseif(basic >= 71 && basic <= 77)
                basicBonus = 55;
            else
                basicBonus = 75;
            end
        end 
        
        function totalScore = get.totalScore(obj)
            temp = obj.scores(obj.scores ~= -1);
            
            totalScore = sum(temp) + obj.basicBonus;
        end    
        
        function fullCard = get.fullCard(obj)
            fullCard = strings(1,17);
            idx = obj.scores ~= -1;
            vals = 1:length(idx);
            idx = vals(idx);
            
            for i = idx
                fullCard(i) = num2str(obj.scores(i));
            end
            
            fullCard(16) = num2str(obj.basicBonus);
            fullCard(17) = num2str(obj.totalScore);
        end
    end
    
    
    
    methods(Access = private)
        function [obj, log] = setScore(obj, score, idx)
            %Makes the score at that index of basic section permanently set
            %once assigned for the first time
            if(obj.scores(idx) == -1 && score ~= -1)
                obj.scores(idx) = score;
                log = true;
            else
                log = false;
            end
        end
        
        function idx = findLowestEmptyScore(obj)
            [Lia, Locb] = ismember(-1, obj.scores);
            idx = min(Locb);            
        end
    end
end
