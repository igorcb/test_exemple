require 'rails_helper'

RSpec.feature 'Events', type: :feature do
  context 'GET index' do
    before { visit events_path }

    scenario 'should h1 tag' do
      expect(page).to have_selector 'h1', text: 'Listing Events'
    end

    scenario 'should one event' do
      event = create(:event)
      visit events_path
      expect(page).to have_content(event.what)
    end

    scenario 'new event' do
      click_link 'New Event'
      expect(page).to have_content('New Event')
    end

    scenario 'show event' do
      event = create(:event)
      visit events_path event.id
      click_link 'Show'

      expect(page).to have_content('Event')
    end

    scenario 'edit event' do
      event = create(:event)
      visit events_path event.id
      click_link 'Edit'

      expect(page).to have_content('Edit Event')
    end

    # scenario 'destroy event', js: true do
    #   event = create(:event)
    #   visit events_path
    #   accept_alert do
    #     click_link 'Destroy'
    #   end

    #   expect(page).to have_content('Event destroyed successfull')
    #   expect(Event.count).to eq(0)
    # end

  end

  context 'GET new' do
    before { visit new_event_path }

    scenario 'create new event' do

      within 'form' do
        what_text = 'laborum numquam qui'
        fill_in 'What', with: what_text
        expect(page).to have_field('event[what]', with: what_text)
        click_button 'Create Event'
      end

      expect(page).to have_content('Event create successfull.')
    end

    scenario 'list all event' do
      click_link 'List All'
      visit events_path
      expect(page).to have_content('Listing Events')
    end

  end

  context 'GET edit' do
    let!(:event) { create(:event) }
    let!(:url) { edit_event_path(event) }
    scenario 'update event' do
      visit url
      what_text = 'laborum numquam qui update'
      expect(page).to have_selector 'h1', text: 'Edit Event'

      within 'form' do
        fill_in 'What', with: 'laborum numquam qui update'
        expect(page).to have_field('event[what]', with: what_text)
        click_button 'Update Event'
      end

      event.reload
      expect(event.what).to eq(what_text)
      expect(page).to have_content('Event update successfull.')
    end

    scenario 'list all event' do
      visit url
      click_link 'List All'
      visit events_path
      expect(page).to have_content('Listing Events')
    end
  end
end
