# frozen_string_literal: true

require "hanami/cli"
require "zeitwerk"

module Hanami
  module RSpec
    # @since 2.0.0
    # @api private
    def self.gem_loader
      @gem_loader ||= Zeitwerk::Loader.new.tap do |loader|
        root = File.expand_path("..", __dir__)
        loader.tag = "hanami-rspec"
        loader.inflector = Zeitwerk::GemInflector.new("#{root}/hanami-respec.rb")
        loader.push_dir(root)
        loader.ignore(
          "#{root}/hanami-rspec.rb",
          "#{root}/hanami/rspec/version.rb"
        )
        loader.inflector.inflect("rspec" => "RSpec")
      end
    end

    gem_loader.setup

    if Hanami::CLI.within_hanami_app?
      Hanami::CLI.after "install", Commands::Install
      Hanami::CLI.after "generate slice", Commands::Generate::Slice
      Hanami::CLI.after "generate action", Commands::Generate::Action
    end
  end
end
