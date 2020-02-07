# encoding: UTF-8
=begin
  Définition des valeurs de configuration

  Pour récupérer une valeur, utiliser :

      Configuration.<nom/clé de la configuration>
      CONFIG[:<nom/clé de la configuration>]

=end
CONFIG = {}
class Configuration
  def self.define
    yield Configuration.new()
  end
  def method_missing method, *args, &block
    method = method.to_s
    if method.end_with?('=')
      CONFIG.merge!( method[0...-1].to_sym => args.first)
    else
      raise e
    end
  end
end


# puts "CONFIG = #{CONFIG.inspect}"
