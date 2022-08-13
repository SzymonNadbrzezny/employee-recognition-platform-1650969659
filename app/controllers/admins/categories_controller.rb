module Admins
  class CategoriesController < AdminsController
    def index
      render :index, locals: { categories: Category.all }
    end

    def new
      render :new, locals: { category: Category.new }
    end

    def edit
      render :edit, locals: { category: category }
    end

    def create
      @category = Category.new(category_params)

      if category.save
        redirect_to admins_categories_path, notice: 'Category was successfully created.'
      else
        render :new, locals: { category: category }
      end
    end

    def update
      if category.update(category_params)
        redirect_to admins_categories_path, notice: 'Category was successfully updated.'
      else
        render :edit, locals: { category: category }
      end
    end

    def destroy
      authorize [:admins, category]
      category.destroy
      redirect_to admins_categories_url, notice: 'Category was successfully destroyed.'
    end

    private

    def category
      @category ||= Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title)
    end
  end
end
