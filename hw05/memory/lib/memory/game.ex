defmodule Memory.Game do

	def new do
		%{
      		tiles: populateBoard(),
      		clickedTiles: 0,
      		seenThis: [0,0,0,0,0,0,0,0],
     		points: 0,
		}
	end

	def single_tile(l,s) do
		%{
			letter: l,
			status: s
		}
	end

	def client_view(game) do
		game
	end

    def populateBoard() do
      letterSet = ["A","B","C","D","E","F","G","H"];
      letterSet ++ letterSet 
      |>  Enum.shuffle()
      |>  Enum.map(fn x -> single_tile(x,0) end)
    end

 	def guess(game, xs, ct) do
 		Map.put(game, :clickedTiles, ct) 
 		|> Map.put(:tiles, xs)
  	end

  	def putPoints(game, st, pts) do
 		Map.put(game, :seenThis, st)
 		|> Map.put(:points, pts)
  	end

end