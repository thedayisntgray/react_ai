module ReactAi
  class Cli
    def initialize(argv)
      @argv = argv
    end

    def run
      input = @argv.join(" ")
      puts ReactAi::Agent.new.query(input, 5)
    end
  end
end
