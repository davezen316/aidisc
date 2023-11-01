class DiscTestsController < ApplicationController
  def new
  end
  
  def result

    dominance_score = params.values.count('D')
    influence_score = params.values.count('I')
    steadiness_score = params.values.count('S')
    compliance_score = params.values.count('C')

    @dominance = dominance_score
    @influence = influence_score
    @steadiness = steadiness_score
    @compliance = compliance_score

    session[:disc_profile] = {
      dominance: @dominance,
      influence: @influence,
      steadiness: @steadiness,
      compliance: @compliance
    }

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
end
