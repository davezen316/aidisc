class QuestionsController < ApplicationController
  def index
  end

  def create

    # Retrieve the specific DiscTestResult for the current user
    @disc_test_result = current_user.disc_test_results.find(params[:disc_test_result_id])
    
    # Build the context string using @disc_test_result
    context = build_context(@disc_test_result)

    message_content = prepare_message_content(context, question)

    response = send_to_openai(message_content)
    
    @answer = response.dig("choices", 0, "message", "content")

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("answer", partial: "answer", locals: { answer: @answer })
      end
      format.html { redirect_to disc_test_result_path(id: params[:disc_test_result_id]) }
    end

  rescue ActiveRecord::RecordNotFound
    # Handle the case where the DiscTestResult does not exist or does not belong to the current user
    redirect_to root_path, alert: "DISC Test Result not found."
  end

  private

  def question
    params[:question]
  end

  def build_context(disc_test_result)
    "The user has a DISC profile with Dominance: #{disc_test_result.dominance}, 
    Influence: #{disc_test_result.influence}, 
    Steadiness: #{disc_test_result.steadiness}, 
    and Compliance: #{disc_test_result.compliance}."
  end

  def prepare_message_content(context, question)
    <<~CONTENT
      Please acted as a professional DISC Consultant, answer the question based on the disc profile below.
      If the question can't be answered based on the profile, please give a reason why the question cannot be answered.
      The answer must always started with the disc profile stated ahead.
      Format the answer with <p><li><ul><strong> and <title> <h1> <h2> <h3> <h4> tag for the headings when necessary.

      Context:
      #{context}

      ---

      Question: #{question}
    CONTENT
  end

  def send_to_openai(message_content)
    openai_client = OpenAI::Client.new(api_key: ENV["OPENAI_API_KEY"])
    openai_client.chat(parameters: {
      model: "gpt-4-0125-preview",
      messages: [{ role: "user", content: message_content }],
      temperature: 0.5,
    })
  end
end