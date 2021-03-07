classdef game
    properties (SetAccess = protected)
        players = scorecard;
        round;
        turn;
        localPlayer;
    end
    
    properties (Constant)
        maxRound = 15;
    end
    
    properties (Dependent)
        currentPlayer;
        currentTopScore;
        allScores;
    end
    
    methods
        function obj = game(players)
            if(nargin == 1)
                obj.players = players;
            end
            obj.round = 0;
            obj.turn = 0;
        end
        
        function obj = setLocalPlayer(obj, playerName)            
            names = [];
            
            for i = obj.Players
                names = [names, i.name];
            end
            
            %If multiple people have the same name, only get the first
            %person with the name
            idx = strcmp(playerName, names); 
            idx = find(idx, 1, 'first');
            
            obj.localPlayer = idx;
        end
        
        function player = get.currentPlayer(obj)
            player = obj.players(obj.turn);
        end
        
        function playerIdx = get.currentTopScore(obj)
            if(~isempty(obj.players))
                scores = zeros(1, length(obj.players));
                for i = 1:length(scores)
                    scores(i) = obj.players(i).totalScore;
                end
                
                [scores, idx] = sort(scores);
                playerIdx = idx(end);
            else
                playerIdx = [];
            end
            
            
        end
        
        function scores = get.allScores(obj)
            for i = 1:length(obj.players)
                scores(i,:) = obj.players(i).fullCard;
            end
        end
        
        function obj = addPlayer(obj, player)
            if(all(class(player) == 'scorecard') && obj.round == 0)
                obj.players(length(obj.players) + 1) = player;
            end
        end
        
        function obj = startGame(obj)
            obj.round = 1;
            obj.turn = 1;
        end
        
        function obj = setScore(obj, score, scoreIdx)
            if(obj.round ~= 0 && obj.round <= obj.maxRound)
                obj.players(obj.turn) = obj.players(obj.turn).inputScores(score, scoreIdx);
                obj = obj.iterateTurn();
            end
        end
        
        function obj = iterateTurn(obj)
            obj.turn = obj.turn+1;
            if(obj.turn > length(obj.players))
                obj.turn = 1;
                obj.round = obj.round + 1;
            end
        end
    end
end