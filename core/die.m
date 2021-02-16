classdef die 
% Class - DIE - Represents a single kismet die to be rolled. 
%   
% Created by Koby Taswell on 2/15/2021
% Last updated by Koby Taswell on 2/15/2021
%
% Properties:
%   - Value: the currently stored value rolled by function rollDie()
%   - Color: the current color based on the Value 
%
% Functions:
%   - die(): default constructor
%   - rollDie(): stores a random value between 1-6 in the instance of the Die object
%

    properties (GetAccess = public, SetAccess = protected)
        Value;
    end 
    
    properties (Dependent)
        Color;
    end
    
    %Roll functions
    methods      
        function obj = die()
            obj.Value = [];
        end
        
        function obj = rollDie(obj)
            obj.Value = randi(6);
        end
        
        function color = get.Color(obj)
            color = colors.checkColor(obj.Value);
        end
    end
end 

