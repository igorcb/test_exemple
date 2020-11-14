require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  
  context "GET #index" do
    #let!(:events) { create_list(:event, 5) }
    
    it "should success and render to index page" do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it "should events empty" do
      get :index
      expect(assigns(:events)).to be_nil
    end
        
    it "should have list events" do
      create(:event)
      get :index
      expect(assigns(:events)).not_to eq be_nil
    end
  
  end

  context "GET #show" do
    let(:event) { create(:event) }
    
    it "should success and render to edit page" do
      get :show, params: { id: event.id}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)   
    end

    it "where have id" do
      get :show, params: { id: event.id}
      expect(assigns(:event)).to be_a(Event)
      expect(assigns(:event)).to eq(event)
    end
  end

  context "GET #new" do
    it "should success and render to new page" do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)   
    end

    it "should new event" do
      get :new
      expect(assigns(:event)).to be_a(Event)
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  context "POST #create" do
    let!(:params) {
      { what: "Aut fugiat fugit animi eos." }
    }

    it "create a new event" do
      post :create, params: { event: params } 
      expect(flash[:notice]).to eq("Event create successfull.")  
      expect(response).to redirect_to(action: :show, id: assigns(:event).id)
    end

    it "not create a new event" do
      params = { what: "" }
      post :create, params: { event: params } 
      expect(response).to render_template("new")   
    end
  
  end

  context "GET #edit" do
    let(:event) { create(:event) }
    it "should success and render to edit page" do
      get :edit, params: { id: event.id }
      expect(response).to render_template(:edit)   
      expect(response).to have_http_status(200)
    end

    it "should edit event" do
      get :edit, params: { id: event.id}
      expect(assigns(:event)).to be_a(Event)
    end
  end

  context "PUT #update" do
    let!(:event) { create(:event) }

    it "should update event info" do
      puts ">>>>>>>>>>>> Event: #{event.to_s}"
      params = { what: "Update what event" }

      put :update, params: {id: event.id, event: params}
      event.reload
      expect(event.what).to eq(params[:what])
      expect(flash[:notice]).to eq("Event update successfull.")
      expect(response).to redirect_to(action: :show, id: assigns(:event).id)
    end
  
    it "should not update post info" do
      params = { what: nil }
      
      put :update, params: {id: event.id, event: params}

      expect(response).to render_template(:edit)   
    end
    

  end

  context "DELETE #destroy" do
    let!(:event) { create(:event) }

    it "should delete event" do
      delete :destroy, params: { id: event.id }
      expect(flash[:notice]).to eq("Event destroyed successfull.")
      expect(response).to redirect_to(action: :index)
    end
    
  end
  

end
