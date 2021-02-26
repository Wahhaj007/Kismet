classdef scorer
% Class - SCORER - Calculates the score to be stored in a scorecard based on input dice array. 
%   
% Created by Koby Taswell on 2/22/2021
% Last updated by Koby Taswell on 2/22/2021
%
% Properties:
%   - diceValues: values of input dice
%   - diceColors: colors of input dice
%   - scores: 1x15 array of all scores
%
%
    properties (GetAccess = private)
        diceValues;
        diceColors;
    end
    
    properties (Dependent)
        scores;
    end
    
    methods
        %Constructor
        function obj = Scorer(values, colors)
            if(nargin == 2)
               obj.diceValues = values;
               obj.diceColors = colors;
            end
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
    %Public for testing prior to all 
    methods 
        %Basic section
        %TODO: Wahhaj
        function [aces,deuces,treys,fours,fives,sixes] = scoreBasicSection(obj)
            aces = sum(obj.diceValues(obj.diceValues == 1));
            deuces = sum(obj.diceValues(obj.diceValues == 2));
            treys = sum(obj.diceValues(obj.diceValues == 3));
            fours = sum(obj.diceValues(obj.diceValues == 4));
            fives = sum(obj.diceValues(obj.diceValues == 5));
            sixes = sum(obj.diceValues(obj.diceValues == 6));
        end   
        
        function twoPairScore = scoreTwoPair(obj)
            %TODO: Edison
            uniqueVal = unique(obj.diceValues);
            uniqueColors = unique(obj.diceColors);
            
            counts = countOccurences(uniqueVal, obj.diceValues);
            x = zeros(1, 2);
            j = 1;
            for i = 1:length(uniqueVal)
               if counts(i) == 2
                   x(j) = uniqueVal(i);
                   j = j+1;
               end
            end
            b = obj.diceColors(1);
            
           
            d= obj.diceColors(1);
            c = 1;
            for i = 1:length(obj.diceValues)
               if obj.diceValues(i) == x(c)
                   if c == 2
                       d = obj.diceColors(i);
                       break;
                   else
                       b = obj.diceColors(i);
                   end
                c = c+1;
               end
            end
            status = b == d;
       
            test = (length(uniqueVal) == 3) && (length(uniqueColors) <= 2);
            if(test && (all(sort(counts) == [1,2,2])) && status)
                twoPairScore = sum(obj.diceValues);
            else 
                twoPairScore = -1;
            end
            
        end
        
        function threeKindScore = scoreThreeKind(obj)
            %TODO: Edison
            uniqueVal = unique(obj.diceValues);
            counts = countOccurences(uniqueVal, obj.diceValues);
            
            test = ismember(3, counts);
            
            if(test)
                threeKindScore = sum(obj.diceValues);
            else
                threeKindScore = -1;
            end
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
            uniques = unique(obj.diceValues);
            
            test = (length(uniques) == 2);
            counts = sort(countOccurences(uniques, obj.diceValues));
            
            if(test && (all(counts == [2, 3])))
                fullHouseScore = sum(obj.diceValues) + 15;
            else 
                fullHouseScore = -1;
            end
        end
        
        function fullHouseSameColorScore = scoreFullHouseSameColor(obj)
            %TODO: Koby
            uniqueVal = unique(obj.diceValues);
            uniqueColors = unique(obj.diceColors);
            
            test = (length(uniqueVal) == 2) && (length(uniqueColors) == 1);
            counts = sort(countOccurences(uniqueVal, obj.diceValues));
            
            if(test && (all(counts == [2, 3])))
                fullHouseSameColorScore = sum(obj.diceValues) + 20;
            else 
                fullHouseSameColorScore = -1;
            end
        end
        
        function fourKindScore = scoreFourKind(obj)
            %TODO: Koby
            uniqueVal = unique(obj.diceValues);
            counts = countOccurences(uniqueVal, obj.diceValues);
            
            test = ismember(4, counts);
            
            if(test)
                fourKindScore = sum(obj.diceValues) + 25;
            else
                fourKindScore = -1;
            end
        end
        
        function yarboroughScore = scoreYarborough(obj)
            %TODO: Koby
            yarboroughScore = sum(obj.diceValues);
        end
        
        function kismetScore = scoreKismet(obj)
            %TODO: Koby
            uniqueVal = unique(obj.diceValues);
            
            test = (length(uniqueVal) == 1);
            
            if(test)
                kismetScore = sum(obj.diceValues) + 50;
            else
                kismetScore = -1;
            end
        end
    end
end
