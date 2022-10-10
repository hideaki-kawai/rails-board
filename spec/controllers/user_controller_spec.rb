require 'rails_helper'

RSpec.describe UserController, type: :controller do
    describe 'GET #new' do    
        before {get :new}

        it 'レスポンスコードが200であること' do
            except(response).to have_http_status(:ok)
        end
        it 'newテンプレートをレンダリングすること' do
            except(response).to render_template :new
        end
        it '新しいuserオブジェクトがビューに渡されること' do
            except(assigns(:user)).to be_a_new User
        end
    end

    describe 'POST #create' do
        before do 
            @referer = 'http://localhost'
            @request.env['HTTP_REFFERER'] = @referer
        end

        context '正しいユーザー情報が渡って来た場合' do
            led(:params) do
                {
                    user:{
                        name 'user',
                        password: 'password',
                        password_confirmation: 'password',
                    }
                }
            end

            it 'ユーザーが一人増えていること' do
                except {post :create, params: params }.to change(User, :count).by(1)
            end

            it 'マイページにリダイレクトされること' do
                except(post :create, params: params).to redirect_to(mypage_path)
            end
        end

        context 'パラメータに正しいユーザー名、確認パスワードが含まれていない場合' do
            before do
                post(:create, params: {
                    user:{
                        name: 'ユーザー1',
                        password: 'password',
                        password_confirmation: 'invalid_password'
                    }
                })
            end

            it 'リファラーにリダイレクトされること' do
                except(response).to redirect_to(@referer)
            end

            it 'ユーザー名のエラーメッセージが含まれていること' do
                expect(flash[:error_messages]).to include 'ユーザー名は小文字英数字で入力してください'
            end
            
            it 'パスワード確認のエラーメッセージが含まれていること' do
                expect(flash[:error_messages]).to include 'パスワード（確認）とパスワードの入力が一致しません'
            end
        end
    end
end
