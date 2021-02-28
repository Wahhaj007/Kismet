classdef diceRoller < handle
% Class - DICEROLLER: a handle variable which collects a set of dice for kismet and allows a player to roll the dice that they wish to roll.
%    
% Created by Koby Taswell on 2/15/2021
% Last updated by Koby Taswell on 2/22/2021
%
% Properties:
%   - rollCount: the current number of rolls performed by the diceRoller
%   - dice: an array of die objects
%   - isRollable: logical value of whether or not further rolls can be made with this diceRoller
%   - diceValues: the array of dice values
%   - diceColors: the array of dice colors
%   - rollMax: the maximum number of rolls possible with this diceRoller. set at construction, immutable
%
% Functions: 
%   - rollAll(): rolls all dice in the diceRoller
%   - rollSelected(idx): rolls selected dice

    properties (GetAccess = public, SetAccess = protected)
        rollCount;
        dice = die;
    end    
   
    properties (Dependent)
        isRollable;
        diceValues; 
        diceColors;
    end
   
    properties (SetAccess = immutable)
        rollMax;
    end
    
    methods (Access = private)
        function obj = rollDice(obj,idx)
            for i = idx
                obj.dice(i) = obj.dice(i).rollDie();
            end
        end
    end
    
    methods
        function obj = diceRoller(size, rollMax, values)
            obj.rollCount = 0;
            obj.rollMax = rollMax;
            if(nargin == 3)
                for i = 1:length(values)
                    obj.dice(i) = die(values(i));
                end
            else
                obj.dice(1:size) = die();
            end
        end
        
        function obj = rollAll(obj)
            if(obj.isRollable)            
                obj = obj.rollDice(1:length(obj.dice));
                obj.rollCount = obj.rollCount + 1;
            end
        end 
        
        function obj = rollSelected(obj, idx)
            if(length(unique(idx)) == 2 && all(unique(idx) == 0:1))
                temp = 1:length(idx);
                idx = temp(logical(idx));
            end
            
            if(obj.isRollable)            
                obj = obj.rollDice(idx);
                obj.rollCount = obj.rollCount + 1;
            end
        end
        
        function isRollable = get.isRollable(obj)
            isRollable = (obj.rollCount < obj.rollMax);
        end
        
        function diceValues = get.diceValues(obj)
            diceValues = zeros(1,length(obj.dice));
            for i = 1:length(diceValues)
                if(~isempty(obj.dice(i).Value))
                    diceValues(i) = obj.dice(i).Value;
                else
                    diceValues(i) = 0;
                end
            end
        end
        
        function diceColors = get.diceColors(obj)
            for i = 1:length(obj.dice)
                    diceColors(i) = obj.dice(i).Color;
            end
        end
        
        function obj = reset(obj)
            obj.rollCount = 0;
            obj.dice(1:length(obj.dice)) = die();
        end
    end
end