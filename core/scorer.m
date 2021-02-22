classdef scorer
% Class - SCORER - Calculates the score to be stored in a scorecard based on input dice array. 
%   
% Created by Koby Taswell on 2/22/2021
% Last updated by Koby Taswell on 2/22/2021
%
% Properties:
%   - diceToScore: Holds the 
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
    properties (GetAccess = private, SetAccess = immutable)
        diceToScore = die;
    end
    
    properties (Dependent)
        scores;
    end
    
    methods
        %Constructor
        function obj = scorer(diceToScore)
            obj.diceToScore = diceToScore;
        end
        
        %full score array
        function scores = get.scores(obj)
            scores = [obj.scoreBasicSection(), obj.scoreTwoPair(), obj.scoreThreeKind(), ...
                obj.scoreStraight(), obj.scoreFlush(), obj.scoreFullHouse(),...
                obj.scoreFullHouseSameColor(), obj.scoreFourKind(), obj.scoreYarborough(),...
                obj.scoreKismet()];
        end
    end
    
    %Individual Scoring Sections
    methods (Access = private)
        %Basic section
        function basicSection = scoreBasicSection(obj)
            %TODO: Wahhaj
            basicSection = [];
        end
        
        function twoPairScore = scoreTwoPair(obj)
            %TODO: Edison
            twoPairScore = [];
        end
        
        function threeKindScore = scoreThreeKind(obj)
            %TODO: Edison
            threeKindScore = [];
        end
        
        function straightScore = scoreStraight(obj)
            %TODO: Edison
            straightScore = [];
        end
        
        function flushScore = scoreFlush(obj)
            %TODO: Edison
            flushScore = [];
        end
        
        function fullHouseScore = scoreFullHouse(obj)
            %TODO: Koby
            fullHouseScore = [];
        end
        
        function fullHouseSameColorScore = scoreFullHouseSameColor(obj)
            %TODO: Koby
            fullHouseSameColorScore = [];
        end
        
        function fourKindScore = scoreFourKind(obj)
            %TODO: Koby
            fourKindScore = [];
        end
        
        function yarboroughScore = scoreYarborough(obj)
            %TODO: Koby
            yarboroughScore = 0;
            for i = obj.diceToScore
                yarboroughScore = yarboroughScore + i.Value;
            end
        end
        
        function kismetScore = scoreKismet(obj)
            %TODO: Koby
            kismetScore = [];
        end
    end
end