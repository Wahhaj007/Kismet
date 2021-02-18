classdef scorecard 
% Class - SCORECARD - Represents a single player scorecard. 
%   
% Created by Wahhaj Malik on 2/17/2021
% Last updated by Wahhaj Malik on 2/17/2021
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
%   - CalculateBasicBonus(): returns a basicBonus based on the sum of
%   basicSection
%
    properties 
        name;
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
            obj.basicSection = [];
            obj.kismetSection = [];
        end
        function basicBonus = get.basicBonus(obj)
            if(sum(obj.basicSection) <= 62)
                basicBonus = 0;
            elseif(sum(obj.basicSection) >= 63 && sum(obj.basicSection) <= 70)
                basicBonus = 35;
            elseif(sum(obj.basicSection) >= 71 && sum(obj.basicSection) <= 77)
                basicBonus = 55;
            else
                basicBonus = 75;
            end
        end 
        function totalScore = get.totalScore(obj)
            totalScore = sum(obj.basicSection) + sum(obj.kismetSection) + obj.basicBonus;
        end         
    end
end
