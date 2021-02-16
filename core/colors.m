classdef colors
% Enumeration - COLORS - an enumeration representing the different colors of the sides of dice in kismet
%
% Created by Koby Taswell on 2/15/2021
% Last updated by Koby Taswell on 2/15/2021
%
% Enumeration values: 
%   - Black, red, green
%
% Static Functions:
%   - checkColor(val)checks which color is visible on the die depending on the input value.
%       
    
    enumeration
        black
        red
        green
    end 
    
    methods (Static)
        function color = checkColor(val)
            % checkColor - checks which color is visible on the die depending on the input value.
            %   inputs - 
            %       val: an integer between 1-6
            %   
            %   outputs -
            %       color: the corresponding color value from the enum
            
            switch(val)
                case 1
                    color = colors.black;
                case 2 
                    color = colors.red;
                case 3
                    color = colors.green;
                case 4
                    color = colors.green;
                case 5 
                    color = colors.red;
                case 6 
                    color = colors.black;
            end
        end
    end
end