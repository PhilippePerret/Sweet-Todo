# encoding: UTF-8
=begin

  Une ligne est décomposée de cette manière :

  > application [arg1] [arg2] [argN] [param1=v1] [param2=v2] [-opt] [--option]

  On trouve les arguments dans    CLI.args
  On trouve les paramètres dans   CLI.params
  On trouve les options dans      CLI.options

  Requis
  ------
    * L'application doit définir MIN_OPT_TO_REAL_OPT
    * et COMMAND_OTHER_PARAM_TO_REAL_PARAM
=end
class CLI

  class << self

    # Analyse la ligne de commande courante
    # Utiliser : Command.parse
    def parse
      ARGV.each do |arg|
        if arg.start_with?('--')
          key = arg[2..-1]
          CLI.options.merge!(key.to_sym => true)
        elsif arg.start_with?('-')
          # Trait simple
          keys = arg[1..-1].split('')
          keys.each do |key|
            key = MIN_OPT_TO_REAL_OPT[key]
            if key.nil?
              error "L'option #{arg} est inconnue."
            else
              CLI.options.merge!(key.to_sym => true)
            end
          end
        elsif arg.include?('=')
          key, val = arg.split('=')
          real_key = COMMAND_OTHER_PARAM_TO_REAL_PARAM[key] || key
          CLI.params.merge!(real_key.to_sym => val)
        else
          CLI.args << arg
        end
      end
      if self.respond_to?(:after_decompose)
        after_decompose
      end
      # puts "COMMAND : #{COMMAND.options.inspect}"
    end

    # Utiliser Command.clear_terminal
    def clear_terminal
      puts "\033c"
    end

    def options
      @options ||= {}
    end
    def args
      @args ||= []
    end
    def params
      @params ||= {}
    end

  end #/<< self

  attr_accessor :options, :params, :args

  def initialize
    init()
  end

  def init
    self.args     = []
    self.options  = {}
    self.params   = {}
  end

end
