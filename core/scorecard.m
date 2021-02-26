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
        basicSection;
        kismetSection;
    end
    
    properties (Dependent)
        totalScore;
        basicBonus;
    end
    
    methods
        function obj = scorecard(name)
            obj.name = name;
            obj.basicSection = ones(1,6) * -1;
            obj.kismetSection = ones(1,9) * -1;
        end
        
        function obj = setBasicSection(obj, score, idx)
            %Makes the score at that index of basic section permanently set
            %once assigned for the first time
            if(obj.basicSection(idx) == -1)
                obj.basicSection(idx) = score;
            end
        end
        
        function obj = setKismetSection(obj, score, idx)
            %Makes the score at that index of kismet section permanently set
            %once assigned for the first time
            if(obj.kismetSection(idx) == -1)
                obj.kismetSection(idx) = score;
            end
        end
        
        function basicBonus = get.basicBonus(obj)
            basic = sum(obj.basicSection(obj.basicSection ~= -1));
            
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
            temp = [obj.basicSection, obj.kismetSection];
            temp = temp(temp ~= -1);
            
            totalScore = sum(temp) + obj.basicBonus;
        end         
    end
end
