require 'test_helper'

module Guts
  class CategoriesControllerTest < ActionController::TestCase
    setup do
      @category = guts_categories :test_category
      @routes   = Engine.routes
    end

    test 'should get index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:categories)
    end

    test 'should get new' do
      get :new
      assert_response :success
    end

    test 'should create category' do
      assert_difference('Category.count') do
        post :create, category: { slug: 'cat-test', title: 'Cat Test' }
      end

      assert_redirected_to categories_path
      assert_equal 'Category was successfully created.', flash[:notice]
    end
    
    test 'should fail to create category and send back to new' do
      post :create, category: { title: '' }
      assert_template 'guts/categories/new'
    end

    test 'should show category' do
      get :show, id: @category
      assert_response :success
    end

    test 'should get edit' do
      get :edit, id: @category
      assert_response :success
    end

    test 'should update category' do
      patch :update, id: @category, category: { slug: @category.slug, title: @category.title }
      assert_redirected_to categories_path
      assert_equal 'Category was successfully updated.', flash[:notice]
    end
    
    test 'should fail to update category and send back to edit' do
      patch :update, id: @category, category: { title: '' }
      assert_template 'guts/categories/edit'
    end

    test 'should destroy category' do
      assert_difference('Category.count', -1) do
        delete :destroy, id: @category
      end

      assert_redirected_to categories_path
      assert_equal 'Category was successfully destroyed.', flash[:notice]
    end
  end
end
