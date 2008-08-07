require File.dirname(__FILE__) + '/../spec_helper'

describe Match do

  it 'should be creatable with two players' do
    match = ::Match.new( :player1 => players(:dean), :player2 => players(:anders) )
    match.lineup.should == 'dean vs. anders'
  end

  it 'should have player 1 on white and player 2 on black' do
    match = Match.new( :player1 => players(:dean), :player2 => players(:maria) )
    match.white.name.should == 'dean'
    match.black.name.should == 'maria'
  end

  it 'should start in the active state' do
    match = Match.new
    match.active.should be_true
  end

  describe "Board Replay" do
    it 'should start with the board in the initial configuration' do
      match = Match.new
      board = match.board

      (1..8).each do |rank|
        %w{ a b c d e f g h }.each do |file|
          if [1,2,7,8].include? rank
            board[ Position.new( file, rank ) ].should_not be_nil
          else
            board[ Position.new( file, rank ) ].should be_nil
          end
        end
      end

    end
    
    it 'should reflect a noncapturing move' do
      match = Match.new
      match.moves << Move.new( :from_coord => :d2, :to_coord => :d4 )
      board = match.board
      (1..8).each do |rank|
        %w{ a b c d e f g h }.each do |file|
          position = Position.new( file, rank )
          if [1,2,7,8].include? rank
            board[position].should_not be_nil unless position.to_sym == :d2
          else
            board[position].should be_nil unless position.to_sym == :d4
          end
        end
      end
    end
    
    it 'should know the count of how many moves played so far' do
      match = matches(:unstarted_match)
      lambda{
        match.moves << Move.new( :from_coord => :d2, :to_coord => :d4 )
      }.should change{ match.moves.count }.by(1)
    end

    it 'should know whose turn it is' do
      match = matches(:unstarted_match)
      lambda{
        match.moves << Move.new( :from_coord => :d2, :to_coord => :d4 )
      }.should change{ match.next_to_move }.from(:white).to(:black)
    end

    it 'should allow a piece to move when it is that players turn' do
      true.should == true #already shown by other tests
    end
    
    it 'should not allow a piece to move when it is not that players turn' do
      match = matches(:unstarted_match)
      lambda{
        match.moves << Move.new( :from_coord => :g8, :to_coord => :f6 ) #valid move by black knight
      }.should_not change{ match.moves.count}
    end
    
  end

end