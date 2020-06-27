module Manager
  class CategoriesController < Manager::BaseController
    before_action :find_category, except: [:index, :new, :create]

    def index
      @categories = Category.all.page(params[:page]).per(10)
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new category_params
      if @category.save
        flash[:success] = "Category was successfully created."
        redirect_to manager_categories_path
      else
        flash[:danger] = "Error"
        render "new"
      end
    end

    def edit
    end

    def update
      if @category.update_attributes category_params
        flash[:success] = "Category was successfully updated."
        redirect_to manager_categories_path
      else
        flash[:danger] = "Error"
        render "edit"
      end
    end

    def destroy
      @category.destroy
      flash[:success] = "Category was removed"
      redirect_to manager_categories_path
    end

    private 
      def category_params
        params.require(:category).permit(:name)
      end

      def find_category
        @category = Category.find params[:id]
      end
    end
  end
