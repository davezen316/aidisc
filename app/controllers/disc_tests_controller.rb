class DiscTestsController < ApplicationController
  def new
  end
  
  def calculate_result
    # Assuming params[:disc_test] contains your test answers
    answers = params[:disc_test] || {}
    dominance_score = answers.values.count('D')
    influence_score = answers.values.count('I')
    steadiness_score = answers.values.count('S')
    compliance_score = answers.values.count('C')
  
    test_result = current_user.disc_test_results.new(
      dominance: dominance_score,
      influence: influence_score,
      steadiness: steadiness_score,
      compliance: compliance_score
    )
  
    if test_result.save
      # Successfully saved the test result
      @dominance = dominance_score
      @influence = influence_score
      @steadiness = steadiness_score
      @compliance = compliance_score
      
      redirect_to disc_test_result_path(id: current_user.disc_test_results.last.id)
    else
      # Handle save failure, e.g., by rendering the form again with error messages
      flash.now[:alert] = "There was a problem saving your test results."
      render :new
    end
  end

  def result
    Rails.logger.debug "DISC Test result action invoked"
    @disc_test_result = current_user.disc_test_results.find(params[:id])

    # Each profile's percentage for the illustration of status bar
    @d_bar = (@disc_test_result.dominance.to_f / 12 * 100).round(2)
    @i_bar = (@disc_test_result.influence.to_f / 12 * 100).round(2)
    @s_bar = (@disc_test_result.steadiness.to_f / 12 * 100).round(2)
    @c_bar = (@disc_test_result.compliance.to_f / 12 * 100).round(2)
    
  rescue ActiveRecord::RecordNotFound
    # Handle the case where the result does not exist or does not belong to the current user
    flash.now[:alert] = "Test result not found."
    redirect_to root_path
  end

  # Here, you can process the answers and calculate the DISC profile
  #@dominance = params[:dominance].to_i
  #@influence = params[:influence].to_i
  # ... capture other attributes similarly

  # Logic to interpret the scores and provide a profile description
  # For example:
  #@profile_description = if @dominance > 7
  #                         "You have a high dominance trait."
  #                       elsif @influence > 7
  #                         "You have a high influence trait."
  #                       end
  # ... and so on
end
