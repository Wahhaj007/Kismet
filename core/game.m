classdef game
% GAME Class - tracks turn, round and scores as input by a scorer from
% a diceroll. Stores all player scorecards and can determine the winner
% once over
% 
%
% Created by Koby Taswell on 2/27/2021
% Last updated by Koby Taswell on 3/11/2021
%
% Properties
%   players - the list of scorecard objects of players in the game
%   round - the current round in a game, once the game has started, equals 1
%   turn - the index of the player whose turn it currently is
%   currentPlayer - scorecard of the current turn's player
%   currentTopScore - idx of the player with the highest score
%   allNames - gets Nx1 array  of all player names where N is number of players
%   allScores - gets Nx17 array all player scores where N is number of players
%   recentlyAddedScore - score and index of the most recently input score
%
%Functions
%   addPlayers(players) - adds a set of player objects, type scorecard, to the list of players
%   startGame() - starts the game, sets turn and round equal to 1
%   
 
    properties (SetAccess = protected)
        players = scorecard;
        round;
        turn;
    end
    
    properties (Constant)
        maxRound = 15;
    end
    
    properties (Dependent)
        currentPlayer;
        currentTopScore;
        allNames;
        allScores;
        recentlyAddedScore; %Recently added score is in the format [score, idx]
    end
    
    methods
        function obj = game(players)
            if(nargin == 1)
                obj.players = players;
            end
            obj.round = 0;
            obj.turn = 0;
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
        
        function names = get.allNames(obj)
            names = [];
            
            for i = obj.players
                names = [names; i.name];
            end
        end
        
        function recentlyAddedScore = get.recentlyAddedScore(obj)
            idx = obj.turn - 1;
            rnd = obj.round;
            if(idx == 0)
                idx = length(obj.players);
                rnd = obj.round - 1;
            end
            
            recentlyAddedScore = [obj.players(idx).scores(obj.players(idx).lastScoreIdx),  obj.players(idx).lastScoreIdx, rnd, idx];
        end
        
        function obj = addPlayers(obj, players)
            if(all(class(players) == 'scorecard') && obj.round == 0)
                if(obj.players(1).name == "")
                    obj.players = players;
                else
                    obj.players = [obj.players, players];
                end
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