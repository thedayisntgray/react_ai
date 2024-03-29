# frozen_string_literal: true

require "dotenv/load"
require "openai"
require_relative "react_ai/cli"
require_relative "react_ai/version"

module ReactAi
  class Error < StandardError; end

  class Agent
    def initialize(agent_prompt: "You run in a loop of Thought, Action, PAUSE, Observation.
      At the end of the loop you output an Answer
      Use Thought to describe your thoughts about the question you have been asked.
      Use Action to run one of the actions available to you - then return PAUSE.
      Observation will be the result of running those actions.

      Your available actions are:

      calculate:
      e.g. calculate: 4 * 7 / 3
      Runs a calculation and returns the number - uses Ruby so be sure to use floating point syntax if necessary

      wikipedia:
      e.g. wikipedia: Ruby On Rails
      Returns a summary from searching Wikipedia

      Always look things up on Wikipedia if you have the opportunity to do so.

      Example session:

      Question: What is the capital of France?
      Thought: I should look up France on Wikipedia
      Action: wikipedia: France
      PAUSE

      You will be called again with this:

      Observation: France is a country. The capital is Paris.

      You then output:

      Answer: The capital of France is Paris")
      @client = OpenAI::Client.new(access_token: ENV["OPEN_AI_KEY"])
      @messages = []

      @known_actions = [
        "wikipedia",
        "calculate"
      ]

      unless agent_prompt.nil?
        @messages << {"role" => "system", "content" => agent_prompt}
      end
    end

    def query(question, max_iterations)
      next_prompt = question
      max_iterations.times do |i|
        result = execute(next_prompt)
        print result
        actions = result.split("\n").map { |a| /^Action: (\w+): (.*)$/.match(a) }.compact.first

        if actions
          tool = actions[1]
          action_input = actions[2]

          unless @known_actions.include?(tool)
            raise "Unknown Action: #{tool}"
          end
          puts " -- running #{tool} #{action_input}"
          observation = send(tool, action_input)
          puts "Observation: #{observation}"
          next_prompt = "Observation: #{observation}"

        else
          return # standard:disable Lint/NonLocalExitFromIterator
        end
      end
    end

    def calculate(expr)
      # consider integrating dentaku instead of using eval() which is unsafe
      # https://github.com/rubysolo/dentaku
      eval(expr)
    end

    def wikipedia(query)
      uri = URI("https://en.wikipedia.org/w/api.php")
      params = {action: "query", list: "search", srsearch: query, format: "json"}
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body)["query"]["search"][0]["snippet"]
    end

    def execute(question)
      @messages << {"role" => "user", "content" => question}
      response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: @messages
        }
      )

      result = response.dig("choices").first.dig("message").dig("content")
      @messages << {"role" => "assistant", "content" => result}
      result
    end
  end
end
