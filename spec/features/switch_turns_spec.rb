feature 'switch turns' do
  # scenario 'Switch turns' do
    # context 'seeing the current turn' do
      scenario 'at the start of the game' do
        sign_in_and_play
        expect(page).to have_content "Dave's turn"
      end

      scenario 'after player 1 attacks' do
        sign_in_and_play
        click_button 'Attack'
      #commenting this out from user story I wanna see Player 2 attaking me and adding
        # click_link 'OK'
        click_button 'OK'
        expect(page).not_to have_content "Dave's turn"
        expect(page).to have_content "Julie's turn"
      end
    # end
  # end
end
