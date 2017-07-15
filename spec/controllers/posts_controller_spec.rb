require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  render_views

  let(:empty_user) { create :empty_user }
  let(:reader_user) { create :reader_user }
  let(:writer_user) { create :writer_user }
  let(:admin_user) { create :admin_user }

  describe 'check authentication' do
    it '#index' do
      get :index
      expect(response).to user_signin_redirection
    end

    it '#show' do
      post = create :post, author: create(:empty_user)
      get :show, id: post.id
      expect(response).to user_signin_redirection
    end
  end

  describe 'GET #index' do
    describe 'show list of posts for any type of user' do
      def check_post_list_for(user)
        create :post, author: writer_user
        create :post, author: admin_user

        sign_in user

        get :index

        expect(Nokogiri::HTML(response.body).css('tbody tr').count).to eq 2
      end

      it('for empty_user')  { check_post_list_for empty_user  }
      it('for reader_user') { check_post_list_for reader_user }
      it('for writer_user') { check_post_list_for writer_user }
      it('for admin_user')  { check_post_list_for admin_user  }
    end
  end


  describe 'GET #show' do
    it 'empty user cannot see post' do
      post = create :post, author: writer_user
      sign_in empty_user
      expect { get :show, id: post.id }.to raise_error Pundit::NotAuthorizedError
    end

    it "author can see it's post" do
      post = create :post, author: writer_user
      sign_in writer_user
      get :show, id: post.id
      expect(response.body).to include post.title
    end

    it "writer can't read foreign post" do
      post = create :post, author: admin_user
      sign_in writer_user
      expect { get :show, id: post.id }.to raise_error Pundit::NotAuthorizedError
    end

    it "admin can see everybodie's posts" do
      post = create :post, author: writer_user
      sign_in admin_user
      get :show, id: post.id
      expect(response.body).to include post.title
    end

    it "reader can see writer's posts" do
      post = create :post, author: writer_user
      sign_in reader_user
      get :show, id: post.id
      expect(response.body).to include post.title
    end

    it "reader can see admin's posts" do
      post = create :post, author: admin_user
      sign_in reader_user
      get :show, id: post.id
      expect(response.body).to include post.title
    end
  end

  describe 'POST #update' do
    it 'empty user cannot update post' do
      post = create :post, author: writer_user
      sign_in empty_user
      expect { post(:update, id: post.id, post: {title: 'new title'}) }.to raise_error Pundit::NotAuthorizedError
    end

    it "author can update it's post" do
      post = create :post, author: writer_user
      sign_in writer_user
      post(:update, id: post.id, post: {title: 'new title'})
      expect(post.reload.title).to eq 'new title'
    end

    it "writer can't update foreign post" do
      post = create :post, author: admin_user
      sign_in writer_user
      expect { post(:update, id: post.id, post: {title: 'new title'}) }.to raise_error Pundit::NotAuthorizedError
    end

    it "admin can update everybodie's posts" do
      post = create :post, author: writer_user
      sign_in admin_user
      post(:update, id: post.id, post: {title: 'new title'})
      expect(post.reload.title).to eq 'new title'
    end

    it "reader cannot update writer's posts" do
      post = create :post, author: writer_user
      sign_in reader_user
      expect { post(:update, id: post.id, post: {title: 'new title'}) }.to raise_error Pundit::NotAuthorizedError
    end

    it "reader cannot update admin's posts" do
      post = create :post, author: admin_user
      sign_in reader_user
      expect { post(:update, id: post.id, post: {title: 'new title'}) }.to raise_error Pundit::NotAuthorizedError
    end
  end

  describe 'DELETE #destroy' do
    it 'empty user cannot delete post' do
      post = create :post, author: writer_user
      sign_in empty_user
      expect { delete :destroy, id: post.id }.to raise_error Pundit::NotAuthorizedError
    end

    it "author can delete it's post" do
      post = create :post, author: writer_user
      sign_in writer_user
      delete :destroy, id: post.id
      expect(flash[:notice]).to eq I18n.t('posts.destroy')
      expect(response).to redirect_to posts_path
    end

    it "writer can't delete foreign post" do
      post = create :post, author: admin_user
      sign_in writer_user
      expect { delete :destroy, id: post.id }.to raise_error Pundit::NotAuthorizedError
    end

    it "admin can delete everybodie's posts" do
      post = create :post, author: writer_user
      sign_in admin_user
      delete :destroy, id: post.id
      expect(flash[:notice]).to eq I18n.t('posts.destroy')
      expect(response).to redirect_to posts_path
    end

    it "reader cannot delete writer's posts" do
      post = create :post, author: writer_user
      sign_in reader_user
      expect { delete :destroy, id: post.id }.to raise_error Pundit::NotAuthorizedError
    end

    it "reader cannot delete admin's posts" do
      post = create :post, author: admin_user
      sign_in reader_user
      expect { delete :destroy, id: post.id }.to raise_error Pundit::NotAuthorizedError
    end
  end
end
