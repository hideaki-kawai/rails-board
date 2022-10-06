class BoardsController < ApplicationController
    # before_actionで各メソッドの実行前にset_target_boardが呼び出される
    before_action :set_target_board, only: %i[show edit update destroy]

    def index
        # @boards = Board.all
        @boards = Board.page(params[:page])
    end
    def new
        @board = Board.new
    end

    def create
        # boardオブジェクトには作成したデータのidなどが返ってくる
        board = Board.create(board_params)
        if board.save
            flash[:notice] = "「#{board.title}」の掲示板を作成しました"
            redirect_to board
        else
            redirect_to :back, flash: {
              board: board,
              error_messages: board.errors.full_messages
            }
        end
    end

    def show
        # @board = Board.find(params[:id])
    end

    def edit
        # @board = Board.find(params[:id])
    end

    def update
        # update処理はviewを必要としないためインスタンス変数に格納する必要はない
        # board = Board.find(params[:id])
        @board.update(board_params)

        redirect_to board
    end
    
    def destroy
        # board = Board.find(params[:id])
        @board.delete

        redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板が削除されました" }
    end

    # 以下、外部から呼び出されることのないメソッド
    private

    def board_params
        params.require(:board).permit(:name, :title, :body)
    end

    # フィルター機能で処理をまとめる
    def set_target_board
        @board = Board.find(params[:id])
    end
end