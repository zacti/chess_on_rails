require File.dirname(__FILE__) + '/../test_helper'

class BoardControllerTest < ActionController::TestCase
	# Replace this with your real tests.
	def test_truth
		assert true
	end
	
	def test_knows_what_piece_is_on_a_square
		assert_nil matches(:unstarted_match).initial_board.piece_at("d4")
		p1 = matches(:unstarted_match).initial_board.piece_at("b2")
		assert_not_nil p1
		
		assert_equal :b_pawn, p1.type
		assert_equal :white, p1.side
	end
	
	def test_can_refer_to_as_many_boards_as_there_are_moves
		match = matches(:unstarted_match)
		assert_not_nil match.initial_board
		
		#todo - get equality working at this level...
		#assert_equal match.initial_board, match.board(0)
		#assert_equal match.board(0), match.board #current board
		
		match.moves << Move.new( :from_coord=>"d2", :to_coord=>"d4", :notation=>"d4", :moved_by=>1 )
		match.save!

		#assert_not_equal match.board(0), match.board #current board
		#assert_equal match.board(1), match.board
				
		#assert_raises ArgumentError do
		#	b = match.board(2)	
		#end
		
	end
#	def test_detects_moved_piece
#		match = matches(:unstarted_match)
#		assert_not_nil match.initial_board
#		assert_not_equal 0, match.initial_board.num_active_pieces
#		
#		assert_not_nil match.initial_board.piece_at("d4")
#		match.moves << Move.new( :from_coord=>"d2", :to_coord=>"d4", :notation=>"d4", :moved_by=>1 )
#		match.save!
#		
#		#		#todo: this is the next test to pass after enabling board replay
#		assert_not_nil match.board.piece_at("d4")
#		
#	end
	
	#should be functional test
	def test_nodoc_can_put_new_move_and_get_board_back
		assert true
	end
	def test_nodoc_rejects_new_move_if_destination_occupied_by_piece_from_same_side
		assert true
	end
	def test_nodoc_rejects_new_move_if_beyond_range_of_board
		assert true
	end
	def test_nodoc_rejects_new_move_if_not_in_possible_moves_list
		assert true
	end
	def test_nodoc_rejects_new_move_if_places_own_king_in_check
		assert true
	end
end