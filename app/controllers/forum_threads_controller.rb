class ForumThreadsController < ApplicationController
  before_action :set_forum_thread, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:new, :create]
 
 #untuk search
 autocomplete :ForumThread, :title, :full => true
  # GET /forum_threads
  # GET /forum_threads.json
  def index
    
    if params[:search]
      @forum_threads = ForumThread.title_search("%#{params[:search]}%").order(sticky_order: :asc).order(id: :desc).paginate(per_page: 3,page: params[:page])
    else
      @forum_threads = ForumThread.order(sticky_order: :asc).order(id: :desc).paginate(per_page: 3,page: params[:page])
    end  
  end

  # GET /forum_threads/1
  # GET /forum_threads/1.json
  def show
    @thread = ForumThread.friendly.find(params[:id])
    @post = ForumPost.new
    @posts = @thread.forum_posts.paginate(per_page: 2, page: params[:page])
  end

  # GET /forum_threads/new
  def new
    @forum_thread = ForumThread.new
    @post = ForumPost.new

  end

  # GET /forum_threads/1/edit
  def edit

    @thread = ForumThread.friendly.find(params[:id])
    # authorize akan mencari ForumThreadPolicy bagian edit
    authorize @thread
  end

  # POST /forum_threads
  # POST /forum_threads.json
  def create
    @forum_thread = ForumThread.new(forum_thread_params)
    # menggunakan current user
    @forum_thread.user = current_user
    respond_to do |format|
      if @forum_thread.save
        format.html { redirect_to @forum_thread, notice: 'Forum thread was successfully created.' }
        format.json { render :show, status: :created, location: @forum_thread }
      else
        
        format.html { render :new }
        format.json { render json: @forum_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forum_threads/1
  # PATCH/PUT /forum_threads/1.json
  def update
    respond_to do |format|
      if @forum_thread.update(forum_thread_params)
        format.html { redirect_to @forum_thread, notice: 'Forum thread was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum_thread }
      else
        format.html { render :edit }
        format.json { render json: @forum_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_threads/1
  # DELETE /forum_threads/1.json
  def destroy
    @forum_thread = ForumThread.friendly.find(params[:id])
    authorize @forum_thread

    @forum_thread.destroy

    redirect_to root_path, notice:'Forum thread was successfully destroyed.'
    # respond_to do |format|
    #   format.html { redirect_to forum_threads_url, notice: 'Forum thread was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end


# pinit
  def pinit
      # find params id terlebih dahulu
      @thread = ForumThread.friendly.find(params[:id])
      @thread.pinit!

      redirect_to root_path
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum_thread
      @forum_thread = ForumThread.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forum_thread_params
      params.require(:forum_thread).permit(:title, :content, :sticky_order, :user_id)
    end
end
